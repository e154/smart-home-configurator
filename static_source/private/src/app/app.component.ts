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

  ngOnInit() {
    this.authService.onAuthenticationChange()
      .subscribe((isAuthenticated: boolean) => {
        console.log(`isAuthenticated2: ${isAuthenticated}`);

      });
  }
}
