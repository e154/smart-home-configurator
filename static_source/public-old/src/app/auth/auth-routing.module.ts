import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {LoginComponent} from './login/login.component';
import {ResetPasswordComponent} from './reset-password/reset-password.component';
import {RequestPasswordComponent} from './request-password/request-password.component';
import {NbAuthComponent, NbAuthService, NbAuthTokenParceler, NbTokenLocalStorage, NbTokenService, NbTokenStorage} from '@nebular/auth';

export const routes: Routes = [
  {
    path: 'auth',
    component: NbAuthComponent,
    children: [
      {
        path: '',
        component: LoginComponent,
      },
      {
        path: 'login',
        component: LoginComponent,
      },
      {
        path: 'reset-pass',
        component: ResetPasswordComponent
      },
      {
        path: 'request-pass',
        component: RequestPasswordComponent
      }
    ]
  },
  {
    path: '**',
    redirectTo: 'auth',
    pathMatch: 'full',
  }
];

@NgModule({
  providers: [NbAuthService, NbTokenService, {
    provide: NbTokenStorage,
    useClass: NbTokenLocalStorage
  }, NbAuthTokenParceler],
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AuthRoutingModule { }
