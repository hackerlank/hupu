var _ = require("app:static/js/underscore/underscore.js");
var Toast = require("app:widget/ui-toast/ui-toast.js");

var targetVideo = {

  init: function(){
      this.bind();
  },
  bind:function() {
    var self = this;
    
    //$(".rating-stars").show(); //已评分时显示星星遮罩
    this.star();
  		//tab切换
  		$(".tab").find("a").on("click", function(){
          $(this).addClass("active").siblings().removeClass("active");
          $(".t-content").eq($(this).index()).show().siblings(".t-content").hide();
      });
      //评分确认
      $(".star_btn").on("click", function() {
        Toast.confirm({"content":"球员评价需要消耗人品值,每评价1次，消耗10个人品值，是否确认评价？","gray":"下次不再显示该提示","submitText":"立即评价"});
      })
      //点赞
      $(".zan").click(function() {
        var that = $(this)
        Toast.confirm({"content":"球员评价需要消耗人品值,每评价1次，消耗10个人品值，是否确认评价？","gray":"下次不再显示该提示",submitHandler:function() {
            options = {
              obj: that,     //要在那个html标签上显示
              str: "+1",       //动画显示内容
              startSize: "12px", //动画开始的文字大小
              endSize: "30px",  //动画结束的文字大小
              interval: 600, //动画时间间隔
              color: "#ff4252",  //文字颜色
            }
            self.tipsBox(options,function(){
              console.log("zan")
            })
        }});
        
      })
      //踩
      $(".bian").on("click",function() {
        options = {
            obj: $(this),
            str: "-1",
            startSize: "12px", //动画开始的文字大小
            endSize: "30px",  //动画结束的文字大小
            interval: 600, //动画时间间隔
            color: "#8dcf5e",  //文字颜色
          }
          self.tipsBox(options,function(){
            console.log("bain")
          })
      })
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


targetVideo.init();
