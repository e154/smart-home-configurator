package models

type AppConfig struct {
	WebHostPort     string `json:"web_host_port" env:"WEB_HOST_PORT"`
	ApiHttpHostPort string `json:"api_http_host_port" env:"API_HTTP_HOST_PORT"`
	ApiGrpcHostPort string `json:"api_grpc_host_port" env:"API_GRPC_HOST_PORT"`
	MemStorySecret  string `json:"mem_story_secret" env:"MEM_STORY_SECRET"`
	SessionStory    string `json:"session_story" env:"SESSION_STORY"`
	BasePath        string `json:"base_path" env:"BASE_PATH"`
	WebSwagger      bool   `json:"web_swagger" env:"WEB_SWAGGER"`
	Debug           bool   `json:"debug"`
}
