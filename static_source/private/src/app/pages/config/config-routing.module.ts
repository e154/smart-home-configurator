import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {ConfigComponent} from './config.component';

const routes: Routes = [
  {
    path: '',
    component: ConfigComponent
  },
  {
    path: 'entities', loadChildren: () => import('./entities/entities.module').then(m => m.EntitiesModule)
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ConfigRoutingModule {
}
