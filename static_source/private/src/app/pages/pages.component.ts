import { Component, OnInit } from '@angular/core';
import {NbMenuItem, NbSidebarService} from '@nebular/theme';
import {MainMenu} from './pages-main-menu';
import {UserMenu} from './pages-user-menu';

@Component({
  selector: 'app-pages',
  templateUrl: './pages.component.html',
  styleUrls: ['./pages.component.scss']
})
export class PagesComponent implements OnInit {

  menu = MainMenu;
  userMenu = UserMenu;

  user: any;

  constructor(private readonly sidebarService: NbSidebarService) { }


  ngOnInit(): void {
  }

  toggleSidebar(): boolean {
    this.sidebarService.toggle();
    return false;
  }

  navigateHome(): void {

  }
}
