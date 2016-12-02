'use strict';

// Modules
var webpack = require('webpack');
var autoprefixer = require('autoprefixer');
var HtmlWebpackPlugin = require('html-webpack-plugin');
var ExtractTextPlugin = require('extract-text-webpack-plugin');
var CopyWebpackPlugin = require('copy-webpack-plugin');


/**
 * Env
 * Get npm lifecycle event to identify the environment
 */
var ENV = process.env.npm_lifecycle_event;
var isProd = ENV === 'build';
var appPaths = __dirname + '/src';


module.exports = function makeWebpackConfig () {
  /**
   * Config
   * Reference: http://webpack.github.io/docs/configuration.html
   * This is the object where all configuration gets set
   */
  var config = {};

  /**
   * Entry
   * Reference: http://webpack.github.io/docs/configuration.html#entry
   * Should be an empty object if it's generating a test build
   * Karma will set this when it's a test build
   */
  config.entry = {
    app: appPaths + '/entry/index.jsx',
    h5: appPaths + '/entry/h5.jsx',
    vendors: [
      'react',
      'react-dom',
      'react-router',
      'react-redux',
      'react-cookie',
      'es6-promise',
      'isomorphic-fetch'
    ]
  };

  /**
   * Output
   * Reference: http://webpack.github.io/docs/configuration.html#output
   * Should be an empty object if it's generating a test build
   * Karma will handle setting it up for you when it's a test build
   */
  config.output = {
    // Absolute output directory
    path: __dirname + '/dist/lrw_manage/static',

    // Output path from the view of the page
    // Uses webpack-dev-server in development
    publicPath: isProd ? '/lrw_manage/static/' : '/',
    // publicPath: isProd ? './static/' : '/',

    // Filename for entry points
    // Only adds hash in build mode
    filename: isProd ? '[name].[hash:8].js' : '[name].bundle.js',

    // Filename for non-entry points
    // Only adds hash in build mode
    chunkFilename: isProd ? '[name].[hash:8].js' : '[name].bundle.js'
  };

  /**
   * Devtool
   * Reference: http://webpack.github.io/docs/configuration.html#devtool
   * Type of sourcemap to use per build type
   */
  if (isProd) {
    config.devtool = 'source-map';
  } else {
    config.devtool = 'eval-source-map';
  }

  config.resolve = {
    // 后缀名
    extensions: ['', '.js', '.jsx', '.scss'],
    // 别名
    alias: {
      'COMMON': appPaths + '/common',
      'UTIL': appPaths + '/common/util',
      'CUI': appPaths + '/common/ui',
      'COMPONENT': appPaths + '/component',
      'ACTION': appPaths + '/actions',
      'REDUCER': appPaths + '/reducers',
      'MODAL': appPaths + '/common/modal/index',
      'DATASERVICE': appPaths + '/common/dataService'
    }
  }

  /**
   * Loaders
   * Reference: http://webpack.github.io/docs/configuration.html#module-loaders
   * List: http://webpack.github.io/docs/list-of-loaders.html
   * This handles most of the magic responsible for converting modules
   */


  // Initialize module
  config.module = {
    preLoaders: [],
    loaders: [{
      // JS LOADER
      // Reference: https://github.com/babel/babel-loader
      // Transpile .js files using babel-loader
      // Compiles ES6 and ES7 into ES5 code
      test: /\.js|jsx$/,
      // loaders: ['babel', 'babel-loader', 'eslint-loader'],
      loaders: ['babel'],
      exclude: /node_modules/
    }, {
      // ASSET LOADER
      // Reference: https://github.com/webpack/url-loader
      // Copy png, jpg, jpeg, gif files to output
      // Rename the file using the asset hash
      // Pass along the updated reference to your code
      // You can add here any file extension you want to get copied to your output
      test: /\.(png|jpg|jpeg|gif)$/,
      loader: 'file?limit=10000&name=images/[name].[hash:8].[ext]'
    }, {
      // ASSET LOADER
      // Reference: https://github.com/webpack/file-loader
      // Copy svg, woff, woff2, ttf, eot files to output
      // Rename the file using the asset hash
      // Pass along the updated reference to your code
      // You can add here any file extension you want to get copied to your output
      test: /\.(svg|woff|woff2|ttf|eot)$/,
      loader: 'file?&name=fonts/[name].[hash:8].[ext]'
    }, {
      // HTML LOADER
      // Reference: https://github.com/webpack/raw-loader
      // Allow loading html throughimages/ js
      test: /\.html$/,
      loader: 'raw'
    }]
  };


  // CSS LOADER
  // Reference: https://github.com/webpack/css-loader
  // Allow loading css through js
  //
  // Reference: https://github.com/postcss/postcss-loader
  // Postprocess your css with PostCSS plugins
  var cssLoader = {
    test: /\.css$/,
    // Reference: https://github.com/webpack/extract-text-webpack-plugin
    // Extract css files in production builds
    //
    // Reference: https://github.com/webpack/style-loader
    // Use style-loader in development for hot-loading
    loader: ExtractTextPlugin.extract('style', 'css?module&localIdentName=[name]-[local]-[hash:8]&-url?sourceMap!postcss')
  };


  var sassLoader = {
    test: /\.s(a|c)ss$/,
    loader: ExtractTextPlugin.extract('style', 'css?sourceMap!postcss!sass?sourceMap')
  };

  // Add cssLoader to the loader list
  config.module.loaders.push(cssLoader, sassLoader);
  config.sassLoader = {includePaths: appPaths + '/static'};


  /**
   * PostCSS
   * Reference: https://github.com/postcss/autoprefixer-core
   * Add vendor prefixes to your css
   */
  config.postcss = [
    // autoprefixer({
    //   browsers: ['last 2 version']
    // })
  ];

  /**
   * Plugins
   * Reference: http://webpack.github.io/docs/configuration.html#plugins
   * List: http://webpack.github.io/docs/list-of-plugins.html
   */
  config.plugins = [];

  // Reference: https://github.com/ampedandwired/html-webpack-plugin
  // Render index.html
  config.plugins.push(
    new HtmlWebpackPlugin({
      template: './index.html',
      filename: '../index.html',
      chunks: ['vendors', 'app'],
      inject: 'body'
    }),
    new HtmlWebpackPlugin({
      template: './h5.html',
      filename: '../h5.html',
      inject: 'body',
      chunks: ['vendors', 'h5']
    }),

    new webpack.optimize.OccurenceOrderPlugin(),

    // Reference: https://github.com/webpack/extract-text-webpack-plugin
    // Extract css files
    // Disabled when in test mode or not in build mode
    new ExtractTextPlugin((isProd ? '[name].[hash:8].css' : '[name].bundle.css'))
  )

  // Add build specific plugins
  if (isProd) {
    config.plugins.push(
      // Reference: http://webpack.github.io/docs/list-of-plugins.html#noerrorsplugin
      // Only emit files when there are no errors
      new webpack.NoErrorsPlugin(),

      // Reference: http://webpack.github.io/docs/list-of-plugins.html#dedupeplugin
      // Dedupe modules in the output
      new webpack.optimize.DedupePlugin(),

      // Reference: http://webpack.github.io/docs/list-of-plugins.html#uglifyjsplugin
      // Minify all javascript, switch loaders to minimizing mode
      new webpack.optimize.UglifyJsPlugin({
        mangle:   true,
        compress: {
            warnings: false // Suppress uglification warnings
        }
      }),

      // Warning: It looks like you're using a minified copy of the development build of React. When deploying React apps to production, make sure to use the production build which skips development warnings and is faster. See https://fb.me/react-minification for more details.
      new webpack.DefinePlugin({
        "process.env": {
           NODE_ENV: JSON.stringify("production")
         }
      })

      // Copy assets from the public folder
      // Reference: https://github.com/kevlened/copy-webpack-plugin
      // new CopyWebpackPlugin(
      //   [{
      //     from: appPaths + '/static'
      //   }],
      //   {
      //     ignore: [
      //       { glob: 'sass/**/*', dot: true }
      //     ]
      //   }
      // )
    )
  }

  config.plugins.push(new webpack.optimize.CommonsChunkPlugin('vendors', '[name].[hash:8].js'))


  // config.eslint = {
  //   configFile: '.eslintrc'
  // };

  /**
   * Dev server configuration
   * Reference: http://webpack.github.io/docs/configuration.html#devserver
   * Reference: http://webpack.github.io/docs/webpack-dev-server.html
   */
  config.devServer = {
    contentBase: appPaths,
    host: '127.0.0.1',
    port: 9091, //默认8080
    stats: 'minimal'
  };

  return config;
}();
