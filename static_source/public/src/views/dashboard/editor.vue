<template>
  <div class="dashboard-container" v-if="!loading">

    <div id="dashboard-editor">

      <el-tabs
        type="card"
        v-model="internal.activeTab"
        :addable="true"
        :editable="false"
        :closable="false"
        :lazy="false"
        @edit="handleTabsEdit"
        @tab-click="updateCurrentTab"
      >
        <el-tab-pane
          v-for="(tab, index) in tabs"
          :label="tab.name"
          :key="index"
          :style="{ backgroundColor: tab.background }"
        >
          <!--          <editor-tab-mas :item="tab" :bus="bus"/>-->
          <!--          <editor-tab-grid :item="tab" :bus="bus"/>-->
          <editor-tab-muu :tab="tab" :bus="bus"/>

        </el-tab-pane>
      </el-tabs>

      <el-empty v-if="tabs.length === 0" :image-size="200" description="please add tab"></el-empty>

    </div>

    <div id="control-panel">
      <el-row :gutter="20" v-if="tabs.length">

        <el-col :span="6">

          <el-card shadow="hover">
            <div slot="header" class="clearfix">
              <span>Tab details</span>
            </div>

            <el-form label-position="top"
                     :model="internal.currentTab"
                     style="width: 100%"
                     :rules="tabRules"
                     ref="tabForm">
              <el-form-item label="name" prop="name">
                <el-input size="small" v-model="internal.currentTab.name"></el-input>
              </el-form-item>
              <el-form-item label="icon" prop="icon">
                <el-input size="small" v-model="internal.currentTab.icon"></el-input>
              </el-form-item>
              <el-form-item label="columnWidth" prop="columnWidth">
                <el-input-number size="small" v-model="internal.currentTab.columnWidth" :min="50"
                                 :max="1024"></el-input-number>
              </el-form-item>
              <el-form-item label="gap" prop="gap">
                <el-input-number size="small" v-model="internal.currentTab.gap" :min="0"
                                 :max="1024"></el-input-number>
              </el-form-item>
              <el-form-item label="background" prop="background">
                <el-color-picker v-model="internal.currentTab.background"></el-color-picker>
              </el-form-item>
              <el-form-item label="enabled" prop="enabled">
                <el-switch v-model="internal.currentTab.enabled"></el-switch>
              </el-form-item>
              <el-form-item label="dragEnabled" prop="dragEnabled">
                <el-switch v-model="internal.currentTab.dragEnabled"></el-switch>
              </el-form-item>
            </el-form>
            <div style="text-align: right">
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

          </el-card>


        </el-col>

        <el-col :span="12">
          <div v-if="internal.currentTab.id">
            <div style="padding: 0 0 20px 0">
              <el-button type="default" @click.prevent.stop="addCard"><i class="el-icon-plus"/> add new</el-button>
            </div>
          </div>

          <div v-if="internal.currentCard && internal.currentCard.id">

            <el-card shadow="hover">
              <div slot="header" class="clearfix">
                <span>Card details</span>
              </div>

              <el-form label-position="top"
                       :model="internal.currentCard"
                       style="width: 100%"
                       :rules="cardRules"
                       ref="cardForm">
                <el-form-item label="title" prop="title">
                  <el-input size="small" v-model="internal.currentCard.title"></el-input>
                </el-form-item>

                <el-form-item label="height" prop="height">
                  <el-input-number size="small" v-model="internal.currentCard.height" :min="10"
                                    :max="1024"></el-input-number>
                </el-form-item>

                <el-form-item label="background" prop="background">
                  <el-color-picker v-model="internal.currentCard.background"></el-color-picker>
                </el-form-item>
                <el-form-item label="enabled" prop="enabled">
                  <el-switch v-model="internal.currentCard.enabled"></el-switch>
                </el-form-item>
              </el-form>

              <div style="text-align: right">
                <el-button type="primary" @click.prevent.stop="updateCard">{{ $t('main.update') }}</el-button>
                <el-button type="default" @click.prevent.stop="updateCardCancel">{{ $t('main.cancel') }}</el-button>
                <el-popconfirm
                  :confirm-button-text="$t('main.ok')"
                  :cancel-button-text="$t('main.no')"
                  icon="el-icon-info"
                  icon-color="red"
                  style="margin-left: 10px;"
                  :title="$t('main.are_you_sure_to_do_want_this?')"
                  v-on:confirm="removeCard"
                >
                  <el-button type="danger" icon="el-icon-delete" slot="reference">{{ $t('main.remove') }}</el-button>
                </el-popconfirm>
              </div>


            </el-card>

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
import {
  ApiDashboard,
  ApiDashboardCard,
  ApiDashboardTab,
  ApiNewDashboardCardRequest,
  ApiNewDashboardTabRequest
} from '@/api/stub';
import {Form} from 'element-ui';
import {randColor} from '@/utils/rans';

