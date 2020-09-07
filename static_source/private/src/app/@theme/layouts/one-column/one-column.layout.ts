import {Component, OnDestroy, OnInit} from '@angular/core';
import {NbSidebarService} from '@nebular/theme';
import {LayoutService} from '../../../@core/utils';
import {takeUntil} from 'rxjs/operators';
import {Subject} from 'rxjs';
import {UserService} from '../../../@core/mock/users.service';
import {NbRoleProvider} from '@nebular/security';
import {NbAuthService} from '@nebular/auth';

@Component({
  selector: 'ngx-one-column-layout',
  styleUrls: ['./one-column.layout.scss'],
  templateUrl: './one-column.layout.html',
})
export class OneColumnLayoutComponent implements OnInit, OnDestroy {

  private destroy$: Subject<void> = new Subject<void>();
  userPictureOnly = false;
  user: any;

  userMenu = [
    {title: 'Profile', link: '/profile'},
    {title: 'Log out', link: ''},
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
