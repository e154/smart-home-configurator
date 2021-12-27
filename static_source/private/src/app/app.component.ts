import {Component, Inject} from '@angular/core';
import {WINDOW} from './@core/services/window.service';
import {baseEndpoint, currentUser} from './@core/common/globals';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'private';

  constructor(@Inject(WINDOW) private window: Window) {
    // console.log(window);
  }
}
