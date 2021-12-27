import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { EntitiesRoutingModule } from './entities-routing.module';
import { EntitiesComponent } from './entities.component';
import {NbCardModule, NbLayoutModule} from '@nebular/theme';
import { ListComponent } from './list/list.component';


@NgModule({
  declarations: [
    EntitiesComponent,
    ListComponent
  ],
  imports: [
    CommonModule,
    NbLayoutModule,
    NbCardModule,
    EntitiesRoutingModule
  ]
})
export class EntitiesModule { }
