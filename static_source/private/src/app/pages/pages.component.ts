import {Component, OnDestroy, OnInit} from '@angular/core';

import { MENU_ITEMS } from './pages-menu';
import {Subject} from 'rxjs';
import {NbSidebarService} from '@nebular/theme';
import {UserService} from '../@core/mock/users.service';
import {LayoutService} from '../@core/utils';
import {NbRoleProvider} from '@nebular/security';
import {NbAuthService} from '@nebular/auth';
import {takeUntil} from 'rxjs/operators';

@Component({
  selector: 'ngx-pages',
  styleUrls: ['./pages.component.scss'],
  templateUrl: './pages.component.html'
})
export class PagesComponent implements OnInit, OnDestroy {

  menu = MENU_ITEMS;

  private destroy$: Subject<void> = new Subject<void>();
  userPictureOnly = false;
  user: any;

  userMenu = [
    {title: 'Profile', link: '/profile'},
    {title: 'Log out', link: '/auth/logout'},
  ];

  constructor(private sidebarService: NbSidebarService,
              private userService: UserService,
              private layoutService: LayoutService,
              private roleProvider: NbRoleProvider,
              private authService: NbAuthService) {
  }

  toggleSidebar(): boolean {
    this.sidebarService.toggle(true, 'menu-sidebar');
    this.layoutService.changeLayoutSize();

    return false;
  }

  navigateHome() {
    //   this.menuService.navigateHome();
    //   return false;
  }

  ngOnInit() {
    this.userService.getUsers()
      .pipe(takeUntil(this.destroy$))
      .subscribe((users: any) => this.user = users.nick);

    this.roleProvider.getRole().subscribe((role) => console.log(role));
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }

}

