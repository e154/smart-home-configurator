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

export interface AccessListListOfString {
  items: string[];
}

export interface SubscribeResponseEvent {
  key?: string;
  events?: string[];
}

export interface UpdateRoleAccessListRequestAccessListDiff {
  items: Record<string, boolean>;
}

export interface ApiAccessItem {
  actions?: string[];
  method?: string;
  description?: string;
  roleName?: string;
}

export interface ApiAccessLevels {
  items: Record<string, ApiAccessItem>;
}

export interface ApiAccessList {
  levels?: Record<string, ApiAccessLevels>;
}

export interface ApiAccessListResponse {
  accessList?: ApiAccessList;
}

export interface ApiAction {
  /** @format int64 */
  id?: number;
  name?: string;

  /** @format int64 */
  taskId?: number;
  script?: ApiScript;
}

export interface ApiArea {
  /** @format int64 */
  id?: number;
  name: string;
  description: string;
}

export interface ApiAttribute {
  name: string;
  type?: ApiTypes;
  int?: number;
  string?: string;
  bool?: boolean;
  float?: number;
  array?: ApiAttribute[];
}

export interface ApiCurrentUser {
  /** @format int64 */
  id: number;
  nickname: string;
  firstName: string;
  lastName: string;
  email: string;
  status: string;
  history: ApiUserHistory[];
  image: ApiImage;

  /** @format int64 */
  signInCount: number;
  meta: ApiUserMeta[];
  role: ApiRole;
  lang: string;

  /** @format date-time */
  createdAt: string;

  /** @format date-time */
  updatedAt: string;

  /** @format date-time */
  currentSignInAt: string;

  /** @format date-time */
  lastSignInAt: string;
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

export interface ApiEntity {
  id?: string;
  pluginName: string;
  description?: string;
  area?: ApiArea;
  image?: ApiImage;
  icon?: string;
  autoLoad: boolean;
  parent?: ApiEntityParent;
  actions?: ApiEntityAction[];
  states?: ApiEntityState[];
  scripts?: ApiScript[];
  attributes?: Map<string, ApiAttribute>;
  settings?: Map<string, ApiAttribute>;
  metrics?: Map<string, ApiAttribute>;

  /** @format date-time */
  createdAt?: string;

  /** @format date-time */
  updatedAt?: string;
}

export interface ApiObject {
  id?: number
}

export interface ApiEntityAction {
  name?: string;
  description?: string;
  icon?: string;
  image?: ApiImage;
  script?: ApiObject;
  type?: string;
}

export interface ApiEntityParent {
  id?: number;
}

export interface ApiEntityShort {
  id?: number;
  pluginName?: string;
  description?: string;
  area?: ApiArea;
  image?: ApiImage;
  icon?: string;
  autoLoad?: boolean;
  parent?: ApiEntityParent;

  /** @format date-time */
  createdAt?: string;

  /** @format date-time */
  updatedAt?: string;
}

export interface ApiEntityState {
  name?: string;
  description?: string;
  icon?: string;
  image?: ApiImage;
  style?: string;
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

export interface ApiGetAreaListResult {
  items: ApiArea[];
  meta: ApiMeta;
}

export interface ApiGetBridgeListResult {
  items: ApiZigbee2MqttShort[];
  meta: ApiMeta;
}

export interface ApiGetEntityListResult {
  items: ApiEntity[];
  meta: ApiMeta;
}

export interface ApiGetImageListResult {
  items: ApiImage[];
  meta: ApiMeta;
}

export interface ApiGetPluginListResult {
  items: ApiPlugin[];
  meta: ApiMeta;
}

export interface ApiGetPluginOptionsResult {
  triggers: boolean;
  actors: boolean;
  actorCustomAttrs: boolean;
  actorAttrs?: Map<string, ApiAttribute>;
  actorCustomActions: boolean;
  actorActions?: Map<string, ApiGetPluginOptionsResultEntityAction>;
  actorCustomStates: boolean;
  actorStates?: Map<string, ApiGetPluginOptionsResultEntityState>;
  actorCustomSetts: boolean;
  actorSetts?: Map<string, ApiAttribute>;
  setts?: Map<string, ApiAttribute>;
}

export interface ApiGetPluginOptionsResultEntityAction {
  name?: string;
  description?: string;
  imageUrl?: string;
  icon?: string;
}

export interface ApiGetPluginOptionsResultEntityState {
  name?: string;
  description?: string;
  imageUrl?: string;
  icon?: string;
}

export interface ApiGetRoleListResult {
  items: ApiRole[];
  meta: ApiMeta;
}

export interface ApiGetScriptListResult {
  items: ApiScript[];
  meta: ApiMeta;
}

export interface ApiGetTaskListResult {
  items: ApiTask[];
  meta: ApiMeta;
}

export interface ApiGetUserListResult {
  items: ApiUserShot[];
  meta: ApiMeta;
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

export interface ApiMeta {
  /** @format uint64 */
  limit: number;

