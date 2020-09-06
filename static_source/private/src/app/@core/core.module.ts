import {APP_INITIALIZER, NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {UserService} from './services/user.service';
import {ConsoleService} from './services/console.service';

// export function initFunction(config: UserService) {
//   return () => config.init();
// }

@NgModule({
  providers: [
    ConsoleService,
    UserService,
    // {provide: APP_INITIALIZER, useFactory: initFunction, deps: [UserService], multi: true}
  ],
  imports: [
    CommonModule,
  ],
  exports: [],
  declarations: [],
})
export class CoreModule {
}
