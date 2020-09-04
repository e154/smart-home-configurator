import {Component, OnInit} from '@angular/core';
import {NbAuthService, NbTokenLocalStorage} from '@nebular/auth';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit {
  title = 'smart home';

  constructor(private authService: NbAuthService, private localStorage: NbTokenLocalStorage) {
  }

  // tslint:disable-next-line:typedef
  ngOnInit() {
    this.localStorage.clear();
    this.authService.logout('email');
    this.authService.onAuthenticationChange()
      .subscribe((isAuthenticated: boolean) => {
        console.log(`isAuthenticated2: ${isAuthenticated}`);
        if (isAuthenticated) {
          window.location.reload();
        }
      });
  }
}
