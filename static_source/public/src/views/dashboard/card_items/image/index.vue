<template>
  <transition name="fade">
    <el-image
      v-show="!item.hidden"
      :src="item.getUrl(item.payload.image)">
      <div slot="error" class="image-slot">
        <i class="el-icon-picture-outline"></i>
      </div>
    </el-image >
  </transition>
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator'
import {CardItem, requestCurrentState} from '@/views/dashboard/core';
import { ApiImage } from '@/api/stub'

@Component({
  name: 'IImage',
  components: {
  }
})
export default class extends Vue {
  @Prop() private item?: CardItem;

  private created() {
    requestCurrentState(this.item?.entityId);
  }
  private mounted() {}
}
</script>

<style >
.el-image__error, .el-image__placeholder, .el-image__inner {
  height: auto;
}

.el-image.item-element{
  overflow: visible;
}
</style>
