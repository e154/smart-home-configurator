import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {LoginComponent} from './login/login.component';
import {
  NbAuthComponent,
  NbAuthService,
  NbAuthTokenParceler,
  NbTokenLocalStorage,
  NbTokenService,
  NbTokenStorage
} from '@nebular/auth';
import {RequestPasswordComponent} from './request-password/request-password.component';
import {ResetPasswordComponent} from './reset-password/reset-password.component';

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
        path: 'request-password',
        component: RequestPasswordComponent
      }
    ],
  }
];

@NgModule({
  providers: [NbAuthService, NbTokenService, {
    provide: NbTokenStorage,
    useClass: NbTokenLocalStorage
  }, NbAuthTokenParceler],
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class NgxAuthRoutingModule {
}
