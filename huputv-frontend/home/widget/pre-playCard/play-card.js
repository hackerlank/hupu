	var _ = require('common:static/js/underscore/underscore.js');
	var Dialog = require('common:widget/dialog/dialog');
	var Basil = require('common:widget/util/util.js');

	var basil = Basil();

/*var prePlayCard={
	init:function(){
		var self = this;
		this.$playCard = $(".J_buttonSupport");
	},
	bind:function(){
		var self = this;
		this.$playCard.on("click",function(e){
			if(!HTV.isLogin){
				HTV.jumpLogin();
			}else{
				$(this).addClass("operat-has-support").siblings().addClass("disable");
			}
			return false;
		})
	},
	render:function(){
		var self = this;
	},
	handle:function(){

	}*/

  	var Pre = {
  		init:function(){
  			var self = this;
  			console.log("enter");
		    this.$playCard = $(".J_buttonSupport"); 
		    this.$lrwPreDataList = [];
		    this.$select = '';		    
		    this.$elEvent = '';		   
		    this.bind();
		    this.clipBoard();
		},
  		bind:function(){  			
  			var self = this;
  			this.$playCard.on('click',function(ev){   
  					console.log("enter")
	    		HTV.playerID = $(this).attr("data-id");
	    		HTV.nickName = $(this).attr("data-nickname");
	    		
	    		console.log(HTV.nickName);
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
		            	self.$select.addClass("selected");
		            	self.$elEvent.addClass("finish");
		            	self.$elEvent.text("已选"+parseInt(self.$elEvent.text())+1);
		            	basil.set('prepuid', HTV.getUserId);

		          	}else{
		           		Toast.toast(data.msg);
		          	}
		        }
		    });
	    },
	    getCookie:function(){
	    	var self = this;	    	
	    	
	    	if(!basil.get('preuid')) {
	    		self.Toastconfirm();
	    	}else if(basil.get('preuid') == HTV.getUserId ){
	    		return true;
	     	}
	    	
	    },
	    Toastconfirm:function(){
	    	var self = this;
	    	var content = '<div class="popup-pred-game"><div class="content">您预测[' + HTV.nickName+ ']，会夺得本场路人王冠军，预测正确将会获得300人品值，预测错误将会扣除100人品值，选择后其它所有选项都不可再选，是否确认选择？</div></div>';
		   
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
  	
  	$(document).ready(function(){
  		console.log('log');
  		Pre.init();
  	})