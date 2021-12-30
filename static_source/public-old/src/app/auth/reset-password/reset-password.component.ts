import { Component, OnInit } from '@angular/core';
import {NbResetPasswordComponent} from '@nebular/auth';

@Component({
  selector: 'app-reset-password',
  templateUrl: './reset-password.component.html',
})
export class ResetPasswordComponent extends NbResetPasswordComponent implements OnInit {

  ngOnInit(): void {
  }

}
