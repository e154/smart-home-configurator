<template>
  <div class="app-container">
      plugin edit page
  </div>
</template>

<script lang="ts">

import {Component, Prop, Vue, Watch} from 'vue-property-decorator';
import api from '@/api/api';
import {ApiGetPluginOptionsResult} from '@/api/stub';
import router from '@/router';

@Component({
  name: 'PluginEditor'
})
export default class extends Vue {
  @Prop({required: true}) private name!: string;

  private listLoading: boolean = true;
  private pluginOptions?: ApiGetPluginOptionsResult;

  created() {
    this.getList();
  }

  private async getList() {
    this.listLoading = true;
    const {data} = await api.v1.pluginServiceGetPluginOptions(this.name);
    this.pluginOptions = data
    this.listLoading = false;
  }
}
</script>

