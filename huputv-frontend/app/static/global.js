!function(){
	var isRun = false;
	var initEvent = function(){
		if(!isRun && window.__ready && window.__ready.length){
			isRun = true;
			$.each(window.__ready, function(idx, callback){
				callback.call(null);
			});
		}
	};
	window.initEvent = initEvent;
	// 兼容:active实现点击效果
	$("body").on("touchstart", function(){});

	$(function(){
		window.initEvent && window.initEvent();
    });
}();