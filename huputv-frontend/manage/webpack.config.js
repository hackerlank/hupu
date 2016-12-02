var path = require("path");

var ENV = process.env.npm_lifecycle_event;
var isProd = ENV === 'build';
var distPaths = __dirname + '/dist/manage/';
var appPaths = __dirname + '/src/';

module.exports = function(config) {
  config.babel.plugins.push('antd');

  // Fix ie8 compatibility
  config.module.loaders.unshift(
    {
        test: /\.jsx?$/,
        loader: 'es3ify-loader',
    }
  );

  config.resolve.alias = {
    'common': path.resolve(__dirname, 'src', 'common')
  };

  return config;
};
