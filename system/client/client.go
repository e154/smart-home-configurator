package client

import (
	"github.com/e154/smart-home-configurator/common/logger"
	m "github.com/e154/smart-home-configurator/models"
	"google.golang.org/grpc"

	pb "github.com/e154/smart-home-configurator/system/client/stub"
)

var (
	log = logger.MustGetLogger("client")
)

type Client struct {
	serverAddr string
}

func NewClient(config *m.AppConfig) *Client {
	log.Infof("client started at %s", config.ApiGrpcHostPort)
	return &Client{
		serverAddr: config.ApiGrpcHostPort,
	}
}

func (c *Client) Conn() (*grpc.ClientConn, error) {
	var opts []grpc.DialOption
	opts = append(opts, grpc.WithInsecure())
	return grpc.Dial(c.serverAddr, opts...)
}


func (c *Client) NewAuthServiceClient(conn *grpc.ClientConn) pb.AuthServiceClient {
	return pb.NewAuthServiceClient(conn)
}

func (c *Client) NewAutomationServiceClient(conn *grpc.ClientConn) pb.AutomationServiceClient {
	return pb.NewAutomationServiceClient(conn)
}

func (c *Client) NewEntityServiceClient(conn *grpc.ClientConn) pb.EntityServiceClient {
	return pb.NewEntityServiceClient(conn)
}

func (c *Client) NewImageServiceClient(conn *grpc.ClientConn) pb.ImageServiceClient {
	return pb.NewImageServiceClient(conn)
}

func (c *Client) NewPluginServiceClient(conn *grpc.ClientConn) pb.PluginServiceClient {
	return pb.NewPluginServiceClient(conn)
}

func (c *Client) NewRoleServiceClient(conn *grpc.ClientConn) pb.RoleServiceClient {
	return pb.NewRoleServiceClient(conn)
}

func (c *Client) NewScriptServiceClient(conn *grpc.ClientConn) pb.ScriptServiceClient {
	return pb.NewScriptServiceClient(conn)
}

func (c *Client) NewStreamServiceClient(conn *grpc.ClientConn) pb.StreamServiceClient {
	return pb.NewStreamServiceClient(conn)
}

func (c *Client) NewUserServiceClient(conn *grpc.ClientConn) pb.UserServiceClient {
	return pb.NewUserServiceClient(conn)
}

func (c *Client) NewZigbee2MqttServiceClient(conn *grpc.ClientConn) pb.Zigbee2MqttServiceClient {
	return pb.NewZigbee2MqttServiceClient(conn)
}
