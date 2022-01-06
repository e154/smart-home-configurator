/* eslint-disable */
/* tslint:disable */

/*
 * ---------------------------------------------------------------
 * ## THIS FILE WAS GENERATED VIA SWAGGER-TYPESCRIPT-API        ##
 * ##                                                           ##
 * ## AUTHOR: acacode                                           ##
 * ## SOURCE: https://github.com/acacode/swagger-typescript-api ##
 * ---------------------------------------------------------------
 */

import {Message, MessageBox} from 'element-ui';
import axios, {AxiosInstance, AxiosRequestConfig, AxiosResponse, ResponseType} from 'axios';
import {UserModule} from '@/store/modules/user';

export interface Pagination {
  limit?: number;
  page?: number;
  sort?: string;
}

export interface Search {
  limit?: number;
  offset?: number;
  query?: string;
}

export interface Meta {
  limit: number;
  page: number;
  total: number;
  sort: string;
}

export interface AccessListListOfString {
  items?: string[];
}

export interface SubscribeResponseEvent {
  key?: string;
  events?: string[];
}

export interface UpdateRoleAccessListRequestAccessListDiff {
  items?: Record<string, boolean>;
}

export interface ApiAccessItem {
  actions?: string[];
  method?: string;
  description?: string;
  roleName?: string;
}

export interface ApiAccessLevels {
  items?: Record<string, ApiAccessItem>;
}

export interface ApiAccessListResponse {
  /** @format byte */
  accessList?: string;
}

export interface ApiAttribute {
  name?: string;
  type?: string;
}

export interface ApiCurrentUser {
  /** @format int64 */
  id: number;
  nickname?: string;
  firstName?: string;
  lastName?: string;
  email?: string;
  status?: string;
  history?: ApiUserHistory[];
  image?: ApiImage;

  /** @format int64 */
  signInCount?: number;
  meta?: ApiUserMeta[];
  role?: ApiRole;
  lang?: string;

  /** @format date-time */
  createdAt?: string;

  /** @format date-time */
  updatedAt?: string;

  /** @format date-time */
  currentSignInAt?: string;

  /** @format date-time */
  lastSignInAt?: string;
}

export interface ApiDeviceBanRequest {
  /** @format int64 */
  id?: number;
  friendlyName?: string;
}

export interface ApiDeviceRenameRequest {
  friendlyName?: string;
  newName?: string;
}

export interface ApiDeviceWhitelistRequest {
  /** @format int64 */
  id?: number;
  friendlyName?: string;
}

export type ApiDisablePluginResult = object;

export type ApiEnablePluginResult = object;

export interface ApiEntityActionShort {
  name?: string;
  description?: string;
  imageUrl?: string;
  icon?: string;
}

export interface ApiEntityStateShort {
  name?: string;
  description?: string;
  imageUrl?: string;
  icon?: string;
}

export interface ApiExecScriptResult {
  result?: string;
}

export interface ApiExecSrcScriptRequest {
  lang?: string;
  name?: string;
  source?: string;
  description?: string;
}

export interface ApiGetBridgeListResult {
  items: ApiZigbee2MqttShort[];
  meta: Meta;
}

export interface ApiGetImageListResult {
  items: ApiImage[];
  meta: Meta;
}


export interface ApiGetPluginListResult {
  items?: ApiPlugin[];
  meta?: Meta;
}

export interface ApiGetPluginOptionsResult {
  triggers?: boolean;
  actors?: boolean;
  actorCustomAttrs?: boolean;
  actorAttrs?: Record<string, ApiAttribute>;
  actorCustomActions?: boolean;
  actorActions?: Record<string, ApiEntityActionShort>;
  actorCustomStates?: boolean;
  actorStates?: Record<string, ApiEntityStateShort>;
  actorSetts?: Record<string, ApiAttribute>;
  setts?: Record<string, ApiAttribute>;
}

export interface ApiGetRoleListResult {
  items?: ApiRole[];
  meta?: Meta;
}

export interface ApiGetScriptListResult {
  items: ApiScript[];
  meta: Meta;
}

export interface ApiGetUserListResult {
  items?: ApiUserShot[];
  meta?: Meta;
}

/**
 * Message that represents an arbitrary HTTP body. It should only be used for
 payload formats that can't be represented as JSON, such as raw binary or
 an HTML page.


 This message can be used both in streaming and non-streaming API methods in
 the request as well as the response.

 It can be used as a top-level request field, which is convenient if one
 wants to extract parameters from either the URL or HTTP template into the
 request fields and also want access to the raw HTTP body.

 Example:

 message GetResourceRequest {
      // A unique request id.
      string request_id = 1;

      // The raw HTTP body is bound to this field.
      google.api.HttpBody http_body = 2;
    }

 service ResourceService {
      rpc GetResource(GetResourceRequest) returns (google.api.HttpBody);
      rpc UpdateResource(google.api.HttpBody) returns
      (google.protobuf.Empty);
    }

 Example with streaming methods:

 service CaldavService {
      rpc GetCalendar(stream google.api.HttpBody)
        returns (stream google.api.HttpBody);
      rpc UpdateCalendar(stream google.api.HttpBody)
        returns (stream google.api.HttpBody);
    }

 Use of this type only changes how the request and response bodies are
 handled, all other features will continue to work unchanged.
 */
export interface ApiHttpBody {
  /** The HTTP Content-Type header value specifying the content type of the body. */
  contentType?: string;

