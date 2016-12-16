
!function(){
  "use strict";

	var Toast = require("app:widget/ui-toast/ui-toast.js");	
	var _ = require("app:static/js/underscore/underscore");

  	var refresh = require("app:widget/ui-refresh/ui-refresh.js");
  	var Basil = require('app:widget/ui-store/ui-basil.js');

  	var basil = Basil();
  	
  	var api = {
  			player:"/m/passerbyking/game/player/:id",
  			discuss:"/m/passerbyking/bbs/:id",
  		}
  	var Pre = {
  		init:function(){
  			HTV.hash = window.location.href.split("#hash=")[1]||'0' ;  			
  			var self = this;
  			this.$wrap = $('#J_lrw_pre');
		    if(!this.$wrap.length){
		        return;
		    }
		    this.$predMain = $("#J-pre-main");
		    this.$tab = $('#J_innerTab');
		    this.$lrwTabItem = $(".lrw-pre-item");
		    this.$lrwPlayerWrap = $("#J_lrwPlayerWrap");
		    this.$lrwPlayer = $("#J_lrwStatisticsTpl").html();//赛前页球员模板
		    this.$tabList = this.$tab.find('li');
		    this.$discussContentWrap = $(".J_discuss");  J-sign-copy
		    this.$discuss = $(".discuss");                 
      		this.discussTpl = $("#J-discuss-tpl").html();    //赛后讨论
      		this.$signCopy = $("#J-sign-copy");      // 复制qq
      		this.tab();
		    this.lrwPreDataList = [];
		    this.select = '';		    
		    this.$elEvent = '';		   
		    this.bind();
		    this.refresh();
		    //this.switchTab(this.$tabList.eq(number));
		    
		},
		tab:function(){
			var self = this;
			var matchID = HTV.match_id;	

			this.$tabList.removeClass('active');
	      	this.$tabList
	        .eq(HTV.hash)
	        .addClass('active');

			this.$lrwTabItem.removeClass("actived");
	        this.$lrwTabItem.eq(HTV.hash).addClass("actived");

			switch (HTV.hash){
				case '1':		
						
					self.matchPlay(api.player,matchID,HTV.hash);
				break;
				case '2':
					
					self.matchDiscuss(api.discuss,HTV.tid,HTV.hash);
				break;
				default:
					
				break;
			}
		},
  		bind:function(){
  			var self = this;  			
	      	this.$tabList.on('click', function() {
	        	self.switchTab($(this));
	    	});
	    	this.$signCopy.on('click',function(){
	    		self.clipBoard();
	    	}) 
  		},
  		handle:function(){
  			var self = this;
  			this.select.on('click',function(ev){   
  					
	    		HTV.playerID = $(this).attr("data-playid");
	    		
	    		self.$elEvent = $(this);
	    		if(!HTV.isLogin){
	    			HTV.jumpLogin();
	    		}else{
	    			self.vote();
	    		}
	    	})
  		},
  		clipBoard:function(){
  			var self = this;

  			this.initBridge(function(){
	           	HupuBridge.send("hupu.ui.copy", {
	                content: "300507990"	                
	           	}, function(){
	           		Toast.toast("已成功复制QQ号，现在就去添加QQ号报名参赛吧");
	           	});
        	});
  		},
  		initBridge:function(callback){

  			if(window.HupuBridge){
  				
                callback();
            }else{
                document.addEventListener("hupuBridgeReady", function(){                	
                    callback();
                });
            }           
  		},
  		render:function(type,data){
  			var self = this;
  			var status = 0;
  			if(type == 'player'){
  				data.list.map(function(item,index){
	  				if(item.id == data.predict_player_id){
	  					status = 1;
	  				}	  				
  				});  				
  				var temp = _.template(self.$lrwPlayer)({datas:data.list,player:type,player_id:data.predict_player_id,status:status,game_status:HTV.game_status});  				
  				self.$lrwPlayerWrap.html(temp);
  				self.select = $('.select_win');
  				self.handle();
  			}
  			if(type== 'discuss'){
  				console.log(data);
  				var temp = _.template(self.discussTpl)({
	            	thread_info: data.data.thread_info,
	            	light_reply: data.data.light_reply,
	            	code: data.code
	         	});  				
  				self.$discussContentWrap.html(temp);
  			}
  		},
  		switchTab: function(elem) {
	     	var self = this,
	      	index = elem.index();	

	      	HTV.hash = index;      	
	      	this.$tabList.removeClass('active');
	      	this.$tabList
	        .eq(index)
	        .addClass('active');
	        
	        this.$lrwTabItem.removeClass("actived");
	        this.$lrwTabItem.eq(index).addClass("actived");
	      	if( index >0 && !this.$lrwTabItem.eq(index).hasClass("visited")){
	      		
	      		var matchID = HTV.match_id;	      		
	      		switch(index){
	      			case 1 :
	      				self.matchPlay(api.player,matchID,index);
	      				break;
	      			case 2 :
	      				self.matchDiscuss(api.discuss,HTV.tid,index);
	      				break;
	      			default :
	      				break;
	      		}
	      	}
	    },
	    matchPlay:function(url,matchID,index){
	    	var self = this;
	    	var type = 'player';
	    	var url = url.replace(":id",matchID);
	    	$.ajax({
		        url: url,
		        type: "GET",		        
		        success: function(data){
		          	if(data.code == 1){
		            	self.render(type,data.data)
		            	self.lrwPreDataList = data.data.list;
		            	self.$lrwTabItem.eq(index).addClass("visited");
		          	}else{
		           		Toast.toast(data.msg);
		          	}
		        }
		    });
	    },
	    matchDiscuss:function(url,tid,index){
	    	console.log("enter");
	    	var self = this;
	    	var type = 'discuss';
	    	self.$discuss.show();
	    	var url = url.replace(":id",tid);
		    $.ajax({
		      	url: url,
		      	type: "GET",
		      	dataType: "json",
		      	success: function(data){		      		
		      		self.render(type,data);		          	
		         	self.$lrwTabItem.eq(index).addClass("visited");		          
		      	}
		    });
	    },
	    vote:function(){
	    	var self = this;
	    	this.getCookie() ? this.voteHandle():'';
	    	
	    },
	    voteHandle:function(){
	    	var self = this;
	    	if(self.$elEvent.hasClass("selected")){
	    		return;
	    	}
	    	var url = '/m/passerbyking/game/champion';	    	
	    	$.ajax({
		        url: url,
		        type: "POST",
		        data:{ game_id:HTV.match_id,player_id:HTV.playerID },		        
		        success: function(data){
		          	if(data.code == 1){

		            	Toast.toast(data.msg);
		            	self.select.addClass("selected");
		            	self.$elEvent.addClass("finish");
		            	self.$elEvent.text("已选"+(parseInt(self.$elEvent.text().replace(/[^0-9]/ig,""))+1));
		            	basil.set('puid', HTV.getUserId);

		          	}else{
		           		Toast.toast(data.msg);
		          	}
		        }
		    });
	    },
	    getCookie:function(){
	    	var self = this;	    	
	    	var nickName = '';
	    	this.lrwPreDataList.map(function(item,index){
	    		if(item.id == HTV.playerID){	    			
	    			nickName = item.nickname;
	    		}
	    	});	   	
	    	

	    	if(!basil.get('puid')) {
	    		
	    		self.Toastconfirm(nickName);
	    		return false;

	    	}else if(basil.get('puid') == HTV.getUserId ){

	    		return true;
	     	}
	    	
	    },
	    Toastconfirm:function(nickName){
	    	var self = this;
	    	var content = '<div class="popup-pred-game"><div class="content">您预测[' + nickName+ ']，会夺得本场路人王冠军，预测正确将会获得300人品值，预测错误将会扣除100人品值，选择后其它所有选项都不可再选，是否确认选择？<div class="tips">该弹层下次不再显示</div></div></div>';
		   
	    	Toast.confirm(
		    	{
		          	title:'',
		          	content: content,
		          	align: "center",
		          	submitHandler: self.voteHandle.bind(this),
		          	submitText: "确认",
		          	cancelText: "取消",
		          	cancelHandler: function(){

		          	}
		        }
		    )
	    },
	    refresh:function(){
	    	var self = this;
			var pHeight = self.$predMain.height();
			var pWindow = $(window).height();
			if(pHeight < pWindow-10){
				self.$predMain.height(pWindow-10);				
			}			
			refresh({
		        contentEl: '#J-pre-main',
		        isRefresh: true,
		        isLoadingMore: false,
		        refreshCallback: function(complete) {
	                setTimeout(function() {
	                   complete();
	                   window.location.href=window.location.href.split("#hash")[0]+"#hash="+HTV.hash;
	                   //location.reload();
	                }, 1000);
		        }
		    });
	    }
  	}


  	$(function(){
      	Pre.init();
  	})

}()