<template>
  <div id="dashboard-editor">

      <div
        id="container"
        ref="canvas"
        :key="forceRefresh"
        :style="{
                    'transform': `scale(${this.zoom})`,
                    'position': 'relative',
                    'background-color': 'white',
                    'overflow': 'scroll',
                    'width': '100%',
                    'height': '250px'}"
        @mousedown.self="card.selectedItem = -1"
      >
        <Moveable
          v-if="!loading"
          v-for="(item, index) in card.items"
          :key="index"
          :container="$refs.canvas"
          class="moveable"
          v-bind="card.settings(index)"
          @drag="handleDrag"
          @resize="handleResize"
          @rotate="handleRotate"
          @warp="handleWarp"
          @renderEnd="hideDataLabel"
          :style="item.position()"
        >
          <div v-if="item.type === 'text'"
            @mousedown.capture="selectItem(index)"
            class="item-element"
            :style="item.style()">
            {{ item.payload.text }}
          </div>
          <div v-else-if="item.type === 'image'"
               @mousedown.capture="selectItem(index)"
               class="item-element"
               :style="item.style()">
            <el-image
              :src="currentUrl"
              fit="fil"
            >
            </el-image>
          </div>
          <div v-else
               @mousedown.capture="selectItem(index)"
               class="item-element"
               :style="item.style()">
            todo create
          </div>

        </Moveable>


      </div>

    <div id="control-panel">

      <el-row :gutter="20">

        <el-col :span="12">
          elements:
          <div>
            <el-button @click.prevent.stop="addItem">add item</el-button>
          </div>

          <el-collapse v-model="card.selectedItem" accordion>
            <el-collapse-item
              title="Consistency"
              :name="index"
              :key="index"
              v-for="(item, index) in card.items"
            >
              <div>{{item.type}}</div>


              <div v-if="item.type === 'text'">

                <el-form label-position="top"
                         :rules="rules"
                         style="width: 100%">

                  <el-form-item label="item_type" prop="item_type">
                    <el-select v-model="item.type"
                               placeholder="Type"
                               label="Type"
                               style="width: 100%"
                    >
                      <el-option
                        v-for="item in options"
                        :key="item.value"
                        :label="item.label"
                        :value="item.value">
                      </el-option>
                    </el-select>
                  </el-form-item>

                  <el-form-item label="text" prop="text">
                    <el-input
                      type="textarea"
                      size="medium"
                      placeholder="text"
                      label="text"
                      v-model="item.payload.text">
                    </el-input>
                  </el-form-item>

                  <el-form-item label="style" prop="style">
                    style ...
                  </el-form-item>
                </el-form>

              </div>


              <div v-else-if="item.type === 'image'" >
                <el-form label-position="top"
                         :rules="rules"
                         style="width: 100%">



                  <el-form-item label="item_type" prop="item_type">
                    <el-select v-model="item.type"
                               placeholder="Type"
                               label="Type"
                               style="width: 100%"
                    >
                      <el-option
                        v-for="item in options"
                        :key="item.value"
                        :label="item.label"
                        :value="item.value">
                      </el-option>
                    </el-select>
                  </el-form-item>

                  <el-form-item :label="$t('entities.table.image')" prop="image">
                    <image-preview :image="item.payload.image" @on-select="onSelectImage"/>
                  </el-form-item>

                  <el-form-item label="style" prop="style">
                    <el-input
                      type="textarea"
                      size="medium"
                      placeholder="Description"
                      label="Description"
                      v-model="item._style">
                    </el-input>
                  </el-form-item>
                </el-form>
              </div>


            </el-collapse-item>
          </el-collapse>
        </el-col>
      </el-row>

    </div>

  </div>
</template>

<script lang="ts">
import {Component, Vue} from 'vue-property-decorator';
import Moveable from 'vue-moveable';
import {Card, Item} from '../dashboard/types';
import {ApiImage} from '@/api/stub';
import ImagePreview from '@/views/images/preview.vue';
import JsonEditor from '@/components/JsonEditor/index.vue';
import stream from '@/api/stream';

class elementOption {
  public value: string = '';
  public label: string = '';
}

@Component({
  name: 'Editor',
  components: {
    Moveable,
    ImagePreview,
    JsonEditor
  }
})
export default class extends Vue {
  private loading: boolean = true;
  private zoom: number = 1;
  private forceRefresh: number = 0;
  private dataLabel = null;
  private card: Card = new Card();

