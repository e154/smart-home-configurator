<template>
  <div class="dashboard-container" v-if="!loading">

    <div id="dashboard-editor">

      <el-tabs
        type="card"
        v-model="internal.activeTab"
        :addable="tabMode !== 'NEW' || tabs.length === 0"
        :editable="false"
        :closable="false"
        :lazy="true"
        @edit="handleTabsEdit"
      >
        <el-tab-pane
          v-for="(tab, index) in tabs"
          :label="tab.name"
          :key="index"
        >
<!--          <editor-tab-mas :item="tab" :bus="bus"/>-->
<!--          <editor-tab-grid :item="tab" :bus="bus"/>-->
          <editor-tab-muu :item="tab" :bus="bus"/>

        </el-tab-pane>
      </el-tabs>

      <el-empty v-if="tabs.length === 0" :image-size="200" description="please add some tabs"></el-empty>

    </div>

    <div id="control-panel">
      <el-row :gutter="20" v-if="tabs.length">

        <el-col :span="6">

          <el-form label-position="top"
                   :model="tabs[internal.activeTab]"
                   style="width: 100%"
                   :rules="tabRules"
                   ref="tabForm">
            <el-form-item label="name" prop="name">
              <el-input size="small" v-model="tabs[internal.activeTab].name"></el-input>
            </el-form-item>
            <el-form-item label="icon" prop="icon">
              <el-input size="small" v-model="tabs[internal.activeTab].icon"></el-input>
            </el-form-item>
            <el-form-item label="columnWidth" prop="columnWidth">
              <el-input-number size="small" v-model="tabs[internal.activeTab].columnWidth" :min="10"
                               :max="1024"></el-input-number>
            </el-form-item>
            <el-form-item label="gap" prop="gap">
              <el-input-number size="small" v-model="tabs[internal.activeTab].gap" :min="0"
                               :max="1024"></el-input-number>
            </el-form-item>
            <el-form-item label="background" prop="background">
              <el-color-picker v-model="tabs[internal.activeTab].background" show-alpha></el-color-picker>
            </el-form-item>
            <el-form-item label="enabled" prop="enabled">
              <el-switch v-model="tabs[internal.activeTab].enabled"></el-switch>
            </el-form-item>
          </el-form>
          <div style="padding: 20px 0; text-align: right" v-if="tabMode === 'NEW' && !tabs[internal.activeTab].id">
            <el-button type="primary" @click.prevent.stop="createTab">{{ $t('main.save') }}</el-button>
            <el-button type="default" @click.prevent.stop="createTabCancel">{{ $t('main.cancel') }}</el-button>
          </div>
          <div v-else style="text-align: right">
            <el-button type="primary" @click.prevent.stop="updateTab">{{ $t('main.update') }}</el-button>
            <el-popconfirm
              :confirm-button-text="$t('main.ok')"
              :cancel-button-text="$t('main.no')"
              icon="el-icon-info"
              icon-color="red"
              style="margin-left: 10px;"
              :title="$t('main.are_you_sure_to_do_want_this?')"
              v-on:confirm="removeTab"
            >
              <el-button type="danger" icon="el-icon-delete" slot="reference">{{ $t('main.remove') }}</el-button>
            </el-popconfirm>
          </div>
        </el-col>

        <el-col :span="12">
          elements:
          <div v-if="tabMode !== 'NEW' && tabs[internal.activeTab].id">
            <div style="padding: 20px 0">
              <el-button type="default" @click.prevent.stop="addCard"><i class="el-icon-plus"/> add new</el-button>
            </div>
          </div>

          <div v-if="tabs[internal.activeTab].cards.length && internal.activeCard">
            <el-form label-position="top"
                     :model="tabs[internal.activeTab].cards[internal.activeCard]"
                     style="width: 100%"
                     :rules="cardRules"
                     ref="tabForm">
              <el-form-item label="title" prop="title">
                <el-input size="small" v-model="tabs[internal.activeTab].cards[internal.activeCard].title"></el-input>
              </el-form-item>

              <el-form-item label="height" prop="height">
                <el-input-number size="small" v-model="tabs[internal.activeTab].cards[internal.activeCard].height" :min="10"
                                 :max="1024"></el-input-number>
              </el-form-item>
              <el-form-item label="gap" prop="gap">
                <el-input-number size="small" v-model="tabs[internal.activeTab].gap" :min="0"
                                 :max="1024"></el-input-number>
              </el-form-item>
              <el-form-item label="background" prop="background">
                <el-color-picker v-model="tabs[internal.activeTab].background" show-alpha></el-color-picker>
              </el-form-item>
              <el-form-item label="enabled" prop="enabled">
                <el-switch v-model="tabs[internal.activeTab].enabled"></el-switch>
              </el-form-item>
            </el-form>
          </div>

        </el-col>
      </el-row>

      <el-empty v-else :image-size="200"></el-empty>

    </div>

  </div>
