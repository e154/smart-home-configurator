package config

type AppConfig struct {
	Httpaddr       string  `json:"httpaddr"`
	Httpport       int     `json:"httpport"`
	Runmode        RunMode `json:"runmode"`
	ApiAddr        string  `json:"api_addr"`
	ApiPort        int     `json:"api_port"`
	MemStorySecret string  `json:"mem_story_secret"`
	SessionStory   string  `json:"session_story"`
}

type RunMode string

const (
	DebugMode   = RunMode("debug")
	ReleaseMode = RunMode("release")
)
