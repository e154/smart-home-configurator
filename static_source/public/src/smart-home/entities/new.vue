<template>
  <div class="app-container">
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
            <el-form-item :label="$t('entities.table.name')" prop="name">
              <el-input v-model.trim="currentEntity.name"/>
            </el-form-item>
            <el-form-item :label="$t('entities.table.pluginName')" prop="pluginName">
              <plugin-search
                v-model="currentEntity.pluginName"
                @update-value="changedPlugin"/>
            </el-form-item>
            <el-form-item :label="$t('entities.table.description')" prop="description">
              <el-input v-model.trim="currentEntity.description"/>
            </el-form-item>
            <el-form-item :label="$t('entities.table.icon')" prop="icon">
              <el-input v-model.trim="currentEntity.icon"/>
            </el-form-item>
            <el-form-item :label="$t('entities.table.image')" prop="image">
              <image-preview :image="currentEntity.image" @on-select="onSelectImage"/>
            </el-form-item>
            <el-form-item :label="$t('entities.table.autoLoad')" prop="description">
              <el-switch v-model="currentEntity.autoLoad"></el-switch>
            </el-form-item>
            <el-form-item :label="$t('entities.table.parent')" prop="parent">
              <entity-search
                v-model="currentEntity.parent"
                @update-value="changedParent"
              />
            </el-form-item>
          </el-form>

        </el-card>

      </el-col>
      <el-col
        :span="18"
        :xs="24"
        v-if="this.internal.pluginOptions"
      >

        <el-card style="margin-bottom:20px;">
          <el-tabs v-model="internal.activeTab">
            <el-tab-pane
              label="Actions"
              name="actions"
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
              v-if="internal.pluginOptions.actorCustomStates"
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
              v-if="internal.pluginOptions.actorCustomAttrs || internal.pluginOptions.actorAttrs"
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
              v-if="internal.pluginOptions.actorCustomSetts || internal.pluginOptions.actorSetts"
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
        <el-button type="primary" @click.prevent.stop="create">{{ $t('main.create') }}</el-button>
        <el-button @click.prevent.stop="cancel">{{ $t('main.cancel') }}</el-button>
      </el-col>
    </el-row>
  </div>
</template>

<script lang="ts">

import {Component, Vue} from 'vue-property-decorator';
import api from '@/api/api';
import {
  ApiAttribute, ApiEntity,
  ApiEntityParent,
  ApiEntityShort, ApiEntityState,
  ApiImage,
  ApiNewEntityRequest,
  ApiPlugin,
  ApiScript,
} from '@/api/stub';
import router from '@/router';
import Attributes from './components/attributes.vue';
import Scripts from './components/scripts.vue';
import Actions from './components/actions.vue';
import States from './components/states.vue';
import ScriptSearch from '@/smart-home/scripts/components/script_search.vue';
import PluginSearch from '@/smart-home/plugins/components/plugin_search.vue';
import EntitySearch from './components/entity_search.vue';
import Metrics from './components/metrics.vue';
import {Form} from 'element-ui';
import AreaSearch from '@/smart-home/areas/components/areas_search.vue';
import ImagePreview from '@/smart-home/images/preview.vue';

@Component({
  name: 'EntityEditor',
  components: {
    Attributes,
    Scripts,
    Actions,
    States,
    ScriptSearch,
    EntitySearch,
    PluginSearch,
    Metrics,
    AreaSearch,
    ImagePreview
  }
})
export default class extends Vue {

  private internal = {
    activeTab: 'actions',
    pluginOptions: undefined
  };

  // entity params
  private currentEntity: ApiNewEntityRequest = {
    name: '',
    description: '',
    pluginName: '',
    autoLoad: true,
    parent: undefined,
    attributes: new Map<string, ApiAttribute>(),
    settings: new Map<string, ApiAttribute>(),
    metrics: new Map<string, ApiAttribute>(),
    actions: [],
    states: [],
    scripts: [],
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
    pluginName: [
      {required: true, trigger: 'blur'},
      {max: 255, trigger: 'blur'}
    ]
  };

  private changedAttributes(value: Map<string, ApiAttribute>, event: any) {
    if (event == 'attributes') {
      if (value) {
        this.$set(this.currentEntity, 'attributes', value);
      } else {
        this.$set(this.currentEntity, 'attributes', undefined);
      }
    } else if (event == 'settings') {
      if (value) {
        this.$set(this.currentEntity, 'settings', value);
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

  private changedPlugin(value: ApiPlugin, event: any) {
    if (value) {
      this.$set(this.currentEntity, 'pluginName', value.name);
      this.fetchPlugin();
    } else {
      this.$set(this.internal, 'pluginOptions', undefined);
    }
  }

  private changedParent(values: ApiEntityShort, event?: any) {
    if (values) {
      this.$set(this.currentEntity, 'parent', values);
    } else {
      this.$set(this.currentEntity, 'parent', '');
    }
  }

  private changedStates(values: ApiEntityState[], event?: any) {
    if (values) {
      this.$set(this.currentEntity, 'states', values);
    } else {
      this.$set(this.currentEntity, 'states', undefined);
    }
  }

  private async fetchPlugin() {
    if (!this.currentEntity || !this.currentEntity.pluginName) {
      return;
    }
    const {data} = await api.v1.pluginServiceGetPluginOptions(this.currentEntity.pluginName);
    this.$set(this.internal, 'pluginOptions', data);
  }

  private async create() {
    (this.$refs.currentEntity as Form).validate(async valid => {
      if (!valid) {
        return;
      }
      let entity: ApiNewEntityRequest = {
        name: this.currentEntity.name,
        pluginName: this.currentEntity.pluginName,
        description: this.currentEntity.description,
        area: this.currentEntity.area,
        icon: this.currentEntity.icon,
        image: this.currentEntity.image,
        autoLoad: this.currentEntity.autoLoad,
        parent: this.currentEntity.parent || undefined,
        actions: [],
        states: [],
        attributes: this.currentEntity.attributes,
        settings: this.currentEntity.settings,
        scripts: this.currentEntity.scripts,
      };

      // update image
      if (entity.image) {
        entity.image = {id: entity.image.id}
      }

      // update actions
      for (const i in this.currentEntity.actions) {
        let action = Object.assign({}, this.currentEntity.actions[<any>i]);
        if (action.image?.id ) {
          action.image = {id: action.image?.id}
        }
        if (action.script?.id ) {
          action.script = {id: action.script?.id}
        }
        entity.actions?.push(action);
      }

      // update states
      for (const i in this.currentEntity.states) {
        let state = Object.assign({}, this.currentEntity.states[<any>i]);
        if (state.image?.id ) {
          state.image = {id: state.image?.id}
        }
        entity.states?.push(state);
      }

      const {data} = await api.v1.entityServiceAddEntity(entity);
      if (data) {
        router.push({path: `/entities/edit/${data.id}`});
      }
    });
  }

  private cancel() {
    router.push({path: `/entities/list`});
  }

  private onSelectImage(value: ApiImage, event?: any) {
    this.$set(this.currentEntity, 'image', value);
  }

}
</script>

