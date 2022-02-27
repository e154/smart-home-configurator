<template>
  <!-- https://github.com/daybrush/moveable/blob/master/handbook/handbook.md#toc-group -->
  <div class="page main">
    <br>&nbsp;
    <button @click="createItem">Add New</button>&nbsp;
    <button @click="zoom += 0.1">Zoom In</button>&nbsp;
    <button @click="zoom -= 0.1">Zoom Out</button>&nbsp;
    <button @click="zoom = 1">Zoom Reset</button>

    <div ref="editorContainer" class="container">
      <div v-show="dataLabel != null" ref="dataLabel" class="data-label" v-html="dataLabel"/>

      <div
        ref="canvas"
        :key="forceRefresh"
        :style="{
                    'transform': `scale(${this.zoom})`,
                    'position': 'relative',
                    'background-color': 'white',
                    'overflow': 'hidden',
                    'width': '100%',
                    'height': '100%'}"
        @mousedown.self="selectedItem = -1"
      >
        <Moveable
          v-for="(item, index) in items"
          :key="index"
          class="moveable"
          v-bind="moveable(index)"
          @drag="handleDrag"
          @resize="handleResize"
          @rotate="handleRotate"
          @warp="handleWarp"
          @renderEnd="hideDataLabel"
          :style="{
                    'width':   `${item.width}px`,
                    'height':  `${item.height}px`,
                    'transform':  item.transform,
                }"
        >
          <div
            @mousedown.capture="selectItem(index)"
            class="item-element"
            :style="{
                        'background-color': item.bgColor,
                        //'border': selectedItem == index ? '2px dashed red' : 'none',
                    }"
          >{{ item.text }}</div>
        </Moveable>
      </div>
    </div>
  </div>
</template>

<script>
/* eslint-disable no-param-reassign,no-unused-expressions,no-console */
import Moveable from "vue-moveable";

let boxCount = 1;

let randomInt = max => Math.floor(Math.random() * max);

export default {
  components: { Moveable },
  data: () => ({
    items: [
      {
        text: "Hello World",
        bgColor: "orange",
        width: 200,
        height: 200,
        transform: ""
      },
      {
        text: "This is a test",
        bgColor: "lightyellow",
        width: 400,
        height: 40,
        transform: ""
      },
      {
        text: "Hello World",
        bgColor: "cyan",
        width: 300,
        height: 100,
        transform: ""
      }
    ],

    selectedItem: 0,
    zoom: 1,
    forceRefresh: 0,
    dataLabel: null
  }),
  methods: {
    selectItem(index) {
      this.selectedItem = index;
      console.log("selected", index);
    },

    createItem() {
      this.items.push({
        text: "Box #" + boxCount++,
        bgColor: `rgb(${randomInt(255)}, ${randomInt(255)} ,${randomInt(
          255
        )})`,
        width: 300,
        height: 100,
        transform: ""
      });
    },

    moveable(index) {
      let selected = index === this.selectedItem;

      let grid = 20;

      return {
        container: this.$refs.editorContainer,

        draggable: selected,
        throttleDrag: 1, // grid,

        keepRatio: false,
        resizable: selected,
        throttleResize: 1,

        scalable: false,
        throttleScale: 0.01,

        rotatable: selected,
        throttleRotate: 1,
        pinchable: selected,

        origin: false,

        snappable: true,
        snapThreshold: 5,
        horizontalGuidlines: [0],
        verticalGuidlines: [0],
        elementGuidelines: Array.apply(
          null,
          document.querySelectorAll(".item-element")
        )
      };
    },

    handleDrag({ target, transform, beforeTranslate }) {
      console.log("onDrag", transform);
      this.items[this.selectedItem].transform = transform;
      target.style.transform = transform;
    },

    handleResize({ target, width, height, clientX, clientY }) {
      width = Math.round(width);
      height = Math.round(height);

      this.items[this.selectedItem].width = width;
      this.items[this.selectedItem].height = height;
      target.style.width = `${width}px`;
      target.style.height = `${height}px`;
      this.setDataLabel(clientX, clientY, `${width} x ${height}`);
    },

    handleRotate({ target, transform, beforeRotate, clientX, clientY }) {
      this.items[this.selectedItem].transform = transform;
      target.style.transform = transform;
      this.setDataLabel(clientX, clientY, `${beforeRotate}°`);
    },

    handleWarp({ target, transform }) {
      //console.log("onWarp", transform);
      this.items[this.selectedItem].transform = transform;
      target.style.transform = transform;
    },

    setDataLabel(x, y, label) {
      this.$refs.dataLabel.style.left = x + "px";
      this.$refs.dataLabel.style.top = y - 20 + "px";
      this.dataLabel = label;
    },

    hideDataLabel() {
      this.dataLabel = null;
    }
  },

  computed: {},

  watch: {
    zoom: function() {
      console.log("zoom changed", this.zoom);
      this.forceRefresh++;
    }
  }
};
</script>

<style lang="scss">
@import url("https://fonts.googleapis.com/css?family=Open+Sans:300,400,600&display=swap");
@import url("https://fonts.googleapis.com/css?family=Roboto:100&display=swap");
html,
body {
  font-family: "Open Sans", sans-serif;
  position: relative;
  margin: 0;
  padding: 0;
  height: 100%;
  color: #333;
  letter-spacing: 1px;
  background: #f5f5f5;
  font-weight: 300;
}

a {
  text-decoration: none;
  color: #333;
}

.page {
  position: relative;
  width: 100%;
  height: 100%;
  box-sizing: border-box;
}

.page.main {
  z-index: 1;
  min-height: 700px;
}

.container {
  position: relative;
  top: 50px;
  left: 100px;

  /* border: 3px solid red; */
  overflow: scroll;
  width: 70%;
  height: 500px;
}

.data-label {
  position: absolute;
  z-index: 99999999;
  top: 0px;
  left: 0px;
  transform: translate(-200%, -200%);
  background-color: #555;
  color: white;
  padding: 5px 10px;
  border-radius: 3px;
  font-size: 12px;
  white-space: nowrap;
}

.item-element {
  /* border: 1px solid #aaa; */
  position: absolute;
  width: 100%;
  height: 100%;
  overflow: hidden;
  cursor: move;
  user-select: none;
}

.moveable {
  font-family: "Roboto", sans-serif;
  position: absolute;
  width: 300px;
  height: 200px;
  text-align: center;
  font-size: 40px;
  margin: 0 auto;
  font-weight: 100;
  letter-spacing: 1px;
}

.moveable-line {
  /* background: transparent !important; */
  /* border: 0px !important; */
}
</style>
