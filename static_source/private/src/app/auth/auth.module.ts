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

@NgModule({
  providers: [
    NbTokenLocalStorage,
    {provide: NbRoleProvider, useClass: UserService},
    ],
  declarations: [
    LoginComponent,
    RequestPasswordComponent,
    ResetPasswordComponent,
  ],
  imports: [
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
  ],
})
export class AuthModule {
}
