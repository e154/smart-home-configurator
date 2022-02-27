import {ApiDashboardCard, ApiImage} from '@/api/stub';

interface Position {
  width: string;
  height: string;
  transform: string;
}

export interface ItemPayload {
  text?: string;
  image?: ApiImage;
}

export interface ItemParams {
  style: object,
  payload: ItemPayload;
  type?: string;
  width: number;
  height: number;
  transform: string;
}

export class Item {

  _style: object;
  payload: ItemPayload;
  type?: string;
  width: number = 0;
  height: number = 0;
  transform: string;

  constructor(params: ItemParams) {
    this.width = params.width;
    this.height = params.height;
    this.transform = params.transform;
    this.type = params.type;
    this.payload = params.payload;
    this._style = params.style;
  }

  position(): Position {
    return {
      'width': `${this.width}px`,
      'height': `${this.height}px`,
      'transform': this.transform,
    };
  }

  style(): object {
    return {};
  }

}

export class Card {

  model: ApiDashboardCard
  public selectedItem: number = -1;
  public items: Item[] = [];

  constructor(model: ApiDashboardCard) {
    this.model = model;
  }

  addItem(item: Item) {
    this.items.push(item);
  }

  settings(index: number) {
    let selected = index === this.selectedItem;

    let grid = 20;

    return {
      // container: this.$refs.editorContainer,

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
      // elementGuidelines: Array.apply(
      //   null,
      //   document.querySelectorAll('.item-element')
      // )
    };
  }
}

