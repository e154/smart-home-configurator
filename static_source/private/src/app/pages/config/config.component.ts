import {Component, OnInit} from '@angular/core';
import {MainMenu} from './config-main-menu';
import {NbMenuItem} from '@nebular/theme';
import {Router} from '@angular/router';

@Component({
  selector: 'app-config',
  templateUrl: './config.component.html',
  styleUrls: ['./config.component.scss']
})
export class ConfigComponent implements OnInit {

  menu = MainMenu;

  constructor(private router: Router) {
  }

  ngOnInit(): void {
  }

  btnClick(item: NbMenuItem): void {
    // tslint:disable-next-line:no-non-null-assertion
    const link: string = item.link!;
    this.router.navigateByUrl(link, {skipLocationChange: true});
  }

}
