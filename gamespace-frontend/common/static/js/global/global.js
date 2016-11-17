/**
 * @file 整站都会引用的js，整站js的入口文件
 * @author yuhongfei@hupu.com
 **/
(function (win) {
    var pageDace = require("common:widget/ui-dace/ui-dace.js");

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
        window.initEvent && window.initEvent();
        pageDace.init();
    });

})(window);
