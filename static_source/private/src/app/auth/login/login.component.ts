import {Component, OnInit} from '@angular/core';
import {NbLoginComponent} from '@nebular/auth';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
})
export class LoginComponent extends NbLoginComponent implements OnInit {

  ngOnInit(): void {
    this.service.onAuthenticationChange()
      .subscribe((isAuthenticated: boolean) => {
        if (isAuthenticated) {
          this.router.navigateByUrl('/');
        }
      });
  }
}
