import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {LoginComponent} from './login/login.component';
import {NgxAuthRoutingModule} from './auth-routing.module';
import {NbAuthJWTToken, NbAuthModule, NbPasswordAuthStrategy, NbTokenLocalStorage} from '@nebular/auth';
import {NbAlertModule, NbButtonModule, NbCheckboxModule, NbInputModule} from '@nebular/theme';
import {FormsModule} from '@angular/forms';
import {RouterModule} from '@angular/router';
import {RequestPasswordComponent} from './request-password/request-password.component';
import {ResetPasswordComponent} from './reset-password/reset-password.component';
import * as GlobalVariable from '../common/globals';

@NgModule({
  providers: [NbTokenLocalStorage],
  declarations: [LoginComponent, RequestPasswordComponent, ResetPasswordComponent],
  imports: [
    CommonModule,
    FormsModule,
    RouterModule,
    NbAlertModule,
    NbInputModule,
    NbButtonModule,
    NbCheckboxModule,
    NgxAuthRoutingModule,

    NbAuthModule.forRoot({
      strategies: [
        NbPasswordAuthStrategy.setup({
          name: 'email',
          baseEndpoint: GlobalVariable.baseEndpoint,
          login: {
            endpoint: '/login',
            method: 'post',
            redirect: {
              success: '/',
              failure: null,
            },
          },
          requestPass: {
            endpoint: '/request-pass',
            method: 'post',
          },
          resetPass: {
            endpoint: '/reset-pass',
            method: 'post',
          },
        }),
      ],
      forms: {},
    }),
  ],
})
export class AuthModule {
}
