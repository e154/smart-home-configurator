package v1

// Config ...
type Config struct {
	HostPort string
	ApiHostPort string
	Debug    bool
	Swagger  bool
}

// String ...
func (c Config) String() string {
	return c.HostPort
}
