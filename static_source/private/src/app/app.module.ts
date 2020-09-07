import {BrowserModule} from '@angular/platform-browser';
import {NgModule} from '@angular/core';

import {AppRoutingModule} from './app-routing.module';
import {AppComponent} from './app.component';
import {HttpClientModule} from '@angular/common/http';
import {AuthModule} from './auth/auth.module';
import {PagesModule} from './pages/pages.module';

const SERVICES = [];

const MODULES = [
  BrowserModule,
  AppRoutingModule,
  HttpClientModule,
  AuthModule,
  PagesModule,
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
  ],
})
export class AppModule {
}