</template>

<script lang="ts">
import {Component, Vue} from 'vue-property-decorator';
import EditorTabMas from './editor-tab-mas.vue';
import EditorTabGrid from './editor-tab-grid.vue';
import EditorTabMuu from './editor-tab-muu.vue';
import stream from '@/api/stream';
import {UUID} from 'uuid-generator-ts';
import Editor from '@/views/automation/new.vue';
import api from '@/api/api';
import {ApiDashboard, ApiDashboardTab, ApiNewDashboardTabRequest} from '@/api/stub';
import {Form} from 'element-ui';
import {randColor} from '@/utils/rans';

export enum Mode {
  EDIT = 'EDIT',
  NEW = 'NEW'
}

@Component({
  name: 'Main',
  components: {
    Editor,
    EditorTabMas,
    EditorTabGrid,
    EditorTabMuu,
  }
})
export default class extends Vue {
  private loading: boolean = true;
  private currentBoard?: ApiDashboard;
  private tabMode: Mode = Mode.NEW;
  private tabs: ApiDashboardTab[] = [];
  private bus: Vue = new Vue;
  private internal = {
    activeTab: 0,
    activeCard: 0,
    model: 'view',
  };

  // id for streaming subscribe
  private currentID: string = '';

  private tabRules = {
    name: [
      {required: true, trigger: 'blur'},
      {min: 4, max: 255, trigger: 'blur'}
    ],
  };

  private cardRules = {
    title: [
      {required: true, trigger: 'blur'},
      {min: 4, max: 255, trigger: 'blur'}
    ],
  };

  private mounted() {

  }

  created() {
    let uuid = new UUID();
    this.currentID = uuid.getDashFreeUUID();

    this.fetchDashboard();

    this.bus.$on('selected_card', (m: any) => {
      this.onSelectedCard(m);
    });

    setTimeout(() => {
      stream.subscribe('state_changed', this.currentID, this.onStateChanged);
    }, 1000);
  }

  private destroyed() {
    stream.unsubscribe('state_changed', this.currentID);
  }

  private onStateChanged(m: object) {
    // console.log('-------')
    // console.log(m)

    this.bus.$emit('state_changed', m);
  }

  private async fetchDashboard() {
    this.loading = true;
    const {data} = await api.v1.dashboardServiceGetDashboardById(1);
    this.currentBoard = data;
    this.tabs = data.tabs;
    if (this.currentBoard.tabs && this.currentBoard.tabs.length > 0) {
      this.internal.activeTab = 0;
      this.tabs = this.currentBoard.tabs || [];
      this.tabMode = Mode.EDIT;
    } else {
      this.tabMode = Mode.NEW;
    }
    this.loading = false;
  }

  // tabs
  // ---------------------------------

  private handleTabsEdit(targetName: string, action: string) {
    console.log('targetName', targetName, 'action', action);
    switch (action) {
      case 'add':
        this.addNewTab();
        break;
      case 'remove':
    }
  }

