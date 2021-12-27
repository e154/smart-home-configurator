import {Injectable} from '@angular/core';
import {User} from '../models/users';
import {NbAclService, NbRoleProvider} from '@nebular/security';
import {BehaviorSubject, Observable, of as observableOf} from 'rxjs';
import * as GlobalVariable from '../common/globals';
import {deserialize} from 'class-transformer';
import {NbAccessControl, NbAclRole} from '@nebular/security/security.options';

@Injectable()
export class UserService extends NbRoleProvider {

  // @ts-ignore
  private currentUser: BehaviorSubject<User> = new BehaviorSubject<User>(null);

  constructor(private aclService: NbAclService) {
    super();

    // set current user params
    this.setUser(deserialize(User, JSON.stringify(GlobalVariable.currentUser)));
  }

  // init(): Promise<Boolean> {
  //   return new Promise<Boolean>((resolve) => {
  //     setTimeout(() => {
  //       console.log("Service is running");
  //       resolve(true);
  //     }, 0);
  //   });
  // }

  setUser(user: User): void {
    this.currentUser.next(user);

    // update role permissions
    const aclRole: NbAclRole = {};
    for (const prop in user.role.access_list) {
      // console.log(prop, user.role.access_list[prop]);
      if (Object.prototype.hasOwnProperty.call(user.role.access_list, prop)) {
        user.role.access_list[prop].forEach((value: string, index, array: string[]) => {
          if (!Object.prototype.hasOwnProperty.call(aclRole, value)) {
            aclRole[value] = new Array<string>();
          }
          (aclRole[value] as Array<string>).push(prop);
        });
      }
    }

    const roleName = this.currentUser.getValue().role.name;
    const accessControl: NbAccessControl = {};
    accessControl[roleName] = aclRole;
    // console.log(accessControl);
    this.aclService.setAccessControl(accessControl);
  }

  getUser(): Observable<User> {
    return this.currentUser;
  }

  getRole(): Observable<string | string[]> {
    return observableOf(this.currentUser.getValue().role.name);
  }
}
