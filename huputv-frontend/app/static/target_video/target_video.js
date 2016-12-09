var _ = require("app:static/js/underscore/underscore.js");
var Toast = require("app:widget/ui-toast/ui-toast.js");
var refresh = require("app:widget/ui-refresh/ui-refresh.js");
var tapLink = require("app:widget/tap-link/tap-link.js");
/**
 * 接口地址
 */
var apiUrl = {
    recommend: '/m/video/recommend',      //推荐视频
    statistics: '/m/passerbyking/game/player',      //球员统计
    zanCai: '/m/passerbyking/player/rating',     //球员评价 赞、踩
    video_score: '/m/video/score',            //视频评分
    discuss: '/m/passerbyking/bbs/'+HTV.tid           //赛后讨论
};
var targetVideo = {

  init: function(){
      this.bind();
      this.getVideoList();
      this.videoGetScore(HTV.score);
      this.video_list = $(".J_video_list");                   
      this.videoTpl =  _.template($("#J-video-tpl").html());  //推荐视频
      this.$lrwPlayerWrap = $("#J_lrwPlayerWrap");
      this.$lrwPlayer = _.template($("#J_lrwStatisticsTpl").html());      //点播页球员模板

      this.discussContent = $(".J_discuss");                   
      this.discussTpl =  _.template($("#J-discuss-tpl").html());    //赛后讨论
      this.page = 0;
      this.videoScore;
      this.peopleScore = HTV.peopleScore;
      tapLink.init(this.video_list);
  },
  bind:function() {
    var self = this;
  		//tab切换
  		$(".tab").find("a").on("click", function(){
        var index = $(this).index();
        $(this).addClass("active").siblings().removeClass("active");
        $(".t-content").eq(index).show().siblings(".t-content").hide();

        switch(index){
          case 1:
            self.getStatisticsList();
            break; 
          case 2:
            self.getDiscussList();
            self.topScroll();
            break; 
        }
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
              $(".star_confirm span").removeClass("star_btn");
              $(".star_confirm span").text("已评分");
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
      $(".statistics").on("click",".zan",function() {
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
          Toast.confirm({"content":"球员评价需要消耗人品值,每评价1次，消耗10个人品值，是否确认评价？","gray":"下次不再显示该提示",submitHandler:function() {
            self.zanCai("1",that.attr("data-id"),function(data) {
              that.find("small").text(parseInt(that.find("small").text())+1);
              self.peopleScore = data.data.score;
            })
            self.tipsBox(options);
          }});
          localStorage.setItem('once', '1');
        }else{
          self.zanCai("1",that.attr("data-id"),function(data) {
            that.find("small").text(parseInt(that.find("small").text())+1);
            self.peopleScore = data.data.score;
          })
            self.tipsBox(options);
        }
      })
      //踩
      $(".statistics").on("click",".bian",function() {
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
            Toast.confirm({"content":"球员评价需要消耗人品值,每评价1次，消耗10个人品值，是否确认评价？","gray":"下次不再显示该提示",submitHandler:function() {
              self.zanCai("2",that.attr("data-id"),function(data) {
                that.find("small").text(parseInt(that.find("small").text())-1);
                self.peopleScore = data.data.score;
              })
              self.tipsBox(options);
            }});
            localStorage.setItem('once', '1');
          }else{
            self.zanCai("2",that.attr("data-id"),function(data) {
              that.find("small").text(parseInt(that.find("small").text())-1);
              self.peopleScore = data.data.score;
            })
              self.tipsBox(options);
          }
      })
  },
  //推荐视频
  getVideoList: function() {
    var self = this;
    $.ajax({
      url: apiUrl.recommend,
      type: "GET",
      dataType: "json",
      success: function(data){
        if(data.code == 1) {
          self.video_list.append(self.videoTpl({datas: data.data.list}) );

          if(data.data.pages > self.page ) {
            self.page++;
            self.initScroll();
          }else{
            self.video_list.append("<li class='no_more'>没有更多了</li>")
          }
          
        }
      }
    });
  },
  //球员统计
  getStatisticsList: function() {
    var self = this;
    $.ajax({
      url: apiUrl.statistics,
      type: "GET",
      dataType: "json",
      success: function(data){
        if(data.code == 1) {
          self.$lrwPlayerWrap.append(self.$lrwPlayer({datas: data.data.list,player:"statistics"}) );
          
        }
      }
    });
  },
  //赛后讨论
  getDiscussList: function(complete) {
    var self = this;
    $.ajax({
      url: apiUrl.discuss,
      type: "GET",
      dataType: "json",
      success: function(data){
          self.discussContent.empty().append(self.discussTpl({
            thread_info: data.data.thread_info,
            light_reply: data.data.light_reply
          }) );
          complete && complete();
      }
    });
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
  //下拉刷新
  initScroll: function() {
    var self = this;
    refresher = refresh({
      contentEl: '.J_video_list',
      isRefresh: false,
      isLoadingMore: true,
      loadingMoreCallback: function(callback) {
        self.getVideoList();
        $(".preloader-loading-more").hide();
      }
    });
  },
  //上拉刷新
  topScroll: function() {
    var self = this;
    refresher = refresh({
      contentEl: '.J_discuss',
      isRefresh: true,
      isLoadingMore: false,
      refreshCallback: function(complete) {
        self.getDiscussList(complete);
      }
    });
  },
  //星星打分
  star:function() {
    var self = this;
    var starLen = $(".star_num").find("li");
    $(starLen).each(function(index,item) {
      var item = $(item);
      item.on("click",function() {
        self.videoScore = (index+1)*2;
        $(".star_num li").removeClass("on");
        for(var i=0;i<=index;i++) {
          starLen.eq(i).addClass("on");
        }
      })
    })
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
//module.exports = targetVideo;
targetVideo.init();
