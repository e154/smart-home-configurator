import { Component, OnInit } from '@angular/core';
import {NbRequestPasswordComponent} from '@nebular/auth';

@Component({
  selector: 'app-request-password',
  templateUrl: './request-password.component.html',
})
export class RequestPasswordComponent extends NbRequestPasswordComponent implements OnInit {

  ngOnInit(): void {
  }

}
