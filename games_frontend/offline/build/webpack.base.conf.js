var path = require('path')
var PAGES = require('./pages');
var autoprefixer = require('autoprefixer');

module.exports = {
  entry: PAGES.reduce(
      function (memo, page) {
        memo[page] = './src/' + page + '/' + page + '.js';
        return memo;
      },
      {}
  ),
  output: {
    path: path.resolve(__dirname, '../dist/static'),
    publicPath: '/static/',
    filename: '[name].js'
  },
  externals: {
      // require("jquery") is external and available
      //  on the global var jQuery
      // 'zepto':'Zepto'
  },
  resolve: {
    extensions: ['', '.js', '.vue', '.less'],
    alias: {
      'src': path.resolve(__dirname, '../src'),
      'common': path.resolve(__dirname, '../src', 'common'),
      'components': path.resolve(__dirname, '../src', 'components')
    },
  },
  resolveLoader: {
    root: path.join(__dirname, 'node_modules'),
  },
  module: {
    loaders: [
      {
        test: /\.vue$/,
        loader: 'vue'
      },
      {
        test: /\.js$/,
        loader: 'babel',
        exclude: /node_modules|vue\/dist|vue-router\/|vue-loader\/|vue-hot-reload-api\//
      },
      {
        test: /\.json$/,
        loader: 'json'
      },
      {
        test: /\.less$/,
        loader: 'css!less'
      },
      {
        test: /\.(png|jpg|gif|svg)$/,
        loader: 'url',
        query: {
          limit: 10000,
          name: '[name].[ext]?[hash]'
        }
      }
    ]
  },
  vue: {
    loaders: {
      js: 'babel',
      css: 'vue-style!css!less'
    }
  },
  eslint: {
    formatter: require('eslint-friendly-formatter')
  },
  /**
   * PostCSS
   * Reference: https://github.com/postcss/autoprefixer-core
   * Add vendor prefixes to your css
   */
  postcss: [
    autoprefixer({
      browsers: ['last 2 version']
    })
  ]
}
