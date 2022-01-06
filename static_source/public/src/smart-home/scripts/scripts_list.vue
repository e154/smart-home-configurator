<template>
  <div class="app-container">

    <pagination
      v-show="total>listQuery.limit"
      :total="total"
      :page.sync="listQuery.page"
      :limit.sync="listQuery.limit"
      @pagination="getList"
    />

    <el-table
      :key="tableKey"
      v-loading="listLoading"
      :data="list"
      style="width: 100%;"
    >
      <el-table-column
        :label="$t('table.id')"
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
        :label="$t('table.name')"
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
        :label="$t('table.lang')"
        class-name="status-col"
        width="150px"
      >
        <template slot-scope="{row}">
          <el-tag :type="row.lang">
            {{ row.lang }}
          </el-tag>
        </template>
      </el-table-column>

      <el-table-column
        :label="$t('table.description')"
        width="auto"
        align="left"
      >
        <template slot-scope="{row}">
          <span>{{ row.description }}</span>
        </template>
      </el-table-column>

      <el-table-column
        :label="$t('table.createdAt')"
        width="160px"
        align="center"
      >
        <template slot-scope="{row}">
          <span>{{ row.createdAt | parseTime }}</span>
        </template>
      </el-table-column>

      <el-table-column
        :label="$t('table.updatedAt')"
        width="160px"
        align="center"
      >
        <template slot-scope="{row}">
          <span>{{ row.updatedAt | parseTime }}</span>
        </template>
      </el-table-column>

    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="listQuery.page"
      :limit.sync="listQuery.limit"
      @pagination="getList"
    />

  </div>
</template>

<script lang="ts">
import {Component, Vue} from 'vue-property-decorator';
import api, {ApiScript} from '@/api/api';
import Pagination from '@/components/Pagination/index.vue';
import router from '@/router';

@Component({
  name: 'ScriptList',
  components: {
    Pagination
  }
})
export default class extends Vue {
  private tableKey = 0;
  private list: ApiScript[] = [];
  private total = 0;
  private listLoading = true;
  private listQuery = {
    page: 1,
    limit: 20,
    sort: '-createdAt'
  };

  created() {
    this.getList();
  }

  private async getList() {
    this.listLoading = true;
    const {data} = await api.v1.scriptServiceGetScriptList({
      limit: this.listQuery.limit,
      page: this.listQuery.page,
      sort: this.listQuery.sort,
    });

    this.list = data.items;
    this.total = data.meta.total;
    // Just to simulate the time of the request
    setTimeout(() => {
      this.listLoading = false;
    }, 0.5 * 1000);
  }

  private handleFilter() {
    this.listQuery.page = 1;
    this.getList();
  }

  private sortChange(data: any) {
    const {prop, order} = data;
    if (prop === 'id') {
      this.sortByID(order);
    }
  }

  private sortByID(order: string) {
    if (order === 'ascending') {
      this.listQuery.sort = '+id';
    } else {
      this.listQuery.sort = '-id';
    }
    this.handleFilter();
  }

  private getSortClass(key: string) {
    const sort = this.listQuery.sort;
    return sort === `+${key}` ? 'ascending' : 'descending';
  }

  private goto(script: ApiScript) {
    router.push({path: `/scripts/edit/${script.id}`});
  }
}
</script>

<style lang="scss" scoped>
.cursor-pointer {
  cursor: pointer;
}
</style>
