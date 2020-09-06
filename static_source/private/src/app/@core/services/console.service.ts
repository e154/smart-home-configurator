/*
 * This file is part of the Smart Home
 * Program complex distribution https://github.com/e154/smart-home
 * Copyright (C) 2016-2020, Filippov Alex
 *
 * This library is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library.  If not, see
 * <https://www.gnu.org/licenses/>.
 */

export class ConsoleService {

  constructor() {
    if (window.console && 'undefined' !== typeof console.log) {
      const url = 'https://github.com/e154/smart-home';
      const i = `Modern smart systems for life - ${url}`;
      console.log('%c Smart home %c Copyright © 2014-%s', 'font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;font-size:62px;color:#303E4D;-webkit-text-fill-color:#303E4D;-webkit-text-stroke: 1px #303E4D;', 'font-size:12px;color:#a9a9a9;', (new Date).getFullYear());
      console.log('%c ' + i, 'color:#333;');
    }
  }
}