  /**
   * The HTTP request/response body as raw binary.
   * @format byte
   */
  data?: string;

  /**
   * Application specific response metadata. Must be set in the first response
   * for streaming APIs.
   */
  extensions?: ProtobufAny[];
}

export interface ApiImage {
  /** @format int64 */
  id?: number;
  thumb?: string;
  url?: string;
  image?: string;
  mimeType?: string;
  title?: string;

  /** @format int64 */
  size?: number;
  name?: string;

  /** @format date-time */
  createdAt?: string;
}

export interface ApiNetworkmapResponse {
  networkmap?: string;
}

export interface ApiNewImageRequest {
  thumb?: string;
  image?: string;
  mimeType?: string;
  title?: string;

  /** @format int64 */
  size?: number;
  name?: string;
}

export interface ApiNewRoleRequest {
  name?: string;
  description?: string;
  parent?: string;
}

export interface ApiNewScriptRequest {
  lang?: string;
  name?: string;
  source?: string;
  description?: string;
}

export interface ApiNewZigbee2MqttRequest {
  name?: string;
  login?: string;
  password?: string;
  permitJoin?: boolean;
  baseTopic?: string;
}

export interface ApiNewtUserRequest {
  nickname?: string;
  firstName?: string;
  lastName?: string;
  password?: string;
  passwordRepeat?: string;
  email?: string;
  status?: string;
  lang?: string;
  image?: ApiNewtUserRequestImage;
  role?: ApiNewtUserRequestRole;
  meta?: ApiUserMeta[];
}

export interface ApiNewtUserRequestImage {
  /** @format int64 */
  id?: number;
}

export interface ApiNewtUserRequestRole {
  name?: string;
}

export interface ApiPlugin {
  name?: string;
  version?: string;
  enabled?: boolean;
  system?: boolean;
  settings?: Record<string, ApiAttribute>;
}

export interface ApiRole {
  parent?: ApiRole;
  name?: string;
  description?: string;
  children?: ApiRole[];
  accessList?: ApiRoleAccessList;

  /** @format date-time */
  createdAt?: string;

  /** @format date-time */
  updatedAt?: string;
}

export interface ApiRoleAccessList {
  levels?: Record<string, AccessListListOfString>;
}

export interface ApiRoleAccessListResult {
  levels?: Record<string, ApiAccessLevels>;
}

export interface ApiScript {
  id: number;
  lang: string;
  name: string;
  source: string;
  description: string;

  /** @format date-time */
  createdAt?: string;

  /** @format date-time */
  updatedAt?: string;
}

export interface ApiSearchDeviceResult {
  items?: ApiZigbee2MqttDevice[];
}

export interface ApiSearchRoleListResult {
  items?: ApiRole[];
}

export interface ApiSearchScriptListResult {
  items?: ApiScript[];
}

export interface ApiSigninResponse {
  currentUser: ApiCurrentUser;
  accessToken: string;
}

export interface ApiSubscribeResponse {
  query?: string;
  data?: object;
  events?: SubscribeResponseEvent[];
}

export interface ApiUpdateRoleAccessListRequest {
  name?: string;
  accessListDiff?: Record<string, UpdateRoleAccessListRequestAccessListDiff>;
}

export interface ApiUpdateUserRequestImage {
  /** @format int64 */
  id?: number;
}

export interface ApiUpdateUserRequestRole {
  name?: string;
}

export interface ApiUploadImageRequest {
  /**
   * Message that represents an arbitrary HTTP body. It should only be used for
   * payload formats that can't be represented as JSON, such as raw binary or
   * an HTML page.
   *
   * This message can be used both in streaming and non-streaming API methods in
   * the request as well as the response.
   * It can be used as a top-level request field, which is convenient if one
   * wants to extract parameters from either the URL or HTTP template into the
   * request fields and also want access to the raw HTTP body.
   * Example:
   *     message GetResourceRequest {
   *       // A unique request id.
   *       string request_id = 1;
   *       // The raw HTTP body is bound to this field.
   *       google.api.HttpBody http_body = 2;
   *     }
   *     service ResourceService {
   *       rpc GetResource(GetResourceRequest) returns (google.api.HttpBody);
   *       rpc UpdateResource(google.api.HttpBody) returns
   *       (google.protobuf.Empty);
   * Example with streaming methods:
   *     service CaldavService {
   *       rpc GetCalendar(stream google.api.HttpBody)
   *         returns (stream google.api.HttpBody);
   *       rpc UpdateCalendar(stream google.api.HttpBody)
   * Use of this type only changes how the request and response bodies are
   * handled, all other features will continue to work unchanged.
   */
  httpBody?: ApiHttpBody;
}

export interface ApiUserFull {
  /** @format int64 */
  id?: number;
  nickname: string;
  firstName?: string;
  lastName?: string;
  email: string;
  status?: string;
  history?: ApiUserHistory[];
  image?: ApiImage;

  /** @format int64 */
  signInCount?: number;
  meta?: ApiUserMeta[];
  role?: ApiRole;
  roleName?: string;
  lang?: string;
  authenticationToken?: string;
  currentSignInIp?: string;
  lastSignInIp?: string;
  user?: ApiUserFullParent;

  /** @format date-time */
  createdAt?: string;

  /** @format date-time */
  updatedAt?: string;

  /** @format date-time */
  currentSignInAt?: string;

  /** @format date-time */
  lastSignInAt?: string;

  /** @format date-time */
  resetPasswordSentAt?: string;

  /** @format date-time */
  deletedAt?: string;
}