  /** @format uint64 */
  page: number;

  /** @format uint64 */
  total: number;
  sort: string;
}

export interface ApiNetworkmapResponse {
  networkmap?: string;
}

export interface ApiNewAreaRequest {
  name?: string;
  description?: string;
}

export interface ApiNewEntityRequest {
  name: string;
  pluginName: string;
  description?: string;
  area?: ApiNewEntityRequestArea;
  icon?: string;
  image?: ApiNewEntityRequestImage;
  autoLoad?: boolean;
  parent?: ApiEntityParent;
  actions?: ApiNewEntityRequestAction[];
  states?: ApiNewEntityRequestState[];
  attributes?: Map<string, ApiAttribute>;
  settings?: Map<string, ApiAttribute>;
  metrics?: Map<string, ApiAttribute>;
  scripts?: ApiScript[];
}

export interface ApiNewEntityRequestAction {
  name?: string;
  description?: string;
  icon?: string;
  image?: ApiNewEntityRequestImage;
  script?: ApiNewEntityRequestActionScript;
  type?: string;
}

export interface ApiNewEntityRequestActionScript {
  /** @format int64 */
  id?: number;
}

export interface ApiNewEntityRequestArea {
  /** @format int64 */
  id?: number;
}

export interface ApiNewEntityRequestImage {
  /** @format int64 */
  id?: number;
}

export interface ApiNewEntityRequestState {
  name?: string;
  description?: string;
  icon?: string;
  image?: ApiNewEntityRequestImage;
  style?: string;
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

export interface ApiNewTaskRequest {
  name?: string;
  description?: string;
  enabled?: boolean;
  condition?: ApiNewTaskRequestConditionEnum;
  triggers?: ApiNewTaskRequestTrigger[];
  conditions?: ApiNewTaskRequestCondition[];
  actions?: ApiNewTaskRequestAction[];
  area?: ApiArea;
}

export interface ApiNewTaskRequestAction {
  name?: string;

  /** @format int64 */
  taskId?: number;

  /** @format int64 */
  scriptId?: number;
}

export interface ApiNewTaskRequestCondition {
  name?: string;

  /** @format int64 */
  taskId?: number;

  /** @format int64 */
  scriptId?: number;
}

export enum ApiNewTaskRequestConditionEnum {
  OR = "OR",
  AND = "AND",
}

export interface ApiNewTaskRequestTrigger {
  name?: string;

  /** @format int64 */
  taskId?: number;
  entityId?: string;

  /** @format int64 */
  scriptId?: number;
  pluginName?: string;
  payload?: Record<string, ApiAttribute>;
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
  meta: ApiUserMeta[];
}

export interface ApiNewtUserRequestImage {
  /** @format int64 */
  id?: number;
}

export interface ApiNewtUserRequestRole {
  name?: string;
}

export interface ApiPlugin {
  name: string;
  version: string;
  enabled: boolean;
  system: boolean;
  settings: Record<string, ApiAttribute>;
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
  id?: number;
  lang: string;
  name: string;
  source: string;
  description: string;

  /** @format date-time */
  createdAt?: string;

