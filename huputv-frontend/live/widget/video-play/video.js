  var _ = require('common:static/js/underscore/underscore.js');
  var Dialog = require('common:widget/dialog/dialog');
  var Flash = require('common:widget/flash-movie/flash');
  var Gift = require('live:widget/send-gift/gift');
  var PageEvent = require("common:widget/page-dace/page-dace.es6");

  var isfullScreenStatus = 0,
      $video = $('#live-video'),
      VideoPlayer;

  // 视频
  if($video.length){
    try {
      VideoPlayer = videojs('live-video');
    } catch (e) {}
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
        if(!Flash.hayFlash()){
          $('#J_zeroClipboard').hide();

          // video
          $('#live-video').hide();
          $('#J_liveVideoRest')
            .show()
            .html('<div class="video-mark">您还没有安装flash播放器，请点击<a href="https://get.adobe.com/cn/flashplayer/?fpchrome" target="_blank">这里</a>安装</div>');
        }

        this.recomRoom();
        this.flashBind();
        this.bind();
      },
      bind: function() {
        var self = this,
            timer = null;

        $(window).on('resize', function() {
            timer = setTimeout(function() {
                self.resize();
            }, 300);
        });

        $(document).on('wall', function(e, data) {
          self.wall(data);
        })
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
         * 网页全屏
         */
        Flash.register('fullScreenVideo', function() {
          self.fullScreenVideo();
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

        switch(data.et){
          // 热线
          case 2000:
            var params = {
              msg: data.cnt
            }

            Flash.send('chat', params);
            break;
          // 礼物
          case 2001:
            var params = {
                msg: data.un + data.cnt
              },
              notShieldGift = !$('.J_shieldCheckbox').is(":checked");

            if(notShieldGift) {
              var detail = Gift.getGiftDetail(data.giftid, data.lt);

              Flash.send('chat', params);

              // 礼物类型 1金豆 6虎扑币
              if(+detail.money_type === 6 && detail.position) {
                data.giftDetail = detail;

                var giftData = this.getGiftData(data);

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
                 Flash.send('gift', giftData);
              }
            }
            break;
          // 参与预测
          case 2002:
            var params = {
              msg: data.un + data.cnt
            }

            Flash.send('chat', params);
            break;
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
       * web视频全屏
       */
      fullScreenVideo: function() {
          if(!isfullScreenStatus){
              isfullScreenStatus = true;
              VideoPlay.resize();
          }else{
              isfullScreenStatus = false;
              VideoPlay.setVideoSize();
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
      },
      /**
       * 设置视频尺寸
       */
      setVideoSize: function() {
        if($(window).width() <= 650){
          return;
        }

        var mainWidth = $('.live-main').width(),
            mainHeight = mainWidth / 1.77;

        $('.live-play, #live-video').css({
            width: mainWidth,
            height: mainHeight
        });
      }
    };

    module.exports = VideoPlay;
