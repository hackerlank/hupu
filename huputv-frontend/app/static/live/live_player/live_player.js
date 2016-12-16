
!function(){
   "use strict";

  var _ = require("app:static/js/underscore/underscore.js");
  var Toast = require("app:widget/ui-toast/ui-toast.js");
  var refresh = require("app:widget/ui-refresh/ui-refresh.js");
  var tapLink = require("app:widget/tap-link/tap-link.js");
  var common = require("app:widget/ui-common/ui-common.js");
/**
 * 接口地址
 */
  var apiUrl = {
        //推荐视频
      statistics: '/m/passerbyking/game/player/list/',      //球员统计
      zanCai: '/m/passerbyking/player/rating',     //球员评价 赞、踩     
  };
  var targetVideo = {

    init: function(){
        this.getStatisticsList();       
        this.$lrwPlayerWrap = $("#J_lrwPlayerWrap");
        this.$lrwPlayer = _.template($("#J_lrwStatisticsTpl").html());      //点播页球员模板
        this.bind();
        this.page = 0;        
        this.peopleScore = HTV.peopleScore;       
    },
    bind:function() {
        var self = this;
      //点赞
        $(".statistics").on("click",".zan",function() {          
          if(!HTV.isLogin){
            common.schemeLogin();
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
        self.zanCai("2",that.attr("data-id"))
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
  };
  $(function(){
    targetVideo.init();
  })
}()
