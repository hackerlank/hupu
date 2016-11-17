  var _ = require('common:static/js/underscore/underscore.js');
  var Dialog = require('common:widget/dialog/dialog');

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
        if(!this.hayFlash()){
          $('#J_zeroClipboard').hide();

          // video
          $('#live-video').hide();
          $('#J_liveVideoRest').show();
          $('#J_liveVideoRest .video-mark').html('您还没有安装flash播放器，请点击<a href="https://get.adobe.com/cn/flashplayer/?fpchrome" target="_blank">这里</a>安装');
        }

        this.bind();
      },
      bind: function() {
        var that = this,
            timer = null;

        $(window).on('resize', function() {
            timer = setTimeout(function() {
                that.resize();
            }, 300);
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
       /**
       * 调试日志
       */
      trace: function(content) {
        if(/debug/i.test(location.search)){
              console.log(content);
        }
      },
      /**
       * flash 交互
       * @param movieName
       * @returns {*}
       */
      getFlashMovie: function(movieName) {
          var isIE = navigator.appName.indexOf("Microsoft") != -1;
          return (isIE) ? window[movieName] : document[movieName];
      },
      hayFlash: function() {
          var flash;

          try{
              flash = new ActiveXObject('ShockwaveFlash.ShockwaveFlash');
          }catch(e){
              flash = navigator.plugins['Shockwave Flash'];
          }
          return flash;
      },
      /**
       * 视频flash交互
       */
      videoFlashMovie: function() {
          return this.getFlashMovie("live-video_Flash_api");
      },
      /**
       * 和flash交互
       */
      callFromJS: function(msg){
        try{
          this.videoFlashMovie().callFromJS(msg);
        } catch(e){
          console && console.log(e.message);
        }
      },
      /**
       * web视频全屏
       */
      fullScreenVideo: function() {
          if(!isfullScreenStatus){
              isfullScreenStatus = true;
              VideoPlay.resize();
          }else{
              isfullScreenStatus = false;
              SetVideoSize();
          }

          $('html,body').toggleClass('ui-full-screen');
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
