	
(function(){
	var _ = require('common:static/js/underscore/underscore.js');
	var Dialog = require('common:widget/dialog/dialog');
	var Share = require("common:widget/share/share.js");
	var Basil = require('common:widget/sessionStorage/basil.js');
	var QRCode = require("common:widget/share/qrcode/qrcode.js");
	var Toast = require("common:widget/toast/toast");
	var basil = Basil();

/*var prePlayCard={
				$(this).addClass("operat-has-support").siblings().addClass("disable");
*/
	var timer = null;

  	var Pre = {
  		init:function(){
  			var self = this;  			
		    this.$playCard = $(".J_buttonSupport"); 
		    this.$lrwPreDataList = [];
		    this.$select = '';		    
		    this.$elEvent = '';	
		    this.shareTimer = null;	   
		    this.bind();
		    this.shareBind();
		    this.clipBoard();
		},
  		bind:function(){  			
  			var self = this;
  			this.$playCard.on('click',function(ev){ 
	    		HTV.playerID = $(this).attr("data-id");
	    		HTV.nickName = $(this).attr("data-nickname");
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
  			if(document.getElementById("J_zeroClipboard")){
                var client = new ZeroClipboard(document.getElementById("J_zeroClipboard"),{
                    moviePath: "http://b3.hoopchina.com.cn/code/zeroClipboard/1.3.5/ZeroClipboard.swf"
                });
                
                client.on("load", function(client) {
                                   
                    client.setText(window.location.href);

                    client.on( "complete", function(client, args) {                    	
                       self.copyTips();
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
	    	   	
	    	var url = 'passerbyking/game/champion';	    	
	    	$.ajax({
		        url: url,
		        type: "POST",
		        data:{ game_id:HTV.game_id,player_id:HTV.playerID },		        
		        success: function(data){
		          	if(data.code == 1){

		            	Toast.toast(data.msg);		            	
		            	self.$elEvent.addClass("operat-has-support").siblings().addClass("disable")
		            	self.$elEvent.find(".number").text(parseInt(self.$elEvent.text())+1);
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
		   
	    	Dialog(
		    	{
		          	title:'',
		          	content: content,
		          	confirm:{
		          		text:'确认',
		          		callback:self.voteHandle.bind(this),
		          	}
		        }
		    )
	    },
	    shareBind:function(){
	    	var self = this;
	    	var $share = $('#J_uiTopShare'),
                $tips = $share.find('.J_shareTips');
            
            $share.hover(
                function() {
                    self.shareShow($tips);
                },
                function() {
                    self.shareHide($tips);
                }
            );
            
            var qrcode = new QRCode("J_shareQrcode", {
                text: HTV.shareUrl,
                width: 98,
                height: 98
            });

            $share.find('.icons-weixin').hover(
                function() {
                    $shareTips.show();
                },
                function() {
                    $shareTips.hide();
                }
            );


            var type = '',
                shareData = HTV.shareData;

            shareData.tempTitle = shareData.title;

            $share.find('.icons').on('click', function(){
                type = $(this).data('type');

                if(type == 'qq'){
                    shareData.title = document.title;
                    shareData.summary = shareData.qqSubTitle;
                }else{
                    shareData.title = shareData.tempTitle;
                    shareData.summary = '';
                }

                new Share(type, shareData);
            })
            
	    },
	    shareShow:function($tips) {
            clearTimeout(this.shareTimer);
            $tips.show();
        },
        shareHide: function($tips) {
            var that = this;

            this.shareTimer = setTimeout(function() {
                $tips.hide();
            }, 500);
        },        
        copyTips: function() {
            var $tips = $('#J_shareCopyTips');

            clearTimeout(timer);
            $tips.show();

            timer = setTimeout(function(){
                clearTimeout(timer);
                $tips.hide();
            }, 1130);
        },

  	}
  	Pre.init();
})()