<template>
  <div>
    <el-empty :image-size="200"></el-empty>
  </div>
</template>

<script lang="ts">
import {Component, Vue} from 'vue-property-decorator';
import ScriptSearch from '@/smart-home/scripts/components/script_search.vue';

@Component({
  name: 'Metrics',
  components: {}
})
export default class extends Vue {

}
</script>
