<template>
  <div v-if="item.entity && !loading">
    <div v-if="item.payload.chart.type === 'bar'">
      <BarChart :chart-data="chartDataBar"
                :chart-options="chartOptionsBar"
                :width="600"
                :height="400"
                :bus="bus"
                ref="bar"
      />
    </div>
    <div v-if="item.payload.chart.type === 'line'">
      <LineChart :chart-data="chartData"
                 :chart-options="chartOptions"
                 :width="600"
                 :height="400"
                 :plugins="plugins"
                 :bus="bus"
                 ref="line"
      />
    </div>
  </div>
</template>

<script lang="ts">
import {Component, Prop, Vue, Watch} from 'vue-property-decorator';
import {CardItem} from '@/views/dashboard/core';
import api from '@/api/api';
import BarChart from '@/views/dashboard/card_items/chart/bar.vue';
import LineChart from '@/views/dashboard/card_items/chart/line.vue';
import {ChartDataSet} from '@/views/dashboard/card_items/chart/types';

@Component({
  name: 'IChart',
  components: {LineChart, BarChart}
})
export default class extends Vue {
  @Prop() private item?: CardItem;
  @Prop({default: false}) private disabled!: boolean;

  private plugins: Array<Object> = [];
  private bus: Vue = new Vue();
  private loading!: boolean = true;

  private created() {
    if (!this.item) {
      return;
    }
    this.prepareData();
  }

  private mounted() {
  }

  private async callAction() {
    await api.v1.interactServiceEntityCallAction({
      id: this.item?.entityId,
      name: this.item?.payload.button?.action || ''
    });
    this.$notify({
      title: 'Success',
      message: 'Call Successfully',
      type: 'success',
      duration: 2000
    });
  }

  private onClick() {
    this.callAction();
  }

  chartData!: {
    labels: Array<string>
    datasets: Array<ChartDataSet>
  };
  chartOptions = {
    interaction: {
      intersect: false
    },
    responsive: true,
    maintainAspectRatio: true,
    plugins: {
      legend: false
    },
    scales: {
      x: {
        display: true,
        // type: 'linear',
        title: {
          display: false,
          // text: 'Month'
        }
      },
      y: {
        display: true,
        title: {
          display: false,
          // text: 'Value'
        }
      }
    }
  };

  private prepareLiteData() {
    if (!this.item?.entity?.metrics) {
      return;
    }

    this.$set(this.chartOptions, 'plugins', {legend: this.item.payload.chart?.legend || false});
    this.chartOptions.scales.x.display = this.item.payload.chart?.xAxis || false;
    this.chartOptions.scales.y.display = this.item.payload.chart?.yAxis || false;

    this.chartData = {
      labels: [],
      datasets: [],
    };

    const metric = this.item.entity.metrics[this.item.payload.chart?.index || 0];
    let totalLabels = Array<string>();
    let dataSets = new Map<string, ChartDataSet>();

    // create data sets
    for (const i in metric.options?.items) {
      totalLabels.push(metric.options?.items[i].name);
      dataSets[metric.options?.items[i].name] = {
        label: metric.options?.items[i].name,
        borderColor: metric.options?.items[i].color,
        backgroundColor: metric.options?.items[i].color,
        data: new Array<number>(),
        borderWidth: this.item.payload.chart?.borderWidth || 1,
        radius: 0,
      };
    }

    // add data to sets
    for (const t in metric.data) {
      // todo: add data filter
      // this.chartData.labels.push(metric.data[t].time);
      this.chartData.labels.push(t);
      for (const l in totalLabels) {
        dataSets[totalLabels[l]].data.push(metric.data[t].value[totalLabels[l]]);
      }
    }

    for (const l in totalLabels) {
      this.chartData.datasets.push(dataSets[totalLabels[l]]);
    }
    // console.log(this.chartData);
    this.bus.$emit('updateChart', 'line');
  }

  private prepareData() {
    if (!this.item?.entity?.metrics) {
      return;
    }

    if (!this.item.payload?.chart?.type) {
      return;
    }

    this.loading = true;

    switch (this.item.payload.chart.type) {
      case 'line':
        this.prepareLiteData();

        break;
      case 'bar':
        break;
      default:
        console.warn(`unknown chart type ${this.item.entity.metrics[this.item.payload.chart?.index || 0].type}`);
    }

    this.loading = false;
  }

  @Watch('item', {deep: true})
  private onUpdateItem(item: CardItem) {
    this.prepareData();
  }
}
</script>

<style scoped>

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}

.clearfix:after {
  clear: both
}

</style>
