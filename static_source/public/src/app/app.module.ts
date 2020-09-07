import {BrowserModule} from '@angular/platform-browser';
import {NgModule} from '@angular/core';

import {AppRoutingModule} from './app-routing.module';
import {AppComponent} from './app.component';
import {HttpClientModule} from '@angular/common/http';
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';
import {NbLayoutModule, NbThemeModule} from '@nebular/theme';
import {NbEvaIconsModule} from '@nebular/eva-icons';
import {AuthModule} from './auth/auth.module';

const SERVICES = [];

const MODULES = [
  BrowserModule,
  AppRoutingModule,
  HttpClientModule,
  BrowserAnimationsModule,
  NbThemeModule.forRoot(),
  NbLayoutModule,
  NbEvaIconsModule,
  AuthModule,
];

const COMPONENTS = [
  AppComponent
];

@NgModule({
  declarations: [
    ...COMPONENTS
  ],
  imports: [
    ...MODULES
  ],
  providers: [
    ...SERVICES
  ],
  bootstrap: [
    AppComponent
  ]
})
export class AppModule {
}
