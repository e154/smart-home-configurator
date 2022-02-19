<template>
  <div>
    Button
  </div>
</template>

<script lang="ts">
import {Component, Prop, Vue} from "vue-property-decorator";
import {ApiDashboardCard} from "@/api/stub";

@Component({
  name: 'Button',
  components: {
  }
})
export default class extends Vue {
  @Prop() private item?: ApiDashboardCard;

  private created() {}
  private mounted() {}
}
</script>

<style scoped>

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}
.clearfix:after {
  clear: both
}

</style>
