import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {LoginComponent} from './login/login.component';
import {NgxAuthRoutingModule} from './auth-routing.module';
import {NbAuthModule, NbPasswordAuthStrategy, NbTokenLocalStorage} from '@nebular/auth';
import {NbAlertModule, NbButtonModule, NbCheckboxModule, NbInputModule} from '@nebular/theme';
import {FormsModule} from '@angular/forms';
import {RouterModule} from '@angular/router';
import {RequestPasswordComponent} from './request-password/request-password.component';
import {ResetPasswordComponent} from './reset-password/reset-password.component';
import * as GlobalVariable from '../@core/common/globals';
import {NbRoleProvider, NbSecurityModule} from '@nebular/security';
import {CoreModule} from '../@core/core.module';
import {UserService} from '../@core/services/user.service';

const SERVICES = [
  NbTokenLocalStorage,
  {provide: NbRoleProvider, useClass: UserService},
];

const MODULES = [
  CoreModule,
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
        },
        logout: {
          endpoint: '/logout',
          method: 'post',
          redirect: {
            success: '/auth/login',
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
  NbSecurityModule.forRoot({
    accessControl: {
      guest: {
        view: ['news', 'comments'],
      },
      user: {
        parent: 'guest',
        create: 'comments',
        view: ['user']
      },
      moderator: {
        parent: 'user',
        create: 'news',
        remove: '*',
      },
    },
  }),
];

const COMPONENTS = [
  LoginComponent,
  RequestPasswordComponent,
  ResetPasswordComponent,
];

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
