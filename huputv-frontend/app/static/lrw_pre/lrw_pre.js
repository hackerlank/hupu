
!function(){
  "use strict";

	var Toast = require("app:widget/ui-toast/ui-toast.js");	
	var _ = require("app:static/js/underscore/underscore");
	var common = require("app:widget/ui-common/ui-common.js");
  	var refresh = require("app:widget/ui-refresh/ui-refresh.js");
  	var Basil = require('app:widget/ui-store/ui-basil.js');

  	var basil = Basil();

  	var Pre = {
  		init:function(){
  			
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
		    this.lrwPreDataList = [];
		    this.select = '';		    
		    this.$elEvent = '';		   
		    this.bind();
		    this.refresh();
		    //this.switchTab(this.$tabList.eq(number));
		    this.clipBoard();
		},
  		bind:function(){
  			var self = this;  			
	      	this.$tabList.on('click', function() {
	        	self.switchTab($(this));
	    	});
  		},
  		handle:function(){
  			var self = this;
  			this.select.on('click',function(ev){   
  					
	    		HTV.playerID = $(this).attr("data-playId");
	    		self.$elEvent = $(this);
	    		if(!HTV.isLogin){
	    			HTV.jumpLogin();
	    		}else{
	    			self.vote();
	    		}
	    	})
  		},
  		clipBoard:function(){

  			if(document.getElementById("J-sign-copy")){
                var client = new ZeroClipboard(document.getElementById("J-sign-copy"),{
                    moviePath: "http://b3.hoopchina.com.cn/code/zeroClipboard/1.3.5/ZeroClipboard.swf"
                });
                
                client.on("load", function(client) {                                   
                    client.setText(document.getElementById("J-sign-copy").innerHTML);
                    client.on( "complete", function(client, args) {                    	
                       Toast.toast('复制成功，现在就去添加QQ号报名参赛吧！');
                    } );                  
                });
               
            }
  		},
  		render:function(type,data){
  			var self = this;
  			var status = 0;

  				data.list.map(function(item,index){
	  				if(item.id == data.predict_player_id){
	  					status = 1;
	  				}	  				
  				});

  			if(type == 'player'){
  				var temp = _.template(self.$lrwPlayer)({datas:data.list,player:type,player_id:data.predict_player_id,status:status});  				
  				self.$lrwPlayerWrap.html(temp);
  				self.select = $('.select_win');
  				self.handle();
  			}
  			if(type== 'discuss'){

  			}
  		},
  		switchTab: function(elem) {
	     	var self = this,
	      	index = elem.index();	      	
	      	this.$tabList.removeClass('active');
	      	this.$tabList
	        .eq(index)
	        .addClass('active');

	        this.$lrwTabItem.removeClass("actived");
	        this.$lrwTabItem.eq(index).addClass("actived");
	      	if( index >0 && !this.$lrwTabItem.eq(index).hasClass("visited")){
	      		var api = {
	      			player:"/m/passerbyking/game/player/:id",
	      			discuss:"",
	      		}
	      		var matchID = HTV.match_id;	      		
	      		switch(index){
	      			case 1 :
	      				self.matchPlay(api.player,matchID,index);
	      				break;
	      			case 2 :
	      				self.matchDiscuss();
	      				break;
	      			default :
	      				break;
	      		}
	      	}
	    },
	    matchPlay:function(urls,matchID,index){
	    	var self = this;
	    	var type = 'player';
	    	var url = urls.replace(":id","36");
	    	$.ajax({
		        url: url,
		        type: "GET",		        
		        success: function(data){
		          	if(data.code == 1){
		            	self.render(type,data.data)
		            	self.lrwPreDataList = data.data.list;
		            	self.$lrwTabItem.eq(index).addClass("visited");
		          	}else{
		           		
		          	}
		        }
		    });
	    },
	    vote:function(){
	    	var self = this;
	    	this.getCookie() ? this.voteHandle():'';
	    	
	    },
	    voteHandle:function(){
	    	var self = this;
	    	   	
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
		            	self.$elEvent.text("已选"+parseInt(self.$elEvent.text())+1);
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

	    	}else if(basil.get('puid') == HTV.getUserId ){

	    		return true;
	     	}
	    	
	    },
	    Toastconfirm:function(nickName){
	    	var self = this;
	    	var content = '<div class="popup-pred-game"><div class="content">您预测[' + nickName+ ']，会夺得本场路人王冠军，预测正确将会获得300人品值，预测错误将会扣除100人品值，选择后其它所有选项都不可再选，是否确认选择？</div></div>';
		   
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
	                   location.reload();
	                }, 1000);
		        }
		    });
	    }
  	}


  	$(function(){
      	Pre.init();
  	})

}()