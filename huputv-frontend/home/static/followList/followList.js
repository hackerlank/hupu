(function(){
	var dace = require("common:widget/page-dace/page-dace.es6");

	var myFollow = {
		init: function(){
			this.render();
			this.bind();
		},

		render: function(){
			this.listContainer = $("#J-list");
		},

		bind: function(){
			var self = this;

			self.listContainer.find(".btn").on("click", function(){
				var btnself = $(this);
				var pageId = __dacePageName;

				if($(this).attr("data-type") == "unfollow"){
					self.unfollow($(this).attr("data-id"), $(this).attr("data-type"), function(){
						btnself.attr("data-type", "follow");
						btnself.html("关注");
						dace.send(pageId + "_unfollowClick");
					});
				}else{
					self.follow($(this).attr("data-id"), $(this).attr("data-type"), function(){
						btnself.attr("data-type", "unfollow");
						btnself.html("取消关注");
					});
				}
			});
		},

		follow: function(id, type, callback){
			$.ajax({
				url: "/user/follow-ajax",
				type: "POST",
				dataType: "json",
				data: {
					room_id: id,
					type: type
				},
				success: function(data) {
					if(data.code == 1){
						callback && callback();
					}
				}
			});
		},

		unfollow: function(id, type, callback){
			$.ajax({
				url: "/user/follow-ajax",
				type: "POST",
				dataType: "json",
				data: {
					room_id: id,
					type: type
				},
				success: function(data) {
					if(data.code == 1){
						callback && callback();
					}
				}
			});
		}
	}

	myFollow.init();
})();