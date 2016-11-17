var _ = require("app:static/js/underscore/underscore.js");
var io = require('common:widget/js/socket-1.4.5/socket.js');
var Toast = require("app:widget/ui-toast/ui-toast.js");
var common = require("app:widget/ui-common/ui-common.js");
var Store = require("app:widget/ui-store/ui-store.js");
var $win = $(window),
	  $mask = $('.mask');
var Hot = {

  init: function(){
      this.render();
      this.socket();
      this.bind();
  },
  bind: function() {
	 //  document.body.ontouchmove=function(e){
		//     e.preventDefault();
		// }

		// document.querySelectorAll('.content')[0].ontouchmove = function(e) {
		//   e.stopPropagation();
		//     //e.cancelBubble = true;
		// };
  },
  render: function() {
		//系统提示
		var systemWrap = $("#J-system-info");
		var systemClose = $("#J-system-close");
		var isTip = new Store("system_tip_show");

		//isTip.remove();

		if(!isTip.get() && common.isInApp){
			$(".no-text").css("padding-top", "90px");
			systemWrap.css("display", "block");
		}
		systemClose.on("click", function(){
			$(".no-text").css("padding-top", "0");
			isTip.set("1");
			systemWrap.hide();
		});

  	//输入框按压事件
		$(".edit-info-input").on("input",function(e) {
			//Hot.limitLength(60);   //一个汉字为三个字符的方法
			var editInfo = $('.edit-info-input').val().length;
			$(".writer-num b").text(editInfo);
		});
		$win.on('scroll load resize', function() {
	    Hot.setMask();
	  });
		//点击底部编辑框弹出键盘输入框
		//校验登陆状态再操作.
  	$(".writer-btn").on("click",function() {
			common.login(GM.islogin, function(){
				$(".writer-btn").hide();
				$(".writer-info").show();
				$(".mask").show();
				document.body.ontouchmove=function(e){
				    e.preventDefault();
				}
				$(".edit-info-input").focus();
	    });
		});
		//取消编辑
		$(".writer-cancel").on("click",function() {
			$(".writer-btn").show();
			$(".writer-info").hide();
			$(".mask").hide();
			document.body.ontouchmove=function(e){
			  e.stopPropagation();
			};
		});

		$(".mask").on("click", function(e) {
			$(".writer-btn").show();
			$(".writer-info").hide();
			$(".mask").hide();
			document.body.ontouchmove=function(e){
			  e.stopPropagation();
			};
		})
		//提交
		$(".writer-submit").on("click",function() {
				if(!GM.islogin) {
					common.login(GM.islogin, function(){
						Hot.postAjax(GM.room_id);
					});
				}else{
					if($(".edit-info-input").val() == ""){
						Toast.alert({"content":"发言内容不能为空"});
						return;
					}
					Hot.postAjax(GM.room_id);
				}
		});
		this.noData();
  },
  //socket数据处理
  getSocketData: function(obj) {
  	// var obj = eval('(' + data + ')'); //字符串转json
		//关闭直播间
		if(obj.et === 3003){
			$(document).trigger('liveend');
		}
		//prepend头部  append尾部
  	$("#J-hotline-wrap").append(_.template( $('#J-hotline-tpl').html(),{datas: obj,userInfo:GM.userInfo,nickname:GM.nickname} ));
 			this.scrollBottom(); 				//自动滚动到底部
 			this.noData();
  },
  limitLength: function(byteLength) {
  	var editText = $(".edit-info-input").val(),
			  length = Hot.getByteLen(editText);
		$(".writer-num b").text(length);
     //当填写的字节数小于设置的字节数
    if (length * 1 <=byteLength * 1){
          return;
    }
    if( length > 60) {
			$(".writer-num b").text(60);
    }
    var valLen = $(".edit-info-input").val().length-1;
    var limitDate = $(".edit-info-input").val().substr(0, valLen);
   	$(".edit-info-input").val(limitDate);
   return;
 	},
	getByteLen: function(val) {
		var len = 0;
		for (var i = 0; i < val.length; i++) {
	    if (val[i].match(/[^\x00-\xff]/ig) != null) //全角
	      len += 3; //如果是全角，占用两个字节  如果mysql中某字段是text, 如果设置编码为utf-8,那么一个中文是占3个字节, gbk是两个字节
	    else
	      len += 1; //半角占用一个字节
		}
		return len;
	},
	//自动滚动到底部
	scrollBottom: function() {
		//自动滚动到底部
  		var $content = $(".hotline-info").height(),
  				$scroll = $(".layout-main");
	   	$scroll.scrollTop($content);
	},
	//遮罩
	setMask: function() {
		$mask.width($win.width());
		$mask.height($win.height() + $win.scrollTop());
	},
	noData: function() {
		var noData = $(".content").text().trim();
		if(noData != "") {
			$(".no-text").hide();
		}else{
			$(".no-text").show();
		}
	},
	socket: function() {
		var self = this;
		var joinData = {
			et: 1000,
			token: GM.token,   //值还没确定
			via: 6,
			match_id: GM.match_id,
			room_id: GM.room_id,
		};
		var isGameStart = false;
		var socketURL = GM.sub_server;
		var socket = io.connect(socketURL);
		socket.on('connect', function(data) {
			socket.emit('join', joinData);
		});
		socket.on('wall',function(data) {
			Hot.getSocketData(data);
		});
	},
	postAjax: function(room_id) {
	  $.ajax({
				//url: "http://dev.videohupu.com/m/room/sub",   //test
				url: "/m/live/sub",//线上
				type: "POST",
				dataType: "json",
				data: {
				    room_id: room_id,
				    content: $(".edit-info-input").val(),
				    match_id: GM.match_id
				},
				success: function(data){
					$(".writer-btn").show();
					$(".writer-info").hide();
					$(".mask").hide();
					$(".writer-num b").text(0);
					$(".edit-info-input").val("");
					document.body.ontouchmove=function(e){
					  e.stopPropagation();
					};
				}
      });
	}
}


module.exports = Hot;
