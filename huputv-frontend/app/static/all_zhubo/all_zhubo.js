/**
 * 全站主播
 */
!function(){
    "use strict";

    var refresh = require("app:widget/ui-refresh/ui-refresh.js");

    var timer = null;

    /**
     * 接口地址
     */
    var apiUrl = {
        // 关注
        follow: '/user/follow-ajax'
    };

    var AllZhubo = {
        init: function() {
            var self = this;

            this.$wrap = $('#J-zhubo-list');

            if(!this.$wrap.length){
                return;
            }


            this.bind();
        },
        bind: function() {
            var self = this;

            refresh({
                contentEl: '#J-zhubo-list',
                isRefresh: true,
                isLoadingMore: false,
                refreshCallback: function(complete) {
                     setTimeout(function() {
                         complete();
                         location.reload();
                     }, 1000);
                }
            });
        },
        /**
         * 关注
         */
        sendFollow: function(type) {
            
        }
    }

    $(function(){
        AllZhubo.init();
    })
}();
