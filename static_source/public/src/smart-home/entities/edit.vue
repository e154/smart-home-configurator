<template>
  <div class="app-container" v-if="!listLoading">
    <el-row :gutter="20">
      <el-col
        :span="6"
        :xs="24"
      >

        <el-card>
          <el-form label-position="top"
                   ref="currentEntity"
                   :model="currentEntity"
                   :rules="rules"
                   style="width: 100%">
            <el-form-item :label="$t('entities.table.id')" prop="id">
              <el-input disabled v-model.trim="currentEntity.id"/>
            </el-form-item>
            <el-form-item :label="$t('entities.table.pluginName')" prop="pluginName">
              <el-input disabled v-model.trim="currentEntity.pluginName"/>
            </el-form-item>
            <el-form-item :label="$t('entities.table.description')" prop="description">
              <el-input v-model.trim="currentEntity.description"/>
            </el-form-item>
            <el-form-item :label="$t('entities.table.icon')" prop="icon">
              <el-input v-model.trim="currentEntity.icon"/>
            </el-form-item>
            <el-form-item :label="$t('entities.table.autoLoad')" prop="autoLoad">
              <el-switch v-model="currentEntity.autoLoad"></el-switch>
            </el-form-item>
            <el-form-item :label="$t('entities.table.parent')" prop="parent">
              <entity-search
                v-model="currentEntity.parent"
                @update-value="changedParent"
              />
            </el-form-item>
            <el-form-item :label="$t('entities.table.area')" prop="area">
              <area-search
                :multiple=false
                v-model="currentEntity.area"
                @update-value="changedArea"
              />
            </el-form-item>
            <el-form-item :label="$t('entities.table.createdAt')">
              <div>{{ currentEntity.createdAt | parseTime }}</div>
            </el-form-item>
            <el-form-item :label="$t('entities.table.updatedAt')">
              <div>{{ currentEntity.updatedAt | parseTime }}</div>
            </el-form-item>
          </el-form>
        </el-card>

      </el-col>
      <el-col
        :span="18"
        :xs="24"
      >

        <el-card style="margin-bottom:20px;">
          <el-tabs v-model="internal.activeTab">
            <el-tab-pane
              label="Actions"
              name="actions"
              v-if="internal.pluginOptions.actorCustomActions || Object.keys(internal.pluginOptions.actorActions).length"
            >
              <actions
                v-model="currentEntity.actions"
                :settings="internal.pluginOptions.actorActions"
                :customActions="internal.pluginOptions.actorCustomActions"
              />
            </el-tab-pane>

            <el-tab-pane
              label="States"
              name="states"
              v-if="internal.pluginOptions.actorCustomStates || Object.keys(internal.pluginOptions.actorStates).length"
            >
              <states
                v-model="currentEntity.states"
                :settings="internal.pluginOptions.actorStates"
                :customStates="internal.pluginOptions.actorCustomStates"
                @update-value="changedStates"
              />
            </el-tab-pane>

            <el-tab-pane
              label="Attributes"
              name="attributes"
              v-if="internal.pluginOptions.actorCustomAttrs || Object.keys(internal.pluginOptions.actorAttrs).length"
            >
              <attributes
                v-model="currentEntity.attributes"
                :settings="internal.pluginOptions.actorAttrs"
                :customAttrs="internal.pluginOptions.actorCustomAttrs"
                @update-value="changedAttributes($event, 'attributes')"
              />
            </el-tab-pane>

            <el-tab-pane
              label="Settings"
              name="settings"
              v-if="internal.pluginOptions.actorCustomSetts || Object.keys(internal.pluginOptions.actorSetts).length"
            >
              <attributes
                v-model="currentEntity.settings"
                :settings="internal.pluginOptions.actorSetts"
                :customAttrs="internal.pluginOptions.actorCustomSetts"
                @update-value="changedAttributes($event, 'settings')"
              />
            </el-tab-pane>

            <el-tab-pane
              label="Scripts"
              name="scripts"
            >
              <scripts
                v-model="currentEntity.scripts"
                @update-value="changedScript"
              />
            </el-tab-pane>

            <el-tab-pane
              label="Metrics"
              name="metrics"
            >
              <metrics
                v-model="currentEntity.metrics"
                @update-value="changedScript"
              />
            </el-tab-pane>

          </el-tabs>
        </el-card>

      </el-col>
    </el-row>
    <el-row>
      <el-col :span="24" align="right">
        <el-button type="primary" @click.prevent.stop="save">{{ $t('main.save') }}</el-button>
        <el-button @click.prevent.stop="cancel">{{ $t('main.cancel') }}</el-button>
        <el-button @click.prevent.stop="remove" type="danger">{{ $t('main.remove') }}</el-button>
      </el-col>
    </el-row>
  </div>
</template>

<script lang="ts">

