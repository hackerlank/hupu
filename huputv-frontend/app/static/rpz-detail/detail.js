
!function(){
  "use strict";
	var Toast = require("app:widget/ui-toast/ui-toast.js");
	var _ = require("app:static/js/underscore/underscore");
	var common = require("app:widget/ui-common/ui-common.js");
  	var refresh = require("app:widget/ui-refresh/ui-refresh.js");

	var apiUrl = {
	    // 获取列表
	    list: '/m/predict/my/recordlist',
	    
	};

	var Zrpdetail={
		init:function(){
			this.$ZrpdetailWrap = $("#J-rpz-detail");
			this.$ZrpItemWrap = $("#J-rpz-detail-wrap");
			this.$zrpItemTemp = $("#J_lrwRpzDetailTpl").html();
			
			this.getData("load");
			this.bind();
			this.isRefresh();			

		}, 
		bind:function(){
      		var self = this;
      		
		},
		render:function(data,type){
			var self = this;
			if(type == 'more'){
				var template = _.template(self.$zrpItemTemp, {datas:data.list});
		        self.$ZrpItemWrap.append(template);
	        }else{
	        	var template = _.template(self.$zrpItemTemp, {datas:data.list});
		        self.$ZrpItemWrap.html(template);
	        }
	       
		},
		getData:function(type){			
			var self = this;			
			$.ajax({
              	url: apiUrl.list,
              	type: "GET",
              	dataType: "json",
              	success: function(res){
                if(res.code == 1) {
                  	self.render(res.data,type);
                  	self.$ZrpItemWrap.attr("data-next",res.data.next_id);
                }else{
                	Toast.toast(res.msg);
                }
              }
            });
		},
		getMoreDate:function(id,callback){
			var self = this;		
			var type = 'more';	
			$.ajax({
              	url: apiUrl.list,
              	type: "GET",
              	data:{
              		next_id:id
              	},
              	dataType: "json",
              	success: function(res){
                if(res.code == 1) {
                  	self.render(res.data,type);
                  	self.$ZrpItemWrap.attr("data-next",res.data.next_id);
                  	if(!res.data.next_id){                        
                         callback && callback("finish");
                    }else{
                        callback && callback(); 
                    }
                }else{
                	Toast.toast(res.msg);
                }
              }
            });
		},
		isRefresh:function(){
			var self = this;
			var pHeight = self.$ZrpdetailWrap.height();
			var pWindow = $(window).height();
			if(pHeight < pWindow-10){
				self.$ZrpdetailWrap.height(pWindow-10);				
			}			
			refresh({
		        contentEl: '#J-rpz-detail',
		        isRefresh: true,
		        isLoadingMore: true,
		        refreshCallback: function(complete) {
	                setTimeout(function() {
	                   complete();
	                   location.reload();
	                }, 1000);
		        },
		        loadingMoreCallback: function(complete) {                   
	                self.loadList(function(val){                   
	                    complete(val);
	                });
	            }
		    });
		},
		loadList:function(callback){
			var self = this;
	        if(	self.$ZrpItemWrap.attr("data-next")){
	            self.getMoreRpz(self.$ZrpItemWrap.attr("data-next"),callback);           
	            
	        }else{            
	            callback && callback("finish");            
	        } 
		}		
		
	}

  	$(function(){
      	Zrpdetail.init();
  	})
}();
