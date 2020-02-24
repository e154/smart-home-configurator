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
    conf_files = require('../config').redactor_theme_files,
    conf_theme = require('../config').redactor_theme_less,
    less = require('gulp-less'),
    concat = require('gulp-concat'),
    gutil = require('gulp-util');

gulp.task('redactor_theme_files', function() {
    return gulp.src(conf_files.minimal.source)
        .pipe(gulp.dest(conf_files.minimal.dest));
});

gulp.task('redactor_theme_less', function() {
    return gulp.src(conf_theme.minimal.source)
        .pipe(concat(conf_theme.filename))
        .pipe(less())
        .on('error', function(err){
            gutil.log(err);
            this.emit('end');
        })
        .pipe(gulp.dest(conf_theme.minimal.dest));
});