  /** @format date-time */
  updatedAt?: string;
}

export interface ApiSearchAreaResult {
  items: ApiArea[];
}

export interface ApiSearchDeviceResult {
  items: ApiZigbee2MqttDevice[];
}

export interface ApiSearchEntityResult {
  items: ApiEntityShort[];
}

export interface ApiSearchRoleListResult {
  items: ApiRole[];
}

export interface ApiSearchScriptListResult {
  items: ApiScript[];
}

export interface ApiSearchPluginListResult {
  items: ApiPlugin[];
}

export interface ApiSigninResponse {
  currentUser: ApiCurrentUser;
  accessToken: string;
}

export interface ApiSubscribeResponse {
  query: string;
  data: object;
  events?: SubscribeResponseEvent[];
}

export interface ApiTask {
  /** @format int64 */
  id?: number;
  name?: string;
  description?: string;
  enabled?: boolean;
  condition?: ApiTaskCondition;
  triggers?: ApiTrigger[];
  conditions?: ApiTaskCondition[];
  actions?: ApiAction[];
  area?: ApiArea;

  /** @format date-time */
  createdAt?: string;

  /** @format date-time */
  updatedAt?: string;
}

export enum ApiTaskCondition {
  OR = "OR",
  AND = "AND",
}

export interface ApiTrigger {
  /** @format int64 */
  id?: number;
  name?: string;

  /** @format int64 */
  taskId?: number;
  entityId?: string;
  script?: ApiScript;
  pluginName?: string;
  payload?: Record<string, ApiAttribute>;
}

export enum ApiTypes {
  INT = "INT",
  STRING = "STRING",
  FLOAT = "FLOAT",
  BOOL = "BOOL",
  ARRAY = "ARRAY",
}

export interface ApiUpdateEntityRequestAction {
  name?: string;
  description?: string;
  icon?: string;
  image?: ApiUpdateEntityRequestImage;
  script?: ApiUpdateEntityRequestActionScript;
  type?: string;
}

export interface ApiUpdateEntityRequestActionScript {
  /** @format int64 */
  id?: number;
}

export interface ApiUpdateEntityRequestArea {
  /** @format int64 */
  id?: number;
}

export interface ApiUpdateEntityRequestImage {
  /** @format int64 */
  id?: number;
}

export interface ApiUpdateEntityRequestState {
  name?: string;
  description?: string;
  icon?: string;
  image?: ApiUpdateEntityRequestImage;
  style?: string;
}

export interface ApiUpdateTaskRequestAction {
  name?: string;

  /** @format int64 */
  taskId?: number;

  /** @format int64 */
  scriptId?: number;
}

export interface ApiUpdateTaskRequestCondition {
  name?: string;

  /** @format int64 */
  taskId?: number;

  /** @format int64 */
  scriptId?: number;
}

export enum ApiUpdateTaskRequestConditionEnum {
  OR = "OR",
  AND = "AND",
}

export interface ApiUpdateTaskRequestTrigger {
  name?: string;

  /** @format int64 */
  taskId?: number;
  entityId?: string;

  /** @format int64 */
  scriptId?: number;
  pluginName?: string;
  payload?: Record<string, ApiAttribute>;
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
   * @format byte
   * @pattern ^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?$
   */
  body?: string;
}

export interface ApiUserFull {
  /** @format int64 */
  id: number;
  nickname: string;
  firstName: string;
  lastName: string;
  email: string;
  status: string;
  history: ApiUserHistory[];
  image: ApiImage;

  /** @format int64 */
  signInCount: number;
  meta: ApiUserMeta[];
  role: ApiRole;
  roleName: string;
  lang: string;
  authenticationToken: string;
  currentSignInIp: string;
  lastSignInIp: string;
  user: ApiUserFullParent;

  /** @format date-time */
  createdAt: string;

  /** @format date-time */
  updatedAt: string;

  /** @format date-time */
  currentSignInAt: string;

  /** @format date-time */
  lastSignInAt: string;

  /** @format date-time */
  resetPasswordSentAt: string;

