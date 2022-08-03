<template>
  <transition name="fade">
    [Unknown item type "{{item.type}}"]
  </transition>
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator'
import { CardItem } from '@/views/dashboard/core'

@Component({
  name: 'Dummy',
  components: {
  }
})
export default class extends Vue {
  @Prop() private item?: CardItem;

  private created() {}
  private mounted() {}
}
</script>

<style scoped>

</style>
