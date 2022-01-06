<template>
  <div class="app-container"
       v-loading="listLoading"
  >
    detail {{ script.name }}

    <div>qwe {{ $route.params.id }}</div>

  </div>
</template>

<script lang="ts">
import {Component, Prop, Vue} from 'vue-property-decorator';
import api, {ApiScript} from '@/api/api';

@Component({
  name: 'ScriptDetail',
  components: {}
})
export default class extends Vue {
  @Prop({required: true}) private id!: number;

  private listLoading = true;
  private script: ApiScript;

  created() {
    this.fetch();
  }

  private async fetch() {
    this.listLoading = true;
    const {data} = await api.v1.scriptServiceGetScriptById(this.id);
    this.script = data;
    setTimeout(() => {
      this.listLoading = false;
    }, 0.5 * 1000);
  }
}
</script>