export interface ApiUserFullParent {
  /** @format int64 */
  id?: number;
  nickname?: string;
}

export interface ApiUserHistory {
  ip?: string;

  /** @format date-time */
  time?: string;
}

export interface ApiUserMeta {
  key?: string;
  value?: string;
}

export interface ApiUserShot {
  /** @format int64 */
  id?: number;
  nickname?: string;
  firstName?: string;
  lastName?: string;
  email?: string;
  status?: string;
  image?: ApiImage;
  lang?: string;
  role?: ApiRole;
  roleName?: string;
  user?: ApiUserShotParent;

  /** @format date-time */
  createdAt?: string;

  /** @format date-time */
  updatedAt?: string;
}

export interface ApiUserShotParent {
  /** @format int64 */
  id?: number;
  nickname?: string;
}

export interface ApiZigbee2Mqtt {
  scanInProcess?: boolean;

  /** @format date-time */
  lastScan?: string;
  networkmap?: string;
  status?: string;

  /** @format int64 */
  id?: number;
  name?: string;
  login?: string;
  permitJoin?: boolean;
  baseTopic?: string;

  /** @format date-time */
  createdAt?: string;

  /** @format date-time */
  updatedAt?: string;
}

export interface ApiZigbee2MqttDevice {
  id?: string;

  /** @format int64 */
  zigbee2mqttId?: number;
  name?: string;
  type?: string;
  model?: string;
  description?: string;
  manufacturer?: string;
  functions?: string[];
  imageUrl?: string;
  status?: string;

  /** @format date-time */
  createdAt?: string;

  /** @format date-time */
  updatedAt?: string;
}

export interface ApiZigbee2MqttShort {
  /** @format int64 */
  id?: number;
  name?: string;
  login?: string;
  permitJoin?: boolean;
  baseTopic?: string;

  /** @format date-time */
  createdAt?: string;

  /** @format date-time */
  updatedAt?: string;
}

/**
 * `Any` contains an arbitrary serialized protocol buffer message along with a
 URL that describes the type of the serialized message.

 Protobuf library provides support to pack/unpack Any values in the form
 of utility functions or additional generated methods of the Any type.

 Example 1: Pack and unpack a message in C++.

 Foo foo = ...;
 Any any;
 any.PackFrom(foo);
 ...
 if (any.UnpackTo(&foo)) {
      ...
    }

 Example 2: Pack and unpack a message in Java.

 Foo foo = ...;
 Any any = Any.pack(foo);
 ...
 if (any.is(Foo.class)) {
      foo = any.unpack(Foo.class);
    }

 Example 3: Pack and unpack a message in Python.

 foo = Foo(...)
 any = Any()
 any.Pack(foo)
 ...
 if any.Is(Foo.DESCRIPTOR):
 any.Unpack(foo)
 ...

 Example 4: Pack and unpack a message in Go

 foo := &pb.Foo{...}
 any, err := anypb.New(foo)
 if err != nil {
       ...
     }
 ...
 foo := &pb.Foo{}
 if err := any.UnmarshalTo(foo); err != nil {
       ...
     }

 The pack methods provided by protobuf library will by default use
 'type.googleapis.com/full.type.name' as the type URL and the unpack
 methods only use the fully qualified type name after the last '/'
 in the type URL, for example "foo.bar.com/x/y.z" will yield type
 name "y.z".


 JSON
 ====
 The JSON representation of an `Any` value uses the regular
 representation of the deserialized, embedded message, with an
 additional field `@type` which contains the type URL. Example:

 package google.profile;
 message Person {
      string first_name = 1;
      string last_name = 2;
    }

 {
      "@type": "type.googleapis.com/google.profile.Person",
      "firstName": <string>,
      "lastName": <string>
    }

 If the embedded message type is well-known and has a custom JSON
 representation, that representation will be embedded adding a field
 `value` which holds the custom JSON in addition to the `@type`
 field. Example (for message [google.protobuf.Duration][]):

 {
      "@type": "type.googleapis.com/google.protobuf.Duration",
      "value": "1.212s"
    }
 */
export interface ProtobufAny {
  /**
   * A URL/resource name that uniquely identifies the type of the serialized
   * protocol buffer message. This string must contain at least
   * one "/" character. The last segment of the URL's path must represent
   * the fully qualified name of the type (as in
   * `path/google.protobuf.Duration`). The name should be in a canonical form
   * (e.g., leading "." is not accepted).
   *
   * In practice, teams usually precompile into the binary all types that they
   * expect it to use in the context of Any. However, for URLs which use the
   * scheme `http`, `https`, or no scheme, one can optionally set up a type
   * server that maps type URLs to message definitions as follows:
   * * If no scheme is provided, `https` is assumed.
   * * An HTTP GET on the URL must yield a [google.protobuf.Type][]
   *   value in binary format, or produce an error.
   * * Applications are allowed to cache lookup results based on the
   *   URL, or have them precompiled into a binary to avoid any
   *   lookup. Therefore, binary compatibility needs to be preserved
   *   on changes to types. (Use versioned type names to manage
   *   breaking changes.)
   * Note: this functionality is not currently available in the official
   * protobuf release, and it is not used for type URLs beginning with
   * type.googleapis.com.
   * Schemes other than `http`, `https` (or the empty scheme) might be
   * used with implementation specific semantics.
   */
  typeUrl?: string;

  /**
   * Must be a valid serialized protocol buffer of the above specified type.
   * @format byte
   */
  value?: string;
}

