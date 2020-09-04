import {Component} from '@angular/core';
import {NbSidebarService} from "@nebular/theme";
import {LayoutService} from "../../../@core/utils";

@Component({
  selector: 'ngx-one-column-layout',
  styleUrls: ['./one-column.layout.scss'],
  templateUrl: './one-column.layout.html',
})
export class OneColumnLayoutComponent {

  constructor(private sidebarService: NbSidebarService,
              private layoutService: LayoutService) {
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
}
