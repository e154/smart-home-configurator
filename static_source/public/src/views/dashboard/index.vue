<template>
  <div class="app-container">
    <el-row>
      <el-col>
        <el-button type="primary" @click.prevent.stop="add">
          <i class="el-icon-plus"/> {{ $t('dashboard.addNew') }}
        </el-button>

        <el-button type="primary" @click.prevent.stop="showImport = true">{{ $t('main.import') }}</el-button>

        <export-tool
          :title="$t('main.import')"
          :visible="showImport"
          :value="importValue"
          @on-close="showImport=false"
          @on-import="onImport"
          :import-dialog="true"/>

      </el-col>
    </el-row>
    <el-row>
      <el-col>
        <pagination
          v-show="total>listQuery.limit"
          :total="total"
          :page.sync="listQuery.page"
          :limit.sync="listQuery.limit"
          @pagination="getList"
        />
      </el-col>
    </el-row>
    <el-row>
      <el-col>
        <el-table
          :key="tableKey"
          v-loading="listLoading"
          :data="list"
          style="width: 100%;"
          @sort-change="sortChange"
        >
          <el-table-column
            :label="$t('dashboard.table.id')"
            prop="id"
            sortable="custom"
            align="center"
            width="70"
            :class-name="getSortClass('id')"
          >
            <template slot-scope="{row}">
              <span>{{ row.id }}</span>
            </template>
          </el-table-column>

          <el-table-column
            :label="$t('dashboard.table.name')"
            width="140px"
            align="left"
          >
            <template slot-scope="{row}">
          <span class="cursor-pointer"
                @click="goto(row)">
            {{ row.name }}
          </span>
            </template>
          </el-table-column>

          <el-table-column
            :label="$t('dashboard.table.description')"
            width="auto"
            align="left"
          >
            <template slot-scope="{row}">
              <span>{{ row.description }}</span>
            </template>
          </el-table-column>

<!--          <el-table-column
            :label="$t('dashboard.table.enabled')"
            class-name="status-col"
            width="150px"
          >
            <template slot-scope="{row}">

              <el-switch
                v-model="row.enabled"
                :disabled="row.system"
                v-on:change="activate(row)">
              </el-switch>
            </template>

          </el-table-column>-->

          <el-table-column
            :label="$t('dashboard.table.operations')"
            width="90px"
            align="right"
          >
            <template slot-scope="{row, $index}">
              <el-button
                type="text" size="small"
                @click='edit(row, $index)'
              >
                {{ $t('dashboard.table.edit') }}
              </el-button>
            </template>
          </el-table-column>

          <el-table-column
            :label="$t('dashboard.table.createdAt')"
            width="160px"
            align="center"
            sortable="custom"
            prop="createdAt"
            :class-name="getSortClass('createdAt')"
          >
            <template slot-scope="{row}">
              <span>{{ row.createdAt | parseTime }}</span>
            </template>
          </el-table-column>

          <el-table-column
            :label="$t('dashboard.table.updatedAt')"
            width="160px"
            align="center"
            sortable="custom"
            prop="updatedAt"
            :class-name="getSortClass('updatedAt')"
          >
            <template slot-scope="{row}">
              <span>{{ row.updatedAt | parseTime }}</span>
            </template>
          </el-table-column>

        </el-table>
      </el-col>
    </el-row>
    <el-row>
      <el-col>
        <pagination
          v-show="total>0"
          :total="total"
          :page.sync="listQuery.page"
          :limit.sync="listQuery.limit"
          @pagination="getList"
        />
      </el-col>
    </el-row>
  </div>

</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'
import api from '@/api/api'
import Pagination from '@/components/Pagination/index.vue'
import router from '@/router'
import { ApiDashboardShort } from '@/api/stub'
import { Core } from '@/views/dashboard/core'
import ExportTool from '@/components/export-tool/index.vue'

@Component({
  name: 'DashboardList',
  components: {
    ExportTool,
    Pagination
  }
})
export default class extends Vue {
  private tableKey = 0;
  private list: ApiDashboardShort[] = [];
  private total = 0;
  private listLoading = true;
  private listQuery = {
    page: 1,
    limit: 20,
    sort: '-createdAt'
  };

  created() {
    this.getList()
  }

  private async getList() {
    this.listLoading = true
    const { data } = await api.v1.dashboardServiceGetDashboardList({
      limit: this.listQuery.limit,
      page: this.listQuery.page,
      sort: this.listQuery.sort
    })

    this.list = data.items
    this.total = data.meta.total
    this.listLoading = false
  }

  private handleFilter() {
    this.listQuery.page = 1
    this.getList()
  }

  private sortChange(data: any) {
    const { prop, order } = data
    if (prop === 'id') {
      this.sortByID(order)
    } else if (prop === 'createdAt') {
      this.sortByCreatedAt(order)
    } else if (prop === 'updatedAt') {
      this.sortByUpdatedAt(order)
    }
  }

  private sortByCreatedAt(order: string) {
    if (order === 'ascending') {
      this.listQuery.sort = '+createdAt'
    } else {
      this.listQuery.sort = '-createdAt'
    }
    this.handleFilter()
  }

  private sortByUpdatedAt(order: string) {
    if (order === 'ascending') {
      this.listQuery.sort = '+updatedAt'
    } else {
      this.listQuery.sort = '-updatedAt'
    }
    this.handleFilter()
  }

  private sortByID(order: string) {
    if (order === 'ascending') {
      this.listQuery.sort = '+id'
    } else {
      this.listQuery.sort = '-id'
    }
    this.handleFilter()
  }

  private getSortClass(key: string) {
    const sort = this.listQuery.sort
    return sort === `+${key}` ? 'ascending' : 'descending'
  }

  private goto(board: ApiDashboardShort) {
    router.push({ path: `/dashboards/view/${board.id}` })
  }

  private async add() {
    const counter: number = this.list.length
    const dashboard = await Core.createNew('new' + counter)
    if (dashboard) {
      this.$notify({
        title: 'Success',
        message: 'dashboard added successfully',
        type: 'success',
        duration: 2000
      })
      router.push({ path: `/dashboards/edit/${dashboard.id}` })
    }
  }

  private activate(item: ApiDashboardShort) {

  }

  private showImport = false;
  private importValue = '';

  private async onImport(value: string, event?: any) {
    const json = JSON.parse(value)
    const data = await Core._import(json)
    if (data) {
      this.getList()
      this.$notify({
        title: 'Success',
        message: 'dashboard imported successfully',
        type: 'success',
        duration: 2000
      })
    }
  }

  private edit(dashboard: ApiDashboardShort, index: number) {
    router.push({ path: `/dashboards/edit/${dashboard.id}` })
  }
}
</script>

<style lang="scss" scoped>
.cursor-pointer {
  cursor: pointer;
}
</style>
