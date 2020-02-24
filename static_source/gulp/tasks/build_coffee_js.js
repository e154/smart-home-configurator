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
    conf = require('../config').build_coffee_js,
    concat = require('gulp-concat'),
    ngconcat = require('gulp-ngconcat'),
    inject = require('gulp-inject'),
    coffee = require('gulp-coffee'),
    uglify = require('gulp-uglify'),
    replace = require('gulp-replace');

var date = new Date();

for (var key in conf) {

    (function (_task, _source, _filename, _dest) {

        var task = 'coffee:' + _task,
            source = _source,
            filename = _filename,
            dest = _dest;

        gulp.task(task, function(done) {
            return gulp.src(source)
                .pipe(coffee({bare: true})
                    .on('error', done))     // Compile coffeescript
                // .pipe(ngconcat(filename))
                .pipe(concat(filename))
                .pipe(uglify())
                //.pipe(ngClassify())
                .pipe(replace('__CURRENT_TIME__', date))
                .pipe(gulp.dest(dest));

        });

    })(key, conf[key].source, conf[key].filename, conf[key].dest)
}

gulp.task('coffee', ['coffee:public', 'coffee:private']);
