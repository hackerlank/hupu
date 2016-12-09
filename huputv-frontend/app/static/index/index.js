
!function(){
  "use strict";

  	var refresh = require("app:widget/ui-refresh/ui-refresh.js");
  	var _ = require("app:static/js/underscore/underscore.js");

  	var api = {
  		matchPre : '/m/passerbyking/game/notice/:id',
  		videoPre :'/m/video/division/0',
  	};

	var Index={
		init:function(){
			var self = this;
			console.log("enter");
			this.$indexItemWrap = $(".item-wrap");
			this.$matchPreWrap = $("#J-match-pre");
			this.$matchPreTpl = $("#J_lrwMatchPreTpl").html();
			this.$tab = $('#J_innerTab');
			this.$tabList = this.$tab.find('li');
			this.$division = $(".J-lrw-area");	
			this.$moreBtn = $("#J-more-btn");									
			this.$videoWrap = $("#J-lrwVideoWrap");//往前视频 容器
			this.$VideoTpl = $("#J_lrwVideoTpl").html();
			this.index = 0;
			this.bind();
			this.getData();	
			this.getVideoData();
			this.switchTab();				
		},
		bind:function(){
			var self = this;
			//初次render 页面
			var url = api.matchPre.replace(":id",'0');
			var areaTitle = "";
			self.getData(url,areaTitle,"none");
			this.$division.on("click",function(){

				var areaId = $(this).attr("data-id")  ? $(this).attr("data-id") : "0"   ;
				areaTitle = $(this).attr("data-name");
				url = api.matchPre.replace(":id",areaId);

				$(this).addClass("active").siblings().removeClass("active");
				self.getData(url,areaTitle,"switch");
			})
			this.$tabList.on('click', function() {
	        	self.switchTab($(this));
	    	});
			
			//点击render 页面
			
		},
		getData:function(url,text,type){
			var self = this;
			var data = [];
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
			var listData = [];
			var listDate2 = [];
			var length = data.length;

			if(length > 5){
				for(var i = 0;i < length ; i++){
					if(i<5){
						listData.push(data[i]);
					}else{
						listDate2.push(data[i]);
					}					
				}

			}else{
				var listData = data;
			}
			length > 5 ? this.$moreBtn.show() : this.$moreBtn.hide();

			var temp = _.template(self.$matchPreTpl)({datas:listData,text:text});  				
  			type == "switch" ? self.$matchPreWrap.html(temp) : self.$matchPreWrap.append(temp) ;
  			console.log("switch");
  			this.showMore(listDate2,length);
		},		
		showMore:function(data,length){
			var self = this;					
			if(length > 5){
				this.$moreBtn.click(function(){
					self.render(data,"","none");
				})
			}
			
		},
		getVideoData:function(){
			var self = this;
			var url = api.videoPre;
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
			var temp = _.template(self.$VideoTpl)({datas:data});  				
  			self.$videoWrap.append(temp);
		},
		switchTab:function(elem){
			var self = this;  			
	      	index = elem.index();
	      	var sid = elem.attr("data-sid");	      	
	      	this.$tabList.removeClass('active');
	      	this.$tabList
	        .eq(index)
	        .addClass('active');

	        this.$indexItemWrap.removeClass("actived");
	        this.$indexItemWrap.eq(index).addClass("actived");

	      	if( index >0 && !this.$indexItemWrap.eq(index).hasClass("visited")){
	      		var api = {
	      			player:"/m/sort/:id",	      			
	      		}
	      		var url = api.player.replace(":id":sid);
	      		self.getmultipleVideo(url,sid);
	      		
	      	}
		},
		getmultipleVideo:function(url,sid){
			
		}
	}

	$(function(){
      	Index.init();
  	})
}();