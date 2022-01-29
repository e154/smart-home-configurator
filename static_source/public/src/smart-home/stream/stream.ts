import {ConstantBackoff, Websocket, WebsocketBuilder} from 'websocket-ts';

class Stream {

  ws: Websocket | null = null;

  constructor() {

  }

  connect(url: string, accessToken: string): void {
    if (this.ws) {
      return;
    }
    url = url.replace('http', 'ws') + '/ws?access_token=' + accessToken;
    this.ws = new WebsocketBuilder(url)
      .onOpen(this.onOpen)
      .onClose(this.onClose)
      .onError(this.error)
      .onMessage(this.onMessage)
      .withBackoff(new ConstantBackoff(1000)) // 1000ms = 1s
      .onRetry((i, ev) => {
        console.log('retry');
      })
      .build();
  }

  disconnect(): void {
    if (!this.ws) {
      return;
    }
    this.ws.close();
    this.ws = null;
  }

  private error(ws: Websocket, ev: Event): any {
    console.log('error');
  }

  private onClose(ws: Websocket, ev: CloseEvent): any {
    console.log('closed');
  }

  private onOpen(ws: Websocket, ev: Event): any {
    console.log('opened');
  }

  private onMessage(ws: Websocket, ev: MessageEvent): any {
    ws.send(ev.data);
    console.log('message received');
  }

}

const stream = new Stream();

export default stream;
