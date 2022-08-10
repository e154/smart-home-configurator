<template>
  <div>
    <common-editor :item="item" :board="board"></common-editor>

    <el-divider content-position="left">Progress options</el-divider>

    <el-form-item :label="$t('dashboard.editor.type')" prop="type">
      <el-select
        v-model="item.payload.chart.type"
        placeholder="please select type"
        style="width: 100%"
      >
        <el-option label="linear" value="line"></el-option>
        <el-option label="bar" value="bar"></el-option>
      </el-select>
    </el-form-item>

    <el-form-item :label="$t('dashboard.editor.index')" prop="index">
      <el-input-number size="small"
                       v-model="item.payload.chart.index"></el-input-number>
    </el-form-item>

    <!--    <el-form-item :label="$t('dashboard.editor.select')" prop="index">-->
    <!--      <el-select v-model="item.payload.chart.select" multiple placeholder="Select">-->
    <!--        <el-option-->
    <!--          v-for="item in item.entity.m"-->
    <!--          :key="item.value"-->
    <!--          :label="item.label"-->
    <!--          :value="item.value">-->
    <!--        </el-option>-->
    <!--      </el-select>-->
    <!--    </el-form-item>-->

    <!--    <el-form-item :label="$t('dashboard.editor.width')" prop="width">-->
    <!--      <el-input-number size="small"-->
    <!--                       v-model="item.payload.chart.width"></el-input-number>-->
    <!--    </el-form-item>-->

    <!--    <el-form-item :label="$t('dashboard.editor.height')" prop="height">-->
    <!--      <el-input-number size="small"-->
    <!--                       v-model="item.payload.chart.height"></el-input-number>-->
    <!--    </el-form-item>-->

    <el-form-item :label="$t('dashboard.editor.borderWidth')" prop="borderWidth">
      <el-input-number size="small"
                       v-model="item.payload.chart.borderWidth"></el-input-number>
    </el-form-item>

    <el-form-item :label="$t('dashboard.editor.legend')" prop="legend">
      <el-switch
        v-model="item.payload.chart.legend"></el-switch>
    </el-form-item>

    <el-form-item :label="$t('dashboard.editor.xAxis')" prop="xAxis">
      <el-switch
        v-model="item.payload.chart.xAxis"></el-switch>
    </el-form-item>

    <el-form-item :label="$t('dashboard.editor.yAxis')" prop="yAxis">
      <el-switch
        v-model="item.payload.chart.yAxis"></el-switch>
    </el-form-item>


    <el-row style="padding-bottom: 20px">
      <el-col>
        <event-viewer :item="item"></event-viewer>
      </el-col>
    </el-row>

  </div>
</template>

<script lang="ts">
import {Component, Prop, Vue} from 'vue-property-decorator';
import {CardItem, Core} from '@/views/dashboard/core';
import CommonEditor from '@/views/dashboard/card_items/common/editor.vue';
import EventViewer from '@/views/dashboard/card_items/common/event_viewer.vue';

@Component({
  name: 'IChartEditor',
  components: {
    CommonEditor,
    EventViewer
  }
})
export default class extends Vue {
  @Prop() private item!: CardItem;
  @Prop() private board!: Core;

  private created() {
  }

  private mounted() {
  }
}
</script>

<style scoped>

</style>