/**
 * `NullValue` is a singleton enumeration to represent the null value for the
 `Value` type union.

 The JSON representation for `NullValue` is JSON `null`.

 - NULL_VALUE: Null value.
 */
export enum ProtobufNullValue {
  NULL_VALUE = 'NULL_VALUE',
}

export interface RpcStatus {
  /** @format int32 */
  code?: number;
  message?: string;
  details?: ProtobufAny[];
}

export type QueryParamsType = Record<string | number, any>;

export interface FullRequestParams extends Omit<AxiosRequestConfig, 'data' | 'params' | 'url' | 'responseType'> {
  /** set parameter to `true` for call `securityWorker` for this request */
  secure?: boolean;
  /** request path */
  path: string;
  /** content type of request body */
  type?: ContentType;
  /** query params */
  query?: QueryParamsType;
  /** format of response (i.e. response.json() -> format: "json") */
  format?: ResponseType;
  /** request body */
  body?: unknown;
}

export type RequestParams = Omit<FullRequestParams, 'body' | 'method' | 'query' | 'path'>;

export interface ApiConfig<SecurityDataType = unknown> extends Omit<AxiosRequestConfig, 'data' | 'cancelToken'> {
  securityWorker?: (
    securityData: SecurityDataType | null,
  ) => Promise<AxiosRequestConfig | void> | AxiosRequestConfig | void;
  secure?: boolean;
  format?: ResponseType;
}

export enum ContentType {
  Json = 'application/json',
  FormData = 'multipart/form-data',
  UrlEncoded = 'application/x-www-form-urlencoded',
}

export class HttpClient<SecurityDataType = unknown> {
  public instance: AxiosInstance;
  private securityData: SecurityDataType | null = null;
  private securityWorker?: ApiConfig<SecurityDataType>['securityWorker'];
  private secure?: boolean;
  private format?: ResponseType;

  constructor({securityWorker, secure, format, ...axiosConfig}: ApiConfig<SecurityDataType> = {}) {
    this.instance = axios.create({...axiosConfig, baseURL: axiosConfig.baseURL || ''});
    this.secure = secure;
    this.format = format;
    this.securityWorker = securityWorker;
    this.setInterceptors();
  }

  private setInterceptors() {
    // Request interceptors
    this.instance.interceptors.request.use(
      (config) => {
        // Add X-Access-Token header to every request, you can add other custom headers here
        if (UserModule.token) {
          config.headers['Authorization'] = UserModule.token;
        }
        return config;
      },
      (error) => {
        Promise.reject(error);
      }
    );
    // Response interceptors
    this.instance.interceptors.response.use(
      (response) => {
        // Some example codes here:
        // code == 200: success
        // You can change this part for your own usage.
        const res = response.data;
        if (response.status !== 200) {
          Message({
            message: res.message || 'Error',
            type: 'error',
            duration: 5 * 1000
          });
          if (response.status === 401 || response.status === 400) {
            MessageBox.confirm(
              '你已被登出，可以取消继续留在该页面，或者重新登录',
              '确定登出',
              {
                confirmButtonText: '重新登录',
                cancelButtonText: '取消',
                type: 'warning'
              }
            ).then(() => {
              UserModule.ResetToken();
              location.reload(); // To prevent bugs from vue-router
            });
          }
          return Promise.reject(new Error(res.message || 'Error'));
        } else {
          if (response.data && response.data.meta) {
            response.data.meta.limit = +response.data.meta.limit;
            response.data.meta.page = +response.data.meta.page;
            response.data.meta.total = +response.data.meta.total;
          }
          return response;
        }
      },
      (error) => {
        Message({
          message: error.message,
          type: 'error',
          duration: 5 * 1000
        });
        return Promise.reject(error);
      }
    );
  }

  public setSecurityData = (data: SecurityDataType | null) => {
    this.securityData = data;
  };

  private mergeRequestParams(params1: AxiosRequestConfig, params2?: AxiosRequestConfig): AxiosRequestConfig {
    return {
      ...this.instance.defaults,
      ...params1,
      ...(params2 || {}),
      headers: {
        ...(this.instance.defaults.headers || {}),
        ...(params1.headers || {}),
        ...((params2 && params2.headers) || {}),
      },
    };
  }

  private createFormData(input: Record<string, unknown>): FormData {
    return Object.keys(input || {}).reduce((formData, key) => {
      const property = input[key];
      formData.append(
        key,
        property instanceof Blob
          ? property
          : typeof property === 'object' && property !== null
            ? JSON.stringify(property)
            : `${property}`,
      );
      return formData;
    }, new FormData());
  }

  public request = async <T = any, _E = any>({
                                               secure,
                                               path,
                                               type,
                                               query,
                                               format,
                                               body,
                                               ...params
                                             }: FullRequestParams): Promise<AxiosResponse<T>> => {
    const secureParams =
      ((typeof secure === 'boolean' ? secure : this.secure) &&
        this.securityWorker &&
        (await this.securityWorker(this.securityData))) ||
      {};
    const requestParams = this.mergeRequestParams(params, secureParams);
    const responseFormat = (format && this.format) || void 0;

    if (type === ContentType.FormData && body && body !== null && typeof body === 'object') {
      requestParams.headers.common = {Accept: '*/*'};
      requestParams.headers.post = {};
      requestParams.headers.put = {};

      body = this.createFormData(body as Record<string, unknown>);
    }

    return this.instance.request({
      ...requestParams,
      headers: {
        ...(type && type !== ContentType.FormData ? {'Content-Type': type} : {}),
        ...(requestParams.headers || {}),
      },
      params: query,
      responseType: responseFormat,
      data: body,
      url: path,
    });
  };
}

