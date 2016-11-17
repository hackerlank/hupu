

var against = {
	init:function() {
		this.bind();
	},
	bind:function() {
		 $(".againsts-nav").find("li").on("click", function(){
        $(this).addClass("active").siblings().removeClass("active");
        $(".pics-list").eq($(this).index()).show().siblings(".pics-list").hide();
    });
	}
}
against.init();