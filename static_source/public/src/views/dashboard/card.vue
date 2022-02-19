<template>

  <el-card shadow="hover">
    <div slot="header" class="clearfix">
      <span>{{ $t('dashboard.card.' + item.title + '.name') }}</span>
    </div>

    <component :is="getCardName(item.type)" :item="item"/>

  </el-card>

</template>

<script lang="ts">
import {Component, Prop, Vue} from 'vue-property-decorator';
import {ApiDashboardCard} from '@/api/stub';
import {CardName, Dummy, FrontendVersion} from '@/views/dashboard/cards';
import stream from '@/api/stream';
import {UUID} from 'uuid-generator-ts';

@Component({
  name: 'Card',
  components: {
    Dummy,
    FrontendVersion
  }
})
export default class extends Vue {
  @Prop() private item!: ApiDashboardCard;
  @Prop() private bus!: Vue;

  private currentID: string = '';

  private getCardName(name: string): string {
    return CardName(name);
  }

  private created() {
    let uuid = new UUID();
    this.currentID = uuid.getDashFreeUUID();

    this.bus.$on('state_changed', (m: any) => {
      this.onStateChanged(m)
    });
  }

  private destroyed() {

  }

  private onStateChanged(m: object) {
    // console.log('-------', this.currentID)
    // console.log(m)
  }
}
</script>

<style lang="scss">

</style>
