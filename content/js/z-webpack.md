---
weight: 20
title: JS
---

## Another Webpack Note

`
其实Webpack的入门指导文章非常多，配置方式也各有各样，这里我推荐题叶大神的入门级指南–Webpack 入门指迷，如果不知道Webpack是什么或者不是很清楚各项配置含义的开发者，可以看此文章扫扫盲。毕竟我这篇文章并不是特别基础。
`

### 1. base.js

var path = require('path')
var baseConfig = {
    resolve: {
        extensions: ['', '.js'],
        fallback: [path.join(__dirname, '../node_modules')],
        alias: {
            'src': path.resolve(__dirname, '../src'),
            'assets': path.resolve(__dirname, '../src/assets'),
            'components': path.resolve(__dirname, '../src/components')
        }
    },
    module: {
        loaders: [{
            test: /\.js$/,
            loader: 'babel',
            exclude: /node_modules/
        }, {
            test: /\.(png|jpe?g|gif|svg|woff2?|eot|ttf|otf)(\?.*)?$/,
            loader: 'url?limit=8192&context=client&name=[path][name].[hash:7].[ext]'
        },
        {
            test: /\.css$/,
            loader: 'style!css!autoprefixer',
        },
        {
            test: /\.scss$/,
            loader: 'style!css!autoprefixer!sass'
        }]
    }
};
 
module.exports = baseConfig;

`
解读下这个基本配置：

1、resolve 解析模块依赖的时候，受影响的配置项。

extensions 决定了哪些文件后缀在引用的时候可以省略点，Webpack帮助你补全名称。
fallback 当webpack在 root（默认当前文件夹，配置时要绝对路径） 和 modulesDirectories（默认当前文件夹，相对路径）配置下面找不到相关modules，去哪个文件夹下找modules
alias 这个大家应该比较熟悉，requirejs之类的都有，就是别名，帮助你快速指向文件路径，少写不少代码，而且不用关心层级关系，需要注意的是：在scss之类的css预编译中引用要加上~，以便于让loader识别是别名引用路径。

2、module 解析不同文件使用哪些loader，这个比较简单，很多文章都有，就不多说了，注意的是，这里的scss可以换成你自己的预编译器，例如：sass、less、stylus等，或者直接用postcss都行，当然还可以用一种通用方法，后面补上。
`

### 2. 开发环境配置 config

var webpack = require('webpack');
var path = require('path')
var merge = require('webpack-merge')
var baseConfig = require('./webpack.base')
var getEntries = require('./getEntries')
 
var hotMiddlewareScript = 'webpack-hot-middleware/client?reload=true';
 
var assetsInsert = require('./assetsInsert')
 
module.exports = merge(baseConfig, {
  entry: getEntries(hotMiddlewareScript),
  devtool: '#eval-source-map',
  output: {
    filename: './[name].[hash].js',
    path: path.resolve('./dist'),
    publicPath:'./dist'
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: '"development"'
      }
    }),
    new webpack.optimize.OccurenceOrderPlugin(),
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NoErrorsPlugin(),
    new assetsInsert()
  ]
})

`
说说这个配置中的一些难点：

1、getEntries 是用来配置入口文件，一般很多人是自己手写，或者SPA页面，只有一个入口， 很容易就写出来，但是公司中，很多情况，是需要多入口，也就是多路由的Url，这个时候入口的配置就比较麻烦，我这里是放单独一个文件里面配置，我们公司是靠规定来执行，也就是一个文件夹所有的main.js都认为是入口文件，其他都忽略。
`

function getEntry(hotMiddlewareScript) {
    var pattern = paths.dev.js + 'project/**/main.js';
    var array = glob.sync(pattern);
    var newObj = {};
 
    array.map(function(el){
        var reg = new RegExp('project/(.*)/main.js','g');
        reg.test(el);
        if (hotMiddlewareScript) {
            newObj[RegExp.$1] = [el, hotMiddlewareScript];
        } else {
            newObj[RegExp.$1] = el;
        }
    });
    return newObj;
}

`
2、assetsInsert 是用来做模板替换的，一个小插件把template里面的值替换成打包后的css或者js。
`

### 3. 打包环境配置 production

var webpack = require('webpack');
var path = require('path')
var merge = require('webpack-merge')
var baseConfig = require('./webpack.base')
var getEntries = require('./getEntries')
var ExtractTextPlugin = require('extract-text-webpack-plugin');
var assetsInsert = require('./assetsInsert')
 
