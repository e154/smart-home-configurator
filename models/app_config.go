package models

type AppConfig struct {
	WebHostPort     string `json:"web_host_port" env:"WEB_HOST_PORT"`
	ApiHttpHostPort string `json:"api_http_host_port" env:"API_HTTP_HOST_PORT"`
	ApiGrpcHostPort string `json:"api_grpc_host_port" env:"API_GRPC_HOST_PORT"`
	ApiWsHostPort   string `json:"api_ws_host_port" env:"API_WS_HOST_PORT"`
	WebSwagger      bool   `json:"web_swagger" env:"WEB_SWAGGER"`
	Debug           bool   `json:"debug" env:"DEBUG"`
}
