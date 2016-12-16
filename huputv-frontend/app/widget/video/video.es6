const _ = require("app:static/js/underscore/underscore.js");
const toast = require("app:widget/ui-toast/ui-toast.js");
const PageEvent = require("app:widget/page-dace/page-dace.es6");
const gift = require("app:widget/gift_rank/gift_rank.js");

const videoController = {
  init() {
      this.videoContainer = $("#J-videocontainer");
      this.video = null;
      this.ctrlContainer = $("#J-ctrl-container");
      this.refreshBtn = this.ctrlContainer.find("#J-refresh");
      this.muteBtn = this.ctrlContainer.find("#J-mute");
      this.fullscreenBtn = this.ctrlContainer.find("#J-fullscreen");
      this.videoMuted = false;
      this.timer = null;
      this.reloadCount = 0;
      this.evnetSource = {
        source: 'mobileLive'
      };
      //如果正在直播，初始化播放器
      if(GM.is_live || HTV.targetVideo){
        this.initVideo();
        this.bindEvent();
      }
      this.autoLayout();
    },
    initVideo() {
      var self = this;
      this.video = videojs("html5player-video").ready(function(){
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


      this.reSize();
      $(window).on('resize', this.reSize.bind(this));
    },
    bindEvent() {
      this.refreshBtn.on("click", () => {
        if(this.video){
          this.video.load();
        } else{
          location.reload(true);
        }
      });

      // ios静音功能不生效，暂时去掉
      // this.muteBtn.on("click", () => {
      //   this.toggleMute();
      // });

      this.fullscreenBtn.on("click", ()=>{
        this.video.requestFullscreen();
      });

    },
    //计算layout main的高度，实现内滚动
    autoLayout(){
      var iHeight = $(window).height();

      $(".layout-main").css({
          "height": iHeight - $(".layout-video").height() - $(".layout-tab").height(),"top": $(".layout-video").height() + $(".layout-tab").height()
      });
      $(".tab").find("a").on("click", function(){
          $(this).addClass("active").siblings().removeClass("active");
          $(".t-content").eq($(this).index()).show().siblings(".t-content").hide();

          if($(this).index() == 2){
              gift.getGift();
          }

          if($(this).index() == 0){
            $(".send-info").show();
          }else{
            $(".send-info").hide();
          }
      });
    },
    reSize(){
      var width = this.videoContainer.width();
      var height = width / 1.778;
      this.videoContainer.css("height", height);
      $(".video-js").css({"height": height, width: width});
    },
    toggleMute() {
      if (!this.video) return;

      if(!this.videoMuted){
        this.videoMuted = true;
        this.video.muted(true);
        this.muteBtn.html('<i class="icon icon-volume-none"></i>取消静音');
      } else{
        this.videoMuted = false;
        this.video.muted(false);
        this.muteBtn.html('<i class="icon icon-volume"></i>静音');
      }
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
            PageEvent.sendBaiduPlayEvent(time, self.evnetSource);
        }, 60 * 1000);
    }
}

export default videoController
