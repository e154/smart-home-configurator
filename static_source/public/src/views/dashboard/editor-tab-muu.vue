<template>
  <vuuri
    v-model="item.cards"
    item-key="id"
    :get-item-width="getItemWidth"
    :get-item-height="getItemHeight"
    drag-enabled
  >
    <template #item="{ item }">
        <editor-card :item="item" :bus="bus"/>
    </template>
  </vuuri>
</template>

<script lang="ts">
import {Component, Prop, Vue} from 'vue-property-decorator';
import EditorCard from './editor-card.vue';
import {ApiDashboardCard, ApiDashboardTab} from '@/api/stub';
import vuuri from 'vuuri'

// register globally
Vue.component('vuuri', vuuri);

@Component({
  name: 'EditorTabMuu',
  components: {
    EditorCard,
    vuuri
  }
})
export default class extends Vue {
  @Prop() private item!: ApiDashboardTab;
  @Prop() private bus!: Vue;

  getItemWidth(item:ApiDashboardCard) {
    console.log('getItemWidth', item.width)
    return `${item.width}px`;
  }
  getItemHeight(item:ApiDashboardCard) {
    console.log('getItemHeight', item.height)
    return `${item.height}px`;
  }

}
</script>

<style lang="scss">

</style>
