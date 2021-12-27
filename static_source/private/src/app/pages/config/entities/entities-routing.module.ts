import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {EntitiesComponent} from './entities.component';

const routes: Routes = [
  {
    path: '', component: EntitiesComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class EntitiesRoutingModule {
}
