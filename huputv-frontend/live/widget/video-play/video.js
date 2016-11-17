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
   * 接口地址
   */
  var apiUrl = {
    // 推荐房间
    recomRoom: '/room/random'
  };

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



        this.recomRoom();
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
        if(_.isUndefined(data.et)) return;

        // 房间切换结束状态
        switch(data.et){
          // 主播关闭直播
          case 3003:
            if($video.length) {
              VideoPlayer.reset();
              VideoPlayer.hide();
            }

            this.$rest.show();
            this.recomRoom();
            break;
          // 主播开播
          case 3002:
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
      },
      /**
       * 推荐直播
       */
      recomRoom: function() {
        var self = this;

        var params = {
          room_id: HTV.roomID,
          limit: 4
        }

        var listTpl = $('#play-recommend-tpl').html();

        this.$rest.find('.live-play-recommend').show();

        $.ajax({
            url: apiUrl.recomRoom,
            type: "GET",
            data: params,
            dataType: 'json',
            success: function(data) {
              if(data.code === 1){
                var template = _.template( listTpl )({
                  datas: data.data
                });

                self.$rest.find('.recommend-bd').html(template);
                self.setRestImg();
              }
            }
        })
      },
      /**
       * 推送礼物信息
       * @param  {[type]} data [description]
       * @return {[type]}      [description]
       */
      pushGift: function(data) {
        var giftData = this.getGiftData(data);

        // 礼物类型 1金豆 6虎扑币
        if(giftData.money_type == 1){
            return;
        }

        if(giftData.position ){
            try {
                /**
                 * 送礼物
                 * @param  {object} data                   礼物信息
                 * @config {string} cover_url              封面
                 * @config {string} effect_file_flash_url  动画flash
                 * @config {string} effect_file_gif_url    GIF素材
                 * @config {string} effect_file_icon_url   icon
                 * @config {number} id                     礼物ID
                 * @config {number} money_type             礼物类型 {1金豆 6虎扑币}
                 * @config {string} name                   礼物名字
                 * @config {number} number                 这次送礼物数量
                 * @config {number} total                  送礼物总数
                 * @config {number} position               送礼位置 ｛1右上角从右至左展出 2人浪 增加屏幕特效-屏幕下方由下至上展出｝
                 * @config {string} username               礼物名字
                 */
                VideoPlay.videoFlashMovie().vjs_rcvGift(giftData);
            } catch(err) {
            }
        }
      },
      /**
       * 获取礼物数据
       * @param data
       */
      getGiftData: function(data) {
        var arr = {
          username: data.un,
          id: data.giftid,
          number: data.giftn,
          total: data.tn,
        }

        if (typeof data.giftDetail !== 'undefined') {
          var detail = data.giftDetail;

          arr.cover = detail.cover;
          arr.effect_file_flash_url = detail.effect_file_flash_url;
          arr.effect_file_gif_url = detail.effect_file_gif_url;
          arr.effect_file_icon_url = detail.effect_file_icon_url;
          // 1金豆 6虎扑币
          arr.money_type = detail.money_type;
          arr.name = detail.name;
          arr.position = detail.position;
        }

          return arr;
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
              flash = new ActiveXObject('ShockwaveFlash.ShockwaveFlash')
          }catch(e){
              flash = navigator.plugins['Shockwave Flash']
          }
          return flash
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
          this.videoFlashMovie().callFromJS(msg)
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
        })
      }
    };

    module.exports = VideoPlay;
