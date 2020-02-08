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
    conf = require('../config').build_haml,
    cache = require('gulp-cached'),
    haml = require('gulp-haml');

for (var key in conf) {

    (function (_task, _source, _dest) {

        var task = 'haml:' + _task,
            source = _source,
            dest = _dest;

        gulp.task(task, function() {
            return gulp.src(source, {read: true})
                .pipe(cache('linting'))
                .pipe(haml())
                .pipe(gulp.dest(dest));
            //.pipe(connect.reload());
        });


    })(key, conf[key].source, conf[key].dest)
}

gulp.task('haml', ['haml:public', 'haml:private']);
