var webpack = require('webpack')
var config = require('./webpack.base.conf')
var ExtractTextPlugin = require('extract-text-webpack-plugin')
var HtmlWebpackPlugin = require('html-webpack-plugin')
var PAGES = require('./pages')

// naming output files with hashes for better caching.
// dist/index.html will be auto-generated with correct URLs.
config.output.filename = '[name].[chunkhash].js'
config.output.chunkFilename = '[id].[chunkhash].js'

// whether to generate source map for production files.
// disabling this can speed up the build.
var SOURCE_MAP = false

config.devtool = SOURCE_MAP ? 'source-map' : false

// generate loader string to be used with extract text plugin
function generateExtractLoaders (loaders) {
  return loaders.map(function (loader) {
    return loader + '-loader' + (SOURCE_MAP ? '?sourceMap' : '')
  }).join('!')
}

config.vue.loaders = {
  js: 'babel',
  // http://vuejs.github.io/vue-loader/configurations/extract-css.html
  css: ExtractTextPlugin.extract('vue-style-loader', generateExtractLoaders(['css', 'less']))
}

config.plugins = (config.plugins || []).concat([
  // http://vuejs.github.io/vue-loader/workflow/production.html
  new webpack.DefinePlugin({
    'process.env': {
      NODE_ENV: '"production"'
    }
  }),
  new webpack.optimize.UglifyJsPlugin({
    compress: {
      warnings: false
    }
  }),
  new webpack.optimize.OccurenceOrderPlugin(),
  // extract css into its own file
  new ExtractTextPlugin('[name].[contenthash].css'),
  // generate dist index.html with correct asset hash for caching.
  // you can customize output by editing /build/index.template.html
  // see https://github.com/ampedandwired/html-webpack-plugin
  // new HtmlWebpackPlugin({
  //   filename: '../index.html',
  //   template: 'src/index.html'
  // })
])

PAGES.forEach(function (page) {
      var excludes = PAGES.filter(function (p) { return p !== page }).concat('app');
      var chunks = excludes.concat(excludes.map(function (p) { return p + '-commons' }));

      config.plugins.push(
        new HtmlWebpackPlugin({
          template: 'src/'+ page + '/' + page + '.html',
          filename: '../'  + page + '.html',
          excludeChunks: chunks
        })
     );

     config.plugins.push(
       new HtmlWebpackPlugin({
         template: './src/' + page + '/' + page + '.night.html',
         filename: '../' + page + '.night.html',
         excludeChunks: chunks
       })
    );
});

module.exports = config
