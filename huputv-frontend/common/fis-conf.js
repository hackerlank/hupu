require('fis3-smarty')(fis);

fis.set('namespace', 'common');

// 构建中去除
fis.set('project.ignore', [
  //'test/**',
  'server-conf/**',
  'fis-conf.js',
  'static/sass/**',
  'output/**',
  'node_modules/**',
  '.git/**',
  '.svn/**'
]);

// 加 md5
fis.match('*.{js,scss,css,png}', {
  useHash: true
});
// 不加 md5
fis.match('*.swf', {
  useHash: false
});

fis.media('debug').match('*.{js,css,png}', {
  useHash: false,
  useSprite: false,
  optimizer: null
});

// 启用 fis-spriter-csssprites 插件
fis.match('::package', {
    spriter: fis.plugin('csssprites'),
    packager: fis.plugin('map', {
        useTrack : false, // 是否输出路径信息,默认为 true
        'pkg/common.css': [
            'static/common.scss',
            'widget/header/header.scss',
            'widget/footer/footer.scss',
            'widget/toast/toast.scss'
        ],
        'pkg/lib.js': [
            'static/mod.js',
            'static/js/jquery/jquery-1.12.0.min.js',
            'static/js/colorbox/jquery.colorbox.js',
            'widget/underscore/underscore.js'
        ],
        'pkg/common.js': [
            'static/js/global/global.js',
            'widget/page-dace/page-dace.es6',
            'widget/header/header.js',
            'widget/login/login.js',
            'widget/toast/toast.js'
        ],
        'pkg/share.js': [
            'widget/share/qrcode/qrcode.js',
            'widget/share/share.js'
        ],
        'pkg/videojs.js': [
            'static/js/videojs/ie8/videojs-ie8.js',
            'static/js/videojs/video.js',
            'static/js/videojs/videojs-hls.min.js'
        ]
    })
})

// 对 CSS 进行图片合并
fis.match('*.{css,scss}', {
  // 给匹配到的文件分配属性 `useSprite`
  useSprite: true
});

fis.match('*.{es6,js}', {
  // fis-optimizer-uglify-js 插件进行压缩，已内置
  optimizer: fis.plugin('uglify-js')
});

fis.match('*.{css,scss}', {
   // fis-optimizer-clean-css 插件进行压缩，已内置
   optimizer: fis.plugin('clean-css')
});

// 开启es6
fis.match('*.es6', {
  rExt: '.js',
  parser: fis.plugin('es6-babel')
});

// 开启模块化开发
fis.hook('module');
fis.match('*.es6', {
  isMod: true
});

fis.match('*.png', {
  // fis-optimizer-png-compressor 插件进行压缩，已内置
  optimizer: fis.plugin('png-compressor')
});

fis.match('*.scss', {
  rExt: '.css',
  parser: fis.plugin('node-sass', {
  })
});

var dev104_receiver = 'http://192.168.8.104/receiver.php';
var dev103_receiver = 'http://192.168.11.103/receiver.php';
var dev112_receiver = 'http://192.168.8.112/receiver.php';
var qa123_receiver = 'http://192.168.8.123/receiver.php';

// 生成本地
function localTo(to) {
    return fis.plugin('local-deliver', {
        to: to
    });
}

// 推送到开发
function pushDev(receiver){
  return fis.plugin('http-push', {
        receiver: receiver,
        to: '/data/www-data/hupu.com/huputv_frontend'
    });
}

// 测试服务器
fis.media('qa123').match('*', {
  deploy: pushDev(qa123_receiver)
});

// 开发服务器
fis.media('dev104').match('*', {
    deploy: pushDev(dev104_receiver)
});

// 开发服务器
fis.media('dev103').match('*', {
    deploy: pushDev(dev103_receiver)
});

// 开发服务器
fis.media('dev112').match('*', {
    deploy: pushDev(dev112_receiver)
});

// 本地
fis.media('local').match('*', {
  deploy: fis.plugin('local-deliver', {
    to: '../output'
  })
});

// 上线增加cdn
fis.media('pushAddCdn')
  .match ('*.{png,jpg,js,es6,css,scss,eot,svg,ttf,woff,swf}', {
      domain: ['http://b3.hoopchina.com.cn/web/tv', 'http://b2.hoopchina.com.cn/web/tv', 'http://b1.hoopchina.com.cn/web/tv']
  })
  .match('*', {
    deploy: pushDev(qa123_receiver)
  });

// 线上
fis.media('online')
  // 静态资源
  .match('*.{png,jpg,js,es6,css,scss,eot,svg,ttf,woff,swf}', {
    deploy: localTo('../../b1/web/tv'),
    // cdn
    domain: ['http://b3.hoopchina.com.cn/web/tv', 'http://b2.hoopchina.com.cn/web/tv', 'http://b1.hoopchina.com.cn/web/tv']
  })
  .match('*-map.json', {
    deploy: localTo('../output')
  })
  .match('/plugin/*.php', {
    deploy: localTo('../output')
  })
  .match('*.tpl', {
    deploy: localTo('../output')
  });
