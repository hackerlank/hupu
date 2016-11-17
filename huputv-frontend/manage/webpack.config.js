var path = require("path");
// var HtmlWebpackPlugin = require('html-webpack-plugin');

var distUrl = '/dist/manage/';

module.exports = function(webpackConfig) {
  webpackConfig.babel.plugins.push('antd');

  // Fix ie8 compatibility
  webpackConfig.module.loaders.unshift(
    {
        test: /\.jsx?$/,
        loader: 'es3ify-loader',
    }
  );

  webpackConfig.resolve.alias = {
    'common': path.resolve(__dirname, 'src', 'common')
  };

  // webpackConfig.output = {
  //   path: __dirname + distUrl + 'static',
  //   publicPath: '/',
  //   filename: '[name].[hash].js',
  //   chunkFilename: '[name].[hash].js'
  // }

  // webpackConfig.plugins = [];

  // webpackConfig.plugins.push(
  //   new HtmlWebpackPlugin({
  //     template: './index.html',
  //     filename: distUrl + 'index.html',
  //     inject: 'body'
  //   })
  // )

  return webpackConfig;
};
