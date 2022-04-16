<template>

  <div
    class="item-card"
    :style="{'background-color': item.background || 'white'}"
    v-on:click="select($event)"
  >
    <div class="item-card-title">
      <span>{{ item.title }}</span>
    </div>

    <div class="item-card-body">
      <!--      card body-->
    </div>
  </div>

</template>

<script lang="ts">
import {Component, Prop, Vue} from 'vue-property-decorator';
import {CardName, Dummy, FrontendVersion} from '@/views/dashboard/cards';
import {UUID} from 'uuid-generator-ts';
import {ApiDashboardCard} from '@/api/stub';

@Component({
  name: 'EditorCard',
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
      this.onStateChanged(m);
    });
  }

  private destroyed() {

  }

  private onStateChanged(m: object) {
    // console.log('-------', this.currentID)
    // console.log(m)
  }

  private select(event?: any) {
    // console.log('select_card', this.itemIndex)
    this.bus.$emit('selected_card', this.item.id);
  }

}
</script>

<style lang="scss">

.item-card {
  position: relative;
  width: 100%;
  height: 100%;
}

.item-card-title {
  position: relative;

  width: 100%;
}



</style>
