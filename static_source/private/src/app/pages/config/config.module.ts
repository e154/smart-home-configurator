import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ConfigRoutingModule } from './config-routing.module';
import { ConfigComponent } from './config.component';
import {NbButtonModule, NbCardModule, NbIconModule, NbLayoutModule} from '@nebular/theme';


@NgModule({
  declarations: [
    ConfigComponent
  ],
  imports: [
    CommonModule,
    NbLayoutModule,
    NbButtonModule,
    NbCardModule,
    NbIconModule,
    ConfigRoutingModule
  ]
})
export class ConfigModule { }
