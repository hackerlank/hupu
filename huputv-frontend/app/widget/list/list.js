var _ = require("app:static/js/underscore/underscore");
var common = require("app:widget/ui-common/ui-common.js");
var _escape = _.escape;

var defaultImg = {
	day: '//b3.hoopchina.com.cn/wl/nativeapp/games/zhubo/images/frontCover_img.jpg',
	night: '//b3.hoopchina.com.cn/wl/nativeapp/games/zhubo/images/frontCover_img.jpg'
}

var Page = {
	update: function(hasZhubo) {
		this.tplRender = _.template($("#J-page-tpl").html());
		this.container = $("#J-zhubo-container");
	  this.render();
	},
	render: function() {
		var self = this;
		$.ajax({
			url: "/m/follow/getFollowing",
			type: "GET",
			dataType: "json",
			data: {
				t: (new Date().getTime()),
				json: 1
			},
			success: function(res) {
				var html = self.tplRender({
					is_login: GM.islogin,
					is_follow: res.data.is_follow,
					data: res.data.followRoomList,
					withRoomUrl: common.withRoomUrl
				});
				self.container.html(html);
			}
		})
	},
	initLoadCover: function(){
		 var imgs = $("#J-page-liveroom img");
		 var self = this;
		 imgs.each(function(idx, img){
			 	self.lazyLoad(img);
		 });
	},
	getDefaultImg: function(){
		return GM.night ? defaultImg.night : defaultImg.day;
	},
	lazyLoad: function(img){
		var realSrc = img.getAttribute('data-src');
		var self = this;

		if(realSrc){
			img.onerror = function(){
				img.onerror = img.onload = null;
				img.src = self.getDefaultImg();
			}
			img.src = realSrc;
			img.removeAttribute('data-src');
		}
	}
};

module.exports = Page;
