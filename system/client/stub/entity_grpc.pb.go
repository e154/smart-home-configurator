// Code generated by protoc-gen-go-grpc. DO NOT EDIT.

package api

import (
	context "context"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
	emptypb "google.golang.org/protobuf/types/known/emptypb"
)

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
// Requires gRPC-Go v1.32.0 or later.
const _ = grpc.SupportPackageIsVersion7

// EntityServiceClient is the client API for EntityService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
type EntityServiceClient interface {
	// add new entity
	AddEntity(ctx context.Context, in *NewEntityRequest, opts ...grpc.CallOption) (*Entity, error)
	// update entity
	UpdateEntity(ctx context.Context, in *UpdateEntityRequest, opts ...grpc.CallOption) (*Entity, error)
	// get entity
	GetEntity(ctx context.Context, in *GetEntityRequest, opts ...grpc.CallOption) (*Entity, error)
	// get entity list
	GetEntityList(ctx context.Context, in *GetEntityListRequest, opts ...grpc.CallOption) (*GetEntityListResult, error)
	// delete entity
	DeleteEntity(ctx context.Context, in *DeleteEntityRequest, opts ...grpc.CallOption) (*emptypb.Empty, error)
	// search entity
	SearchEntity(ctx context.Context, in *SearchEntityRequest, opts ...grpc.CallOption) (*SearchEntityResult, error)
}

type entityServiceClient struct {
	cc grpc.ClientConnInterface
}

func NewEntityServiceClient(cc grpc.ClientConnInterface) EntityServiceClient {
	return &entityServiceClient{cc}
}

