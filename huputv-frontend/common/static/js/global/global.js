/**
 * @file 整站都会引用的js，整站js的入口文件
 * @author yuhongfei@hupu.com
 **/
(function (win) {
    var pageDace = require('common:widget/page-dace/page-dace');

    /* ie console报错处理  */
    //if(window['console']){ return; }
    //window['console'] = {
    //    log: function(){}
    //    ,clear: function(){}
    //    ,debug: function(){}
    //    ,error: function(){}
    //    ,info: function(){}
    //    ,count: function(){}
    //    ,time: function(){}
    //    ,trace: function(){}
    //    ,warn: function(){}
    //}

    var isRun = false;
    var initEvent = function(){
        if(!isRun && window.__ready && window.__ready.length){
            isRun = true;
            $.each(window.__ready, function(idx, callback){
                callback.call(null);
            });
        }
    };

    window.initEvent = initEvent;

    $(document).ready(function () {
        var hasTouch = 'ontouchstart' in window;

        window.initEvent && window.initEvent();

        $('body').on(hasTouch ? 'click' : 'mousedown', function (e) {
            //统计初始化.
            pageDace.init(e);
        });
    });

})(window);
