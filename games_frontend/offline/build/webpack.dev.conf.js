var webpack = require('webpack')
var config = require('./webpack.base.conf')
var HtmlWebpackPlugin = require('html-webpack-plugin')
var BrowserSyncPlugin = require('browser-sync-webpack-plugin')
var PAGES = require('./pages')
config.devtool = 'eval-source-map'


// add hot-reload related code to entry chunk
config.entry = PAGES.reduce(
      function (memo, page) {
        memo[page] = [
         'eventsource-polyfill',
         'webpack-hot-middleware/client?quiet=true&reload=true',
          config.entry[page]
        ]
        return memo;
      },
      {}
);

config.output.publicPath = '/'

config.plugins = (config.plugins || []).concat([
  new webpack.optimize.OccurenceOrderPlugin(),
  new webpack.HotModuleReplacementPlugin(),
  new webpack.NoErrorsPlugin(),
  new BrowserSyncPlugin(
    // BrowserSync options
    {
      host: '127.0.0.1',
      port: 8080,
      proxy: 'http://127.0.0.1:8000/',
      logConnections: false,
      notify: false
    },
    // plugin options
    {
      reload: true
  })
])

PAGES.forEach(function (page) {
      var excludes = PAGES.filter(function (p) { return p !== page }).concat('app');
      var chunks = excludes.concat(excludes.map(function (p) { return p + '-commons' }));

      config.plugins.push(
        new HtmlWebpackPlugin({
          template: './src/' + page + '/' + page + '.html',
          filename: page + '.html',
          excludeChunks: chunks
        })
     );

      config.plugins.push(
        new HtmlWebpackPlugin({
          template: './src/' + page + '/' + page + '.night.html',
          filename: page + '.night.html',
          excludeChunks: chunks
        })
     );
});

module.exports = config
