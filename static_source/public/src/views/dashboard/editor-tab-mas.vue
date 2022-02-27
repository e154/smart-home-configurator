<template>
  <masonry-wall :items="item.cards" :column-width="item.columnWidth||300" :gap="item.gap">
    <template #default="{ item, index }">
      <editor-card :item="item" :item-index="index" :bus="bus"/>
    </template>
  </masonry-wall>
</template>

<script lang="ts">
import {Component, Prop, Vue} from 'vue-property-decorator';
import MasonryWall from '@yeger/vue2-masonry-wall';
import EditorCard from './editor-card.vue';
import {ApiDashboardCard, ApiDashboardTab} from '@/api/stub';

@Component({
  name: 'EditorTabMas',
  components: {
    MasonryWall,
    EditorCard
  }
})
export default class extends Vue {
  @Prop() private item!: ApiDashboardTab;
  @Prop() private bus!: Vue;

}
</script>

<style lang="scss">

.masonry-item {
  /*width: 400px;*/
}

</style>
