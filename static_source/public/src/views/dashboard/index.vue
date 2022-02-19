<template>
  <div class="app-container" v-if="!loading">

    <el-tabs v-model="internal.activeTab">
      <el-tab-pane
        v-for="(tab, index) in currentBoard.tabs"
        :label="tab.name"
        :name="tab.name"
        v-bind:key="tab.name"
      >

        <tab :item="tab" :bus="bus"/>

      </el-tab-pane>
    </el-tabs>

  </div>
</template>

<script lang="ts">
import {Component, Vue} from 'vue-property-decorator';
import api from '@/api/api';
import {ApiDashboard, ApiDashboardTab} from '@/api/stub';
import Tab from './tab.vue';
import stream from '@/api/stream';
import {UUID} from 'uuid-generator-ts';

@Component({
  name: 'Main',
  components: {
    Tab,
  }
})
export default class extends Vue {
  private loading: boolean = true;
  private currentBoard?: ApiDashboard;
  private currentTab?: ApiDashboardTab;
  private currentID: string = '';
  private bus: Vue = new Vue;
  private internal = {
    activeTab: 'main',
    model: 'view',
  };

  private created() {
    let uuid = new UUID();
    this.currentID = uuid.getDashFreeUUID();

    this.fetchDashboard();
    setTimeout(() => {
      stream.subscribe('state_changed', this.currentID, this.onStateChanged);
    },1000)
  }

  private destroyed() {
    stream.unsubscribe('state_changed', this.currentID);
  }

  private mounted() {

  }

  private async fetchDashboard() {
    this.loading = true;
    const {data} = await api.v1.dashboardServiceGetDashboardById(1);
    this.currentBoard = data;
    if (this.currentBoard.tabs && this.currentBoard.tabs.length > 0) {
      this.internal.activeTab = this.currentBoard.tabs[0].name;
    }
    this.loading = false;
  }


  private onStateChanged(m: object) {
    // console.log('-------')
    // console.log(m)

    this.bus.$emit('state_changed', m);
  }
}
</script>
