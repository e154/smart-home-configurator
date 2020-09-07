import { Component, OnInit } from '@angular/core';
import {NbRequestPasswordComponent} from '@nebular/auth';

@Component({
  templateUrl: './request-password.component.html',
})
export class RequestPasswordComponent extends NbRequestPasswordComponent implements OnInit {

  ngOnInit(): void {
    this.service.onAuthenticationChange()
      .subscribe((isAuthenticated: boolean) => {
        if (isAuthenticated) {
          this.router.navigateByUrl('/');
        }
      });
  }
}
