(function(){

	// 根据屏幕宽度有两种布局
	$(window).on("load resize", function(){
		var iWidth = $(window).width();
		var oBody = $("body");

		if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/7./i)=="7.") {
			return false;
		}else{
			if(iWidth >= 1530){
				oBody.addClass("body-1530");
			}else{
				if(oBody.hasClass("body-1530")){
					$("body").removeClass("body-1530");
				}
			}
		}
	});

})();
