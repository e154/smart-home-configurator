import {BrowserModule} from '@angular/platform-browser';

import {AppRoutingModule} from './app-routing.module';
import {AppComponent} from './app.component';
import {PagesModule} from './pages/pages.module';
import {NgModule} from '@angular/core';
import {HttpClientModule} from '@angular/common/http';
import {NbWindowService} from '@nebular/theme';
import {WINDOW_PROVIDERS} from './@core/services/window.service';

const SERVICES = [
  WINDOW_PROVIDERS
];

const MODULES = [
  BrowserModule,
  AppRoutingModule,
  HttpClientModule,
  PagesModule,
];

const COMPONENTS = [
  AppComponent
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
  bootstrap: [
    AppComponent
  ]
})
export class AppModule {
}
