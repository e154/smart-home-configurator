<template>
  <section class="app-main">
    <transition
      name="fade-transform"
      mode="out-in"
    >
      <keep-alive :include="cachedViews">
        <router-view :key="key" />
      </keep-alive>
    </transition>

    <el-drawer
      :visible.sync="drawer"
      :direction="direction"
      :show-close="false"
      :withHeader="false"
      :before-close="handleClose">
     <div class="terminal-viewer">

     </div>
    </el-drawer>

  </section>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'
import { TagsViewModule } from '@/store/modules/tags-view'

@Component({
  name: 'AppMain',
  components: {
  }
})
export default class extends Vue {
  private drawer: boolean = false
  private direction: string = 'btt'

  get cachedViews() {
    return TagsViewModule.cachedViews
  }

  get key() {
    return this.$route.path
  }

  private handleClose(done: any) {
    done();
  }

  created() {
    this.$root.$on('update-drawer', this.toggleDriver)
  }

  private toggleDriver(event: any) {
    this.drawer = !this.drawer;
  }
}
</script>

<style lang="scss" scoped>
.app-main {
  /* 50= navbar  50  */
  min-height: calc(100vh - 50px);
  width: 100%;
  position: relative;
  overflow: hidden;
}

.fixed-header+.app-main {
  padding-top: 50px;
  height: 100vh;
  overflow: auto;
}

.hasTagsView {
  .app-main {
    /* 84 = navbar + tags-view = 50 + 34 */
    min-height: calc(100vh - 84px);
  }

  .fixed-header+.app-main {
    padding-top: 84px;
  }
}

.terminal-viewer {
  background-color: #000000;
  color: #ffffff;
  padding: 20px;
  height: 100%;
  min-height: 100%;
}
</style>
