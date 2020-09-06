import { Observable } from 'rxjs';
import {Lang} from './lang';

export class History {
  ip: string;
  time: string;
}

export interface IRoleAccessList {
  [name: string]: string[];
}

export class Role {
  name: string;
  description: string;
  parent?: Role;
  children?: Role;
  created_at: string;
  updated_at: string;
  access_list: IRoleAccessList;
}

export class UserMeta {
  id: bigint;
  key: string;
  value: string;
}

export class User {
  id: bigint;
  nickname: string;
  first_name: string;
  last_name: string;
  email: string;
  history: History[];
  status: string;
  sign_in_count: bigint;
  current_sign_in_ip: string;
  last_sign_in_ip: string;
  created_by: string;
  role: Role;
  meta: UserMeta[];
  lang: Lang;
  current_sign_in_at: string;
  last_sign_in_at: string;
  created_at: string;
  updated_at: string;
}

export interface Contacts {
  user: User;
  type: string;
}

export interface RecentUsers extends Contacts {
  time: number;
}

export abstract class UserData {
  abstract getUsers(): Observable<User[]>;
  abstract getContacts(): Observable<Contacts[]>;
  abstract getRecentUsers(): Observable<RecentUsers[]>;
}
