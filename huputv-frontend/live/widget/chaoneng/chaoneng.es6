var _ = require('common:static/js/underscore/underscore.js');
var Gift = require('live:widget/send-gift/gift.es6');
var VideoPlay = require('live:widget/video-play/video.js');

var ChaoNeng = {
	init: function() {
		this.energyMatch = $("#J-energy-match");
		this.bind();
	},

	bind: function() {
		var self = this;

		this.boxHandle(); // 延迟框
		this.progressAuto(); // 自适应能量条
		this.swiperFn($(".home-skill-swiper")); // 主队技能轮播
		this.swiperFn($(".guest-skill-swiper")); // 客队技能轮播
		this.skillView(); // 技能展示

		$(window).on("resize load", function() {
			self.progressAuto();
		});

		// 添加能量
		this.energyMatch.on("click", ".add-energy-box a", function() {
			var gameid = HTV.chaoneng.id;
			var teamid = parseInt($(this).parents("ul").attr("data-teamid"));
			var number = parseInt($(this).attr("data-number"));

			self.addEnergy(gameid, teamid, true, number);
		});
	},
	getSocketIP: function() {
		return HTV.chaoneng.chaoneng_socket[(Math.random() * HTV.chaoneng.chaoneng_socket
			.length) | 0];
	},
	// 能量条颜色宽度变化
	autoProgressColorWidth: function() {
		var self = this;
		var powerLeft = 0;
		var powerTotal = 0;

		self.energyMatch.find(".progress-inner").each(function() {
			powerLeft = parseInt($(this).parents(".progress").siblings(".skill").find(
				".power-left").text());
			powerTotal = parseInt($(this).parents(".progress").siblings(".skill").find(
				".power-total").data("total"));

			if (powerLeft / powerTotal <= 0.25) {
				$(this).css("background-color", "#c01e2f");
			} else if (powerLeft / powerTotal > 0.25 && powerLeft / powerTotal <=
				0.5) {
				$(this).css("background-color", "#d6576d");
			} else if (powerLeft / powerTotal > 0.5 && powerLeft / powerTotal <=
				0.75) {
				$(this).css("background-color", "#ec6500");
			} else if (powerLeft / powerTotal > 0.75) {
				$(this).css("background-color", "#ffb300");
			}

			if (powerLeft / powerTotal >= 1) {
				$(this).next()
					.removeClass("energy-full energy-nofull")
					.addClass("energy-full");
			} else {
				$(this).next()
					.removeClass("energy-full energy-nofull")
					.addClass("energy-nofull");
			}

			var float = powerLeft / powerTotal;
			float = float > 1 ? 1 : float;
			$(this).css("width", float * 100 + "%");
		});
	},

	// 添加能量
	addEnergy: function(gameid, teamid, ischaoneng, number) {
		var isHomeTeam = teamid == HTV.chaoneng.home_team;
		var giftId = isHomeTeam ? HTV.chaoneng.home_gift : HTV.chaoneng.guest_gift;
		var self = this;
		var homePowerLeft = $(".home-power-left");
		var homePowerTotal = $(".home-power-total");
		var homeAddTip = $(".home-add-tip");

		var guestPowerLeft = $(".guest-power-left");
		var guestPowerTotal = $(".guest-power-total");
		var guestAddTip = $(".guest-add-tip");

		Gift.send(giftId, number, gameid, teamid, ischaoneng, function() {
			if (isHomeTeam) {
				homeAddTip.text("×" + number).show().animate({
					top: -55,
					opacity: 0
				}, 600, function() {
					homeAddTip.css({
						top: -20,
						opacity: 1
					}).hide();
				});
			} else {
				guestAddTip.text("×" + number).show().animate({
					top: -55,
					opacity: 0
				}, 600, function() {
					guestAddTip.css({
						top: -20,
						opacity: 1
					}).hide();
				});
			}
		});
	},

	// 技能浏览
	skillView: function(swiperSelector) {
		$(".skill-container").find(".skill-pic").on("mouseover", function() {
			var skill = {
				name: $(this).parent().attr("data-name"),
				logo: $(this).parent().attr("data-logo"),
				desc: $(this).parent().attr("data-desc"),
				value: $(this).parent().attr("data-value")
			}
			var $skillBox = $(this).parents(".bd").siblings(".skill-side-box");

			$skillBox.find(".skill-logo")
				.attr("src", skill.logo)
				.attr("alt", skill.name)
				.attr("title", skill.name);

			$skillBox.find(".skill-name").text(skill.name);
			$skillBox.find(".skill-value").text(skill.value);
			$skillBox.find(".skill-desc").text(skill.desc);
		});
	},

	// 技能轮播
	swiperFn: function(swiperSelector) {
		var self = this;
		var bSwiper = true;
		var swiper = swiperSelector;
		var slide = swiper.find(".slide").eq(0);
		var swiperInner = swiper.find(".skill-inner");
		var innerWidth = slide.width();
		var prevBtn = swiper.find(".btn-prev");
		var nextBtn = swiper.find(".btn-next");
		var swiperWidth = innerWidth * Math.ceil(swiper.find("li").length / 8);

		//技能数量
		var index = 1,
			slideCount = 8;
		var allSkillCount = swiper.find("li").size();
		//技能屏幕数量
		var allSlideLen = Math.ceil(allSkillCount / slideCount);

		swiperInner.css("width", swiperWidth);

		function autoToggleBtnClass() {
			//不到一屏
			if (allSlideLen <= 1) {
				prevBtn.addClass("disabled");
				nextBtn.addClass("disabled");
			} else {
				//最后一屏
				if (index == allSlideLen) {
					prevBtn.removeClass("disabled");
					nextBtn.addClass("disabled");
				} else {
					//第一屏
					if (index == 1) {
						prevBtn.addClass("disabled");
						nextBtn.removeClass("disabled");
						//其他屏
					} else {
						prevBtn.removeClass("disabled");
						nextBtn.removeClass("disabled");
					}
				}
			}

		}
		autoToggleBtnClass();

		nextBtn.on("click", function() {
			var left = parseInt(swiperInner.css("left"));
			if (swiperWidth - innerWidth + left > 0 && bSwiper) {
				bSwiper = false;
				swiperInner.animate({
					"left": left - innerWidth
				}, 1000, function() {
					bSwiper = true;
					index++;
					autoToggleBtnClass();
				});
			}
		});

		prevBtn.on("click", function() {
			var left = parseInt(swiperInner.css("left"));
			if (innerWidth + left <= 0 && bSwiper) {
				bSwiper = false;
				swiperInner.animate({
					"left": left + innerWidth
				}, 1000, function() {
					bSwiper = true;
					index--;
					autoToggleBtnClass();
				});
			}
		});
	},

	// 能量条自适应
	progressAuto: function() {
		var taskAndGiftWidth = $(".task-and-gift").width(); //总宽度
		var taskBtnWidth = $(".task-left").outerWidth(); //任务按钮宽度
		var teamWidth = this.energyMatch.find(".center").width(); //队伍宽度
		var skillWidth = this.energyMatch.find(".btn-skill").outerWidth(); //技能库宽度
		var othersWidth = 230;

		this.energyMatch.find(".progress").css({
			"width": (taskAndGiftWidth - taskBtnWidth - teamWidth - skillWidth -
				othersWidth) / 2
		});
	},

	// 延迟框
	boxHandle: function() {
		var self = this;
		var interval = null;

		this.energyMatch.on("mouseover", ".mod-btn-box", function() {
			self.energyMatch.find(".mod-box").hide();
			$(this).next().show();
			clearTimeout(interval);
		});

		this.energyMatch.on("mouseout", ".mod-btn-box", function() {
			var that = $(this);
			interval = setTimeout(function() {
				that.next().hide();
			}, 300);
		});

		this.energyMatch.on("mouseover", ".mod-box", function() {
			$(".mod-box").hide();
			$(this).show();
			clearTimeout(interval);
		});

		this.energyMatch.on("mouseout", ".mod-box", function() {
			var that = $(this);
			interval = setTimeout(function() {
				that.hide();
			}, 300);
		});
	},
	skillUpdate: function($container, data){
		var $total = parseInt(data.skill_totlenum, 10);
    var $used  = parseInt(data.skill_usednum , 10);

    var $cls = "";
    //正在使用
    if($used > 0){
      // 购买已使用完
      if($total == $used){
        $cls = "shade";
      }
    } else{
      if($total == 0){
        //未购买状态
        $cls = "gray";
      }
    }
		$container.attr("class", $cls);
		$container.find(".skill-total-num").text($total - $used);
		$container.find(".skill-used-num").text($used);
	},
	wall: function(data) {
		var self = this;

		if(_.isUndefined(data.et)) return;

		if(data.et !== 3009 && data.et !== 3011 && data.et !== 3008 && data.et !== 3013){
			return;
		}

		var roomid = HTV.roomID;
		var gid = HTV.chaoneng.id;
		var sectionNum = parseInt(HTV.chaoneng.game_sectionnum);

		var isGameStart = false;

		//是否主队
		var isHomeTeam = function(teamId) {
				return teamId == HTV.chaoneng.home_team;
			}
			//是否客队
		var isGuestTeam = function(teamId) {
			return teamId == HTV.chaoneng.guest_team;
		}

		switch(data.et) {
      // 更新时间，删除   
      // case 3009:  
	      /**
				 * 时间更新时间
				 * {"room":"hupuTv","type":"chaoneng","room_id":"28","game_id":"5","section":"1","minute":"00","second":"00","time_str":"第1节 00:00"}
				 */
	    
				// if (self.energyMatch.find(".show-vs").size() || isGameStart) {
				// 	isGameStart = true;
				// 	self.energyMatch.find(".show-vs").remove();
				// 	self.energyMatch.find(".J-score").show();
				// }
	    
				// var section = parseInt(data.sec);
				// var showSectionNum = section > sectionNum ? section - sectionNum :
				// 	section;
				// var showSection = section > sectionNum ? ("加时" + showSectionNum) : ("第" +
				// 	showSectionNum + "节");
	    
				// self.energyMatch.find(".section-num").text(showSection);
				// if (data.min == "00" && data.s == "00") {
				// 	self.energyMatch.find(".section-time").text('已结束');
				// } else {
				// 	self.energyMatch.find(".section-time").text(' ' + data.min + ":" +
				// 		data.s);
				// }
	      // break;
	    // 技能使用 
	    case 3011:
	    	/**
				 * 技能卡使用
				 * {"room":"chaoneng","type":"hupuTv","room_id":"28","game_id":"4","skill_name":"Jrs祝福","skill_logo":"http://c1.hoopchina.com.cn/uploads/star/newuser/160111/fcd5354b858f5c25122adcba3f8e45de49f7feed.png","skill_value":"5","skill_visible":"1"}
				 */
				var teamName = isHomeTeam(data.team_id) ? "home" : "guest";
				var skill = "#" + teamName + "_skill_" + data.skill_id;
		
				data.isHomeTeam = isHomeTeam(data.team_id);
				data.teamName = data.isHomeTeam ? HTV.chaoneng.home_team_info.cn_name : HTV.chaoneng.guest_team_info.cn_name;
				if (data.skill_status) {
					VideoPlay.callFromJS({
						key: "skillcardOnline",
						data: data
					});
					$(skill).find(".active").show();
				} else {
					VideoPlay.callFromJS({
						key: "skillcardOffline",
						data: data
					});
					$(skill).find(".active").hide();
				}
	    	break;
	    // 能量值变化
	    case 3008:
		  	/**
				 * 能量变更事件
				 * {"room":"chaoneng","type":"hupuTv","room_id":"28","game_id":"4","team_id":"1","power":335}
				 */
				if (isHomeTeam(data.tid)) {
					self.energyMatch.find(".home-power-total").text(data.tp);
					self.energyMatch.find(".home-power-left").text(data.lp);
				} else {
					self.energyMatch.find(".guest-power-total").text(data.tp);
					self.energyMatch.find(".guest-power-left").text(data.lp);
				}

				self.autoProgressColorWidth();
	    	break;
	    // 技能更新
	    case 3013:
		  	/**
				 * 技能卡变更事件
				 * {"room":"chaoneng","type":"hupuTv","room_id":"28","game_id":"4","skill_id":"16","team_id":"1","skill_totlenum":"100","skill_usednum":18}
				 */
				var teamName = isHomeTeam(data.team_id) ? "home" : "guest";
				var skill = "#" + teamName + "_skill_" + data.skill_id;
				// 全部剩余技能角标数量展示.
				var sum_able = parseInt(data.sum_able);
				var skillNumId = "." + teamName + "-skill-num";
				if (sum_able) {
					$(skillNumId).show().text(sum_able);
				} else {
					$(skillNumId).hide();
				}

				//更新技能状态样式
				self.skillUpdate($(skill), data);
	    	break;
    }

		// return;

		// socket.on('skillcardused', function(msg) {
		// 	/**
		// 	 * 技能卡使用
		// 	 * {"room":"chaoneng","type":"hupuTv","room_id":"28","game_id":"4","skill_name":"Jrs祝福","skill_logo":"http://c1.hoopchina.com.cn/uploads/star/newuser/160111/fcd5354b858f5c25122adcba3f8e45de49f7feed.png","skill_value":"5","skill_visible":"1"}
		// 	 */
		// 	var teamName = isHomeTeam(data.team_id) ? "home" : "guest";
		// 	var skill = "#" + teamName + "_skill_" + data.skill_id;
		// 	var liveData = {
		// 		lineType: "use"
		// 	};
		// 	liveData.teamname = teamName == "home" ? HTV.chaoneng.home_team_info.cn_name :
		// 		HTV.chaoneng.guest_team_info.cn_name;
		// 	liveData.name = data.skill_name;

		// 	data.isHomeTeam = isHomeTeam(data.team_id);
		// 	data.teamName = data.isHomeTeam ? HTV.chaoneng.home_team_info.cn_name :
		// 		HTV.chaoneng.guest_team_info.cn_name;
		// 	if (data.skill_status) {
		// 		Chatroom.renderLive([liveData], true);
		// 		VideoPlay.callFromJS({
		// 			key: "skillcardOnline",
		// 			data: msg.data
		// 		});
		// 		$(skill).find(".active").show();
		// 	} else {
		// 		VideoPlay.callFromJS({
		// 			key: "skillcardOffline",
		// 			data: msg.data
		// 		});
		// 		$(skill).find(".active").hide();
		// 	}
		// });

		// socket.on('skillcardupdate', function(msg) {
		// 	/**
		// 	 * 技能卡变更事件
		// 	 * {"room":"chaoneng","type":"hupuTv","room_id":"28","game_id":"4","skill_id":"16","team_id":"1","skill_totlenum":"100","skill_usednum":18}
		// 	 */
		// 	var teamName = isHomeTeam(data.team_id) ? "home" : "guest";
		// 	var skill = "#" + teamName + "_skill_" + data.skill_id;
		// 	// 全部剩余技能角标数量展示.
		// 	var sum_able = parseInt(data.sum_able);
		// 	var skillNumId = "." + teamName + "-skill-num";
		// 	if (sum_able) {
		// 		$(skillNumId).show().text(sum_able);
		// 	} else {
		// 		$(skillNumId).hide();
		// 	}

		// 	//更新技能状态样式
		// 	self.skillUpdate($(skill), msg.data);
		// });

		// socket.on('skillcardbuy', function(msg) {
		// 	/**
		// 	 * 技能卡购买事件
		// 	 * {"room":"chaoneng","type":"hupuTv","room_id":"28","game_id":"4","skill_id":"16","team_id":"1","skill_totlenum":"100","skill_usednum":18}
		// 	 */
		// 	var liveData = {
		// 		lineType: "buy"
		// 	};
		// 	liveData.teamname = isHomeTeam(data.team_id) ? HTV.chaoneng.home_team_info
		// 		.cn_name : HTV.chaoneng.guest_team_info.cn_name;
		// 	liveData.name = data.skill_name;
		// 	liveData.count = 1;

		// 	Chatroom.renderLive([liveData], true);
		// });

		// socket.on('score', function(msg) {
		// 	/**
		// 	 * 比分事件
		// 	 *{"room":"chaoneng","type":"hupuTv","room_id":"28","game_id":"6","home_score":28,"guest_score":28}
		// 	 */
		// 	var homeScore = parseInt(data.home_score) > 0 ? data.home_score :
		// 		0;
		// 	var guestScore = parseInt(data.guest_score) > 0 ? data.guest_score :
		// 		0;

		// 	self.energyMatch.find(".home-score").text(homeScore);
		// 	self.energyMatch.find(".guest-score").text(guestScore);
		// });

		// socket.on('power', function(msg) {
		// 	/**
		// 	 * 能量变更事件
		// 	 * {"room":"chaoneng","type":"hupuTv","room_id":"28","game_id":"4","team_id":"1","power":335}
		// 	 */
		// 	if (isHomeTeam(data.team_id)) {
		// 		self.energyMatch.find(".home-power-total").text(data.total_power);
		// 		self.energyMatch.find(".home-power-left").text(data.power);
		// 	} else {
		// 		self.energyMatch.find(".guest-power-total").text(data.total_power);
		// 		self.energyMatch.find(".guest-power-left").text(data.power);
		// 	}

		// 	self.autoProgressColorWidth();
		// });

	}
};

module.exports = ChaoNeng;
