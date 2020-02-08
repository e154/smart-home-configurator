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
    conf_css = require('../config').build_lib_css,
    conf_js = require('../config').build_lib_js,
    mainBowerFiles = require('main-bower-files'),
    concat = require('gulp-concat'),
    filter = require('gulp-filter'),
    csso = require('gulp-csso'),
    inject = require("gulp-inject"),
    uglify = require('gulp-uglify');

for (var key in conf_js) {

    (function (_task, _paths, _filename, _dest) {

        var task = 'bower:js:' + _task,
            paths = _paths,
            filename = _filename,
            dest = _dest;

        gulp.task(task, function() {
            var jsFilter = filter('**/*.js');       //отбираем только  javascript файлы
            return gulp.src(mainBowerFiles({
                includeDev: false,
                paths: paths
            }))

                .pipe(jsFilter)
                .pipe(concat(filename))
                .pipe(gulp.dest(dest));
        });

    })(key, conf_js[key].paths, conf_js[key].filename, conf_js[key].dest)
}

for (var key in conf_css) {

    (function (_task, _paths, _filename, _dest) {

        var task = 'bower:css:' + _task,
            paths = _paths,
            filename = _filename,
            dest = _dest;

        gulp.task(task, function () {
            var cssFilter = filter('**/*.css');  //отбираем только css файлы
            return gulp.src(mainBowerFiles({
                includeDev: false,
                paths: paths
            }))

                .pipe(cssFilter)
                //.pipe(csso()) // минимизируем css
                .pipe(concat(filename))
                .pipe(gulp.dest(dest)); // записываем css
        });

    })(key, conf_css[key].paths, conf_css[key].filename, conf_css[key].dest)
}

gulp.task('bower:js', ['bower:js:public', 'bower:js:private']);
gulp.task('bower:css', ['bower:css:public', 'bower:css:private']);
