import {NgModule} from '@angular/core';
import {NbMenuModule, NbSidebarModule, NbThemeModule} from '@nebular/theme';
import { of as observableOf } from 'rxjs/observable/of';

import {ThemeModule} from '../@theme/theme.module';
import {PagesComponent} from './pages.component';
import {PagesRoutingModule} from './pages-routing.module';
import {MiscellaneousModule} from './miscellaneous/miscellaneous.module';
import {UserService} from '../@core/mock/users.service';
import {LayoutService} from '../@core/utils';
import {NbRoleProvider, NbSecurityModule} from '@nebular/security';
import {BrowserAnimationsModule, NoopAnimationsModule} from '@angular/platform-browser/animations';

@NgModule({
  providers: [UserService, LayoutService,   {
    provide: NbRoleProvider,
    useValue: {
      getRole: () => {
        // here we simply return a list of roles for current user
        return observableOf(['guest', 'user', 'editor']);
      },
    },
  },],
  imports: [
    PagesRoutingModule,
    ThemeModule,
    NbMenuModule,
    MiscellaneousModule,
    NbThemeModule.forRoot(),
    NbMenuModule.forRoot(),
    NbSidebarModule.forRoot(), // NbSidebarModule.forRoot(), //if this is your app.module
    NbSecurityModule,
    NbSecurityModule.forRoot(),
    BrowserAnimationsModule,
    NoopAnimationsModule,
  ],
  declarations: [
    PagesComponent,
  ],
})
export class PagesModule {
}
