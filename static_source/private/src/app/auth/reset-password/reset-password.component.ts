import { Component, OnInit } from '@angular/core';
import {NbRequestPasswordComponent, NbResetPasswordComponent} from '@nebular/auth';

@Component({
  templateUrl: './reset-password.component.html',
})
export class ResetPasswordComponent extends NbResetPasswordComponent implements OnInit {

  ngOnInit(): void {
    this.service.onAuthenticationChange()
      .subscribe((isAuthenticated: boolean) => {
        if (isAuthenticated) {
          this.router.navigateByUrl('/');
        }
      });
  }
}
