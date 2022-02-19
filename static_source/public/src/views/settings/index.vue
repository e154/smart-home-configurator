<template>
  <div class="app-container">
    <card-wrapper>
      <el-tabs v-model="internal.activeTab">

        <el-tab-pane
          label="Plugins"
          name="plugins"
        >
          <plugins/>
        </el-tab-pane>

        <el-tab-pane
          label="Variables"
          name="variables"
        >
          <variables/>
        </el-tab-pane>

      </el-tabs>
    </card-wrapper>
  </div>
</template>

<script lang="ts">
import {Component, Vue} from 'vue-property-decorator';
import Plugins from '@/views/plugins/index.vue';
import Variables from '@/views/variables/index.vue';
import CardWrapper from '@/components/card-wrapper/index.vue';

@Component({
  name: 'Settings',
  components: {
    CardWrapper,
    Plugins,
    Variables,
  }
})
export default class extends Vue {
  private internal = {
    activeTab: 'plugins',
    pluginOptions: undefined
  };


}
</script>

<style lang="scss" scoped>

</style>
