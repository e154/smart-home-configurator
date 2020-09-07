import {NgModule} from '@angular/core';
import {
  NbActionsModule, NbButtonModule, NbContextMenuModule,
  NbIconModule,
  NbLayoutModule,
  NbMenuModule,
  NbSearchModule, NbSelectModule,
  NbSidebarModule,
  NbThemeModule,
  NbUserModule
} from '@nebular/theme';

import {ThemeModule} from '../@theme/theme.module';
import {PagesComponent} from './pages.component';
import {PagesRoutingModule} from './pages-routing.module';
import {MiscellaneousModule} from './miscellaneous/miscellaneous.module';
import {UserService} from '../@core/mock/users.service';
import {LayoutService} from '../@core/utils';
import {BrowserAnimationsModule, NoopAnimationsModule} from '@angular/platform-browser/animations';
import {NbIsGrantedDirective, NbSecurityModule} from '@nebular/security';
import {NbEvaIconsModule} from '@nebular/eva-icons';

const SERVICES = [
  UserService,
  LayoutService,
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
  NbLayoutModule,
  NbIconModule,
  NbActionsModule,
  NbSecurityModule,
  NbMenuModule,
  NbUserModule,
  NbSearchModule,
  NbContextMenuModule,
  NbButtonModule,
  NbSelectModule,
  NbEvaIconsModule,
];

const COMPONENTS = [
  PagesComponent,
];

@NgModule({
  providers: [
    ...SERVICES
  ],
  imports: [
    ...MODULES
  ],
  declarations: [
    ...COMPONENTS
  ],
})
export class PagesModule {
}