export interface internalType {
  activeTab: string;
  activeCard: number;
  currentTab: ApiDashboardTab | undefined;
  currentCard: ApiDashboardCard | undefined;
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
  // private currentTab?: ApiDashboardTab;
  // private currentCard?: ApiDashboardCard;
  private loading: boolean = true;
  private currentBoard?: ApiDashboard;
  private tabs: ApiDashboardTab[] = [];
  private bus: Vue = new Vue;
  private internal: internalType = {
    activeTab: "0",
    activeCard: 0,
    currentTab: {} as ApiDashboardTab,
    currentCard: {} as ApiDashboardCard,
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
      this.internal.activeTab = "0";
      this.tabs = this.currentBoard.tabs || [];
      this.updateCurrentTab();
    }
    this.loading = false;
  }

  // ---------------------------------
  // tabs
  // ---------------------------------

  private handleTabsEdit(targetName: string, action: string) {
    console.log('targetName', targetName, 'action', action);
    switch (action) {
      case 'add':
        this.createTab();
        break;
      case 'remove':
    }
  }

  private async createTab() {
    if (!this.currentBoard) {
      return;
    }

    let request: ApiNewDashboardTabRequest = {
      name: 'NEW_TAB' + (this.tabs.length + 1),
      icon: '',
      columnWidth: 300,
      gap: 0,
      background: 'white',
      enabled: true,
      weight: this.tabs.length,
      dashboardId: this.currentBoard.id,
    };
    const {data} = await api.v1.dashboardTabServiceAddDashboardTab(request);
    if (!data) {
      return;
    }

    data.cards = [];
    this.tabs.push(data);
    this.internal.currentTab = {
      id: data.id,
      name: data.name,
      columnWidth: data.columnWidth,
      gap: data.gap,
      background: data.background,
      icon: data.icon,
      enabled: data.enabled,
      weight: data.weight,
      dashboardId: data.dashboardId,
      cards: data.cards || [],
    } as ApiDashboardTab;

    this.internal.activeTab = "" + (this.tabs.length - 1);

    this.internal.currentCard = undefined

    this.$notify({
      title: 'Success',
      message: 'tab created successfully',
      type: 'success',
      duration: 2000
    });
  }

  private async updateTab() {
    if (!this.currentBoard || !this?.internal || !this.internal?.currentTab) {
      return;
    }

    const boardId = this.currentBoard.id;
    let tab: ApiDashboardTab = this.internal.currentTab as ApiDashboardTab;

    (this.$refs.tabForm as Form).validate(async valid => {
      if (!valid) {
        return;
      }

      //todo optimize
      this.tabs[this.internal.activeTab].name = tab.name;
      this.tabs[this.internal.activeTab].icon = tab.icon;
      this.tabs[this.internal.activeTab].columnWidth = tab.columnWidth;
      this.tabs[this.internal.activeTab].gap = tab.gap;
      this.tabs[this.internal.activeTab].background = tab.background;
      this.tabs[this.internal.activeTab].enabled = tab.enabled;
      this.tabs[this.internal.activeTab].weight = tab.weight;
      this.tabs[this.internal.activeTab].dashboardId = tab.dashboardId;

      this.bus.$emit('update_tab', tab.id);

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

  private async removeTab() {
    if (!this.currentBoard) {
      return;
    }

    const tab = this.tabs[this.internal.activeTab];
    if (!tab.id) {
      return;
    }

    const {data} = await api.v1.dashboardTabServiceDeleteDashboardTab(tab.id);
    if (data) {
      this.bus.$emit('remove_tab', tab.id);
      this.internal.currentCard = undefined
      await this.fetchDashboard();
    }
  }

  getSize(): number {
    const number = Math.random();
    if (number < 0.333) {
      return 100;
    }

    if (number < 0.666) {
      return 150;
    }

    return 200;
  }

  private updateCurrentTab() {
    if (!this.tabs.length) {
      this.internal.currentTab = undefined;
      return;
    }
    console.log('click tab', this.internal.activeTab, typeof this.internal.activeTab)
    let tab = this.tabs[this.internal.activeTab];
    this.internal.currentTab = {
      id: tab.id,
      name: tab.name,
      columnWidth: tab.columnWidth,
      gap: tab.gap,
      background: tab.background,
      icon: tab.icon,
      enabled: tab.enabled,
      weight: tab.weight,
      dashboardId: tab.dashboardId,
      cards: tab.cards,
    } as ApiDashboardTab;
    this.bus.$emit('update_tab', tab.id);
  }

  // ---------------------------------
  // cards
  // ---------------------------------
  private onSelectedCard(id: number) {
    if (!this.internal.currentTab || !this.internal.currentTab?.cards) {
      return;
    }
    for (let index in this.internal.currentTab.cards) {
      if (this.internal.currentTab.cards[index].id === id) {
        console.log('set current card', id, index);
        this.internal.activeCard = index as unknown as number;
        let card = this.internal.currentTab.cards[index];
        this.internal.currentCard = {
          id: card.id,
          title: card.title,
          height: card.height,
          width: card.width,
          background: card.background,
          weight: card.weight,
          enabled: card.enabled,
          dashboardTabId: card.dashboardTabId,
          payload: card.payload,
        } as ApiDashboardCard;
      }
    }
  }

  private async addCard() {
    const tab = this.tabs[this.internal.activeTab];

    let request = {
      title: 'new card',
      background: randColor(),
      width: tab.columnWidth,
      height: this.getSize(),
      enabled: true,
      dashboardTabId: tab.id,
      weight: -1,
    } as ApiNewDashboardCardRequest;
    const {data} = await api.v1.dashboardCardServiceAddDashboardCard(request);

    if (data) {

      this.internal.currentCard = {
        id: data.id,
        background: data.background,
        createdAt: data.createdAt,
        dashboardTabId: data.dashboardTabId,
        enabled: data.enabled,
        height: data.height,
        payload: data.payload,
        title: data.title,
        updatedAt: data.updatedAt,
        weight: data.weight,
        width: data.width,
      } as ApiDashboardCard;

      this.tabs[this.internal.activeTab].cards.push({
        id: data.id,
        background: data.background,
        createdAt: data.createdAt,
        dashboardTabId: data.dashboardTabId,
        enabled: data.enabled,
        height: data.height,
        payload: data.payload,
        title: data.title,
        updatedAt: data.updatedAt,
        weight: data.weight,
        width: data.width,
      } as ApiDashboardCard);

      this.internal.activeCard = this.tabs[this.internal.activeTab].cards.length - 1;

    }
  }

  private async updateCard() {
    if (!this.internal?.currentCard) {
      return;
    }

    let card = this.internal?.currentCard;

    const request = {
      background: card.background,
      dashboardTabId: card.dashboardTabId,
      enabled: card.enabled,
      height: card.height,
      weight: card.weight,
      payload: card.payload,
      title: card.title,
      width: card.width,
    };
    const {data} = await api.v1.dashboardCardServiceUpdateDashboardCard(card.id, request);

    if (data) {
      this.$notify({
        title: 'Success',
        message: 'card updated successfully',
        type: 'success',
        duration: 2000
      });
    } else {
      return;
    }

    if (!this.internal.currentTab || !this.internal.currentTab.cards) {
      return;
    }

    this.internal.currentTab.cards[this.internal.activeCard].background = card.background;
    this.internal.currentTab.cards[this.internal.activeCard].createdAt = card.createdAt;
    this.internal.currentTab.cards[this.internal.activeCard].dashboardTabId = card.dashboardTabId;
    this.internal.currentTab.cards[this.internal.activeCard].enabled = card.enabled;
    this.internal.currentTab.cards[this.internal.activeCard].height = card.height;
    this.internal.currentTab.cards[this.internal.activeCard].payload = card.payload;
    this.internal.currentTab.cards[this.internal.activeCard].title = card.title;
    this.internal.currentTab.cards[this.internal.activeCard].updatedAt = card.updatedAt;
    this.internal.currentTab.cards[this.internal.activeCard].weight = card.weight;
    this.internal.currentTab.cards[this.internal.activeCard].width = card.width;
  }

  private updateCardCancel() {
    if (this.internal.currentCard) {
      this.onSelectedCard(this.internal.currentCard.id)
    }
  }

  private async removeCard() {
    if (!this.internal?.currentCard || this.internal?.activeCard == undefined) {
      return;
    }
    let card = this.internal?.currentCard;
    const {data} = await api.v1.dashboardCardServiceDeleteDashboardCard(card.id);
    if (data) {
      this.$notify({
        title: 'Success',
        message: 'card removed successfully',
        type: 'success',
        duration: 2000
      });
    } else {
      return;
    }
    this.tabs[this.internal.activeTab].cards.splice(this.internal?.activeCard, 1);
    this.internal.currentCard = undefined;
    this.bus.$emit('update_tab', tab.id);
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
