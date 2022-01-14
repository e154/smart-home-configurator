<template>
  <div class="app-container">
    <el-row :gutter="20">
      <el-col
        :span="6"
        :xs="24"
      >
        <el-card style="margin-bottom:20px;">

          <el-form label-position="top"
                   ref="currentScript"
                   :model="currentScript"
                   :rules="rules"
                   style="width: 100%">
            <el-form-item :label="$t('scripts.table.name')" prop="name">
              <el-input
                size="medium"
                placeholder="Name"
                label="Name"
                v-model="currentScript.name">
              </el-input>
            </el-form-item>

            <el-form-item :label="$t('scripts.table.lang')" prop="lang">
              <el-select v-model="currentScript.lang"
                         size="medium"
                         placeholder="Language"
                         label="Language"
              >
                <el-option
                  v-for="item in options"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </el-form-item>
            <el-form-item :label="$t('scripts.table.lang')" prop="description">
              <el-input
                type="textarea"
                size="medium"
                placeholder="Description"
                label="Description"
                v-model="currentScript.description">
              </el-input>
            </el-form-item>
          </el-form>

        </el-card>
      </el-col>
      <el-col :span="18"
              :xs="24"
              class="json-editor">
        <el-card>
          <textarea ref="textarea"/>
        </el-card>
      </el-col>
    </el-row>

    <el-row>
      <el-col :span="24" align="right" class="buttons">
        <el-button type="primary" @click.prevent.stop="save">{{ $t('main.save') }}</el-button>
        <el-button @click.prevent.stop="cancel">{{ $t('main.cancel') }}</el-button>
        <el-button @click.prevent.stop="copy">{{ $t('main.copy') }}</el-button>
        <el-button @click.prevent.stop="remove" type="danger">{{ $t('main.remove') }}</el-button>
      </el-col>
    </el-row>

  </div>
</template>

<script lang="ts">
import CodeMirror, {Editor} from 'codemirror';
import 'codemirror/addon/lint/lint.css';
import 'codemirror/lib/codemirror.css';
import 'codemirror/theme/darcula.css';
import 'codemirror/mode/coffeescript/coffeescript';
import 'codemirror/addon/lint/lint';
import 'codemirror/addon/lint/json-lint';
import {Component, Prop, Vue, Watch} from 'vue-property-decorator';
import api from '@/api/api';
import {ApiScript} from '@/api/stub';
import router from '@/router';
import {Form} from 'element-ui';

// HACK: have to use script-loader to load jsonlint
/* eslint-disable import/no-webpack-loader-syntax */
require('script-loader!jsonlint');

class elementOption {
  public value: string = '';
  public label: string = '';
}

@Component({
  name: 'ScriptEdit'
})
export default class extends Vue {
  @Prop({required: true}) private id!: number;

  private jsonEditor?: Editor;
  private value?: string = '';
  private listLoading = true;
  private options: elementOption[] = [
    {value: 'coffeescript', label: 'coffeescript'},
    {value: 'javascript', label: 'javascript'},
    {value: 'typescript', label: 'typescript'},
  ];

  private currentScript: ApiScript = {
    name: '',
    description: '',
    source: '',
    lang: 'coffeescript'
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
    lang: [
      {required: true, trigger: 'blur'},
      {max: 255, trigger: 'blur'}
    ]
  };

  private async fetch() {
    this.listLoading = true;
    const {data} = await api.v1.scriptServiceGetScriptById(this.id);
    this.currentScript = data;
    this.setValue(data.source);
    this.listLoading = false;
  }

  created() {
    this.fetch();
  }

  private async save() {
    (this.$refs.currentScript as Form).validate(async valid => {
      if (!valid) {
        return;
      }

      let script: ApiScript = {
        name: this.currentScript.name,
        lang: this.currentScript.lang,
        source: this.getValue(),
        description: this.currentScript.description,
      };
      const {data} = await api.v1.scriptServiceUpdateScriptById(this.id, script);
      if (data) {
        this.$notify({
          title: 'Success',
          message: 'script updated successfully',
          type: 'success',
          duration: 2000
        });
      }
    });
  }

  private cancel() {
    this.fetch();
  }

  private async copy() {
    const {data} = await api.v1.scriptServiceCopyScriptById(this.id);
    router.push({path: `/scripts/edit/${data.id}`});
  }

  private async remove() {
    const {data} = await api.v1.scriptServiceDeleteScriptById(this.id);
    this.$notify({
      title: 'Success',
      message: 'Delete Successfully',
      type: 'success',
      duration: 2000
    });
    router.push({path: `/scripts`});
  }

  @Watch('value')
  private onValueChange(value: string) {
    if (this.jsonEditor) {
      const editorValue = this.jsonEditor.getValue();
      if (value !== editorValue) {
        this.jsonEditor.setValue(JSON.stringify(this.value, null, 2));
      }
    }
  }

  mounted() {
    this.jsonEditor = CodeMirror.fromTextArea(this.$refs.textarea as HTMLTextAreaElement, {
      lineNumbers: true,
      mode: 'application/vnd.coffeescript',
      gutters: ['CodeMirror-lint-markers'],
      theme: 'darcula',
      lint: true
    });

    this.jsonEditor.setValue(JSON.stringify(this.value, null, 2));
    this.jsonEditor.on('change', editor => {
      this.$emit('changed', editor.getValue());
      this.$emit('input', editor.getValue());
    });
  }

  public setValue(value: string) {
    if (this.jsonEditor) {
      this.jsonEditor.setValue(value);
    }
  }

  public getValue() {
    if (this.jsonEditor) {
      return this.jsonEditor.getValue();
    }
    return '';
  }
}
</script>

<style lang="scss">

.buttons {
  margin: 20px 0;
}

.CodeMirror {
  height: auto;
  min-height: 300px;
  font-family: inherit;
}

.CodeMirror-scroll {
  min-height: 300px;
}

.cm span.cm-string {
  color: #F08047;
}
</style>

<style lang="scss" scoped>
.json-editor {
  height: 100%;
  position: relative;
}
</style>
