var _ = require("app:static/js/underscore/underscore.js");
var refresh = require("app:widget/ui-refresh/ui-refresh.js");
var tapLink = require("app:widget/tap-link/tap-link.js");
/**
 * 接口地址
 */
var apiUrl = {
    recommend: '/m/video/recommend'      //推荐视频
};

var videoList = {
	init: function() {
		this.bind();
	  this.getList();
		this.video_list = $(".J_video_list");
		this.videoTpl =  _.template($("#J-video-tpl").html());
		this.page = 0;
		tapLink.init(this.video_list);
	},
	bind: function() {
		//this.initScroll();
	},
	getList: function() {
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
	initScroll: function() {
		var self = this;
		refresher = refresh({
			contentEl: '.J_video_list',
			isRefresh: false,
			isLoadingMore: true,
			loadingMoreCallback: function(callback) {
				self.getList();
				$(".preloader-loading-more").hide();
			}
		});
	}
}
module.exports = videoList;