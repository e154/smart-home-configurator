/*
 * This file is part of the Smart Home
 * Program complex distribution https://github.com/e154/smart-home
 * Copyright (C) 2016-2020, Filippov Alex
 *
 * This library is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library.  If not, see
 * <https://www.gnu.org/licenses/>.
 */

import {RouterModule} from '@angular/router'; // we also need angular router for Nebular to function properly
import {
  NbActionsModule,
  NbButtonModule, NbIconModule,
  NbLayoutModule, NbMenuModule,
  NbSidebarModule,
  NbThemeModule
} from '@nebular/theme';
import {NgModule} from '@angular/core';
import {DashboardComponent} from './dashboard.component';
import {DashboardRoutingModule} from './dashboard-routing.module';
import {NbEvaIconsModule} from '@nebular/eva-icons';

@NgModule({
  declarations: [DashboardComponent],
  imports: [
    RouterModule, // RouterModule.forRoot(routes, { useHash: true }), if this is your app.module
    NbLayoutModule,
    NbActionsModule,
    NbSidebarModule.forRoot(), // NbSidebarModule.forRoot(), //if this is your app.module
    NbThemeModule.forRoot({name: 'dark'}),
    NbButtonModule,
    DashboardRoutingModule,
    NbEvaIconsModule,
    NbIconModule,
    NbMenuModule.forRoot(),
  ],
})
export class DashboardModule {

}
