import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';

import {AuthRoutingModule} from './auth-routing.module';
import {LoginComponent} from './login/login.component';
import {RequestPasswordComponent} from './request-password/request-password.component';
import {ResetPasswordComponent} from './reset-password/reset-password.component';
import {NbAlertModule, NbButtonModule, NbCheckboxModule, NbIconModule, NbInputModule} from '@nebular/theme';
import {NbAuthModule, NbPasswordAuthStrategy, NbTokenLocalStorage} from '@nebular/auth';
import {RouterModule} from '@angular/router';
import {FormsModule} from '@angular/forms';
import * as GlobalVariable from '../@core/common/globals';
import {CoreModule} from '../@core/core.module';
import {WINDOW_PROVIDERS} from '../@core/services/window.service';

const SERVICES = [
  NbTokenLocalStorage,
  WINDOW_PROVIDERS
];

const COMPONENTS = [
  LoginComponent,
  RequestPasswordComponent,
  ResetPasswordComponent,
];

const MODULES = [
  CoreModule,
  CommonModule,
  AuthRoutingModule,
  CommonModule,
  FormsModule,
  RouterModule,
  NbInputModule,
  NbAlertModule,
  NbButtonModule,
  NbCheckboxModule,
  NbIconModule,

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
];

// @ts-ignore
@NgModule({
  providers: [
    ...SERVICES
  ],
  declarations: [
    ...COMPONENTS
  ],
  imports: [
    ...MODULES
  ],
})
export class AuthModule {
}
