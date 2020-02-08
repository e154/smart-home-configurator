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

var gulp = require('gulp'),
    config = require('../config'),
    watcher = function (_task, _source) {
        var task = _task,
            source = _source;

        gulp.watch(source, function () {
            gulp.run(task);
        });
    };

gulp.task('watch', function() {

    //  coffee
    //================//
    for (var key in config.build_coffee_js) {

        (function (_task, _paths) {

            var task = 'coffee:' + _task,
                paths = _paths;

            watcher(task, paths)

        })(key, config.build_coffee_js[key].watch)
    }

    //  less
    //================//
    for (var key in config.build_less) {

        (function (_task, _paths) {

            var task = 'less:' + _task,
                paths = _paths;

            watcher(task, paths)

        })(key, config.build_less[key].watch)
    }

    //  haml
    //================//
    for (var key in config.build_haml) {

        (function (_task, _paths) {

            var task = 'haml:' + _task,
                paths = _paths;

            watcher(task, paths)

        })(key, config.build_haml[key].watch)
    }

    //  templates
    //================//
    for (var key in config.build_templates) {

        (function (_task, _paths) {

            var task = 'template:' + _task,
                paths = _paths;

            watcher(task, paths)

        })(key, config.build_templates[key].watch)
    }

    gulp.watch(config.copy.translate.watch, function() {
        gulp.run('copy:translate');
    });
    gulp.watch(config.redactor_theme_less.watch, function() {
        gulp.run('redactor_theme_less');
    });
    gulp.watch(config.redactor_theme_files.watch, function() {
        gulp.run('redactor_theme_files');
    });
});
