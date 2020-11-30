 // Importing specific gulp API functions lets us write them below as series() instead of gulp.series()
const { src, dest, watch, series, parallel } = require('gulp');
const fs = require('fs');
const del = require('del');

// Initialize modules
const sourcemaps = require('gulp-sourcemaps');
const sass = require('gulp-sass');
const concat = require('gulp-concat');
const uglify = require('gulp-uglify');
const postcss = require('gulp-postcss');
const autoprefixer = require('autoprefixer');
const cssnano = require('cssnano');

const excludeFromDist = [
    'Dockerfile',
    'node_modules/**',
    'Jenkinsfile'
];

const allowInPackageJson = ['name', 'version', 'description', 'keywords', 'author', 'license'];

// File paths
const files = { 
    scssPath: ['source/scss/barcelona/**/*.scss', '!source/scss/barcelona/theme/*.scss'],
    watchScssPath: 'source/scss/barcelona/*.scss',
    jsPath: 'source/js/barcelona/**/*.js'
}

// SCSS task: compile scss to css and place in assets/css folder
function scssTask(){    
    return src(files.scssPath)
        .pipe(sourcemaps.init()) // initialize sourcemaps first
        .pipe(sass()) // compile SCSS to CSS
        .pipe(postcss([ autoprefixer(), cssnano() ])) // PostCSS plugins
        .pipe(sourcemaps.write('.')) // write sourcemaps file in current directory
        .pipe(dest('assets/css')
    );
}

// JS task: concatenates and uglifies JS files to barcelona.min.js
function jsTask(){
    return src([
        files.jsPath
        //,'!' + 'includes/js/jquery.min.js', // to exclude any specific files
        ])
        .pipe(concat('barcelona.min.js'))
        .pipe(uglify())
        .pipe(dest('assets/js')
    );
}

// Watch task: watch SCSS and JS files for changes
function watchTask(){
    watch([files.watchScssPath, files.jsPath],
        series(
            parallel(scssTask, jsTask)
        )
    );    
}

function cleanUpDist(){
    return del('dist')
}

function makePackageJson(cb){
    let pkg = require('./package.json');
    Object.keys(pkg)
        .filter(key => !allowInPackageJson.includes(key))
        .forEach(key => delete pkg[key]);
    fs.writeFile('dist/package.json', JSON.stringify(pkg, null, 2), cb);
}

function injectDist() {
    return src('**', {
        ignore: excludeFromDist
    }).pipe(dest('dist'));
};

exports.dist = series(
    parallel(scssTask, jsTask),
    cleanUpDist,
    injectDist,
    makePackageJson
);

exports.default = series(
    parallel(scssTask, jsTask),
    watchTask
);