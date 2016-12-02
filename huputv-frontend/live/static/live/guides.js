(function(){
	var cookie={
		add:function(key,val,ecdays){
			var str=key+"="+escape(val);
			if(ecdays>0){
				var data=new Date();
				data.setTime(data.getTime()+ecdays*24*60*60*1000);
				str+=";expires="+data.toUTCString();
				document.cookie=str;
			}
		},
		get:function(key){
			var arrStr=document.cookie.split("; ");
			for(var i=0;i<arrStr.length;i++){
				var temp=arrStr[i].split("=");
				if(temp[0]==key){
					return unescape(temp[1]);
				}
			}
			return false;
		},
		del:function(key){
			var date=new date();
			date.setTime(-10000);
			var str=key+"="+escape(val);
			document.cookie=key+"=a;expire="+data.toGMTstring();
		}
 	}   

	var guideLive={
		init:function(){
			$("body").css("overflow","hidden");
			this.Img=$("#guideOverlay img");
			this.zrpPrev=$(".task-and-gift");//攒人品相对位置
			this.dayBoard=$(".day-board");//日排行榜
			this.dayBoardPrev=$(".bulletin");//主播公告
			this.confirmBtn=$("#guideKnow");//我知道了按钮
			this.zrpBtn=$("#J_predGame");//攒人品
			this.personMes=$(".rpz-link");//悬浮个人信息
			this.gChartRoom=$("#J_chatroom");//聊天面板相对位置
     		this.guide();
		},
		guide:function(){
			var self=this;
     		if($(self.dayBoard).length){
      				var T=($(self.dayBoard).offset().top-51)+"px";
      				var l=($(self.dayBoard).offset().left-144)+"px";
      				$(self.Img).eq(3).css({"left":l,"top":T});
      		}else{
      				var T=($(self.dayBoardPrev).offset().top+$(self.dayBoardPrev).height()+20)+"px";
      				var l=($(self.dayBoardPrev).offset().left-144)+"px";
      				$(self.Img).eq(3).css({"left":l,"top":T});
      			}			
			var zrpT=($(self.zrpBtn).offset().top-63)+"px";
			var zrpl=($(self.zrpBtn).offset().left-60)+"px";
			$(self.Img).eq(0).css({"left":zrpl,"top":zrpT});
      		if($(self.personMes).length){
      			var perT=$(self.personMes).css("top")+"px";
      			$(self.Img).eq(2).css({"top":perT,"right":0});
      		}else{
      			$(self.Img).eq(2).css({"top":280,"right":0});
      		}

      		var chartl=$(self.gChartRoom).offset().left-300+"px";
      		$(self.Img).eq(1).css({"left":chartl});
      		$(self.confirmBtn).css({"top":$(window).height()/2-15+"px","left":$(window).width()/2-75+"px"});
		}
	}

	var getCookie=cookie.get("_Post");
	if(getCookie){
		/*非首次进入不写入cookie*/
	}else{
		/*首次进入直播间写入cookie*/		
		cookie.add("_Post","huputv-v1.2",365);
		$("#guideOverlay").show();
		/*显示弹层*/	
		function getCalSize(){
			var windowWidth=$(window).width();			
			if(windowWidth<1090){
			}else if(windowWidth>1090){
				/*判断主播公告高度--确定首次滑到顶部的距离*/
				if(windowWidth>1732){					
					var sTop=$(".bulletin").outerHeight()+130;					
					$("html,body").animate({scrollTop:sTop},300);
				
				}else {
					$("html,body").animate({scrollTop:sTop},0);
				}
				$("html,body").css("overflow","hidden");
				guideLive.init();
			}
		}
		getCalSize();
		$(window).resize(getCalSize);
		
	}
	$("#guideKnow").on("click",function(){
		$("#guideOverlay").hide();
		$(window).off("resize",getCalSize);
		$("html,body").css("overflow","auto");
		$("html,body").animate({scrollTop:0},300);
	});		
})()	