  private options: elementOption[] = [
    {value: 'text', label: 'text'},
    {value: 'image', label: 'image'},
  ];

  private rules = {
    type: [
      {required: true, trigger: 'blur'},
      {min: 4, max: 255, trigger: 'blur'}
    ],
  };

  private selectItem(index: number) {
    this.card.selectedItem = index;
    console.log('selected', index);
  }

  created() {
    console.log("created")
  }

  mounted() {
    console.log("mounted")
    this.$nextTick(function () {
        console.log("timeout")
        this.loadDemoData()
        this.loading = false;
    })
  }

  handleDrag({target, transform, beforeTranslate, left, top}: any) {
    console.log('onDrag', transform, 'left, top', left, top);
    this.card.items[this.card.selectedItem].transform = transform;
    target.style.transform = transform;
  }

  handleResize({target, width, height, clientX, clientY}: any) {
    console.log('resize');
    width = Math.round(width);
    height = Math.round(height);

    this.card.items[this.card.selectedItem].width = width;
    this.card.items[this.card.selectedItem].height = height;
    target.style.width = `${width}px`;
    target.style.height = `${height}px`;
    // this.setDataLabel(clientX, clientY, `${width} x ${height}`);
  }

  handleRotate({target, transform, beforeRotate, clientX, clientY}: any) {
    this.card.items[this.card.selectedItem].transform = transform;
    target.style.transform = transform;
    // this.setDataLabel(clientX, clientY, `${beforeRotate}°`);
  }

  handleWarp({target, transform}: any) {
    console.log('onWarp', transform);
    this.card.items[this.card.selectedItem].transform = transform;
    target.style.transform = transform;
  }

  private handleScale({target, width, height}: any) {
    // console.log("onResize", width, height);
    target.style.width = `${width}px`;
    target.style.height = `${height}px`;
  }

  private hideDataLabel() {
    this.dataLabel = null;
  }

  private addLayer() {

  }

  private onSelectImage(value: ApiImage, event?: any) {
    if (this.card.items[this.card.selectedItem].payload ) {
      this.currentImage = value;
      this.getUrl()
      this.$set(this.card.items[this.card.selectedItem].payload, 'image', value);
    }
  }

  private addItem() {
    let item = new Item({
      style: {},
      payload: {
        text: 'new item'
      },
      type: 'text',
      width: 100,
      height: 100,
      transform: '',
    })
    this.card.addItem(item)
  }

  loadDemoData() {
    const items = [
      {
        style: {},
        payload: {
          text: 'Hello World',
        },
        width: 100,
        height: 100,
        transform: '',
        type: 'text'
      },
      {
        style: {},
        payload: {
          text: 'Hello World2',
        },
        width: 300,
        height: 100,
        transform: '',
        type: 'text'
      },
      {
        style: {},
        payload: {
          text: 'Hello World3',
        },
        width: 400,
        height: 40,
        transform: '',
        type: 'text'
      }
    ];

    for (let item of items) {
      this.card.addItem(new Item(item));
    }
  }

  private currentUrl: string = '';
  private currentImage?: ApiImage;
  private basePath: string = process.env.VUE_APP_BASE_API || window.location.origin;
  private getUrl() {
    if (this.currentImage) {
      this.currentUrl = this.basePath + this.currentImage.url;
    } else {
      this.currentUrl = '';
    }
  }

  private changed(value: string) {
    // let style: object

  }
}
</script>

<style lang="scss">

#dashboard-editor {
  position: relative;
}

#container {

}

.item-element {
  /* border: 1px solid #aaa; */
  position: absolute;
  width: 100%;
  height: 100%;
  overflow: hidden;
  cursor: move;
  user-select: none;
}

.moveable {
  font-family: "Roboto", sans-serif;
  position: absolute;
  width: 300px;
  height: 200px;
  text-align: center;
  font-size: 20px;
  margin: 0 auto;
  font-weight: 100;
  letter-spacing: 1px;
  overflow: hidden;
}

#control-panel {
  padding: 20px;
  border-top: #2d2f33 1px solid ;
}

.moveable-line {
  /* background: transparent !important; */
  /* border: 0px !important; */
}

</style>
