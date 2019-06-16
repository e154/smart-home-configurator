Smart home configurator
-----------------------

[Project site](https://e154.github.io/smart-home/) |
[Server](https://github.com/e154/smart-home/) |
[Node](https://github.com/e154/smart-home-node/) |
[Development Tools](https://github.com/e154/smart-home-tools/) |
[Smart home Socket](https://github.com/e154/smart-home-socket/) |
[Modbus device controller](https://github.com/e154/smart-home-modbus-ctrl-v1/)

[![Build Status](https://travis-ci.org/e154/smart-home-configurator.svg?branch=master)](https://travis-ci.org/e154/smart-home-configurator)
[![Coverage Status](https://coveralls.io/repos/github/e154/smart-home-configurator/badge.svg?branch=master)](https://coveralls.io/github/e154/smart-home-configurator?branch=master)

Attention! The project is under active development.
---------

### Installation for development

```bash
go get -u github.com/golang/dep/cmd/dep

git clone https://github.com/e154/smart-home-configurator $GOPATH/src/github.com/e154/smart-home-configurator

cd $GOPATH/src/github.com/e154/smart-home-configurator

dep ensure

go build
```

editing configuration files

```bash
cp conf/config.dev.json conf/config.json

```

init project files

```bash
./bin/project.sh --init
```

run frontend development tools

```bash
./cd static_source && gulp
```

run server

```bash
./smart-home-configurator
```

It's all

### LICENSE

[MIT Public License](https://github.com/e154/smart-home-configurator/blob/master/LICENSE)