import {Component, Prop, Vue} from 'vue-property-decorator';
import api from '@/api/api';
import {
  ApiArea,
  ApiAttribute,
  ApiEntity,
  ApiEntityParent,
  ApiEntityShort,
  ApiEntityState,
  ApiScript,
} from '@/api/stub';
import router from '@/router';
import Attributes from './components/attributes.vue';
import Scripts from './components/scripts.vue';
import Actions from './components/actions.vue';
import States from './components/states.vue';
import ScriptSearch from '@/smart-home/scripts/components/script_search.vue';
import AreaSearch from '@/smart-home/areas/components/areas_search.vue';
import EntitySearch from './components/entity_search.vue';
import Metrics from './components/metrics.vue';
import {Form} from 'element-ui';

@Component({
  name: 'EntityEditor',
  components: {
    Attributes,
    Scripts,
    Actions,
    States,
    ScriptSearch,
    EntitySearch,
    Metrics,
    AreaSearch
  }
})
export default class extends Vue {
  @Prop({required: true}) private id!: string;

  private listLoading: boolean = true;

  private internal = {
    activeTab: 'actions',
    pluginOptions: undefined
  };

  // entity params
  private currentEntity: ApiEntity = {
    pluginName: '',
    autoLoad: true
  };

  private rules = {
    name: [
      {required: true, trigger: 'blur'},
      {min: 4, max: 255, trigger: 'blur'}
    ],
    description: [
      {required: false, trigger: 'blur'},
      {max: 255, trigger: 'blur'}
    ],
    plugin: [
      {required: false, trigger: 'blur'},
      {max: 255, trigger: 'blur'}
    ]
  };

  created() {
    this.fetchEntity();
  }

  private changedAttributes(value: Map<string, ApiAttribute>, event: any) {
    if (event == 'attributes') {
      if (value) {
        this.$set(this.currentEntity, 'attributes', value);
        // this.currentEntity = Object.assign({}, this.currentEntity, {attributes: value})
      } else {
        this.$set(this.currentEntity, 'attributes', undefined);
      }
    } else if (event == 'settings') {
      if (value) {
        this.$set(this.currentEntity, 'settings', value);
        // this.currentEntity = Object.assign({}, this.currentEntity, {settings: value})
      } else {
        this.$set(this.currentEntity, 'settings', undefined);
      }
    }
  }

  private changedScript(values: ApiScript[], event: any) {
    if (values) {
      this.$set(this.currentEntity, 'scripts', values);
    } else {
      this.$set(this.currentEntity, 'scripts', undefined);
    }
  }

  private changedParent(values: ApiEntityShort, event?: any) {
    if (values) {
      this.$set(this.currentEntity, 'parent', values);
    } else {
      this.$set(this.currentEntity, 'parent', undefined);
    }
  }

  private changedArea(values: ApiArea, event?: any) {
    if (values) {
      this.$set(this.currentEntity, 'area', values);
    } else {
      this.$set(this.currentEntity, 'area', undefined);
    }
  }

  private changedStates(values: ApiEntityState[], event?: any) {
    if (values) {
      this.$set(this.currentEntity, 'states', values);
    } else {
      this.$set(this.currentEntity, 'states', undefined);
    }
  }

  private async fetchEntity() {
    this.listLoading = true;
    const {data} = await api.v1.entityServiceGetEntity(this.id);
    this.currentEntity = data;
    await this.fetchPlugin();
    this.listLoading = false;
  }

  private async fetchPlugin() {
    this.listLoading = true;
    const {data} = await api.v1.pluginServiceGetPluginOptions(this.currentEntity.pluginName);
    this.$set(this.internal, 'pluginOptions', data);
    this.listLoading = false;
  }

  private async save() {
    (this.$refs.currentEntity as Form).validate(async valid => {
      if (!valid) {
        return;
      }
      const entity = {
        pluginName: this.currentEntity.pluginName,
        description: this.currentEntity.description,
        area: this.currentEntity.area,
        icon: this.currentEntity.icon,
        // image?: ApiUpdateEntityRequestImage,
        autoLoad: this.currentEntity.autoLoad,
        parent: this.currentEntity.parent || undefined,
        actions: this.currentEntity.actions,
        states: this.currentEntity.states,
        attributes: this.currentEntity.attributes,
        settings: this.currentEntity.settings,
        scripts: this.currentEntity.scripts,
      };
      const {data} = await api.v1.entityServiceUpdateEntity(this.id, entity);
      if (data) {
        this.$notify({
          title: 'Success',
          message: 'entity updated successfully',
          type: 'success',
          duration: 2000
        });
      }
    });
  }

  private async remove() {
    const {data} = await api.v1.entityServiceDeleteEntity(this.id);
    this.$notify({
      title: 'Success',
      message: 'Delete Successfully',
      type: 'success',
      duration: 2000
    });
    router.push({path: `/entities`});
  }
}
</script>


