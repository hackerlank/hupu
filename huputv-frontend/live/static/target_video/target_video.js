"use strict";

var _ = require("common:static/js/underscore/underscore.js");
var Toast = require("common:widget/toast/toast.js");
var Share = require("common:widget/share/share.js");
var QRCode = require("common:widget/share/qrcode/qrcode.js");
var User = require("common:widget/login/login.js");
var tapLink = require("common:widget/tap-link/tap-link.js");

/**
 * 接口地址
 */
var apiUrl = {
    zanCai: '/passerbyking/player/rating',     //球员评价 赞、踩
    video_score: '/video/score',            //视频评分
    target_bbs: '/passerbyking/bbs/13096693'    //点播赛后讨论
};

var LiveContent = {
    init: function() {
        var that = this;
        this.targetSidebar = $(".target-sidebar")
        this.discussContent = $(".J_discuss");                   
        this.discussTpl =  _.template($("#J-discuss-tpl").html());

        this.bind();
        this.shareBind();
        this.targetBbs();
        this.videoGetScore(HTV.score);
        tapLink.init(this.targetSidebar);
    },
    bind: function() {
        var self = this;
        //十分钟调用一次亮回帖内容
        setTimeout(function() {
            $(".addReply").show();
        },600000);
        $(".addReply").on("click",function() {
            self.targetBbs();
            $(".addReply").hide();
        });
        //星星视频评分确认
      $(".star_btn").on("click", function() {
        if(!HTV.isLogin){
            HTV.jumpLogin();
        }
        var ajaxScore = function() {
          $.ajax({
            url: apiUrl.video_score,
            type: "POST",
            dataType: "json",
            data:{
              "vid":HTV.vid,
              "score":self.videoScore
            },
            success: function(data){
              $(".star span").removeClass("star_btn");
              $(".star span").text("已评分");
              self.videoGetScore(data.data.score,1)
              localStorage.setItem('videoScore', '1');
            }
          });
        }
        if(!localStorage.videoScore) {
          Toast.confirm({"content":"球员评价需要消耗人品值,每评价1次，消耗10个人品值，是否确认评价？","gray":"下次不再显示该提示","submitText":"立即评价",submitHandler:function() {
              ajaxScore();
          }});
        }else{
          ajaxScore();
        }
      })
        //点赞
        $(".player-card-info").on("click",".button-zan",function() {
            if(!HTV.isLogin){
                HTV.jumpLogin();
                return;
            }
            var that = $(this);
            var options = {
                  obj: that,     //要在那个html标签上显示
                  str: "+1",       //动画显示内容
                  startSize: "12px", //动画开始的文字大小
                  endSize: "30px",  //动画结束的文字大小
                  interval: 600, //动画时间间隔
                  color: "#ff4252",  //文字颜色
                }
              //判断人品值是否足够
              if(self.peopleScore < 10) {
                Toast.confirm({"content":"人品值不足，赶紧参与”攒人品“答题赚取人品值吧！","submitText":"我的人品值","cancelText":"我知道了",submitHandler:function() {
                    window.location.href = "/m/predict/my/list";
                  }
                })
                return false;
              }
            if(!localStorage.once){
               //Toast.confirm({"content":"球员评价需要消耗人品值,每评价1次，消耗10个人品值，是否确认评价？","gray":"下次不再显示该提示",submitHandler:function() {
                self.zanCai("1",that.attr("data-id"),function(data) {
                  that.find("span").text(data.data.top);
                  self.peopleScore = data.data.score;
                })
                self.tipsBox(options);
              //}});
              localStorage.setItem('once', '1');
            }else{
              self.zanCai("1",that.attr("data-id"),function(data) {
                that.find("span").text(data.data.top);
                self.peopleScore = data.data.score;
              })
                self.tipsBox(options);
            }
        });
        //踩
        $(".player-card-info").on("click",".cai",function() {
            if(!HTV.isLogin){
                HTV.jumpLogin();
                return;
            }
            var that = $(this);
            var options = {
                obj: that,
                str: "-1",
                startSize: "12px", //动画开始的文字大小
                endSize: "30px",  //动画结束的文字大小
                interval: 600, //动画时间间隔
                color: "#8dcf5e",  //文字颜色
            }
            //判断人品值是否足够
            if(self.peopleScore < 10) {
                Toast.confirm({"content":"人品值不足，赶紧参与”攒人品“答题赚取人品值吧！","submitText":"我的人品值","cancelText":"我知道了",submitHandler:function() {
                    window.location.href = "/m/predict/my/list";
                  }
                })
                return false;
            }
            if(!localStorage.once){
            //Toast.confirm({"content":"球员评价需要消耗人品值,每评价1次，消耗10个人品值，是否确认评价？","gray":"下次不再显示该提示",submitHandler:function() {
              self.zanCai("2",that.attr("data-id"),function(data) {
                that.find("span").text(data.data.step);
                self.peopleScore = data.data.score;
              })
              self.tipsBox(options);
            //}});
            localStorage.setItem('once', '1');
            }else{
            self.zanCai("2",that.attr("data-id"),function(data) {
              that.find("span").text(data.data.step);
              self.peopleScore = data.data.score;
            })
              self.tipsBox(options);
            }
        })
        //视频播放开关
        $(".toggle i").on("click",function() {
            if($(this).hasClass("close")) {
                $(this).removeClass("close");
            }else{
                $(this).addClass("close");
            } 
        })
    },
    //点播赛前讨论
    targetBbs:function() {
        var self = this;
        $.ajax({
            url: apiUrl.target_bbs,
            type: "POST",
            dataType: 'json',
            success: function(data) {
                self.discussContent.empty().append(self.discussTpl({
                    thread_info: data.data.thread_info,
                    light_reply: data.data.light_reply
                }) );
            }
        });
    },
    /**
     * 分享
     */
    shareBind: function() {
        var self = this;

        if(document.getElementById("J_zeroClipboard")){
            var client = new ZeroClipboard(document.getElementById("J_zeroClipboard"),{
                moviePath: "http://b3.hoopchina.com.cn/code/zeroClipboard/1.3.5/ZeroClipboard.swf"
            });

            client.on("load", function(client) {
                client.setText(window.location.href);

                client.on( "complete", function(client, args) {
                    self.copyTips();
                } );
            });
        }
        var $share = $('#J_uiTopShare'),
            $tips = $share.find('.J_shareTips');

        $('#global-zeroclipboard-html-bridge').hover(
            function() {
                clearTimeout(self.shareTimer);
                $tips.show();
            },
            function() {
            }
        );

        var $shareTips = $('#J_shareWeixinTips');

        // 生成weixin二维码
        var qrcode = new QRCode("J_shareQrcode", {
            text: HTV.shareUrl,
            width: 98,
            height: 98
        });

        var type = '',
            shareData = HTV.shareData;
        shareData.tempTitle = shareData.title;
        $share.find('.icons').on('click', function(){
            type = $(this).data('type');

            if(type == 'qq'){
                shareData.title = document.title;
                shareData.summary = shareData.qqSubTitle;
            }else{
                shareData.title = shareData.tempTitle;
                shareData.summary = '';
            }

            new Share(type, shareData);
        })
    },
    shareShow: function($tips) {
        clearTimeout(this.shareTimer);
        $tips.show();
    },
    shareHide: function($tips) {
        var that = this;

        this.shareTimer = setTimeout(function() {
            $tips.hide();
        }, 500);
    },
    //星星打分
    star:function() {
        var starLen = $(".star_num").find("li");
        $(starLen).each(function(index,item) {
          var item = $(item);
          item.on("click",function() {
            $(".star_num li").removeClass("on");
            for(var i=0;i<=index;i++) {
              starLen.eq(i).addClass("on");
            }
          })
        })
    },
      /*
    *score为视频评分分数 
    *success 判断是否为打分成功后调用
   */
    videoGetScore:function(score,success) {
    var rateStar = $(".rating-stars");
    //判断为已评分还是未评
        if( HTV.is_rated || success) {
          rateStar.show(); //已评分时显示星星遮罩
          $(".star_num li").removeClass("on");

          var score = (score / 2).toFixed(1);
          if(0.5<=score && score<1) {
            rateStar.css("width","8px");
          }
          else if(1<=score && score<1.5) {
            rateStar.css("width","15px");
          }
          else if(1.5<=score && score<2) {
            rateStar.css("width","21px");
          }
          else if(2<=score && score<2.5) {
            rateStar.css("width","42px");
          }
          else if(2.5<=score && score<3) {
            rateStar.css("width","49px");
          }

          else if(3<=score && score<3.5) {
            rateStar.css("width","57px");
          }
          else if(3.5<=score && score<4) {
            rateStar.css("width","70px");
          }
          else if(4<=score && score<4.5) {
            rateStar.css("width","77px");
          }
          else if(4.5<=score && score<5) {
            rateStar.css("width","91px");
          }
          else if(score == 5) {
            rateStar.css("width","99px");
          }
        }else{
          this.star();
        }
    },
    //点赞和踩 
    zanCai:function(type,player_id,callback) {
        $.ajax({
          url: apiUrl.zanCai,
          type: "POST",
          dataType: "json",
          data:{
            "game_id":HTV.game_id,
            "player_id":player_id,
            "type":type
          },
          success: function(data){
            callback && callback(data)
          }
        });  
    },
    //点赞 踩
    tipsBox: function (options,callback) {
        $("body").append("<span class='num'>" + options.str + "</span>");
        var box = $(".num");
        var left = options.obj.offset().left + options.obj.width() / 2;
        var top = options.obj.offset().top - options.obj.height();
        box.css({
            "position": "absolute",
            "left": left + "px",
            "top": top + "px",
            "z-index": 9999,
            "font-size": options.startSize,
            "line-height": options.endSize,
            "color": options.color
        });
        box.animate({
            "font-size": options.endSize,
            "opacity": "0",
            "top": top - parseInt(options.endSize) + "px"
        }, options.interval, function () {
            box.remove();
            callback && callback();
        });
    }
}

LiveContent.init();

