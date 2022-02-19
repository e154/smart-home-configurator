<template>
  <div>
    {{ appVersion }}
  </div>
</template>

<script lang="ts">
import {Component, Prop, Vue} from 'vue-property-decorator';
import {ApiDashboardCard} from '@/api/stub';

@Component({
  name: 'FrontendVersion',
  components: {}
})
export default class extends Vue {
  @Prop() private item?: ApiDashboardCard;
  private appVersion: string = '';

  private created() {
    // this.appVersion = globalThis.app_settings.configurator_version();
  }

  private mounted() {
  }


}
</script>

<style scoped>

</style>
