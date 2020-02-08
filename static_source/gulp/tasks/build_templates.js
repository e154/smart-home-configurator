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
    conf = require('../config').build_templates,
    connect = require('gulp-connect'),
    templateCache = require('gulp-angular-templatecache');

for (var key in conf) {

    (function (_task, _source, _filename, _dest, _prefix) {

        var task = 'template:' + _task,
            source = _source,
            filename = _filename,
            prefix = _prefix,
            dest = _dest;

        gulp.task(task, function() {
            return gulp.src(source)
                .pipe(templateCache(filename, {
                    transformUrl: function(url) {
                        return prefix + url.replace(/\.html\.html/, '.html')
                    }
                }))
                .pipe(gulp.dest(dest))
                .pipe(connect.reload());
        });


    })(key, conf[key].source, conf[key].filename, conf[key].dest, conf[key].prefix)
}

gulp.task('template', ['template:public', 'template:private']);
