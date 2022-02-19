<template>
  <masonry-wall :items="item.cards" :column-width="300" :gap="10">
    <template #default="{ item, index }">
      <card :item="item" :bus="bus"/>
    </template>
  </masonry-wall>
</template>

<script lang="ts">
import {Component, Prop, Vue} from 'vue-property-decorator';
import {ApiDashboardTab} from '@/api/stub';
import MasonryWall from '@yeger/vue2-masonry-wall';
import Card from './card.vue';

@Component({
  name: 'Tab',
  components: {
    MasonryWall,
    Card
  }
})
export default class extends Vue {
  @Prop() private item!: ApiDashboardTab;
  @Prop() private bus!: Vue;

}
</script>

<style lang="scss">

</style>
