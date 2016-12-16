
(function(){
	var dace = require("common:widget/page-dace/page-dace.es6");
	var _ = require('common:static/js/underscore/underscore.js');
	var Dialog = require('common:widget/dialog/dialog');
	var Share = require("common:widget/share/share.js");
	var Basil = require('common:widget/sessionStorage/basil.js');
	var QRCode = require("common:widget/share/qrcode/qrcode.js");
	var Toast = require("common:widget/toast/toast");
	var User = require("common:widget/login/login.js");
	var basil = Basil();

/*var prePlayCard={
				$(this).addClass("operat-has-support").siblings().addClass("disable");
*/
	var timer = null;
	var apiUrl = {
        // 关注
        follow: '/user/follow-ajax',
        discuss:'/passerbyking/bbs/:id',
    };

  	var Pre = {
  		init:function(){
  			var self = this;  			
		    this.$playCard = $(".J_buttonSupport"); 
		    this.$suscribute = $("#J-pre-subscribe");

            this.$discussContentWrap = $("#J_discuss");  
                           
            this.discussTpl = $("#J-discuss-tpl").html();    //赛后讨论
            this.$signCopy = $("#J-sign-copy");// 复制qq  J_zeroClipboard
            this.$zeroClipboard = $("#J_zeroClipboard");
		    this.$lrwPreDataList = [];
		    this.$select = '';		    
		    this.$elEvent = '';	
		    this.shareTimer = null;	  
            this.matchDiscuss(); 
		    this.bind();
		    this.shareBind();		    
		    // this.clipBoard();
            // this.clipBoardQQ();
		},
  		bind:function(){  			
  			var self = this;
  			this.$playCard.on('click',function(ev){ 
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
	    	this.$suscribute.on("click",function(){
	    		var type = $(this).hasClass("action") ? '1' :'0';
	    		self.sendFollow(type,$(this));
                return false;
	    	})
            this.$signCopy.on("click",function(){
                var type = "2";//qq
                self.clipBoard(document.getElementById("J-sign-copy"),type);
                return false;
            })
            this.$zeroClipboard.on("click",function(){
                var type = "1";//网址
                self.clipBoard(document.getElementById("J_zeroClipboard"),type);
            })
  		}, 
        render:function(data){
            var self = this;
            if(!data.light_reply && !data.thread_info){
                $(".pre-discuss").hide();
            }              
            var temp = _.template(self.discussTpl,{
                thread_info: data.thread_info,
                light_reply: data.light_reply
            });        
            
            self.$discussContentWrap.html(temp);
        },
        matchDiscuss:function(){
            var self = this;
            var url = apiUrl.discuss.replace(":id",HTV.tid);           
            
            $.ajax({
                url: url,
                type: "GET",
                dataType: "json",
                success: function(data){                    
                    self.render(data.data); 
                }
            });
        }, 		
  		clipBoard:function(even,type){
  			var self = this;

  			if(even){
                var client = new ZeroClipboard(even,{
                    moviePath: "http://b3.hoopchina.com.cn/code/zeroClipboard/1.3.5/ZeroClipboard.swf"
                });               
                client.on("load", function(client) {    
                    var text = type=="1"? window.location.href : even.innerHTML;                
                    client.setText(text);                   
                    client.on("complete", function(client, args) {                    	
                       self.copyTips();                       
                    } );                  
                });
               
            }
  		}, 
  		clipBoardQQ:function(){
  			var self = this;

  			if(document.getElementById("J-sign-copy")){
                var clientqq = new ZeroClipboard(document.getElementById("J-sign-copy"),{
                    moviePath: "http://b3.hoopchina.com.cn/code/zeroClipboard/1.3.5/ZeroClipboard.swf"
                });
                
                clientqq.on("load", function(clientqq) {
                    var text = $("#J-sign-copy").html();                    
                    clientqq.setText(text);                    
                    clientqq.on("complete", function(clientqq, args) {                          
                        self.copyQQtips();
                    } );                  
                });
               
            }
  		}, 	
        copyQQtips:function(){
            $(".copyqq-tips").show();
            var setTime = setTimeout(function(){
                 $(".copyqq-tips").hide();
            },5000)                     
            
        },	
	    vote:function(){
	    	var self = this;
            
	    	this.getCookie() ? this.voteHandle():'';
	    	
	    },
	    voteHandle:function(){
	    	var self = this;
	    	console.log(HTV.game_id);
            console.log(HTV.playerID);  	
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
	    //订阅
	    sendFollow:function(type,elem){
	    	var self = this;
            var followType = 'follow';

            if(!HTV.isLogin){
                User.login();
                return;
            }

            // 取消关注
            if(type == 1){
                followType = 'unfollow';
            }

            var sendData = {
                room_id: HTV.roomID,
                type: followType
            }

            $.ajax({
                url: apiUrl.follow,
                type: "POST",
                data: sendData,
                dataType: 'json',
                success: function(data) {
                    if(data.code === 1){    
                        // 取消关注
                        if(type == 1){
                            self.$suscribute                               
                                .find("span.subscribe-text")
                                .text("订阅");
                            self.suscributeTips(type);
                            elem.removeClass("action");
                            //dace.send(pageId + "_unfollowClick");
                        }else{
                            self.$suscribute
                                .find("span.subscribe-text")
                                .text('取消订阅');
                            elem.addClass("action");
                            self.suscributeTips(type);   
                            //dace.send(pageId + "_followClick");
                        }
                    }
                }
            });
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
            var $shareTips = $('#J_shareWeixinTips');

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
            var self = this;

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
        suscributeTips:function(type){            
                $("#J-subscribe-tips").show();
           if(type == 1){                
                $("#J-subscribe-tips").find(".subscribe-tips-text").text("订阅已取消");                
           }else{
                $("#J-subscribe-tips").find(".subscribe-tips-text").text("订阅成功，您将会收到"+HTV.zhubo+"的推送");               
           } 
            setTimeout(function(){
                $("#J-subscribe-tips").hide();
            },5000)
        }
  	}
  	Pre.init();
})()