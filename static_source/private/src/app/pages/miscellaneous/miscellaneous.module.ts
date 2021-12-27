import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { MiscellaneousRoutingModule } from './miscellaneous-routing.module';
import { MiscellaneousComponent } from './miscellaneous.component';
import { NotFoundComponent } from './not-found/not-found.component';
import {NbButtonModule, NbCardModule, NbThemeModule} from '@nebular/theme';


@NgModule({
  declarations: [
    MiscellaneousComponent,
    NotFoundComponent
  ],
  imports: [
    NbCardModule,
    CommonModule,
    NbButtonModule,
    MiscellaneousRoutingModule
  ]
})
export class MiscellaneousModule { }
