  var _ = require('common:static/js/underscore/underscore.js');
  var Dialog = require('common:widget/dialog/dialog');
  var Flash = require('common:widget/flash-movie/flash');
  var PageEvent = require("common:widget/page-dace/page-dace.es6");

  var isfullScreenStatus = 0,
      $video = $('#live-video'),
      VideoPlayer;

  // 视频
  if($video.length){
      VideoPlayer = videojs('live-video');
  }

    /**
     * 视频
     */
    var VideoPlay = {
      init: function(callback) {
        var that = this;

        this.$rest = $('#J_liveVideoRest');

        // 判断是否安装flash
        if(!Flash.hayFlash()){
          // video
          $('#live-video').hide();
          $('#J_liveVideoRest').show();
          $('#J_liveVideoRest .video-mark').html('您还没有安装flash播放器，请点击<a href="https://get.adobe.com/cn/flashplayer/?fpchrome" target="_blank">这里</a>安装');
        }

        this.bind();
        this.flashBind();
      },
      bind: function() {
        var that = this,
            timer = null;

        $(window).on('resize', function() {
            timer = setTimeout(function() {
                that.resize();
            }, 300);
        });

        if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/7./i)=="7.") {
            $(".J-list a").on("click", function(){
                window.location.href = $(this).attr("href");
            });
        }

        $("#J-video-silde").find("li").on("click", function(){
            $(this).addClass("active").siblings().removeClass("active");
            $(this).parents(".main-wrap").find(".btn-enter").attr("href", $(this).attr("data-url"));

            Flash.send('playStream', {
                url:  $(this).attr("data-rtmp")
            });
        });
      },
      /**
       * flash调用事件
       * @return {[type]} [description]
       */
      flashBind: function() {
        var self = this;

        /**
         * 网页全屏
         */
        Flash.register('trace', function(str) {
          Flash.debug(str);
        });

        /**
         * 发送百度自定义事件
         * @param {array} arr 自定内容
         */
        Flash.register('sendBaiduEvent', function(arr) {
          PageEvent.sendBaiduEvent(arr);
        });

        /**
         * 发送百度播放自定义事件
         * @param {array} arr 自定内容
         */
        Flash.register('sendBaiduPlayEvent', function(value, opt) {
          return PageEvent.sendBaiduPlayEvent(value, opt);
        });

        /**
         * 发送播放时长
         * @param {string} str dace的数据
         */
        Flash.register('sendDacePlayTime', function(str) {
          return PageEvent.sendDacePlayTime(str);
        });
      },
      wall: function(data) {
        // 过滤空内容
        if (typeof data.result.data === 'undefined') {
            return ;
        }

        if (data.result.data.length !== 1){
            return ;
        }

        // 房间切换结束状态
        if(typeof data.result.data[0].event_type !== 'undefined') {
          switch(data.result.data[0].event_type){
            // 停止直播
            case 2004:
              if($video.length) {
                VideoPlayer.reset();
                VideoPlayer.hide();
              }

              this.$rest.show();
              break;
            // 主播开播
            case 2003:
              Dialog({
                content: '主播已经开播啦，是否立即观看？',
                confirm: {
                  text: '立即观看',
                  callback: function() {
                    window.location.reload();
                  }
                }
              });
              break;
            default:
          }
        }
      },
      resize: function() {
          // 是否播放器播放器窗口全屏
          if(!isfullScreenStatus){
            this.setRestImg();
            return;
          }

          var viewWidth = $(window).width(),
              viewHeight = $(window).height();


          $('#live-video').css({
              width: viewWidth,
              height: viewHeight
          });
      },
      /**
       * 设置休息图片
       */
      setRestImg: function() {
        var $pic = this.$rest.find('.live-announce-list .pic');

        if(!$pic.length){
          return;
        }

        var $recom = this.$rest.find('.live-play-recommend'),
          height = $recom.width() / 2 * (9 / 16);

        $pic.css({
          height: height
      });
      }
    };

    module.exports = VideoPlay;