func (c *entityServiceClient) AddEntity(ctx context.Context, in *NewEntityRequest, opts ...grpc.CallOption) (*Entity, error) {
	out := new(Entity)
	err := c.cc.Invoke(ctx, "/api.EntityService/AddEntity", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *entityServiceClient) UpdateEntity(ctx context.Context, in *UpdateEntityRequest, opts ...grpc.CallOption) (*Entity, error) {
	out := new(Entity)
	err := c.cc.Invoke(ctx, "/api.EntityService/UpdateEntity", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *entityServiceClient) GetEntity(ctx context.Context, in *GetEntityRequest, opts ...grpc.CallOption) (*Entity, error) {
	out := new(Entity)
	err := c.cc.Invoke(ctx, "/api.EntityService/GetEntity", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *entityServiceClient) GetEntityList(ctx context.Context, in *GetEntityListRequest, opts ...grpc.CallOption) (*GetEntityListResult, error) {
	out := new(GetEntityListResult)
	err := c.cc.Invoke(ctx, "/api.EntityService/GetEntityList", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *entityServiceClient) DeleteEntity(ctx context.Context, in *DeleteEntityRequest, opts ...grpc.CallOption) (*emptypb.Empty, error) {
	out := new(emptypb.Empty)
	err := c.cc.Invoke(ctx, "/api.EntityService/DeleteEntity", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *entityServiceClient) SearchEntity(ctx context.Context, in *SearchEntityRequest, opts ...grpc.CallOption) (*SearchEntityResult, error) {
	out := new(SearchEntityResult)
	err := c.cc.Invoke(ctx, "/api.EntityService/SearchEntity", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// EntityServiceServer is the server API for EntityService service.
// All implementations must embed UnimplementedEntityServiceServer
// for forward compatibility
type EntityServiceServer interface {
	// add new entity
	AddEntity(context.Context, *NewEntityRequest) (*Entity, error)
	// update entity
	UpdateEntity(context.Context, *UpdateEntityRequest) (*Entity, error)
	// get entity
	GetEntity(context.Context, *GetEntityRequest) (*Entity, error)
	// get entity list
	GetEntityList(context.Context, *GetEntityListRequest) (*GetEntityListResult, error)
	// delete entity
	DeleteEntity(context.Context, *DeleteEntityRequest) (*emptypb.Empty, error)
	// search entity
	SearchEntity(context.Context, *SearchEntityRequest) (*SearchEntityResult, error)
	mustEmbedUnimplementedEntityServiceServer()
}

// UnimplementedEntityServiceServer must be embedded to have forward compatible implementations.
type UnimplementedEntityServiceServer struct {
}

func (UnimplementedEntityServiceServer) AddEntity(context.Context, *NewEntityRequest) (*Entity, error) {
	return nil, status.Errorf(codes.Unimplemented, "method AddEntity not implemented")
}
func (UnimplementedEntityServiceServer) UpdateEntity(context.Context, *UpdateEntityRequest) (*Entity, error) {
	return nil, status.Errorf(codes.Unimplemented, "method UpdateEntity not implemented")
}
func (UnimplementedEntityServiceServer) GetEntity(context.Context, *GetEntityRequest) (*Entity, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetEntity not implemented")
}
func (UnimplementedEntityServiceServer) GetEntityList(context.Context, *GetEntityListRequest) (*GetEntityListResult, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetEntityList not implemented")
}
func (UnimplementedEntityServiceServer) DeleteEntity(context.Context, *DeleteEntityRequest) (*emptypb.Empty, error) {
	return nil, status.Errorf(codes.Unimplemented, "method DeleteEntity not implemented")
}
func (UnimplementedEntityServiceServer) SearchEntity(context.Context, *SearchEntityRequest) (*SearchEntityResult, error) {
	return nil, status.Errorf(codes.Unimplemented, "method SearchEntity not implemented")
}
func (UnimplementedEntityServiceServer) mustEmbedUnimplementedEntityServiceServer() {}

// UnsafeEntityServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to EntityServiceServer will
// result in compilation errors.
type UnsafeEntityServiceServer interface {
	mustEmbedUnimplementedEntityServiceServer()
}

func RegisterEntityServiceServer(s grpc.ServiceRegistrar, srv EntityServiceServer) {
	s.RegisterService(&EntityService_ServiceDesc, srv)
}

func _EntityService_AddEntity_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(NewEntityRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(EntityServiceServer).AddEntity(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/api.EntityService/AddEntity",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(EntityServiceServer).AddEntity(ctx, req.(*NewEntityRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _EntityService_UpdateEntity_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(UpdateEntityRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(EntityServiceServer).UpdateEntity(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/api.EntityService/UpdateEntity",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(EntityServiceServer).UpdateEntity(ctx, req.(*UpdateEntityRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _EntityService_GetEntity_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(GetEntityRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(EntityServiceServer).GetEntity(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/api.EntityService/GetEntity",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(EntityServiceServer).GetEntity(ctx, req.(*GetEntityRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _EntityService_GetEntityList_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(GetEntityListRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(EntityServiceServer).GetEntityList(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/api.EntityService/GetEntityList",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(EntityServiceServer).GetEntityList(ctx, req.(*GetEntityListRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _EntityService_DeleteEntity_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(DeleteEntityRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(EntityServiceServer).DeleteEntity(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/api.EntityService/DeleteEntity",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(EntityServiceServer).DeleteEntity(ctx, req.(*DeleteEntityRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _EntityService_SearchEntity_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(SearchEntityRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(EntityServiceServer).SearchEntity(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/api.EntityService/SearchEntity",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(EntityServiceServer).SearchEntity(ctx, req.(*SearchEntityRequest))
	}
	return interceptor(ctx, in, info, handler)
}

// EntityService_ServiceDesc is the grpc.ServiceDesc for EntityService service.
// It's only intended for direct use with grpc.RegisterService,
// and not to be introspected or modified (even as a copy)
var EntityService_ServiceDesc = grpc.ServiceDesc{
	ServiceName: "api.EntityService",
	HandlerType: (*EntityServiceServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "AddEntity",
			Handler:    _EntityService_AddEntity_Handler,
		},
		{
			MethodName: "UpdateEntity",
			Handler:    _EntityService_UpdateEntity_Handler,
		},
		{
			MethodName: "GetEntity",
			Handler:    _EntityService_GetEntity_Handler,
		},
		{
			MethodName: "GetEntityList",
			Handler:    _EntityService_GetEntityList_Handler,
		},
		{
			MethodName: "DeleteEntity",
			Handler:    _EntityService_DeleteEntity_Handler,
		},
		{
			MethodName: "SearchEntity",
			Handler:    _EntityService_SearchEntity_Handler,
		},
	},
	Streams:  []grpc.StreamDesc{},
	Metadata: "entity.proto",
}
