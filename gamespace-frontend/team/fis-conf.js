fis.config.merge({
	namespace : 'team',
    pack : {

    },
    modules : {
        parser: {
            sass : 'sass',
            scss: 'sass'
        },
        scss: 'sass'
    },
    roadmap : {
        ext: {
            sass: 'css',
            scss: 'css'
        },
        domain: '//w3.hoopchina.com.cn/channel/gamespace,//w2.hoopchina.com.cn/channel/gamespace, //w1.hoopchina.com.cn/channel/gamespace'
    },
    project : {
        exclude: ['**/_*.scss', '**/vendor', "**/static/mini.sh","**/static/watch*.js"]
    },
    deploy : {
        // 测试环境
        dev: [{
            receiver: 'http://dev-nba.hupu.com/receiver.php',
            from: '/static',
            to: '/data/www-data/hupu.com/gamespace-frontend',
            exclude: [/\/sass\//i]
        }, {
            receiver: 'http://dev-nba.hupu.com/receiver.php',
            from: "/template",
            to: '/data/www-data/hupu.com/gamespace-frontend'
        }, {
            receiver: 'http://dev-nba.hupu.com/receiver.php',
            from: "/config",
            to: '/data/www-data/hupu.com/gamespace-frontend'
        }],
        test: [{
            receiver: 'https://test-nba.hupu.com/receiver.php',
            from: '/static',
            to: '/data/www-data/hupu.com/gamespace-frontend',
            exclude: [/\/sass\//i]
        }, {
            receiver: 'https://test-nba.hupu.com/receiver.php',
            from: "/template",
            to: '/data/www-data/hupu.com/gamespace-frontend'
        }, {
            receiver: 'https://test-nba.hupu.com/receiver.php',
            from: "/config",
            to: '/data/www-data/hupu.com/gamespace-frontend'
        }],
        //本地
        local: [{
            from: "/template",
            to: '../output'
        }, {
            from: "/config",
            to: '../output'
        }, {
            from: "/static",
            to: '../output'
        }],
        //上线
        online: [{
            from: "/plugin",
            to: '../output'
        },{
            from: "/template",
            to: '../output'
        }, {
            from: "/config",
            to: '../output'
        }, {
            from: "/static",
            to: '../../w1/channel/gamespace/'
        }]
    }
});
