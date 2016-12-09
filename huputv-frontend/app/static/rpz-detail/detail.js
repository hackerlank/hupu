
!function(){
  "use strict";
	var Toast = require("app:widget/ui-toast/ui-toast.js");
	var _ = require("app:static/js/underscore/underscore");
	var common = require("app:widget/ui-common/ui-common.js");
  	var refresh = require("app:widget/ui-refresh/ui-refresh.js");

	var apiUrl = {
	    // 获取列表
	    list: '/predict/topic/list/:id',
	    
	};

	var Zrpdetail={
		init:function(){
			this.$ZrpdetailWrap = $("#J-rpz-detail");
			this.$ZrpItemWrap = $("#J-rpz-detail-wrap");
			this.$zrpItemTemp = $("#J_lrwRpzDetailTpl").html();
			//this.bind();
			this.render();

		},
		bind:function(){
      		var self = this;
		},
		render:function(){
			var self = this;
			console.log("enter");
			var pHeight = self.$ZrpdetailWrap.height();
			var pWindow = $(window).height();
			if(pHeight < pWindow-10){
				self.$ZrpdetailWrap.height(pWindow-10);				
			}			
			refresh({
		        contentEl: '#J-rpz-detail',
		        isRefresh: true,
		        isLoadingMore: false,
		        refreshCallback: function(complete) {
	                setTimeout(function() {
	                   complete();
	                   location.reload();
	                }, 1000);
		        }
		    });
			var template = _.template(self.$zrpItemTemp, {datas:datas});

	        self.$ZrpItemWrap.append(template);
	        console.log('enter2');
		},		
		
	}

  $(function(){
      Zrpdetail.init();
  })
}();
