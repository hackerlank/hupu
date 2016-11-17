var teamList = {
	init:function(){
		this.bindFun();
	},
	bindFun:function(){
		var obj = $(".teamlist_box_r").find(".team").find(".box"),
		    obj2 = $(".teamlist_box_r").find(".all").find(".a span");
		obj.hover(function(){
			$(this).addClass("on");
			$(this).parents(".team").prev().find("span").addClass("on");
		},function(){
			obj2.removeClass("on");
			obj.removeClass("on");
		});
	}
}
teamList.init();
exports = teamList;