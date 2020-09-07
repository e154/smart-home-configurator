import {NgModule} from '@angular/core';
import {NbButtonModule, NbCardModule, NbMenuModule} from '@nebular/theme';

import {ThemeModule} from '../../@theme/theme.module';
import {ProfileRoutingModule} from './profile-routing.module';
import {ProfileComponent} from './profile.component';

const SERVICES = [];

const MODULES = [
  ThemeModule,
  NbCardModule,
  NbButtonModule,
  NbMenuModule,
  ProfileRoutingModule,
];

const COMPONENTS = [
  ProfileComponent
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
  ]
})
export class ProfileModule {
}