/**
 * @title Smart home api
 * @version 1.0
 * @contact Alex Filippov <support@e154.ru> (https://e154.github.io/smart-home/)
 *
 * This documentation describes APIs found under https://github.com/e154/smart-home
 */
export class Api<SecurityDataType extends unknown> extends HttpClient<SecurityDataType> {
  subscribe = {
    /**
     * No description
     *
     * @tags StreamService
     * @name StreamServiceSubscribe
     * @summary stream
     * @request GET:/subscribe
     * @secure
     */
    streamServiceSubscribe: (query?: { query?: string }, params: RequestParams = {}) =>
      this.request<{ result?: ApiSubscribeResponse; error?: RpcStatus }, RpcStatus>({
        path: `/subscribe`,
        method: 'GET',
        query: query,
        secure: true,
        format: 'json',
        ...params,
      }),
  };
  v1 = {
    /**
     * No description
     *
     * @tags AuthService
     * @name AuthServiceAccessList
     * @summary get user access list object
     * @request GET:/v1/access_list
     * @secure
     */
    authServiceAccessList: (params: RequestParams = {}) =>
      this.request<ApiAccessListResponse, RpcStatus>({
        path: `/v1/access_list`,
        method: 'GET',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags ImageService
     * @name ImageServiceAddImage
     * @summary add new image
     * @request POST:/v1/image
     * @secure
     */
    imageServiceAddImage: (body: ApiNewImageRequest, params: RequestParams = {}) =>
      this.request<ApiImage, RpcStatus>({
        path: `/v1/image`,
        method: 'POST',
        body: body,
        secure: true,
        type: ContentType.Json,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags ImageService
     * @name ImageServiceUploadImage
     * @summary Upload file
     * @request POST:/v1/image/upload
     * @secure
     */
    imageServiceUploadImage: (body: ApiUploadImageRequest, params: RequestParams = {}) =>
      this.request<ApiImage, RpcStatus>({
        path: `/v1/image/upload`,
        method: 'POST',
        body: body,
        secure: true,
        type: ContentType.Json,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags ImageService
     * @name ImageServiceGetImageById
     * @summary get image by id
     * @request GET:/v1/image/{id}
     * @secure
     */
    imageServiceGetImageById: (id: number, params: RequestParams = {}) =>
      this.request<ApiImage, RpcStatus>({
        path: `/v1/image/${id}`,
        method: 'GET',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags ImageService
     * @name ImageServiceDeleteImageById
     * @summary delete image by id
     * @request DELETE:/v1/image/{id}
     * @secure
     */
    imageServiceDeleteImageById: (id: number, params: RequestParams = {}) =>
      this.request<any, RpcStatus>({
        path: `/v1/image/${id}`,
        method: 'DELETE',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags ImageService
     * @name ImageServiceUpdateImageById
     * @summary update image
     * @request PUT:/v1/image/{id}
     * @secure
     */
    imageServiceUpdateImageById: (
      id: number,
      body: { thumb?: string; image?: string; mimeType?: string; title?: string; size?: string; name?: string },
      params: RequestParams = {},
    ) =>
      this.request<ApiImage, RpcStatus>({
        path: `/v1/image/${id}`,
        method: 'PUT',
        body: body,
        secure: true,
        type: ContentType.Json,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags ImageService
     * @name ImageServiceGetImageList
     * @summary get image list
     * @request GET:/v1/images
     * @secure
     */
    imageServiceGetImageList: (
      query?: Pagination,
      params: RequestParams = {},
    ) =>
      this.request<ApiGetImageListResult, RpcStatus>({
        path: `/v1/images`,
        method: 'GET',
        query: query,
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags PluginService
     * @name PluginServiceDisablePlugin
     * @summary disable plugin
     * @request POST:/v1/plugin/{name}/disable
     * @secure
     */
    pluginServiceDisablePlugin: (name: string, params: RequestParams = {}) =>
      this.request<ApiDisablePluginResult, RpcStatus>({
        path: `/v1/plugin/${name}/disable`,
        method: 'POST',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags PluginService
     * @name PluginServiceEnablePlugin
     * @summary enable plugin
     * @request POST:/v1/plugin/{name}/enable
     * @secure
     */
    pluginServiceEnablePlugin: (name: string, params: RequestParams = {}) =>
      this.request<ApiEnablePluginResult, RpcStatus>({
        path: `/v1/plugin/${name}/enable`,
        method: 'POST',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags PluginService
     * @name PluginServiceGetPluginOptions
     * @summary get plugin options
     * @request GET:/v1/plugin/{name}/options
     * @secure
     */
    pluginServiceGetPluginOptions: (name: string, params: RequestParams = {}) =>
      this.request<ApiGetPluginOptionsResult, RpcStatus>({
        path: `/v1/plugin/${name}/options`,
        method: 'GET',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags PluginService
     * @name PluginServiceGetPluginList
     * @summary get plugin list
     * @request GET:/v1/plugins
     * @secure
     */
    pluginServiceGetPluginList: (
      query?: Pagination,
      params: RequestParams = {},
    ) =>
      this.request<ApiGetPluginListResult, RpcStatus>({
        path: `/v1/plugins`,
        method: 'GET',
        query: query,
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags RoleService
     * @name RoleServiceAddRole
     * @summary add new role
     * @request POST:/v1/role
     * @secure
     */
    roleServiceAddRole: (body: ApiNewRoleRequest, params: RequestParams = {}) =>
      this.request<ApiRole, RpcStatus>({
        path: `/v1/role`,
        method: 'POST',
        body: body,
        secure: true,
        type: ContentType.Json,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags RoleService
     * @name RoleServiceUpdateRoleAccessList
     * @summary update role access list
     * @request PUT:/v1/role/n/access_list
     * @secure
     */
    roleServiceUpdateRoleAccessList: (body: ApiUpdateRoleAccessListRequest, params: RequestParams = {}) =>
      this.request<ApiRoleAccessListResult, RpcStatus>({
        path: `/v1/role/n/access_list`,
        method: 'PUT',
        body: body,
        secure: true,
        type: ContentType.Json,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags RoleService
     * @name RoleServiceGetRoleByName
     * @summary get role by name
     * @request GET:/v1/role/{name}
     * @secure
     */
    roleServiceGetRoleByName: (name: string, params: RequestParams = {}) =>
      this.request<ApiRole, RpcStatus>({
        path: `/v1/role/${name}`,
        method: 'GET',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags RoleService
     * @name RoleServiceDeleteRoleByName
     * @summary delete role by name
     * @request DELETE:/v1/role/{name}
     * @secure
     */
    roleServiceDeleteRoleByName: (name: string, params: RequestParams = {}) =>
      this.request<any, RpcStatus>({
        path: `/v1/role/${name}`,
        method: 'DELETE',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags RoleService
     * @name RoleServiceUpdateRoleByName
     * @summary update role
     * @request PUT:/v1/role/{name}
     * @secure
     */
    roleServiceUpdateRoleByName: (
      name: string,
      body: { description?: string; parent?: string },
      params: RequestParams = {},
    ) =>
      this.request<ApiRole, RpcStatus>({
        path: `/v1/role/${name}`,
        method: 'PUT',
        body: body,
        secure: true,
        type: ContentType.Json,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags RoleService
     * @name RoleServiceGetRoleAccessList
     * @summary get role access list
     * @request GET:/v1/role/{name}/access_list
     * @secure
     */
    roleServiceGetRoleAccessList: (name: string, params: RequestParams = {}) =>
      this.request<ApiRoleAccessListResult, RpcStatus>({
        path: `/v1/role/${name}/access_list`,
        method: 'GET',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags RoleService
     * @name RoleServiceGetRoleList
     * @summary get role list
     * @request GET:/v1/roles
     * @secure
     */
    roleServiceGetRoleList: (
      query?: Pagination,
      params: RequestParams = {},
    ) =>
      this.request<ApiGetRoleListResult, RpcStatus>({
        path: `/v1/roles`,
        method: 'GET',
        query: query,
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags RoleService
     * @name RoleServiceSearchRoleByName
     * @summary delete role by name
     * @request GET:/v1/roles/search
     * @secure
     */
    roleServiceSearchRoleByName: (
      query?: Search,
      params: RequestParams = {},
    ) =>
      this.request<ApiSearchRoleListResult, RpcStatus>({
        path: `/v1/roles/search`,
        method: 'GET',
        query: query,
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags ScriptService
     * @name ScriptServiceAddScript
     * @summary add new script
     * @request POST:/v1/script
     * @secure
     */
    scriptServiceAddScript: (body: ApiNewScriptRequest, params: RequestParams = {}) =>
      this.request<ApiScript, RpcStatus>({
        path: `/v1/script`,
        method: 'POST',
        body: body,
        secure: true,
        type: ContentType.Json,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags ScriptService
     * @name ScriptServiceExecSrcScriptById
     * @summary exec src script by id
     * @request POST:/v1/script/exec_src
     * @secure
     */
    scriptServiceExecSrcScriptById: (body: ApiExecSrcScriptRequest, params: RequestParams = {}) =>
      this.request<ApiExecScriptResult, RpcStatus>({
        path: `/v1/script/exec_src`,
        method: 'POST',
        body: body,
        secure: true,
        type: ContentType.Json,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags ScriptService
     * @name ScriptServiceGetScriptById
     * @summary get script by id
     * @request GET:/v1/script/{id}
     * @secure
     */
    scriptServiceGetScriptById: (id: number, params: RequestParams = {}) =>
      this.request<ApiScript, RpcStatus>({
        path: `/v1/script/${id}`,
        method: 'GET',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags ScriptService
     * @name ScriptServiceDeleteScriptById
     * @summary delete script by id
     * @request DELETE:/v1/script/{id}
     * @secure
     */
    scriptServiceDeleteScriptById: (id: number, params: RequestParams = {}) =>
      this.request<any, RpcStatus>({
        path: `/v1/script/${id}`,
        method: 'DELETE',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags ScriptService
     * @name ScriptServiceUpdateScriptById
     * @summary update script
     * @request PUT:/v1/script/{id}
     * @secure
     */
    scriptServiceUpdateScriptById: (
      id: number,
      body: { lang?: string; name?: string; source?: string; description?: string },
      params: RequestParams = {},
    ) =>
      this.request<ApiScript, RpcStatus>({
        path: `/v1/script/${id}`,
        method: 'PUT',
        body: body,
        secure: true,
        type: ContentType.Json,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags ScriptService
     * @name ScriptServiceCopyScriptById
     * @summary copy script by id
     * @request POST:/v1/script/{id}/copy
     * @secure
     */
    scriptServiceCopyScriptById: (id: number, params: RequestParams = {}) =>
      this.request<ApiScript, RpcStatus>({
        path: `/v1/script/${id}/copy`,
        method: 'POST',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags ScriptService
     * @name ScriptServiceExecScriptById
     * @summary exec script by id
     * @request POST:/v1/script/{id}/exec
     * @secure
     */
    scriptServiceExecScriptById: (id: number, params: RequestParams = {}) =>
      this.request<ApiExecScriptResult, RpcStatus>({
        path: `/v1/script/${id}/exec`,
        method: 'POST',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags ScriptService
     * @name ScriptServiceGetScriptList
     * @summary get script list
     * @request GET:/v1/scripts
     * @secure
     */
    scriptServiceGetScriptList: (
      query?: Pagination,
      params: RequestParams = {},
    ) =>
      this.request<ApiGetScriptListResult, RpcStatus>({
        path: `/v1/scripts`,
        method: 'GET',
        query: query,
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags ScriptService
     * @name ScriptServiceSearchScriptById
     * @summary delete script by id
     * @request GET:/v1/scripts/search
     * @secure
     */
    scriptServiceSearchScriptById: (
      query?: Pagination,
      params: RequestParams = {},
    ) =>
      this.request<ApiSearchScriptListResult, RpcStatus>({
        path: `/v1/scripts/search`,
        method: 'GET',
        query: query,
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags AuthService
     * @name AuthServiceSignin
     * @summary sign in user
     * @request POST:/v1/signin
     * @secure
     */
    authServiceSignin: (params: RequestParams = {}) =>
      this.request<ApiSigninResponse, RpcStatus>({
        path: `/v1/signin`,
        method: 'POST',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags AuthService
     * @name AuthServiceSignout
     * @summary sign out user
     * @request POST:/v1/signout
     * @secure
     */
    authServiceSignout: (params: RequestParams = {}) =>
      this.request<any, RpcStatus>({
        path: `/v1/signout`,
        method: 'POST',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags UserService
     * @name UserServiceAddUser
     * @summary add new user
     * @request POST:/v1/user
     * @secure
     */
    userServiceAddUser: (body: ApiNewtUserRequest, params: RequestParams = {}) =>
      this.request<ApiUserFull, RpcStatus>({
        path: `/v1/user`,
        method: 'POST',
        body: body,
        secure: true,
        type: ContentType.Json,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags UserService
     * @name UserServiceGetUserById
     * @summary get user by id
     * @request GET:/v1/user/{id}
     * @secure
     */
    userServiceGetUserById: (id: number, params: RequestParams = {}) =>
      this.request<ApiUserFull, RpcStatus>({
        path: `/v1/user/${id}`,
        method: 'GET',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags UserService
     * @name UserServiceDeleteUserById
     * @summary delete user by id
     * @request DELETE:/v1/user/{id}
     * @secure
     */
    userServiceDeleteUserById: (id: number, params: RequestParams = {}) =>
      this.request<any, RpcStatus>({
        path: `/v1/user/${id}`,
        method: 'DELETE',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags UserService
     * @name UserServiceUpdateUserById
     * @summary update user by id
     * @request PUT:/v1/user/{id}
     * @secure
     */
    userServiceUpdateUserById: (
      id: number,
      body: {
        nickname?: string;
        firstName?: string;
        lastName?: string;
        password?: string;
        passwordRepeat?: string;
        email?: string;
        status?: string;
        lang?: string;
        image?: ApiUpdateUserRequestImage;
        role?: ApiUpdateUserRequestRole;
        meta?: ApiUserMeta[];
      },
      params: RequestParams = {},
    ) =>
      this.request<ApiUserFull, RpcStatus>({
        path: `/v1/user/${id}`,
        method: 'PUT',
        body: body,
        secure: true,
        type: ContentType.Json,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags UserService
     * @name UserServiceGetUserList
     * @summary get user list
     * @request GET:/v1/users
     * @secure
     */
    userServiceGetUserList: (
      query?: Pagination,
      params: RequestParams = {},
    ) =>
      this.request<ApiGetUserListResult, RpcStatus>({
        path: `/v1/users`,
        method: 'GET',
        query: query,
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags Zigbee2mqttService
     * @name Zigbee2MqttServiceGetBridgeList
     * @summary get bridge list
     * @request GET:/v1/zigbee2mqtt/bridge
     * @secure
     */
    zigbee2MqttServiceGetBridgeList: (
      query?: Pagination,
      params: RequestParams = {},
    ) =>
      this.request<ApiGetBridgeListResult, RpcStatus>({
        path: `/v1/zigbee2mqtt/bridge`,
        method: 'GET',
        query: query,
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags Zigbee2mqttService
     * @name Zigbee2MqttServiceAddZigbee2MqttBridge
     * @summary add new bridge
     * @request POST:/v1/zigbee2mqtt/bridge
     * @secure
     */
    zigbee2MqttServiceAddZigbee2MqttBridge: (body: ApiNewZigbee2MqttRequest, params: RequestParams = {}) =>
      this.request<ApiZigbee2Mqtt, RpcStatus>({
        path: `/v1/zigbee2mqtt/bridge`,
        method: 'POST',
        body: body,
        secure: true,
        type: ContentType.Json,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags Zigbee2mqttService
     * @name Zigbee2MqttServiceGetZigbee2MqttBridge
     * @summary get bridge
     * @request GET:/v1/zigbee2mqtt/bridge/{id}
     * @secure
     */
    zigbee2MqttServiceGetZigbee2MqttBridge: (id: number, params: RequestParams = {}) =>
      this.request<ApiZigbee2Mqtt, RpcStatus>({
        path: `/v1/zigbee2mqtt/bridge/${id}`,
        method: 'GET',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags Zigbee2mqttService
     * @name Zigbee2MqttServiceDeleteBridgeById
     * @summary delete bridge by id
     * @request DELETE:/v1/zigbee2mqtt/bridge/{id}
     * @secure
     */
    zigbee2MqttServiceDeleteBridgeById: (id: number, params: RequestParams = {}) =>
      this.request<any, RpcStatus>({
        path: `/v1/zigbee2mqtt/bridge/${id}`,
        method: 'DELETE',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags Zigbee2mqttService
     * @name Zigbee2MqttServiceUpdateBridgeById
     * @summary update bridge by id
     * @request PUT:/v1/zigbee2mqtt/bridge/{id}/bridge
     * @secure
     */
    zigbee2MqttServiceUpdateBridgeById: (
      id: number,
      body: { name?: string; login?: string; password?: string; permitJoin?: boolean; baseTopic?: string },
      params: RequestParams = {},
    ) =>
      this.request<ApiZigbee2Mqtt, RpcStatus>({
        path: `/v1/zigbee2mqtt/bridge/${id}/bridge`,
        method: 'PUT',
        body: body,
        secure: true,
        type: ContentType.Json,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags Zigbee2mqttService
     * @name Zigbee2MqttServiceNetworkmap
     * @summary networkmap
     * @request GET:/v1/zigbee2mqtt/bridge/{id}/networkmap
     * @secure
     */
    zigbee2MqttServiceNetworkmap: (id: number, params: RequestParams = {}) =>
      this.request<ApiNetworkmapResponse, RpcStatus>({
        path: `/v1/zigbee2mqtt/bridge/${id}/networkmap`,
        method: 'GET',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags Zigbee2mqttService
     * @name Zigbee2MqttServiceUpdateNetworkmap
     * @summary update networkmap
     * @request POST:/v1/zigbee2mqtt/bridge/{id}/networkmap
     * @secure
     */
    zigbee2MqttServiceUpdateNetworkmap: (id: number, params: RequestParams = {}) =>
      this.request<any, RpcStatus>({
        path: `/v1/zigbee2mqtt/bridge/${id}/networkmap`,
        method: 'POST',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags Zigbee2mqttService
     * @name Zigbee2MqttServiceResetBridgeById
     * @summary reset bridge by id
     * @request POST:/v1/zigbee2mqtt/bridge/{id}/reset
     * @secure
     */
    zigbee2MqttServiceResetBridgeById: (id: number, params: RequestParams = {}) =>
      this.request<any, RpcStatus>({
        path: `/v1/zigbee2mqtt/bridge/${id}/reset`,
        method: 'POST',
        secure: true,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags Zigbee2mqttService
     * @name Zigbee2MqttServiceDeviceBan
     * @summary device ban
     * @request POST:/v1/zigbee2mqtt/device_ban
     * @secure
     */
    zigbee2MqttServiceDeviceBan: (body: ApiDeviceBanRequest, params: RequestParams = {}) =>
      this.request<any, RpcStatus>({
        path: `/v1/zigbee2mqtt/device_ban`,
        method: 'POST',
        body: body,
        secure: true,
        type: ContentType.Json,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags Zigbee2mqttService
     * @name Zigbee2MqttServiceDeviceRename
     * @summary device rename
     * @request POST:/v1/zigbee2mqtt/device_rename
     * @secure
     */
    zigbee2MqttServiceDeviceRename: (body: ApiDeviceRenameRequest, params: RequestParams = {}) =>
      this.request<any, RpcStatus>({
        path: `/v1/zigbee2mqtt/device_rename`,
        method: 'POST',
        body: body,
        secure: true,
        type: ContentType.Json,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags Zigbee2mqttService
     * @name Zigbee2MqttServiceDeviceWhitelist
     * @summary device whitelist
     * @request POST:/v1/zigbee2mqtt/device_whitelist
     * @secure
     */
    zigbee2MqttServiceDeviceWhitelist: (body: ApiDeviceWhitelistRequest, params: RequestParams = {}) =>
      this.request<any, RpcStatus>({
        path: `/v1/zigbee2mqtt/device_whitelist`,
        method: 'POST',
        body: body,
        secure: true,
        type: ContentType.Json,
        format: 'json',
        ...params,
      }),

    /**
     * No description
     *
     * @tags Zigbee2mqttService
     * @name Zigbee2MqttServiceSearchDevice
     * @summary search device
     * @request GET:/v1/zigbee2mqtt/search_device
     * @secure
     */
    zigbee2MqttServiceSearchDevice: (
      query?: Search,
      params: RequestParams = {},
    ) =>
      this.request<ApiSearchDeviceResult, RpcStatus>({
        path: `/v1/zigbee2mqtt/search_device`,
        method: 'GET',
        query: query,
        secure: true,
        format: 'json',
        ...params,
      }),
  };
}

const api = new Api({
  baseURL: process.env.VUE_APP_BASE_API, // url = base url + request url
  timeout: 5000
  // withCredentials: true // send cookies when cross-domain requests
});

export default api;
