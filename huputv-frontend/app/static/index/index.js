
!function(){
  "use strict";

  	var refresh = require("app:widget/ui-refresh/ui-refresh.js");
  	var _ = require("app:static/js/underscore/underscore.js");
  	var Util = require('common:widget/util/util');
  	var common = require("app:widget/ui-common/ui-common.js");
  	var Toast = require("app:widget/ui-toast/ui-toast.js"); 

  	var api = {
  		matchPre : '/m/passerbyking/game/notice/:id',
  		videoPre :'/m/video/division/:id',
  		subscribe : "/m/follow/doFollow",
		unsubscribe: "/m/follow/undoFollow",
		player:"/m/sort/:id",	 
  	};

	var Index={
		init:function(){
			HTV.hash = window.location.href.split("#hash=")[1] || '0';
			var self = this;
			this.$lrwWrap =$("#lrw-wrap");//整个wrap
			this.$indexItemWrap = $(".item-wrap");
			this.$matchPreWrap = $("#J-match-pre");
			this.$matchPreTpl = $("#J_lrwMatchPreTpl").html();
			this.$tab = $('#J_innerTab');
			this.$tabList = this.$tab.find('li');
			this.$division = $(".J-lrw-area");	
			this.$moreBtn = $("#J-more-btn");									
			this.$videoWrap = $("#J-forshow-wrap");//首页往前视频 容器
			this.$VideoTpl = $("#J_lrwVideoTpl").html();
			this.$catagory = $(".J-catagory"); //频道
			this.$itemWrap = $(".item-wrap");
			this.loginBtn = $("#J-login-btn");			
			this.index = 0;
			this.tab();
			this.step = false;
			this.bind();
			// this.getData();	
			this.getVideoData("0");
			this.share();
			//this.switchTab();	
			this.refresh();
				
		}, 
		share:function(){
			var link = window.location.href.split("#hash")[0];
			HupuBridge.send("hupu.share.setNative",{
			     imageUrl: "",
			     title: "虎扑路人王",
			     text: "虎扑路人王-全民参与的篮球赛事",
			     linkUrl: link
			}, function(status){
			    
			});
		},
		//刷新页面显示当前tab
		tab:function(){
			
			
			this.$tabList.removeClass('active');
	      	this.$tabList
	        .eq(HTV.hash)
	        .addClass('active');	       

	        this.$indexItemWrap.removeClass("actived");
	        this.$indexItemWrap.eq(HTV.hash).addClass("actived");
	        this.$itemWrap.eq(HTV.hash).addClass("active-show").siblings().removeClass("active-show");
			if(HTV.hash > 0){
				var id = HTV.areaId || "0";
				var url = api.player.replace(":id",id)
				this.getmultipleVideo(url,HTV.hash);
			}else{
				var url = api.matchPre.replace(":id",'0');
				var areaTitle = "";
				this.getData(url,areaTitle,"enter");
			}
			
				
		},
		bind:function(){
			var self = this;
			
			this.loginBtn.on("click",function() {          
	          	if(!HTV.isLogin){
	            	return common.schemeLogin();
	            }
	            
	        });
			//初次render 页面
			var url = api.matchPre.replace(":id",'0');
			var areaTitle = "";
			self.getData(url,areaTitle,"enter");

			this.$division.on("click",function(){

				var areaId = $(this).attr("data-id")  ? $(this).attr("data-id") : "0"   ;
				areaTitle = $(this).attr("data-name");
				url = api.matchPre.replace(":id",areaId);
				HTV.areaId = areaTitle;
				$(this).addClass("active").siblings().removeClass("active");
				self.getData(url,areaTitle,"enter");
				self.getVideoData(areaId);
			})
			this.$tabList.on('click', function() {
	        	self.switchTab($(this));
	        	$(this).removeClass("active");				
				$(this).addClass("active");	
				var index = $(this).index();
				self.$itemWrap.eq(index).addClass("active-show").siblings().removeClass("active-show");
	    	});
		},
		getData:function(url,text,type){

			var self = this;
			
			$.ajax({
				url:url,
				type:"GET",
				success:function(res){
					if(res.code == 1){
						self.render(res.data,text,type);						
					}
				}
			})
		},
		render:function(data,text,type){
			
			var self = this;
			var listDate = [];
			var listData1 = []; //前5
			var listDate2 = [];  //后面所以
			var length = data.length;
			
			if(length > 5 && type != 'more'){				 
				for(var i = 0;i < length ; i++){
					if(i<5){
						listData1.push(data[i]);
					}else{
						listDate2.push(data[i]);
					}					
				}
				listDate = listData1 ;
				
			}else{
				listDate = data;
			}
			
			length > 5 && type != 'more'? this.$moreBtn.show() : this.$moreBtn.hide();
			
			//站点为空时，显示战区
			var tempText = text ? text+"站" : "全部站";
			//全部没有数据，整个栏目hide
			if(!text && !length){
				$(".foreshow").hide();
			}

			var temp = _.template(self.$matchPreTpl)({datas:listDate,text:tempText,sub:Util.subString}); 			
  			type == "enter" ? self.$matchPreWrap.html(temp) : self.$matchPreWrap.append(temp);
  			 			
			this.subscribe();
			if(length > 5 ){
				this.showMore(listDate2,length,type);
			}  			
		},		
		showMore:function(data,length,type){
			var self = this;				
			this.step = true;	
			if(length > 5 && type != 'more'){
				this.$moreBtn.off("click").on('click',function(){
					self.render(data,"","more");					
				})				
			}
			
		},
		getVideoData:function(id){
			var self = this;

			var url = api.videoPre.replace(":id",id);
			$.ajax({
				url:url,
				type:"GET",
				success:function(res){
					if(res.code == 1){
						self.renderVideo(res.data);
					}
				}
			})
		},
		renderVideo:function(data){
			var self = this;
			var temp = _.template(self.$VideoTpl)({datas:data,sub:Util.subString});  				
  			self.$videoWrap.html(temp);
		},
		switchTab:function(elem){	
			
			var self = this;  			
	      	var index = elem  ? elem.index() : "0";
	      	HTV.hash = index;//频道位置索引，下拉刷新使用
	      	var sid = elem.attr("data-sid");
	      	HTV.sid = sid;	      	
	      	this.$tabList.removeClass('active');
	      	this.$tabList
	        .eq(index)
	        .addClass('active');	       

	        this.$indexItemWrap.removeClass("actived");
	        this.$indexItemWrap.eq(index).addClass("actived");

	      	if( index >0 && !this.$tabList.eq(index).hasClass("visited")){
	      		
	      		var url = api.player.replace(":id",sid);
	      		self.getmultipleVideo(url,index);
	      		
	      	}
		},
		getmultipleVideo:function(url,index){
			var self = this;
			$.ajax({
				url:url,
				type:"GET",
				success:function(res){
					if(res.code == 1){

						self.getmultipleVideoRender(res.data,index);
						self.$tabList.eq(index).addClass("visited");
						
						if(!res.data.length && index > 0){							
							$(".no-video").css("margin-top",$(window).height()/2-60);
						}else if(!res.data.length && index == 0){ 
							$(".past-match").hide();
						}
					}
				}
			})
		},
		getmultipleVideoRender:function(data,index){
			var self = this;

			var temp = _.template(self.$VideoTpl)({datas:data}); 								
  			this.$itemWrap.eq(index).html(temp);
		},
		subscribe:function(){
			this.$subscribe = $(".J-subscribe");//订阅btn
			this.subscribeBind();
		},
		subscribeBind:function(){
			var self = this;
			this.element = "";			
			this.$subscribe.on("click",function(){
				if(!HTV.isLogin){
					return common.schemeLogin();
				}
				var type = $(this).attr("data-status");
				var room_id = $(this).attr("data-roomid");
				self.element = $(this);
				self.subscribeData(type,room_id);
			})		  	
		},
		subscribeData:function(type,room_id){
			
			var self = this;
	  		var url = type == 0 ? api.subscribe : api.unsubscribe;
	  		
	  		$.ajax({
	  			url:url,
	  			type:"POST",
	  			data:{room_id:room_id},
	  			success:function(res){
	  				if(res.code == 1){
	  					if (type == 0){
	  						self.element.addClass("subscribed");
	  						self.element.find(".subscribe-text").text("取消订阅");
	  						self.element.attr("data-status",'1');
	  						
	  						Toast.toast("订阅成功，您将会收到路人王的开赛提醒");
	  					}else{
	  						self.element.removeClass("subscribed");
	  						self.element.find(".subscribe-text").text("订阅");
	  						self.element.attr("data-status",'0');
	  						
	  						Toast.toast("订阅已取消");
	  					}
	  					
	  				}
	  			}
	  		})

		},
		refresh:function(){
	    	var self = this;
			var pHeight = self.$lrwWrap.height();
			var pWindow = $(window).height();
			if(pHeight < pWindow-10){
				self.$lrwWrap.height(pWindow-10);				
			}			
			refresh({
		        contentEl: '#lrw-wrap',
		        isRefresh: true,
		        isLoadingMore: false,
		        refreshCallback: function(complete) {
	                setTimeout(function() {
	                   complete();
	                   window.location.href=window.location.href.split("#hash")[0]+"#hash="+HTV.hash;
	                   location.reload();
	                }, 1000);
		        }
		    });
	    }
	}

	$(function(){
      	Index.init();
  	})
}();