var productionConf = merge(baseConfig, {
    entry: getEntries(),
    output: {
        filename: './[name].[hash].js',
        path: path.resolve('./public/dist'),
        publicPath: './'
    },
    plugins: [
        new webpack.DefinePlugin({
            'process.env': {
                NODE_ENV: '"production"'
            }
        }),
        new ExtractTextPlugin('./[name].[hash].css', {
            allChunks: true
        }),
        new webpack.optimize.UglifyJsPlugin({
            compress: {
                warnings: false
            }
        }),
        new webpack.optimize.OccurenceOrderPlugin(),
        new assetsInsert()
    ]
})
 
productionConf.module.loaders = [
             {
                test: /\.js$/,
                loader: 'babel',
                exclude: /node_modules/
            }, {
                test: /\.(png|jpe?g|gif|svg|woff2?|eot|ttf|otf)(\?.*)?$/,
                loader: 'url?limit=8192&context=client&name=[path][name].[hash:7].[ext]'
            },
            {
                test: /\.css$/,
                loader: ExtractTextPlugin.extract('style', 'css'),
            },
            {
                test: /\.scss$/,
                loader: ExtractTextPlugin.extract('style', 'css!sass')
            }]
 
module.exports = productionConf

`
基本跟开发的差不多，差别在于：

1、使用ExtractTextPlugin 来打包css，所以要干掉原来base的loaders，重新写了一个，在最下面。

2、UglifyJsPlugin 给js压缩代码。其他没有什么好解释的了，一样的。
`

### 4. 构建命令

require('shelljs/global')
env.NODE_ENV = 'production'
var ora = require('ora')
var webpack = require('webpack')
var webpackConfig = require('./webpack.production.config')
 
var spinner = ora('building for production...')
spinner.start()
 
var staticPath = __dirname + '/../public/dist/'
rm('-rf', staticPath)
mkdir('-p', staticPath)
 
webpack(webpackConfig, function (err, stats) {
  spinner.stop()
  if (err) throw err
  process.stdout.write(stats.toString({
    colors: true,
    modules: false,
    children: false,
    chunks: false,
    chunkModules: false
  }) + '\n')
})

`
写一个build.js，然后在package.json里面添加 script 参数

"build": "node build.js"//这里记得写自己build.js路径
`

### 5. 甜点（马卡龙） 有点腻

`
上面的配置是可以更改的，例如你在loaders 里面加上
`
{
  test: /\.vue$/,
  loader: 'vue'
}
`
就可以变成支持.vue文件的vuejs打包构建，同理，修改下支持jsx，和添加一些reactjs的module，就可以用来跑Reactjs的东西。

还有可以随意更改Css预编译器的类型，用你自己喜欢就行，或者跟我们前面提到的方法，把所有类型都配置上，
`
var path = require('path')
var config = require('../config')
var ExtractTextPlugin = require('extract-text-webpack-plugin')
 
exports.assetsPath = function (_path) {
  return path.posix.join(config.build.assetsSubDirectory, _path)
}
 
exports.cssLoaders = function (options) {
  options = options || {}
  // generate loader string to be used with extract text plugin
  function generateLoaders (loaders) {
    var sourceLoader = loaders.map(function (loader) {
      var extraParamChar
      if (/\?/.test(loader)) {
        loader = loader.replace(/\?/, '-loader?')
        extraParamChar = '&'
      } else {
        loader = loader + '-loader'
        extraParamChar = '?'
      }
      return loader + (options.sourceMap ? extraParamChar + 'sourceMap' : '')
    }).join('!')
 
    if (options.extract) {
      return ExtractTextPlugin.extract('vue-style-loader', sourceLoader)
    } else {
      return ['vue-style-loader', sourceLoader].join('!')
    }
  }
 
  // http://vuejs.github.io/vue-loader/configurations/extract-css.html
  return {
    css: generateLoaders(['css']),
    postcss: generateLoaders(['css']),
    less: generateLoaders(['css', 'less']),
    sass: generateLoaders(['css', 'sass?indentedSyntax']),
    scss: generateLoaders(['css', 'sass']),
    stylus: generateLoaders(['css', 'stylus']),
    styl: generateLoaders(['css', 'stylus'])
  }
}
 
// Generate loaders for standalone style files (outside of .vue)
exports.styleLoaders = function (options) {
  var output = []
  var loaders = exports.cssLoaders(options)
  for (var extension in loaders) {
    var loader = loaders[extension]
    output.push({
      test: new RegExp('\\.' + extension + '$'),
      loader: loader
    })
  }
  return output
}

`
这就是把所有的css预编译的都加到配置里面了。
`

