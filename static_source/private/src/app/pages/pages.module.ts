import {NgModule} from '@angular/core';
import {NbMenuModule, NbSidebarModule, NbThemeModule} from '@nebular/theme';

import {ThemeModule} from '../@theme/theme.module';
import {PagesComponent} from './pages.component';
import {PagesRoutingModule} from './pages-routing.module';
import {MiscellaneousModule} from './miscellaneous/miscellaneous.module';
import {UserService} from '../@core/mock/users.service';
import {LayoutService} from '../@core/utils';
import {BrowserAnimationsModule, NoopAnimationsModule} from '@angular/platform-browser/animations';

const SERVICES = [
  PagesComponent
];

const MODULES = [
  PagesRoutingModule,
  ThemeModule,
  NbMenuModule,
  MiscellaneousModule,
  NbThemeModule.forRoot(),
  NbMenuModule.forRoot(),
  NbSidebarModule.forRoot(), // NbSidebarModule.forRoot(), //if this is your app.module
  BrowserAnimationsModule,
  NoopAnimationsModule,
];

const COMPONENTS = [
  UserService,
  LayoutService,
];

@NgModule({
  providers: [
    ...COMPONENTS
  ],
  imports: [
    ...MODULES
  ],
  declarations: [
    ...SERVICES
  ],
})
export class PagesModule {
}
