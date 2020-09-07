import {NgModule} from '@angular/core';
import {NbButtonModule, NbCardModule, NbMenuModule} from '@nebular/theme';

import {ThemeModule} from '../../@theme/theme.module';
import {ConfigRoutingModule} from './config-routing.module';
import {ConfigComponent} from './config.component';

const SERVICES = [];

const MODULES = [
  ThemeModule,
  NbCardModule,
  NbButtonModule,
  NbMenuModule,
  ConfigRoutingModule,
];

const COMPONENTS = [
  ConfigComponent
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
export class ConfigModule {
}
