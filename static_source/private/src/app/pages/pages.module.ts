import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PagesRoutingModule } from './pages-routing.module';
import { MiscellaneousModule } from './miscellaneous/miscellaneous.module';
import {
  NbActionsModule, NbButtonModule,
  NbContextMenuModule,
  NbIconModule,
  NbLayoutModule,
  NbMenuModule, NbSearchModule, NbSelectModule,
  NbSidebarModule,
  NbThemeModule,
  NbUserModule
} from '@nebular/theme';
import { PagesComponent } from './pages.component';
import {NbSecurityModule} from '@nebular/security';
import {NbEvaIconsModule} from '@nebular/eva-icons';


@NgModule({
  declarations: [
    PagesComponent
  ],
  imports: [
    CommonModule,
    PagesRoutingModule,
    MiscellaneousModule,
    NbThemeModule.forRoot({name: 'dark'}),
    NbMenuModule.forRoot(),
    NbSidebarModule.forRoot(), // NbSidebarModule.forRoot(), //if this is your app.module
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
  ]
})
export class PagesModule { }
