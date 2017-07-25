---
weight: 20
title: JS
---

## An Introduction to Webpack

**Webpack** is a bundler for javascript, and related resources.
All resources are treated as modules, and with various *loaders*,
webpack can handle modules of CommonJs, AMD, ES6, CSS, Image, JSON, Coffeescript, LESS, etc.


```
// what a webpack config file 'webpack.config.js' looks like
module: {
  loaders: [
    { test: /\.css$/, loader: 'style!css' }, // use ! to chain loaders
    { test: /\.js$/, loader: 'jsx?harmony!babel', exclude: /node_modules/ }
    // loaders can be written like 'jsx-loader' or 'jsx'
    // loaders can take parameters as a querystring
  ]
}
```
Entrance and output.

```
// webpack.config.js
module.exports = {
  entry: './entry.js',
  output: {
    filename: 'bundle.js'
  }
};
```
Filename extensions.
```
// webpack.config.js
module.exports = {
  entry: 'entry.js',
  output: {
    filename: 'bundle.js'
  },
  resolve: {
    extensions: ['', '.js]
    // require('./foo') will search module with filename './foo' and './foo.js'
  }
}
```

### require a module
```
require('foo') // from module directory
require('./bar') // from relative path

define (require, exports.module) ->
  require('foo')
  require('./bar)
```

#### module shim
To require modules from `window`, you might need `expose-loader`.
Take jQuery for example
```
{ test: require.resolve('jquery'), loader: 'expose?jQuery' }
```

### CSS and Image
Write loader and require them as normal modules.
```
// webpack.config.js
module.exports = {
  entry: 'entry.js',
  output: {
    path: './build', // for output processed images and resources
    publicPath: 'http://mycdn.com/', // for generate URLs to resources
    filename: 'bundle.js'
  },
  module: {
    loaders: [
      { test: /\.js$/, loader: 'jsx?harmony!babel', exclude: /node_modules/ }
      { test: /\.css$/, loader: 'style!css },
      { test: /\.less$/, loader: 'style!css!less },
      { test: /\.(png|jpg)$/, loader: 'url?limit=8192' }
      // inline base64 URLs for <=8k images, direct URLs for the rest
    ]
  }
};
```
```
require('./bootstrap.css');
require('./style.less');

let img = document.createElement('img');
img.src = require('./logo.png');
```

### Multi-package and shared package
Shared packages are handled by `commonsPlugin`.
```
var CommonsChunkPlugin = require("webpack/lib/optimize/CommonsChunkPlugin");
module.exports = {
    entry: {
        p1: "./page1",
        p2: "./page2",
        p3: "./page3"
    },
    output: {
        filename: "[name].entry.chunk.js"
    },
    plugins: [
        new CommonsChunkPlugin("commons.chunk.js")
    ]
}
```

### [Separated CSS package](http://webpack.github.io/docs/stylesheets.html#separate-css-bundle)

### Hash js files
*One hash for the bundle*
`webpack ./entry output.[hash].bundle.js`
```
{
    output: {
        path: path.join(__dirname, "assets", "[hash]"),
        publicPath: "assets/[hash]/",
        filename: "output.[hash].bundle.js",
        chunkFilename: "[id].[hash].bundle.js"
    }
}
```

*One hash per chunk* `--output-chunk-file [chunkhash].js`
```
output: { chunkFilename: "[chunkhash].bundle.js" }
```

*Get filenames from stats*
```
plugins: [
  function() {
    this.plugin("done", function(stats) {
      require("fs").writeFileSync(
        path.join(__dirname, "..", "stats.json"),
        JSON.stringify(stats.toJson()));
    });
  }
]
```

### Options for Product
You can specify a different config file for product-level bundling.
`webpack --config webpack.min.js`

Compress the code. Loaders are switched into minimizing mode.
[Uglify](http://webpack.github.io/docs/list-of-plugins.html#uglifyjsplugin)
```
plugins: [
   new webpack.optimize.MinChunkSizePlugin(minSize)
]
```
```
new webpack.optimize.UglifyJsPlugin([options])
// e.g.
new webpack.optimize.UglifyJsPlugin({
    compress: {
        warnings: false
    }
})
```

You can/should use normal npm React package instead of the precompiled library.
Webpack can compress it to smaller size than react.min.js.
```
new webpack.DefinePlugin({
  "process.env": {
    NODE_ENV: JSON.stringify("production")
  }
})
```

#### Hot Replace
Include `webpack/hot/dev-server` in your project code, edit config file.
```
  entry: {
    main: ['webpack/hot/dev-server', './entry],
  },
```
Then start the server, and visit it at [http://localhost:8080/webpack-dev-server/].
```
webpack-dev-server --hot --quiet
```

And there is a [**react-hot-loader**](http://gaearon.github.io/react-hot-loader/getstarted/).
```
entry: [
  'webpack-dev-server/client?http://0.0.0.0:8080', // WebpackDevServer host and port
  'webpack/hot/only-dev-server',
  './scripts/index' // Your appʼs entry point
]
```
As for `only-dev-server`, the issue is replied [here](https://github.com/gaearon/react-hot-loader/issues/73#issuecomment-73679446).

### Miscellaneous
When webpack reports an error, but you cannot find out what's wrong, try this.
```
webpack --display-error-details
```

----
[Webpack list of loaders] http://webpack.github.io/docs/list-of-loaders.html
[optimization](https://github.com/webpack/docs/wiki/optimization#multi-page-app)
[long term caching]http://webpack.github.io/docs/long-term-caching.html
