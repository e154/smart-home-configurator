<template>
  <div v-if="item.entity && !loading">
    <div v-if="item.payload.chart.type === 'bar'">
      <BarChart :chart-data="chartData"
                :chart-options="chartOptions"
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
    <div v-if="item.payload.chart.type === 'doughnut'">
      <DoughnutChart :chart-data="chartData"
                     :chart-options="chartOptions"
                     :width="600"
                     :height="400"
                     :plugins="plugins"
                     :bus="bus"
                     ref="doughnut"
      />
    </div>
    <div v-if="item.payload.chart.type === 'radar'">
      <RadarChart :chart-data="chartData"
                  :chart-options="chartOptions"
                  :width="600"
                  :height="400"
                  :plugins="plugins"
                  :bus="bus"
                  ref="radar"
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
import DoughnutChart from '@/views/dashboard/card_items/chart/doughnut.vue';
import RadarChart from '@/views/dashboard/card_items/chart/radar.vue';
import {UUID} from 'uuid-generator-ts';

export interface ChartDataInterface {
  labels: Array<string>;
  datasets: Array<ChartDataSet>;
}

@Component({
  name: 'IChart',
  components: {RadarChart, DoughnutChart, LineChart, BarChart}
})
export default class extends Vue {
  @Prop() private item?: CardItem;
  @Prop({default: false}) private disabled!: boolean;

  private plugins: Array<Object> = [];
  private bus: Vue = new Vue();
  private loading: boolean = true;

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
  chartOptions: any = {};

  private prepareLiteData(): ChartDataInterface {
    let chartData: ChartDataInterface = {
      labels: [],
      datasets: [],
    };

    if (!this.item?.entity?.metrics || !this.item.payload.chart?.props || this.item.payload.chart?.props.length == 0) {
      return chartData;
    }

    const metric = this.item.entity.metrics[this.item.payload.chart?.metric_index || 0];
    let totalLabels: Array<string> = this.item.payload.chart?.props;
    let dataSets = new Map<string, ChartDataSet>();

    // create data sets
    for (const i in metric.options?.items) {
      // totalLabels.push(metric.options?.items[i].name);
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
      // this.chartData.labels.push(metric.data[t].time);
      chartData.labels.push(t);
      for (const l in totalLabels) {
        dataSets[totalLabels[l]].data.push(metric.data[t].value[totalLabels[l]]);
      }
    }

    for (const l in totalLabels) {
      chartData.datasets.push(dataSets[totalLabels[l]]);
    }
    // console.log(chartData);
    return chartData;
  }

  private prepareData() {
    if (!this.item?.entity?.metrics) {
      return;
    }

    if (!this.item.payload?.chart?.type) {
      return;
    }

    this.loading = true;

    this.chartData = this.prepareLiteData();

    switch (this.item.payload.chart.type) {
      case 'line':
        this.chartOptions = {
          interaction: {
            intersect: false
          },
          responsive: true,
          maintainAspectRatio: true,
          plugins: {
            legend: this.item.payload.chart?.legend || false
          },
          scales: {
            x: {
              display: this.item.payload.chart?.xAxis || false,
              type: 'linear',
              title: {
                display: false,
                // text: 'Month'
              }
            },
            y: {
              display: this.item.payload.chart?.yAxis || false,
              title: {
                display: false,
                // text: 'Value'
              }
            }
          }
        };
        this.bus.$emit('updateChart', 'line');
        break;
      case 'bar':
        this.bus.$emit('updateChart', 'bar');
        this.chartOptions = {
          interaction: {
            intersect: false
          },
          responsive: true,
          maintainAspectRatio: true,
          plugins: {
            legend: this.item.payload.chart?.legend || false
          },
          scales: {
            x: {
              display: this.item.payload.chart?.xAxis || false,
              type: 'linear',
              title: {
                display: false,
                // text: 'Month'
              }
            },
            y: {
              display: this.item.payload.chart?.yAxis || false,
              title: {
                display: false,
                // text: 'Value'
              }
            }
          }
        };
        break;
      case 'radar':
        this.bus.$emit('updateChart', 'radar');
        this.chartOptions = {
          responsive: true,
          maintainAspectRatio: true,
        };
        break;
      case 'doughnut':
        this.bus.$emit('updateChart', 'doughnut');
        this.chartOptions = {
          responsive: true,
          maintainAspectRatio: true,
        };
        break;
      default:
        console.warn(`unknown chart type ${this.item.entity.metrics[this.item.payload.chart?.metric_index || 0].type}`);
    }

    this.loading = false;
  }

  @Watch('item', {deep: true})
  private onUpdateItem(item: CardItem) {
    this.prepareData();
  }

  private genId(): string {
    const uuid = new UUID();
    return uuid.getDashFreeUUID();
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