  /** @format date-time */
  deletedAt: string;
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
   * @pattern ^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?$
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
  NULL_VALUE = "NULL_VALUE",
}

export interface RpcStatus {
  /** @format int32 */
  code?: number;
  message?: string;
  details?: ProtobufAny[];
}

import axios, { AxiosInstance, AxiosRequestConfig, AxiosResponse, ResponseType } from "axios";

export type QueryParamsType = Record<string | number, any>;

export interface FullRequestParams extends Omit<AxiosRequestConfig, "data" | "params" | "url" | "responseType"> {
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

export type RequestParams = Omit<FullRequestParams, "body" | "method" | "query" | "path">;

export interface ApiConfig<SecurityDataType = unknown> extends Omit<AxiosRequestConfig, "data" | "cancelToken"> {
  securityWorker?: (
    securityData: SecurityDataType | null,
  ) => Promise<AxiosRequestConfig | void> | AxiosRequestConfig | void;
  secure?: boolean;
  format?: ResponseType;
}

export enum ContentType {
  Json = "application/json",
  FormData = "multipart/form-data",
  UrlEncoded = "application/x-www-form-urlencoded",
}

export class HttpClient<SecurityDataType = unknown> {
  public instance: AxiosInstance;
  private securityData: SecurityDataType | null = null;
  private securityWorker?: ApiConfig<SecurityDataType>["securityWorker"];
  private secure?: boolean;
  private format?: ResponseType;