  private addNewTab() {
    const tab = {
      columnWidth: 300,
      gap: 10,
      background: 'white',
      name: 'NEW_TAB' + (this.tabs.length + 1),
      enabled: true,
      weight: -1,
      dashboardId: this.currentBoard?.id || 0,
      createdAt: '',
      updatedAt: '',
      id: 0,
      icon: '',
      cards: [],
    };
    this.tabs.push(tab);
    this.internal.activeTab = this.tabs.length - 1;
    this.tabMode = Mode.NEW;
  }

  private async updateTab() {
    if (!this.currentBoard) {
      return;
    }

    const boardId = this.currentBoard.id;
    const tab = this.tabs[this.internal.activeTab];

    (this.$refs.tabForm as Form).validate(async valid => {
      if (!valid) {
        return;
      }

      let request = {
        name: tab.name || '',
        icon: tab.icon,
        columnWidth: tab.columnWidth,
        gap: tab.gap,
        background: tab.background,
        enabled: tab.enabled,
        weight: tab.weight,
        dashboardId: boardId,
      };
      const {data} = await api.v1.dashboardTabServiceUpdateDashboardTab(tab.id, request);
      if (data) {
        this.$notify({
          title: 'Success',
          message: 'tab updated successfully',
          type: 'success',
          duration: 2000
        });
      }
    });


  }

  private async createTab() {
    if (!this.currentBoard) {
      return;
    }
    const boardId = this.currentBoard.id;

    (this.$refs.tabForm as Form).validate(async valid => {
      if (!valid) {
        return;
      }

      const tab = this.tabs[this.internal.activeTab];

      let request: ApiNewDashboardTabRequest = {
        name: tab.name || '',
        icon: tab.icon,
        columnWidth: tab.columnWidth,
        gap: tab.gap,
        background: tab.name,
        enabled: tab.enabled,
        weight: tab.weight,
        dashboardId: boardId,
      };
      const {data} = await api.v1.dashboardTabServiceAddDashboardTab(request);
      this.tabs[this.internal.activeTab].id = data.id;
      this.tabMode = Mode.EDIT;

      if (data) {
        this.$notify({
          title: 'Success',
          message: 'tab created successfully',
          type: 'success',
          duration: 2000
        });
      }
    });
  }

  private createTabCancel() {
    this.tabs.pop();
    this.internal.activeTab = this.tabs.length - 1;
    this.tabMode = Mode.EDIT;
  }

  private async removeTab() {
    if (!this.currentBoard) {
      return;
    }

    const tab = this.tabs[this.internal.activeTab];
    if (!tab.id) {
      return;
    }

    const {data} = await api.v1.dashboardTabServiceDeleteDashboardTab(tab.id);

    await this.fetchDashboard();
  }

  getSize() {
    const number = Math.random();
    if (number < 0.333) {
      return 100;
    }

    if (number < 0.666) {
      return 150;
    }

    return 200;
  }

  // cards
  // ---------------------------------
  private onSelectedCard(index: number) {
    console.log('selected_card12', index)
  }

  private addCard() {
    const tab = this.tabs[this.internal.activeTab];
    console.log('tab.weight', tab.columnWidth)
    const card = {
      id: Math.random(),
      title: 'new card',
      height: this.getSize(),
      width:  tab.columnWidth,
      background: randColor(),
      weight: -1,
      enabled: true,
      dashboardTabId: 1,
      payload: {},
      createdAt: '',
      updatedAt: '',
    }
    tab.cards.push(card);
  }

  private createCard() {
  }

  private createCardCancel() {
  }

  private removeCard() {
  }
}
</script>


<style lang="scss">

.dashboard-container {
  padding-top: 20px;
  position: relative;
}

#dashboard-editor {
  position: relative;
  min-height: 300px;
  max-height: 500px;
  overflow: scroll;
  padding: 0 20px;
}

#control-panel {
  padding: 20px;
  border-top: #2d2f33 1px solid;
}

</style>
