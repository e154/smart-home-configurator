import {NgModule} from '@angular/core';
import {NbButtonModule, NbCardModule, NbMenuModule} from '@nebular/theme';

import {ThemeModule} from '../../@theme/theme.module';
import {DashboardRoutingModule} from './dashboard-routing.module';
import {DashboardComponent} from './dashboard.component';

const SERVICES = [];

const MODULES = [
  ThemeModule,
  NbCardModule,
  NbButtonModule,
  NbMenuModule,
  DashboardRoutingModule,
];

const COMPONENTS = [
  DashboardComponent
];

@NgModule({
  imports: [
    ...MODULES
  ],
  declarations: [
    ...COMPONENTS
  ],
  providers: [
    ...SERVICES
  ],
})
export class DashboardModule {
}
