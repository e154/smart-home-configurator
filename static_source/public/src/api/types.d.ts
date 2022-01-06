export interface IArticleData {
  id: number;
  status: string;
  title: string;
  abstractContent: string;
  fullContent: string;
  sourceURL: string;
  imageURL: string;
  timestamp: string | number;
  platforms: string[];
  disableComment: boolean;
  importance: number;
  author: string;
  reviewer: string;
  type: string;
  pageviews: number;
}

export interface IRoleData {
  key: string;
  name: string;
  description: string;
  routes: any;
}

export interface ITransactionData {
  orderId: string;
  timestamp: string | number;
  username: string;
  price: number;
  status: string;
}

export interface IUserData {
  id: number;
  username: string;
  password: string;
  name: string;
  email: string;
  phone: string;
  avatar: string;
  introduction: string;
  roles: string[];
}

export interface IUserHistory {
  ip: string;
  time: string;
}


export interface IMeta {

}

export interface IRole {
  name: string;
  parent: IRole;
  created_at: string;
  updated_at: string;
}

export interface IUser {
  id: number;
  login: string;
  first_name: string;
  last_name: string;
  lang: string;
  status: string;
  email: string;
  meta: IMeta[];
  history: IUserHistory[];
  // role: IRole;
  created_at: string;
  updated_at: string;
  current_sign_in_at: string;
  last_sign_in_at: string;
}

export interface ISignInfo {
  current_user: IUser;
  access_token: string;
}