  constructor({ securityWorker, secure, format, ...axiosConfig }: ApiConfig<SecurityDataType> = {}) {
    this.instance = axios.create({ ...axiosConfig, baseURL: axiosConfig.baseURL || "/" });
    this.secure = secure;
    this.format = format;
    this.securityWorker = securityWorker;
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
          : typeof property === "object" && property !== null
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
      ((typeof secure === "boolean" ? secure : this.secure) &&
        this.securityWorker &&
        (await this.securityWorker(this.securityData))) ||
      {};
    const requestParams = this.mergeRequestParams(params, secureParams);
    const responseFormat = (format && this.format) || void 0;

    if (type === ContentType.FormData && body && body !== null && typeof body === "object") {
      requestParams.headers.common = { Accept: "*/*" };
      requestParams.headers.post = {};
      requestParams.headers.put = {};

      body = this.createFormData(body as Record<string, unknown>);
    }

    return this.instance.request({
      ...requestParams,
      headers: {
        ...(type && type !== ContentType.FormData ? { "Content-Type": type } : {}),
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
 * @baseUrl /
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
        method: "GET",
        query: query,
        secure: true,
        format: "json",
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
        method: "GET",
        secure: true,
        format: "json",
        ...params,
      }),

    /**
     * No description
     *
     * @tags AreaService
     * @name AreaServiceAddArea
     * @summary add new area
     * @request POST:/v1/area
     * @secure
     */
    areaServiceAddArea: (data: ApiNewAreaRequest, params: RequestParams = {}) =>
      this.request<ApiArea, RpcStatus>({
        path: `/v1/area`,
        method: "POST",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
        ...params,
      }),

    /**
     * No description
     *
     * @tags AreaService
     * @name AreaServiceGetAreaById
     * @summary get area by id
     * @request GET:/v1/area/{id}
     * @secure
     */
    areaServiceGetAreaById: (id: number, params: RequestParams = {}) =>
      this.request<ApiArea, RpcStatus>({
        path: `/v1/area/${id}`,
        method: "GET",
        secure: true,
        format: "json",
        ...params,
      }),

    /**
     * No description
     *
     * @tags AreaService
     * @name AreaServiceUpdateArea
     * @summary update area
     * @request PUT:/v1/area/{id}
     * @secure
     */
    areaServiceUpdateArea: (id: number, data: { name?: string; description?: string }, params: RequestParams = {}) =>
      this.request<ApiArea, RpcStatus>({
        path: `/v1/area/${id}`,
        method: "PUT",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
        ...params,
      }),

    /**
     * No description
     *
     * @tags AreaService
     * @name AreaServiceDeleteArea
     * @summary delete area
     * @request DELETE:/v1/area/{id}
     * @secure
     */
    areaServiceDeleteArea: (id: number, params: RequestParams = {}) =>
      this.request<ApiDisablePluginResult, RpcStatus>({
        path: `/v1/area/${id}`,
        method: "DELETE",
        secure: true,
        format: "json",
        ...params,
      }),

    /**
     * No description
     *
     * @tags AreaService
     * @name AreaServiceGetAreaList
     * @summary get area list
     * @request GET:/v1/areas
     * @secure
     */
    areaServiceGetAreaList: (query?: { page: number; limit: number; sort: string }, params: RequestParams = {}) =>
      this.request<ApiGetAreaListResult, RpcStatus>({
        path: `/v1/areas`,
        method: "GET",
        query: query,
        secure: true,
        format: "json",
        ...params,
      }),

    /**
     * No description
     *
     * @tags AreaService
     * @name AreaServiceSearchArea
     * @summary search area
     * @request GET:/v1/areas/search
     * @secure
     */
    areaServiceSearchArea: (query?: { query: string; limit: number; offset: number }, params: RequestParams = {}) =>
      this.request<ApiSearchAreaResult, RpcStatus>({
        path: `/v1/areas/search`,
        method: "GET",
        query: query,
        secure: true,
        format: "json",
        ...params,
      }),

    /**
     * No description
     *
     * @tags EntityService
     * @name EntityServiceGetEntityList
     * @summary get entity list
     * @request GET:/v1/entities
     * @secure
     */
    entityServiceGetEntityList: (
      query?: { page: number; limit: number; sort: string },
      params: RequestParams = {},
    ) =>
      this.request<ApiGetEntityListResult, RpcStatus>({
        path: `/v1/entities`,
        method: "GET",
        query: query,
        secure: true,
        format: "json",
        ...params,
      }),

    /**
     * No description
     *
     * @tags EntityService
     * @name EntityServiceAddEntity
     * @summary add new entity
     * @request POST:/v1/entity
     * @secure
     */
    entityServiceAddEntity: (data: ApiNewEntityRequest, params: RequestParams = {}) =>
      this.request<ApiEntity, RpcStatus>({
        path: `/v1/entity`,
        method: "POST",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
        ...params,
      }),

    /**
     * No description
     *
     * @tags EntityService
     * @name EntityServiceSearchEntity
     * @summary search entity
     * @request GET:/v1/entity/search
     * @secure
     */
    entityServiceSearchEntity: (
      query?: { query: string; limit: number; offset: number },
      params: RequestParams = {},
    ) =>
      this.request<ApiSearchEntityResult, RpcStatus>({
        path: `/v1/entity/search`,
        method: "GET",
        query: query,
        secure: true,
        format: "json",
        ...params,
      }),

    /**
     * No description
     *
     * @tags EntityService
     * @name EntityServiceGetEntity
     * @summary get entity
     * @request GET:/v1/entity/{id}
     * @secure
     */
    entityServiceGetEntity: (id: string, params: RequestParams = {}) =>
      this.request<ApiEntity, RpcStatus>({
        path: `/v1/entity/${id}`,
        method: "GET",
        secure: true,
        format: "json",
        ...params,
      }),

    /**
     * No description
     *
     * @tags EntityService
     * @name EntityServiceUpdateEntity
     * @summary update entity
     * @request PUT:/v1/entity/{id}
     * @secure
     */
    entityServiceUpdateEntity: (
      id: string,
      data: {
        name?: string;
        pluginName?: string;
        description?: string;
        area?: ApiUpdateEntityRequestArea;
        icon?: string;
        image?: ApiUpdateEntityRequestImage;
        autoLoad?: boolean;
        parent?: ApiEntityParent;
        actions?: ApiUpdateEntityRequestAction[];
        states?: ApiUpdateEntityRequestState[];
        attributes?: Map<string, ApiAttribute>;
        settings?: Map<string, ApiAttribute>;
        scripts?: ApiScript[];
      },
      params: RequestParams = {},
    ) =>
      this.request<ApiEntity, RpcStatus>({
        path: `/v1/entity/${id}`,
        method: "PUT",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
        ...params,
      }),

    /**
     * No description
     *
     * @tags EntityService
     * @name EntityServiceDeleteEntity
     * @summary delete entity
     * @request DELETE:/v1/entity/{id}
     * @secure
     */
    entityServiceDeleteEntity: (id: string, params: RequestParams = {}) =>
      this.request<ApiDisablePluginResult, RpcStatus>({
        path: `/v1/entity/${id}`,
        method: "DELETE",
        secure: true,
        format: "json",
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
    imageServiceAddImage: (data: ApiNewImageRequest, params: RequestParams = {}) =>
      this.request<ApiImage, RpcStatus>({
        path: `/v1/image`,
        method: "POST",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
        ...params,
      }),

    /**
     * No description
     *
     * @tags ImageService
     * @name ImageServiceUploadImage
     * @summary upload image
     * @request POST:/v1/image/upload
     * @secure
     */
    imageServiceUploadImage: (data: ApiUploadImageRequest, params: RequestParams = {}) =>
      this.request<ApiImage, RpcStatus>({
        path: `/v1/image/upload`,
        method: "POST",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
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
        method: "GET",
        secure: true,
        format: "json",
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
      data: { thumb?: string; image?: string; mimeType?: string; title?: string; size?: string; name?: string },
      params: RequestParams = {},
    ) =>
      this.request<ApiImage, RpcStatus>({
        path: `/v1/image/${id}`,
        method: "PUT",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
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
      this.request<ApiDisablePluginResult, RpcStatus>({
        path: `/v1/image/${id}`,
        method: "DELETE",
        secure: true,
        format: "json",
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
    imageServiceGetImageList: (query?: { page: number; limit: number; sort: string }, params: RequestParams = {}) =>
      this.request<ApiGetImageListResult, RpcStatus>({
        path: `/v1/images`,
        method: "GET",
        query: query,
        secure: true,
        format: "json",
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
        method: "POST",
        secure: true,
        format: "json",
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
        method: "POST",
        secure: true,
        format: "json",
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
        method: "GET",
        secure: true,
        format: "json",
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
      query?: { page: number; limit: number; sort: string },
      params: RequestParams = {},
    ) =>
      this.request<ApiGetPluginListResult, RpcStatus>({
        path: `/v1/plugins`,
        method: "GET",
        query: query,
        secure: true,
        format: "json",
        ...params,
      }),

    /**
     * No description
     *
     * @tags PluginService
     * @name PluginsServiceSearchPlugin
     * @summary search plugin
     * @request GET:/v1/plugins/search
     * @secure
     */
    pluginsServiceSearchPlugin: (
      query?: { query: string; limit: number; offset: number },
      params: RequestParams = {},
    ) =>
      this.request<ApiSearchPluginListResult, RpcStatus>({
        path: `/v1/plugins/search`,
        method: "GET",
        query: query,
        secure: true,
        format: "json",
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
    roleServiceAddRole: (data: ApiNewRoleRequest, params: RequestParams = {}) =>
      this.request<ApiRole, RpcStatus>({
        path: `/v1/role`,
        method: "POST",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
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
        method: "GET",
        secure: true,
        format: "json",
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
      data: { description?: string; parent?: string },
      params: RequestParams = {},
    ) =>
      this.request<ApiRole, RpcStatus>({
        path: `/v1/role/${name}`,
        method: "PUT",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
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
      this.request<ApiDisablePluginResult, RpcStatus>({
        path: `/v1/role/${name}`,
        method: "DELETE",
        secure: true,
        format: "json",
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
        method: "GET",
        secure: true,
        format: "json",
        ...params,
      }),

    /**
     * No description
     *
     * @tags RoleService
     * @name RoleServiceUpdateRoleAccessList
     * @summary update role access list
     * @request PUT:/v1/role/{name}/access_list
     * @secure
     */
    roleServiceUpdateRoleAccessList: (
      name: string,
      data: { accessListDiff?: Record<string, UpdateRoleAccessListRequestAccessListDiff> },
      params: RequestParams = {},
    ) =>
      this.request<ApiRoleAccessListResult, RpcStatus>({
        path: `/v1/role/${name}/access_list`,
        method: "PUT",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
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
    roleServiceGetRoleList: (query?: { page: number; limit: number; sort: string }, params: RequestParams = {}) =>
      this.request<ApiGetRoleListResult, RpcStatus>({
        path: `/v1/roles`,
        method: "GET",
        query: query,
        secure: true,
        format: "json",
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
      query?: { query: string; limit: number; offset: number },
      params: RequestParams = {},
    ) =>
      this.request<ApiSearchRoleListResult, RpcStatus>({
        path: `/v1/roles/search`,
        method: "GET",
        query: query,
        secure: true,
        format: "json",
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
    scriptServiceAddScript: (data: ApiNewScriptRequest, params: RequestParams = {}) =>
      this.request<ApiScript, RpcStatus>({
        path: `/v1/script`,
        method: "POST",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
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
    scriptServiceExecSrcScriptById: (data: ApiExecSrcScriptRequest, params: RequestParams = {}) =>
      this.request<ApiExecScriptResult, RpcStatus>({
        path: `/v1/script/exec_src`,
        method: "POST",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
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
        method: "GET",
        secure: true,
        format: "json",
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
      data: { lang?: string; name?: string; source?: string; description?: string },
      params: RequestParams = {},
    ) =>
      this.request<ApiScript, RpcStatus>({
        path: `/v1/script/${id}`,
        method: "PUT",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
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
      this.request<ApiDisablePluginResult, RpcStatus>({
        path: `/v1/script/${id}`,
        method: "DELETE",
        secure: true,
        format: "json",
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
        method: "POST",
        secure: true,
        format: "json",
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
        method: "POST",
        secure: true,
        format: "json",
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
      query?: { page: number; limit: number; sort: string },
      params: RequestParams = {},
    ) =>
      this.request<ApiGetScriptListResult, RpcStatus>({
        path: `/v1/scripts`,
        method: "GET",
        query: query,
        secure: true,
        format: "json",
        ...params,
      }),

    /**
     * No description
     *
     * @tags ScriptService
     * @name ScriptServiceSearchScript
     * @summary delete script by id
     * @request GET:/v1/scripts/search
     * @secure
     */
    scriptServiceSearchScript: (
      query?: { query: string; limit: number; offset: number },
      params: RequestParams = {},
    ) =>
      this.request<ApiSearchScriptListResult, RpcStatus>({
        path: `/v1/scripts/search`,
        method: "GET",
        query: query,
        secure: true,
        format: "json",
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
        method: "POST",
        secure: true,
        format: "json",
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
      this.request<ApiDisablePluginResult, RpcStatus>({
        path: `/v1/signout`,
        method: "POST",
        secure: true,
        format: "json",
        ...params,
      }),

    /**
     * No description
     *
     * @tags AutomationService
     * @name AutomationServiceAddTask
     * @summary add new task
     * @request POST:/v1/task
     * @secure
     */
    automationServiceAddTask: (data: ApiNewTaskRequest, params: RequestParams = {}) =>
      this.request<ApiTask, RpcStatus>({
        path: `/v1/task`,
        method: "POST",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
        ...params,
      }),

    /**
     * No description
     *
     * @tags AutomationService
     * @name AutomationServiceGetTask
     * @summary get task
     * @request GET:/v1/task/{id}
     * @secure
     */
    automationServiceGetTask: (id: number, params: RequestParams = {}) =>
      this.request<ApiTask, RpcStatus>({
        path: `/v1/task/${id}`,
        method: "GET",
        secure: true,
        format: "json",
        ...params,
      }),

    /**
     * No description
     *
     * @tags AutomationService
     * @name AutomationServiceUpdateTask
     * @summary update task
     * @request PUT:/v1/task/{id}
     * @secure
     */
    automationServiceUpdateTask: (
      id: number,
      data: {
        name?: string;
        description?: string;
        enabled?: boolean;
        condition?: ApiUpdateTaskRequestConditionEnum;
        triggers?: ApiUpdateTaskRequestTrigger[];
        conditions?: ApiUpdateTaskRequestCondition[];
        actions?: ApiUpdateTaskRequestAction[];
        area?: ApiArea;
      },
      params: RequestParams = {},
    ) =>
      this.request<ApiTask, RpcStatus>({
        path: `/v1/task/${id}`,
        method: "PUT",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
        ...params,
      }),

    /**
     * No description
     *
     * @tags AutomationService
     * @name AutomationServiceDeleteTask
     * @summary delete task
     * @request DELETE:/v1/task/{id}
     * @secure
     */
    automationServiceDeleteTask: (id: number, params: RequestParams = {}) =>
      this.request<ApiDisablePluginResult, RpcStatus>({
        path: `/v1/task/${id}`,
        method: "DELETE",
        secure: true,
        format: "json",
        ...params,
      }),

    /**
     * No description
     *
     * @tags AutomationService
     * @name AutomationServiceGetTaskList
     * @summary get task list
     * @request GET:/v1/tasks
     * @secure
     */
    automationServiceGetTaskList: (
      query?: { page: number; limit: number; sort: string },
      params: RequestParams = {},
    ) =>
      this.request<ApiGetTaskListResult, RpcStatus>({
        path: `/v1/tasks`,
        method: "GET",
        query: query,
        secure: true,
        format: "json",
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
    userServiceAddUser: (data: ApiNewtUserRequest, params: RequestParams = {}) =>
      this.request<ApiUserFull, RpcStatus>({
        path: `/v1/user`,
        method: "POST",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
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
        method: "GET",
        secure: true,
        format: "json",
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
      data: {
        nickname: string;
        firstName: string;
        lastName: string;
        password: string;
        passwordRepeat: string;
        email: string;
        status: string;
        lang: string;
        image: ApiUpdateUserRequestImage;
        role: ApiUpdateUserRequestRole;
        meta: ApiUserMeta[];
      },
      params: RequestParams = {},
    ) =>
      this.request<ApiUserFull, RpcStatus>({
        path: `/v1/user/${id}`,
        method: "PUT",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
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
      this.request<ApiDisablePluginResult, RpcStatus>({
        path: `/v1/user/${id}`,
        method: "DELETE",
        secure: true,
        format: "json",
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
    userServiceGetUserList: (query?: { page: number; limit: number; sort: string }, params: RequestParams = {}) =>
      this.request<ApiGetUserListResult, RpcStatus>({
        path: `/v1/users`,
        method: "GET",
        query: query,
        secure: true,
        format: "json",
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
      query?: { page: number; limit: number; sort: string },
      params: RequestParams = {},
    ) =>
      this.request<ApiGetBridgeListResult, RpcStatus>({
        path: `/v1/zigbee2mqtt/bridge`,
        method: "GET",
        query: query,
        secure: true,
        format: "json",
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
    zigbee2MqttServiceAddZigbee2MqttBridge: (data: ApiNewZigbee2MqttRequest, params: RequestParams = {}) =>
      this.request<ApiZigbee2Mqtt, RpcStatus>({
        path: `/v1/zigbee2mqtt/bridge`,
        method: "POST",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
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
        method: "GET",
        secure: true,
        format: "json",
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
      this.request<ApiDisablePluginResult, RpcStatus>({
        path: `/v1/zigbee2mqtt/bridge/${id}`,
        method: "DELETE",
        secure: true,
        format: "json",
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
      data: { name?: string; login?: string; password?: string; permitJoin?: boolean; baseTopic?: string },
      params: RequestParams = {},
    ) =>
      this.request<ApiZigbee2Mqtt, RpcStatus>({
        path: `/v1/zigbee2mqtt/bridge/${id}/bridge`,
        method: "PUT",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
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
        method: "GET",
        secure: true,
        format: "json",
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
      this.request<ApiDisablePluginResult, RpcStatus>({
        path: `/v1/zigbee2mqtt/bridge/${id}/networkmap`,
        method: "POST",
        secure: true,
        format: "json",
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
      this.request<ApiDisablePluginResult, RpcStatus>({
        path: `/v1/zigbee2mqtt/bridge/${id}/reset`,
        method: "POST",
        secure: true,
        format: "json",
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
    zigbee2MqttServiceDeviceBan: (data: ApiDeviceBanRequest, params: RequestParams = {}) =>
      this.request<ApiDisablePluginResult, RpcStatus>({
        path: `/v1/zigbee2mqtt/device_ban`,
        method: "POST",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
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
    zigbee2MqttServiceDeviceRename: (data: ApiDeviceRenameRequest, params: RequestParams = {}) =>
      this.request<ApiDisablePluginResult, RpcStatus>({
        path: `/v1/zigbee2mqtt/device_rename`,
        method: "POST",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
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
    zigbee2MqttServiceDeviceWhitelist: (data: ApiDeviceWhitelistRequest, params: RequestParams = {}) =>
      this.request<ApiDisablePluginResult, RpcStatus>({
        path: `/v1/zigbee2mqtt/device_whitelist`,
        method: "POST",
        body: data,
        secure: true,
        type: ContentType.Json,
        format: "json",
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
      query?: { query: string; limit: number; offset: number },
      params: RequestParams = {},
    ) =>
      this.request<ApiSearchDeviceResult, RpcStatus>({
        path: `/v1/zigbee2mqtt/search_device`,
        method: "GET",
        query: query,
        secure: true,
        format: "json",
        ...params,
      }),
  };
}
