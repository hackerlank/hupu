
!function(){
  "use strict";

	var Toast = require("app:widget/ui-toast/ui-toast.js");
	var _ = require("app:static/js/underscore/underscore");
	var common = require("app:widget/ui-common/ui-common.js");
  	var refresh = require("app:widget/ui-refresh/ui-refresh.js");

  	var Pre = {
  		init:function(){
  			
  			var self = this;
  			this.$wrap = $('#J_lrw_pre');
		    if(!this.$wrap.length){
		        return;
		    }
		    this.$tab = $('#J_innerTab');
		    this.$tabList = this.$tab.find('li');
		    this.bind();
		    //this.switchTab(this.$tabList.eq(number));
		    this.clipBoard();
		},
  		bind:function(){
  			var self = this;

		      	this.$tabList.on('click', function() {
		        	self.switchTab($(this));
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
  		render:function(){

  		},
  		switchTab: function(elem) {
	     	var self = this,
	      	index = elem.index();

	      	this.$tabList.removeClass('active');
	      	this.$tabList
	        .eq(index)
	        .addClass('active');

	      	this.getUserInfo(function() {
	       		switch (index) {
			        case 1:
			            self.Match();
			            break;
			        case 2:
			            self.Player();
			            break;
			        default:
			            self.Discuss();
	        	}
	      	});
	    },
	    Match:function(){
	    	var self = this;
	        template = '';
	        isShowRank = (self.match_status <= 4);
	        url = isShowRank ? M_LRW.top8_match_url : M_LRW.top8_rank_url;
		},
	    Player:function(){

	    },
	    Discuss:function(){

	    }
  	}


  	$(function(){
      	Pre.init();
  	})

}()