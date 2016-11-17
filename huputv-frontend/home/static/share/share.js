/**
 * 分享
 */
!function(){
    "use strict";

    var PageEvent = require("common:widget/page-dace/page-dace.es6");

    var Share = {
        init: function() {
            var that = this;

            this.$video = $('#live-video');

            if(!this.$video.length){
                return;
            }

            // 重新连接数
            this.reloadCount = 0;
            this.timer = null;
            this.evnetSource = {source: 'Share'};

            this.bind();
        },
        bind: function() {
            var self = this;

            videojs("live-video").ready(function(){
                var VideoPlayer = this;

                VideoPlayer.on('error', function(e) {

                    if(this.error().code === 4 && self.reloadCount <= 10 ) {
                        self.reloadCount++;

                        PageEvent.sendBaiduPlayEvent('卡顿', self.evnetSource);
                        VideoPlayer.load();
                    }else{
                        PageEvent.sendBaiduPlayEvent('错误' + this.error().code, self.evnetSource);
                    }
                });

                // 监听播放
                VideoPlayer.on('play', function(e) {
                    self.loopSendPlayTime(1);
                });
            });
        },
        /**
         * 循环播放时长
         */
        loopSendPlayTime: function(time) {
            var self = this;

            this.timer && clearInterval(this.timer);

            this.timer = setInterval(function() {
                // 发送播放时长
                PageEvent.sendDacePlayTime(time);
                self.evnetSource.type = 1;
                PageEvent.sendBaiduPlayEvent((time), self.evnetSource);
            }, 60 * 1000);
        }
    }

    $(function(){
        Share.init();
    })
}();