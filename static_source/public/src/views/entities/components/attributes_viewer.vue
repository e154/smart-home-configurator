<template>
  <el-table
    :data="attributes">
    <el-table-column
      prop="name"
      :label="$t('entities.table.name')"
      width="180px">
      <template slot-scope="{row}">
        <span>{{ row.name }}</span>
      </template>
    </el-table-column>

    <el-table-column
      prop="type"
      :label="$t('entities.table.type')"
      width="150px">
      <template slot-scope="{row}">
        <span>{{ row.type }}</span>
      </template>
    </el-table-column>

    <el-table-column
      width="auto"
      :label="$t('entities.table.value')"
    >

      <template slot-scope="{row}">
        <div v-if="row.type === 'STRING'">
          <span>{{ row.string }}</span>
        </div>
        <div v-if="row.type === 'INT'">
          <span>{{ row.int }}</span>
        </div>
        <div v-if="row.type === 'FLOAT'">
          <span>{{ row.float }}</span>
        </div>
        <div v-if="row.type === 'ARRAY'">
          <span>{{ row.array }}</span>
        </div>
        <div v-if="row.type === 'BOOL'">
          <span>{{ row.bool }}</span>
        </div>
      </template>

    </el-table-column>

  </el-table>
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator'
import { ApiAttribute } from '@/api/stub'

@Component({
  name: 'AttributesViewer',
  components: {}
})
export default class extends Vue {
  @Prop({ required: true }) private value?: Record<string, ApiAttribute>;

  get attributes(): ApiAttribute[] {
    const attr: ApiAttribute[] = []
    if (this.value) {
      for (const key in this.value) {
        attr.push(this.value[key])
      }
    }
    return attr
  }

  set attributes(value: ApiAttribute[]) {

  }
}
</script>
