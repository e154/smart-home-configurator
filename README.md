`Smart home configurator
-----------------------

[Project site](https://e154.github.io/smart-home/) |
[Server](https://github.com/e154/smart-home/) |
[Mobile gate](https://github.com/e154/smart-home-gate/) |
[Node](https://github.com/e154/smart-home-node/) |
[Smart home Socket](https://github.com/e154/smart-home-socket/) |
[Modbus device controller](https://github.com/e154/smart-home-modbus-ctrl-v1/) |
[Mobile app](https://github.com/e154/smart-home-app/)

![status](https://img.shields.io/badge/status-beta-yellow.svg)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

|Branch      |Status   |
|------------|---------|
|master      | ![Build Status](https://github.com/e154/smart-home-configurator/actions/workflows/test.yml/badge.svg?branch=master)   |
|dev         | ![Build Status](https://github.com/e154/smart-home-configurator/actions/workflows/test.yml/badge.svg?branch=develop)  |

Attention! The project is under active development.
---------

| screenshots | screenshots |
|:-------------------------:|:-------------------------:|
|<img width="1604" alt="smart home configurator" src="doc/screenshot3.png">  |  <img width="1604" alt="smart home configurator" src="doc/screenshot1.png">|
|<img width="1604" alt="smart home configurator" src="doc/screenshot2.png">  |  <img width="1604" alt="smart home configurator" src="doc/screenshot4.png">|

### Installation for development

```bash
git clone https://github.com/e154/smart-home-configurator $GOPATH/src/github.com/e154/smart-home-configurator

cd $GOPATH/src/github.com/e154/smart-home-configurator

go mod vendor

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

new module

```bash
ng g m config --route config --module=app
```

new component

```bash
ng g c auth/base --module=auth
```

new service

```bash
ng g service @core/services/window
```

### install depends on MAC OS

install macports from https://www.macports.org/install.php

install specific version nodejs and npm
```bash
sudo port install nodejs14
sudo port install npm6
```

### build frontend

``bash
cd  static_source/public
npm run serve
``

It's all

### LICENSE

[GPLv3 Public License](https://github.com/e154/smart-home-configurator/blob/master/LICENSE)
