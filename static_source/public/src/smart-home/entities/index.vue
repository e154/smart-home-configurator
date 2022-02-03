<template>
  <div class="app-container">
    <el-row>
      <el-col>
        <el-button
          @click.prevent.stop="add">
          <i class="el-icon-plus"/> {{ $t('entities.addNew') }}
        </el-button>
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
            :label="$t('entities.table.id')"
            prop="id"
            sortable="custom"
            align="left"
            width="180px"
            :class-name="getSortClass('id')"
          >
            <template slot-scope="{row}">
            <span class="cursor-pointer"
                  @click="goto(row)">
              {{ row.id }}
            </span>
            </template>
          </el-table-column>

          <el-table-column
            :label="$t('entities.table.pluginName')"
            class-name="status-col"
            align="left"
            width="150px"
          >
            <template slot-scope="{row}">
              <el-tag type="info">
                {{ row.pluginName }}
              </el-tag>
            </template>
          </el-table-column>

          <el-table-column
            :label="$t('entities.table.area')"
            class-name="status-col"
            width="150px"
          >
            <template slot-scope="{row}" v-if="row.area">
              <el-tag type="info"
                      class="cursor-pointer"
                      @click="gotoArea(row.area)">
                {{ row.area.name }}
              </el-tag>
            </template>
          </el-table-column>

          <el-table-column
            :label="$t('entities.table.description')"
            width="auto"
            align="left"
          >
            <template slot-scope="{row}">
          <span class="cursor-pointer">
            {{ row.description }}
          </span>
            </template>
          </el-table-column>

          <el-table-column
            :label="$t('entities.table.operations')"
            width="90px"
            align="right"
          >
            <template slot-scope="{row, $index}">
              <el-button
                type="text" size="small"
                @click='reloadEntity(row, $index)'
              >
                {{ $t('entities.table.reload') }}
              </el-button>
            </template>
          </el-table-column>

          <el-table-column
            :label="$t('entities.table.createdAt')"
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
            :label="$t('entities.table.updatedAt')"
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
import {Component, Vue} from 'vue-property-decorator';
import Pagination from '@/components/Pagination/index.vue';
import api from '@/api/api';
import {ApiArea, ApiEntity} from '@/api/stub';
import router from '@/router';

@Component({
  name: 'EntitiesList',
  components: {
    Pagination
  }
})
export default class extends Vue {
  private tableKey = 0;
  private list: ApiEntity[] = [];
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
    const {data} = await api.v1.entityServiceGetEntityList({
      limit: this.listQuery.limit,
      page: this.listQuery.page,
      sort: this.listQuery.sort,
    });

    this.list = data.items;
    this.total = data.meta.total;
    this.listLoading = false;
  }

  private handleFilter() {
    this.listQuery.page = 1;
    this.getList();
  }

  private sortChange(data: any) {
    const {prop, order} = data;
    if (prop === 'id') {
      this.sortByID(order);
    } else if (prop === 'createdAt') {
      this.sortByCreatedAt(order);
    } else if (prop === 'updatedAt') {
      this.sortByUpdatedAt(order);
    }
  }

  private sortByCreatedAt(order: string) {
    if (order === 'ascending') {
      this.listQuery.sort = '+createdAt';
    } else {
      this.listQuery.sort = '-createdAt';
    }
    this.handleFilter();
  }

  private sortByUpdatedAt(order: string) {
    if (order === 'ascending') {
      this.listQuery.sort = '+updatedAt';
    } else {
      this.listQuery.sort = '-updatedAt';
    }
    this.handleFilter();
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

  private goto(entity: ApiEntity) {
    router.push({path: `/entities/edit/${entity.id}`});
  }

  private add() {
    router.push({path: `/entities/new`});
  }

  private gotoArea(area: ApiArea) {
    router.push({path: `/areas/edit/${area.id}`});
  }

  private async reloadEntity(entity: ApiEntity, index: number) {
    if (entity) {
      await api.v1.developerToolsServiceReloadEntity(entity.id);
      this.$notify({
        title: 'Success',
        message: 'entity reloaded successfully',
        type: 'success',
        duration: 2000
      });
    }
  }
}
</script>

<style lang="scss" scoped>

.cursor-pointer {
  cursor: pointer;
}

.pagination-container {

}
</style>
