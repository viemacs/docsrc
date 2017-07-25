---
weight: 20
title: JS
---

## GULP

`
 我曾经自己配置的一个打包构建gulpfile，里面做了上述我提到的所有事情，除了js模块化打包之外，
这个大家可以自己研究下，比较简单。我来解释下各个任务的作用。

default， 主要是监听less变化生成css。
clean， 清除掉publish文件夹的内容
bulid，把源码移动到publish文件夹下面，对于一些类型的文件做处理，例如css的压缩，js的压缩，图片的压缩缓存等等。
revision，md5文件，根据html，css的引用来给相关的文件添加md5戳，生成新的md5戳文件，来保持文件更新。
publish，根据上面 revision生成的新的md5文件来做一次文件替换，替换里面js，css，image的引用路径。

其实有些地方可以优化的，这个大家有时间可以自己去试试。
`

//三只松鼠–干货

var gulp = require('gulp');
var less = require('gulp-less');
var plugins = require('gulp-load-plugins')();
var pngquant = require('imagemin-pngquant');
 
 
gulp.task('default', function(){
    gulp.src('less/zhanzhao.less').pipe(less()).pipe(gulp.dest('css/'));
    gulp.src('less/liuqian.less').pipe(less()).pipe(gulp.dest('css/'));
    gulp.src('less/student.less').pipe(less()).pipe(gulp.dest('css/'));
    return gulp.src('less/company.less').pipe(less()).pipe(gulp.dest('css/'));
});
 
gulp.task('clean',function(){
    return gulp.src('publish/').pipe(plugins.clean());
});
 
 
gulp.task('bulid', ['clean'],function(){
  gulp.src('favicon.ico').pipe(gulp.dest('publish/'));
    gulp.src('download/**/*').pipe(gulp.dest('publish/download/'));
    gulp.src('mail/**/*').pipe(gulp.dest('publish/mail/'));
    gulp.src('statement/**/*').pipe(gulp.dest('publish/statement/'));
    gulp.src('template/**/*').pipe(gulp.dest('publish/template/'));
  gulp.src('css/**/*.css').pipe(plugins.minifyCss()).pipe(gulp.dest('publish/css/'));
    gulp.src('scripts/**/*.js').pipe(plugins.uglify()).pipe(gulp.dest('publish/scripts/'));
  return gulp.src('images/**/*').pipe(plugins.cache(plugins.imagemin({
            optimizationLevel: 5,
            progressive: true,
            svgoPlugins: [{removeViewBox: false}],
            use: [pngquant()]
        }))).pipe(gulp.dest('publish/images/'));
});
 
gulp.task("revision",['bulid'],function(){
  gulp.src(['template/head-js.html', 'template/baidu.html']).pipe(plugins.concat('head-js.html')).pipe(gulp.dest('publish/template/'));
 
  return gulp.src(['publish/css/*.css','publish/scripts/config.js','publish/images/**/*'],{base: 'publish'})
        .pipe(plugins.rev())
        .pipe(gulp.dest('publish/'))
        .pipe(plugins.rev.manifest({
          merge: true
        }))
        .pipe(gulp.dest('publish/'));
});
 
 
gulp.task("publish", ["revision"],function(){
  var manifestCss = gulp.src("publish/rev-manifest.json"),
      manifestDownload = gulp.src("publish/rev-manifest.json"),
      manifest = gulp.src("publish/rev-manifest.json");
 
  gulp.src('publish/css/*.css')
    .pipe(plugins.revReplace({manifest: manifest}))
    .pipe(gulp.dest('publish/css/'));
 
  gulp.src('*.html')
    .pipe(plugins.revReplace({manifest: manifestCss}))
    .pipe(gulp.dest('publish/'));
 
  gulp.src('publish/download/*.html')
    .pipe(plugins.revReplace({manifest: manifestDownload}))
    .pipe(gulp.dest('publish/download/'));
});

