$(function () {
	if($("#table_list_two").length>0){
	  table_list.init();//顶部表格左右滚动效果1
	}else{
	  table_list_two.init();//顶部表格左右滚动效果2
	}

    //比赛预测数据获取
	if($(".play_rule").length > 0){
		team_rank.init();//比赛预测数据获取
    }

    //赞队伍
	voteTeam.init();
	table_list_live.init();//表格鼠标滑动加背景
	font_Interval.init();//获取文字直播
	team_home.init();//球队主页
	postfix.init();//随页面滚动
	//$.feedback();//新版吐槽
	setTimeout(function(){
        players_home.init();
	},500);

});

var host = 'https://'+window.location.host;
var table_list = {//顶部表格左右滚动
	num:0,
	pages:0,
	preOffset:0,
	nextOffset:0,
	init:function(){
		var table = $(".table_list_c").find("ul"),
		    width = table.find("li").length * table.find("li").eq(0).outerWidth();
            table.css({
               width:width
            });

            table.find("li").hover(function(){
				$(this).css({
					"backgroundColor":"#fff"
				});
			},function(){
	            $(this).removeAttr("style");
			});
            this.left = table.find("li").eq(0).outerWidth() * 7;
            this.bindFun();
	},
	bindFun:function(){
		var table = $(".table_list_c").find("ul"),that = this,
		    obj1 = $(".table_list").find(".table_list_l"),
		    obj2 = $(".table_list").find(".table_list_r2"),
		    dateStr = obj1.attr("date"),
		    ajaxloding;
	   obj1.hover(function(){
          $(this).removeClass().addClass("table_list_l2");
       },function(){
       	  $(this).removeClass().addClass("table_list_l");
       });

	   obj2.hover(function(){
          $(this).removeClass().addClass("table_list_r");
       },function(){
       	  $(this).removeClass().addClass("table_list_r2");
       });

		obj1.click(function(){
			if(ajaxloding){
				return false;
			}
            that.pages--;
		    if(that.num > 0){
		    	var left = --that.num * -that.left;
		    	table.stop().animate({
				    left:left
				},"slow");
		    }else{
			    ajaxloding = true;
                $.ajax({
				   type: "GET",
				   url: host + "/schedule/count/"+$(this).attr("date"),
				   data: {
					   offset: --that.preOffset
				   },
				   success: function(data){
					 var tmp = "";
					 var html = "";
					 for(key in data.data){
						 tmp = [
	 						"<li><a href='"+data.data[key].link+"'>",
	 							"<p>"+data.data[key].week+"</p>",
	 							"<div class='team'>",
	 								"<span class='name'>"+key.substring(5)+"</span>",
	 							"</div>",
	 							"<div class='team2 border'>",
	 								"<span class='name'>"+data.data[key].count+"场比赛</span>",
	 							"</div>",
	 						"</a></li>"
	 					 ].join("");
						 html += tmp;
					 }
				   	 that.num = 0;
				     table.prepend(html);
		             table.css({
		               width:table.find("li").length * table.find("li").eq(0).outerWidth(),
		               left:-that.left
		             });
				     table.stop().animate({
					    left:0
					 },"slow");
					 ajaxloding = false;
				   }
				});
		     }
		});

		obj2.click(function(){
			if(ajaxloding){
				return false;
			}
		    that.pages++;
		    that.listnum = parseInt(table.find("li").length/7) + (table.find("li").length%7 > 0?1:0);
		    if(that.num < that.listnum-1){
		    	var left = ++that.num * -that.left;
		    	table.stop().animate({
				    left:left
				},"slow");
		    }else{
			    ajaxloding = true;
                $.ajax({
				   type: "GET",
				   url: host + "/schedule/count/"+$(this).attr("date"),
				   data: {
					   offset: ++that.nextOffset
				   },
				   success: function(data){
				     var left = ++that.num * -that.left;
					 var tmp = "";
					 var html = "";
					 for(key in data.data){
						 tmp = [
	 						"<li><a href='"+data.data[key].link+"'>",
	 							"<p>"+data.data[key].week+"</p>",
	 							"<div class='team'>",
	 								"<span class='name'>"+key.substring(5)+"</span>",
	 							"</div>",
	 							"<div class='team2 border'>",
	 								"<span class='name'>"+data.data[key].count+"场比赛</span>",
	 							"</div>",
	 						"</a></li>"
	 					 ].join("");
						 html += tmp;
					 }
				     table.append(html);
		             table.css({
		               width:table.find("li").length * table.find("li").eq(0).outerWidth()
		             });
                    table.stop(true).animate({
					    left:left
					 },800);
					 ajaxloding = false;
				   }
				});
		    }
		});
	}
};

var table_list_two = {//顶部表格左右滚动
	num:0,
	init:function(){
		var table = $(".table_list_c").find("ul"),
		    width = table.find("li").length * table.find("li").eq(0).outerWidth();
            table.css({
               width:width
            });
            table.find("li").hover(function(){
				$(this).css({
					"backgroundColor":"#fff"
				});
			},function(){
	            $(this).removeAttr("style");
			});
            this.listnum = parseInt(table.find("li").length/7) + (table.find("li").length%7 > 0?1:0);
            this.left = table.find("li").eq(0).outerWidth() * 7;
            this.bindFun();
	},
	bindFun:function(){
		var table = $(".table_list_c").find("ul"),that = this,
		    obj1 = $(".table_list").find(".table_list_l"),
		    obj2 = $(".table_list").find(".table_list_r2");

		obj1.hover(function(){
          $(this).removeClass().addClass("table_list_l2");
       },function(){
       	  $(this).removeClass().addClass("table_list_l");
       });

		obj2.hover(function(){
          $(this).removeClass().addClass("table_list_r");
       },function(){
       	  $(this).removeClass().addClass("table_list_r2");
       });

		obj1.click(function(){
			that.num > 0?that.num--:"";
			var left = -that.left*that.num;
			table.stop().animate({
			   left:left
			},"slow");
		});

		obj2.click(function(){
			that.num < that.listnum-1?that.num++:"";
			var left = -that.left*that.num;
			table.stop().animate({
			   left:left
			},"slow");
		});
	}
};

// 预测
var gameCentervote = {
	init:function(){
		var yuece_num_a = $(".yuece_num_a"),
            num = yuece_num_a.find("#num_1").html();
		this.widthObj = yuece_num_a.find(".bg_repert_b");

		if(num == "100%"){
       	  this.widthObj.css({
		       width:num,
		       borderRadius:"5px"
		  });
       }else{
       	  this.widthObj.css({
		       width:num,
		       borderRadius:"5px 0 0 5px"
		  });
       }
		this.bindFun();
	},
	bindFun:function(){
		var yuece_num_a = $(".yuece_num_a"),that = this,
		    uid = $.cookie("ua"),
		    matchid = yuece_num_a.attr("matchid");
            yuece_num_a.find(".a").click(function(){
            	if(uid * 1 != 0){
			       that.getJson($(this),[uid,matchid,1]);
				}else{
				   $(this).tips("请先登录");
				}
			});
			yuece_num_a.find(".c").click(function(){
	           if(uid * 1 != 0){
			       that.getJson($(this),[uid,matchid,2]);
				}else{
				   $(this).tips("请先登录");
				}
			});
	},
	getJson:function(obj,arr){
		var that = this;
        var params = {
            gid:arr[1],
            predict: obj.attr("id"),
			type: 1
        };

        $.getJSON("http://m.hupu.com/predict/add?callback=?", params, function(data) {
            switch(data.code * 1){
			    case 200: //投票成功
			       if(data.data.width * 1 == "100"){
			       	  that.widthObj.css({
					       width:data.data.width + '%',
					       borderRadius:"5px"
					  });
			       }
                   else{
			       	  that.widthObj.css({
					       width:data.data.width + '%',
					       borderRadius:"5px 0 0 5px"
					  });
			       }

			       var num = 100 - data.data.width * 1,
			           nums = new Number(Math.round(num*100)/100).toFixed(2) + "%";

				   $(".yuece_num_a").find("#num_1").html(data.data.width+"%");
				   $(".yuece_num_a").find("#num_2").html(nums);
				   $(".yuece_num_a").find(".num_pop").html(data.data.awayVote*1 + data.data.homeVote*1);
				   obj.tips("预测成功");
				   $(".play_rule .content").find("p").eq(0).show().html("您本场预测:"+(arr[2]*1 == 1?homeTeamName:awayTeamName)+"胜");
				   $(".play_rule .content").find(".bai").eq(0).html(data.data.width+"%");
				   $(".play_rule .content").find(".bai").eq(1).html(nums);
	               break;
			    case 400:  //已经预测
                   obj.tips("已经预测");
	               break;
			    case 401:  //参数错误
			       obj.tips("参数错误");
	               break;
	            case 402:  //请先登录
			       obj.tips("请先登录");
	               break;
			    default :
			       obj.tips("参数错误");
			}
        });
	}
};

// 赞投票
var voteTeam = {
	init:function(){
       this.num1 = $(".team_vs_good").find(".team_a").find("b");
       this.num2 = $(".team_vs_good").find(".team_b").find("b");
       $(".team_vs_good").find(".d").css({
       	  width:this.getPercent(this.num1.html(),this.num2.html())
       });
       this.bindFun();

	  if(typeof(is_boxscore)!="undefined" ||  typeof(is_playbyplay)!="undefined"){
	  	 this.replaceDom();
	  }

	},
	bindFun:function(){
		var that = this,team = $(".team_vs_good")
		    teamId = team.attr("matchid"),
		    tips_layes = $(".tips_layes");
		team.delegate(".a","click",function(){
            that.getJson([teamId,"home"],team);
		});
		team.delegate(".c","click",function(){
            that.getJson([teamId,"away"],team);
		});

		tips_layes.live("mouseover",function(){
           $(this).find(".tips_tems").show();
           $(this).css({
           	  color:"#000"
           });
		});
		tips_layes.live("mouseout",function(){
           $(this).find(".tips_tems").hide();
           $(this).css({
           	  color:"#999"
           })
		});
	},
	getJson:function(str,obj){
         $.getJSON(host + "/node/team/vote/" + str[0] + '/' + str[1],function(data){
         	  obj.find(".b").find(".d").css({
         	  	 width:data.width
         	  });
              obj.find(".team_a").find("p b").html(data.home_vote);
              obj.find(".team_b").find("p b").html(data.away_vote);
	      });
	},
	replaceDom:function(){
		var that = this;
		function getjsons(type){
			that.t = setInterval(function(){
	              $.getJSON(host + "/nba/homepage/getMatchBasicInfo?matchId="+matchId,function(data){
                       switch(data.status*1){
							case 200:
							  $(".team_vs").remove();
		                       $(".yuece_num").remove();
		                       $(".top_bg").after(data.html);
							  break;
							case 500:
							  return false;
							  break;
							case 600:
							  clearInterval(that.t);
							  break;
							default:
						}
			      });

                  if(type == "on"){
	                  	$.getJSON(host + "/nba/boxscore/ajaxGetTeamStats?matchId="+matchId,function(data){
	                       switch(data.status*1){
								case 200:
								  $(".table_list_live").remove();
								  $(".box_a").eq(0).after(data.html);
								  break;
								case 500:
								  return false;
								  break;
								case 600:
								  break;
								default:
							}
				       })
                  }
	        },9000);
		}
		if(typeof(is_playbyplay)!="undefined" && is_live){
			getjsons();
		}

		if(typeof(is_boxscore)!="undefined" && is_live){
			getjsons("on");
		}
	},
	getPercent:function(num, num2){
	    var num = parseFloat(num),
            num2 = parseFloat(num2),
            total = num + num2;
	        if (isNaN(num) || isNaN(total)) {
	            return "-";
	        };
	        return Math.round(num / total * 10000) / 100.00 + "%";
	}
}

//比赛预测数据获取
var team_rank = {
	init:function() {
		var obj = $(".gamecenter_content_r .play_rule .content"),
		    uid = $.cookie("ua"),
		    next_game_play = $(".next_game_play");

		if (uid*1 != 0) {
			$.getJSON("http://m.hupu.com/predict/getuserpredictinfo?callback=?", {matchId:matchId}, function(data) {
                if (data.status == 200) {
                    obj.find(".bai").eq(0).text(data.data.hometeamper + '%');
                    obj.find(".bai").eq(1).text(data.data.awayteamper + '%');

                    var leftyuce = $(".yuece_num .yuece_num_a .b");
                    leftyuce.find(".num_pop").text(data.data.total);
                    leftyuce.find("#num_1").text(data.data.hometeamper + '%');
                    leftyuce.find("#num_2").text(data.data.awayteamper + '%');

                    obj.find(".yuce").html('<span class="a">您的预测战绩：'+data.data.winNum+'/'+data.data.allNum+'</span> 准确率：'+data.data.width+ '%');

                    if(data.data.predictName != ""){
                        obj.find("p").eq(0).show().html("您本场预测:"+(data.data.predictName*1 == 1?homeTeamName:awayTeamName)+"胜");

                    }

                    //预测输赢
                    gameCentervote.init();
                }
		    });
		}

		next_game_play.find("p").hover(function(){
            $(this).addClass("bgimg");
		},function(){
			$(this).removeClass("bgimg");
		});
	}
}

var postfix = {//随页面滚动
	init:function(){
        this.po = $(".table_list");//.postfix
        if(this.po.length > 0){
            this.top = this.po.offset().top;
            this.bindFun();
        }
	},
	bindFun:function(){
     var that = this,
         bgs_png = $(".bgs_png");
         bgs_png.css({
         	width:that._getpageSize()[0]
         });
     if($(document).height() > 1300){
	     $(window).scroll(function(){
	         if(that.getpageScroll() > that.top){
	             that.po.addClass("postfix");
	             bgs_png.show();
	         }else{
	             that.po.removeClass("postfix");
	             bgs_png.hide();
	         };
	     });
	  }
    },
    getpageScroll: function() {
        var yScrolltop;
        if (self.pageYOffset) {
            yScrolltop = self.pageYOffset;
        } else if (document.documentElement && document.documentElement.scrollTop) {
            yScrolltop = document.documentElement.scrollTop;
        } else if (document.body) {
            yScrolltop = document.body.scrollTop;
        }
        return yScrolltop;
    },
    _getpageSize: function() {//获取窗口大小
        var de = document.documentElement, arrayPageSize,
                w = window.innerWidth || self.innerWidth || (de && de.clientWidth) || document.body.clientWidth,
                h = window.innerHeight || self.innerHeight || (de && de.clientHeight) || document.body.clientHeight;
        arrayPageSize = [w, h]
        return arrayPageSize;
    }
}

var team_table = {//
   num:0,
   init:function(){
   	  var post_click_a = $(".post_click_a"),
   	      post_click_b = $(".post_click_b");
   	      post_click_a.css({
              opacity:0.5
   	      });
   	      post_click_b.css({
              opacity:0.5
   	      });
   	   this.bindFun();
   	   this.video();
   },
   bindFun:function(){
   	  var that =  this,box_post = $("#table_post"),
   	      box_post2 = $("#table_post2"),
   	      post_click_a = $(".post_click_a"),
   	      post_click_b = $(".post_click_b"),
   	      obj = box_post2.find(".x_title").find("span"),
   	      obj2 = $(".team_list_data .jiben_title_table");
   	    this.listnum = parseInt(obj.length/5) + (obj.length%5 > 0?1:0);
	    if(this.listnum <= 1){
	    	return false;
	    }

	    this.left = obj.eq(0).outerWidth() * 5;
        box_post2.css({
           width:this.left * this.listnum + 100
   	    });

   	    post_click_a.hover(function(){
            $(this).css({
              opacity:1
            });
   	    },function(){
   	    	$(this).css({
              opacity:0.5
            });
   	    });

   	    post_click_b.hover(function(){
            $(this).css({
              opacity:1
            });
   	    },function(){
   	    	$(this).css({
              opacity:0.5
            });
   	    });

        $(".team_list_data").find(".jiben_title").find("span").click(function(){
               $(this).addClass("on");
               $(this).siblings().removeClass("on");
               if($(this).attr("att") == "more"){
               	  post_click_b.show();
               	  box_post.hide();
               	  box_post2.show();
               	  obj2.find(".c").show();
               }else{
               	  post_click_a.css({
               	  	opacity:0.5
               	  }).hide();
               	  post_click_b.css({
               	  	opacity:0.5
               	  }).hide();
               	  that.num = 0;
               	  box_post2.css({
               	  	left:0
               	  });
               	  obj2.find(".c").hide();
               	  box_post.show();
               	  box_post2.hide();
               }
        });

	    post_click_a.css({
	    	top:parseInt(obj2.outerHeight()/2) - 24
	    }).click(function(){
			that.num > 0?that.num--:"";
			var left = -that.left*that.num;
			box_post2.stop().animate({
			   left:left
			},"slow");
			if(that.num == 0){
				$(this).hide();
			}
			if(that.num == 0 || that.num < that.listnum-1){
				post_click_b.show();
			}
		});

		post_click_b.css({
			top:parseInt(obj2.outerHeight()/2) - 24
		}).click(function(){
			that.num < that.listnum-1?that.num++:"";
			var left = -that.left*that.num;
			box_post2.stop().animate({
			   left:left
			},"slow");
			if(that.num > 0){
				post_click_a.show();
			}
			if(that.num == that.listnum-1){
				$(this).hide();
			}
		});

		$(".team_list_data").find(".jiben_title").find("span").eq(1).click();
   },
   video:function(){
   	  var obj = $(".gamecenter_content_r").find(".video_box").find("li");
   	  obj.hover(function(){
           $(this).css({
              backgroundColor:"#f2f2f2"
           });
   	  },function(){
   	  	  $(this).css({
              backgroundColor:"#fff"
           });
   	  });
   }
}

var table_list_live = {
	init:function(){
		this.bindFun();
	},
	bindFun:function(){
		var obj = $(".table_list_live").find("table");
		obj.delegate("tr","mousemove",function(){
			$(this).css({
				backgroundColor:"#FBFBFB"
			})
		});

		obj.delegate("tr","mouseout",function(){
			if(!$(this).hasClass("bg_a") && !$(this).hasClass("pause")){
               $(this).css({
					backgroundColor:"#ffffff"
				})
			}
		});
	}
}

var font_Interval = {
	init:function(){
		this.obj = $(".table_overflow").find("table");
		if(this.obj.attr("matchstatus") == "in"){
			this.getAjax();
		}
	},
	getAjax:function(){
		var that = this,
		    sid,
		    s_count,
		    match_id = that.obj.attr("matchid"),
		    t = 3000;
		function setInt(time,datas){
            that.set = setInterval(function(){
			   sid = that.obj.find("tr").eq(0).attr("sid"),
			   s_count = that.obj.find("tr").length;
	           $.ajax({
				   type: "GET",
				   url: host + "/node/playbyplay/matchLives",
				   data: datas?datas:"sid="+sid+"&s_count="+s_count+"&match_id="+match_id+"&homeTeamName="+encodeURIComponent(homeTeamName)+"&awayTeamName="+encodeURIComponent(awayTeamName),
				   success: function(data){
					   	if(data == "over"){
					   		clearInterval(that.set);
					   		return false;
					   	}
					   	if(datas){
					   		clearInterval(that.set);
					   		that.obj.find("tbody").html("");
					   		setInt(t);
					   	}
		                that.obj.find("tbody").prepend(data);
				   }
				});
			},time);
		}
		setInt(t);
		setInterval(function(){
		   clearInterval(that.set);
           setInt(t,"sid=0&s_count=0&match_id="+match_id+"&homeTeamName="+encodeURIComponent(homeTeamName)+"&awayTeamName="+encodeURIComponent(awayTeamName));
		},70000);
	}
}

var team_home = {
	init:function(){
		var obj = $(".region_box"),
		    team = $(".region_box").find(".tiltle").attr("conference");
		    show = $(".itinerary_table_show");
		if(team == "E"){
			obj.find(".tiltle").find("span").eq(0).css({
            	backgroundColor:"#FBFBFB",
            	color:"#444444"
            });
            obj.find(".tiltle").find("span").eq(1).css({
            	backgroundColor:"#F2F2F2",
            	color:"#999999"
            });
            show.hide();
            show.eq(0).show();
		}else{
			obj.find(".tiltle").find("span").eq(1).css({
            	backgroundColor:"#FBFBFB",
            	color:"#444444"
            });
            obj.find(".tiltle").find("span").eq(0).css({
            	backgroundColor:"#F2F2F2",
            	color:"#999999"
            });
            show.hide();
            show.eq(1).show();
		}
		if(obj){
			obj.find(".tiltle").find("span").click(function(){
                $(this).css({
                	backgroundColor:"#FBFBFB",
                	color:"#444444"
                });

                $(this).siblings().css({
                    backgroundColor:"#F2F2F2",
                    color:"#999999"
                });
                show.hide();
                show.eq($(this).index()).show();
			});
		}
	}
}

var teamList = {
	init:function(){
		this.bindFun();
	},
	bindFun:function(){
		var obj = $(".teamlist_box_r").find(".team").find(".box"),
		    obj2 = $(".teamlist_box_r").find(".all").find(".a span");
		obj.hover(function(){
			$(this).addClass("on");
			$(this).parents(".team").prev().find("span").addClass("on");
		},function(){
			obj2.removeClass("on");
			obj.removeClass("on");
		});
	}
}

var playersList = {
	init:function(){
		this.bindFun();
	},
	bindFun:function(){
		var obj = $(".players_list").find("li");
		obj.click(function(){
            window.location = $(this).find("a").attr("href");
		});
	}
}

var players_home = {
	tables:false,
	atm:0,
	atr:0,
	init:function(){
		if($(".table_chick").length > 0){
			this.tbchoose();
			this.bindFun();
		}
	},
	tbchoose:function(){
		var obj = $("#in_box");
         function chiecks(){
	   	  	obj.height("auto");
		 	if($(".shengyasai_tables").height() < 490){
	        	obj.find(".loding_more").hide();
	        }else{
	        	obj.height(485)
	        	obj.find(".loding_more").show();
	        	obj.find(".loding_more").find(".list_a").show();
	        	obj.find(".loding_more").find(".list_b").hide();
	        	obj.find(".loding_more").attr("click","false");
	        }
		 }

		 chiecks();

	   	  var clickchoose = $(".clickchoose"),
	   	      shengyasai = $(".shengyasai"),
	   	      list_table_box = $(".J_p_l");
	   	  clickchoose.click(function(){
	          clickchoose.addClass("title_border2");
	          clickchoose.find(".title_font").addClass("title_font2");
	          $(this).removeClass("title_border2");
	          $(this).find(".title_font").removeClass("title_font2");
		      shengyasai.hide();
		      shengyasai.eq($(this).attr("atm")).show();
		      shengyasai.eq($(this).attr("atm")).find(".team_qushi").find(".on").click();
		      list_table_box.hide();
		      list_table_box.eq($(this).attr("atm")).show();
	   	  	  chiecks();
		      players_home.atm = $(this).attr("atm");
	   	  });


	   	  var Js_click_c = $(".Js_click_c"),
	   	      Js_showtable = $(".Js-show-table"),
	   	      Js_show_line = $(".Js_show_line"),
	   	      Js_playe_table = $(".Js_playe_table");
	   	  Js_click_c.click(function(){

	   	  	  Js_click_c.addClass("title_border2");
	          Js_click_c.find(".title_font").addClass("title_font2");
	          $(this).removeClass("title_border2");
	          $(this).find(".title_font").removeClass("title_font2");
	   	  	  if($(this).attr("atr")*1 == 0){
	   	  	  	  Js_showtable.hide();
	   	  	  	  Js_showtable.eq(0).show();
	   	  	  	  Js_show_line.hide();
	   	  	  	  Js_show_line.eq(0).show();
	   	  	  }else{
	   	  	  	  Js_showtable.hide();
	   	  	  	  Js_showtable.eq(1).show();
	   	  	  	  Js_show_line.hide();
	   	  	  	  Js_show_line.eq(1).show();
	   	  	  }

	   	  	  if(!Js_playe_table.is(":hidden")){
	   	  	  	  Js_playe_table.find(".loding_more").show();
		   	  	    Js_playe_table.find(".loding_more").find(".list_a").show();
		        	Js_playe_table.find(".loding_more").find(".list_b").hide();
		        	Js_playe_table.find(".loding_more").attr("click","false");
			      if($(".all_tables_check").height()*1 < 450){
		              	 Js_playe_table.height("auto");
		              	 Js_playe_table.find(".loding_more").hide();
	              }else{
	              	 Js_playe_table.height(485);
	              }
	   	  	  }
              players_home.atr = $(this).attr("atr");
	   	  });

          Js_click_c.eq(0).click();
	},
	bindFun:function(){
		var obj = $(".table_chick"),
		    obj2 = $(".table_chick2"),
		    tables_check2 = $(".tables_check2"),
		    tables_check = $(".tables_check"),
		    that = this;

		obj.eq(0).click(function(){
			tables_check2.css("height","auto");
            tables_check.hide();
            tables_check2.show();
            $(this).hide();
            obj2.eq(0).show();
			if(tables_check2.find(".list_b").is(":hidden") && tables_check2.height() > 490){
				tables_check2.height(485);
			}

			$(".Js_click_c").eq(that.atr).click();
			if((!!$.browser.msie && parseInt($.browser.version) <= 6)){
				if(!$(".Js_click_c").eq(1).hasClass('title_border2')){
					$(".Js_click_c").eq(1).click();
				}
				if(!$(".Js_click_c").eq(0).hasClass('title_border2')){
					$(".Js_click_c").eq(0).click();
				}
			}
		});

		obj2.eq(0).click(function(){
            tables_check.show();
            tables_check2.hide();
            $(this).hide();
            obj.eq(0).show();
            $(".Js_show_line").eq(that.atr).find(".team_qushi").find(".on").click();
		});

		obj.eq(1).click(function(){
			$(".shengyasai_tables").show();
			$(".shengyasai_line").hide();
			$(this).hide();
            obj2.eq(1).show();
            that.tables = true;
		});

		obj2.eq(1).click(function(){
            $(".shengyasai_tables").hide();
			$(".shengyasai_line").show();
			$(this).hide();
            obj.eq(1).show();
            that.tables = false;
            $(".shengyasai").eq(that.atm).find(".team_qushi").find(".on").click();
		});
		console.log(12)

		$(".loding_more").click(function(){
             if($(this).attr("click") == "false"){
            	 $(this).parent().height(485);
	             $(this).find(".list_a").show();
	             $(this).find(".list_b").hide();
	             $(this).attr("click","false");
	         }else{
	         	 $(this).parent().height($(this).parent().find(".all_tables_check").height());
	             $(this).find(".list_a").hide();
	             $(this).find(".list_b").show();
	             tableChoose = true;
	             $(this).attr("click","true");
	         }
		});

	}
}

;(function($){
	function tips(a) {
        return this.each(function() {
            var $this = $(this),
                str = '<div class="tips_layer" style="position: absolute; background-color:#ff6600; display:none; z-index:100">\
                  <div class="tips-text" style="padding:5px; color:#fff;">'+a+'</div>\
                  <div class="diamond"></div>\
              </div>';
             if($(".tips_layer")){
             	$(".tips_layer").remove();
             }
            $(str).appendTo("body");
            var $tips_text = $(".tips-text"),
                    $tips_layer = $(".tips_layer");
            $tips_layer.css({
                "top": $this.offset().top - parseInt($tips_layer.outerHeight()),
                "left": $this.offset().left
            }).fadeIn();

            setTimeout(function(){
               $tips_layer.remove();
            },1500);
            /*
             a.time ? t = setTimeout(function() {
             $tips_layer.stop(true).fadeOut();
             }, a.time) : "";
             */
        })
    }

    $.fn.extend({
	    tips:tips
	});
	$.extend({
        cookie:function(name, value, options){//cookie
            if (typeof value != 'undefined') {
                options = options || {};
                if (value === null) {
                    value = '';
                    options.expires = -1;
                }
                var expires = '';
                if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
                    var date;
                    if (typeof options.expires == 'number') {
                        date = new Date();
                        date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
                    } else {
                        date = options.expires;
                    }
                    expires = '; expires=' + date.toUTCString();
                }
                var path = options.path ? '; path=' + options.path : '';
                var domain = options.domain ? '; domain=' + options.domain : '';
                var secure = options.secure ? '; secure' : '';
                document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
            } else {
                var cookieValue = null;
                if (document.cookie && document.cookie != '') {
                    var cookies = document.cookie.split(';');
                    for (var i = 0; i < cookies.length; i++) {
                        var cookie = $.trim(cookies[i]);
                        if (cookie.substring(0, name.length + 1) == (name + '=')) {
                            cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                            break;
                        }
                    }
                }
                return cookieValue;
            }
        }
    });
})(jQuery);

;(function($,win,doc){
	$.ui = $.ui || {};
    $.extend($.ui, {//合并方法到$.ui方便使用
        _showMasks: function(a) {//显示遮罩 a:遮罩透明度
            var str = "<div class='body-mask' style='position:absolute; top:0; left:0; width:100%; height:" + $(document).height() + "px; background-color:#000;  z-index:98;'></div>";
            $("body").append(str);
            $(".body-mask").css("opacity", 0);
            $(".body-mask").animate({
                "opacity": a ? a : "0.8"
            });
        },
        _closeMasks: function() {//关闭遮罩
            var close = $(".body-mask");
            close.fadeOut(function() {
                close.remove();
            });
        },
        _getpageSize: function() {//获取窗口大小
            var de = doc.documentElement, arrayPageSize,
                    w = win.innerWidth || self.innerWidth || (de && de.clientWidth) || doc.body.clientWidth,
                    h = win.innerHeight || self.innerHeight || (de && de.clientHeight) || doc.body.clientHeight;
            arrayPageSize = [w, h]
            return arrayPageSize;
        },
        _getpageScroll: function() {//获取滚动条距离顶部的距离
            var yScrolltop;
            if (self.pageYOffset) {
                yScrolltop = self.pageYOffset;
            } else if (doc.documentElement && doc.documentElement.scrollTop) {
                yScrolltop = doc.documentElement.scrollTop;
            } else if (doc.body) {
                yScrolltop = doc.body.scrollTop;
            }
            return yScrolltop;
        },
        _position: function(obj) {//计算对象放置在屏幕中间的值   obj:需要计算的对象
            var left = ((this._getpageSize()[0] - parseInt(obj.outerWidth())) / 2);
            var top = ((this._getpageSize()[1] - parseInt(obj.outerHeight())) / 2);
            return [left, top];
        },
        _offset:function(obj){//计算对象距离页面顶部和左侧的位置  obj:需要计算的对象
           var left = obj.offset().left;
           var top;
           if(jQuery.fn.jquery <=1.6){
                if(!!$.browser.msie && parseInt($.browser.version) <= 6){
                    top = obj.offset().top+$.ui._getpageScroll();
                }else{
                    top = obj.offset().top;
                }
           }else{
               top = obj.offset().top;
           };
           return [left, top];
        },
        isie: !!$.browser.msie,
        isie6: (!!$.browser.msie && parseInt($.browser.version) <= 6)
    });

   var feedback = {
   	  ajaxloding:false,
      init:function(){
      	 var that = feedback;
      	 that.addDom();
      },
      addDom:function(){
      	 var tops = parseInt($(window).height()/2),
      	     str = '<style type="text/css">\
                    .right_feed_back{width:100px; height:50px; position:fixed; _position:absolute;background-color:#fff;right:0px;top:'+(tops+150)+'px;_top:expression(documentElement.scrollTop+'+(tops+150)+'+"px"); z-index:95;}\
                    .right_feed_back a{background:url(/images/gamespace/voice_ico.jpg) no-repeat 0 0; display:block; width:100px; height:50px;}\
                    .right_feed_back a:hover{background-position:-100px 0px;}\
                    .feed_back_from{width:500px;  position:fixed; _position:absolute;background-color:#fff; left:0px; top:'+tops+'px;_top:expression(documentElement.scrollTop+'+(tops-100)+'+"px"); z-index:99; display:none;}\
                    .feed_back_from .feed_back_topbgs{background:url(/images/gamespace/tcbg.gif) no-repeat left top; width:500px; height:35px;}\
                    .feed_back_from .feed_back_topbgs h2{float:left; font-size:14px; color:#fff; margin:5px 0 0 25px;}\
                    .feed_back_from .feed_back_topbgs .close{float:right; font-size:14px; margin:5px 10px 0 0; color:#fff; cursor:pointer}\
                    .feed_back_from .content{width:468px; border:1px #000 solid; border-top:0px; background-color:#fff; padding:15px;}\
                    .feed_back_from .tex{width:460px; height:140px; border:1px #666666 solid; background-color:#e3e3e3; padding:3px;}\
                    .feed_back_from .email{margin-top:10px; display:inline-block;}\
                    .feed_back_from .email .em{width:146px; height:22px; color:#cccccc; border:1px #666666 solid; padding-left:5px;}\
                    .feed_back_from .sub{float:right; margin-top:10px; padding:3px;}\
              </style>\
              <div class="feed_back_from">\
                      <div class="feed_back_topbgs"><h2>反馈</h2><div class="close">×</div></div>\
                      <div class="content">\
                         <form id="reg_sisters" action="#" method="post">\
                           <textarea class="tex">给比赛中心的一些建议</textarea>\
                           <input class="sub" type="button" value="提交" /><span class="email">Email: <input class="em" type="text" value="请输入您的邮箱" /></span></form>\
                      </div>\
              </div>\
      	     <div class="right_feed_back">\
                 <a href="javascript:void(0);"></a>\
              </div>';
      	 $(str).appendTo("body");
      	 this.bindFun();
      },
      bindFun:function(){
      	   var feed_back_from = $(".feed_back_from"),
      	   that= this;
          $(".right_feed_back").click(function(){
             that.postDom();
          });
          $(".feed_back_from").find(".close").click(function(){
          	   $.ui._closeMasks();
               feed_back_from.hide();
          });

          $("#reg_sisters").find(".sub").click(function(){
          	     that.chech();
                 return false;
          });

          $("#reg_sisters").find(".tex").focus(function(){
          	  if(!$(this).data("befo")){
                $(this).val("");
                $(this).data("befo",true);
              }
          });

          $("#reg_sisters").find(".em").focus(function(){
          	  if(!$(this).data("befo")){
                $(this).val("");
                $(this).data("befo",true);
                $(this).css({
                	color:"#000"
                });
              }
          });
      },
      postDom:function(){
      	 var obj = $(".feed_back_from");
      	 $.ui._showMasks();
      	 if($.ui.isie6){
      	 	obj.css({
	      	 	left:$.ui._position(obj)[0]
	      	 }).show();
      	 }else{
      	 	obj.css({
	      	 	left:$.ui._position(obj)[0],
	      	 	top:$.ui._position(obj)[1]
	      	 }).show();
      	 }
      	 this.dataInit();
      },
      chech:function(){
      	 var emails=/^.+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/;
      	     obj = $("#reg_sisters"),
      	     emailVal = obj.find(".em").val(),
      	     that = this;
         if($.trim(obj.find(".tex").val()) == "" || !obj.find(".tex").data("befo")){
         	 obj.find(".tex").tips("内容不能为空");
         	 return false;
         }

         if($.trim(emailVal) != "" && obj.find(".em").data("befo")){
         	if(!emails.test(emailVal)){
	         	obj.find(".em").tips("邮箱地址不正确");
	         	return false;
	        }
         }

         if(this.ajaxloding){
         	return false;
         }
         that.ajaxloding = true;
         $.getJSON('http://g.hupu.com/nba/feedback',{email:emailVal,content:encodeURI(obj.find(".tex").val()),type:"gamespace"},function(data){
               if(data.status*1 == 200){
               	   obj.find(".sub").tips("提交成功");
               	   setTimeout(function(){
                      $(".feed_back_from").find(".close").click();
                      that.ajaxloding = false;
                      that.dataInit();
               	   },1500);
               }else{
               	  obj.find(".sub").tips("提交失败");
               	  that.ajaxloding = false;
               }
         });
      },
      dataInit:function(){
      	var reg_sisters = $("#reg_sisters");
      	reg_sisters.find(".tex").data("befo",false);
        reg_sisters.find(".em").data("befo",false);
        reg_sisters.find(".tex").val("给比赛中心的一些建议");
      	reg_sisters.find(".em").val("请输入您的邮箱");
      }
   }

   var dimCode = {
   	   init:function(par){
   	   	   var that = dimCode;
   	   	   that.addDom(par);

   	   },
   	   addDom:function(par){
   	   	   var str = '<style type="text/css">\
   	   	                .dimCode{background: url("https://b3.hoopchina.com.cn/web/channel/nba/index/qcode/erwei.jpg") no-repeat left top;position:fixed;_position:absolute;left:'+par.left+'px;top:'+par.top+'px; _top:expression(documentElement.scrollTop+170+"px"); background-color:#fff;  width:116px; height:61px; padding-top:134px; line-height:18px; text-align:center;}\
   	   	                .nba_er_link{width: 100px;height: 100px;display: block;position: absolute;left: 8px;top: 27px;}\
   	   	                .nba_er_link2{color:#000; text-decoration: underline;}\
   	   	                .nba_er_link2:hover{text-decoration: none;}\
                    </style>\
   	   	            <div class="dimCode">\
   	   	                <a class="nba_er_link" target="_blank" href="http://goto.hupu.com/?a=goClick&amp;id=5655"></a>\
   	   	                <b style="color:#b74545;">手机看NBA直播</b><br>点击或扫描下载<br>\
   	   	                <a target="_blank" href="http://bbs.hupu.com/4051495.html" class="nba_er_link2">如何扫描？</a>\
   	   	                <div style="position:absolute; width:21px; height:21px; right:0px; top:0px;  cursor:pointer;" class="nba_er_close"></div>\
   	   	             </div>';
   	   	    $(str).appendTo("body");
   	   	    $(".nba_er_close").click(function(){
               $(".dimCode").remove();
   	   	    });
   	   	    $(window).resize(function(){
                  $(".dimCode").css("left",$(".hp-threeNav").offset().left + $(".hp-threeNav").width()+10);
   	   	    });
   	   }
   }
   $.extend({
	    feedback:feedback.init,
	    dimCode:dimCode.init
   });

   $.dimCode({
   	   left:$(".hp-threeNav").offset().left + $(".hp-threeNav").width()+10,
   	   top:$(".hp-threeNav").offset().top
   });
})(jQuery,window,document);

;(function($){//走势图插件封装
var highc = {
	defaults:{
		enabled:true
	},
	init:function(){//$('#container')
	   var that = highc,el,args = arguments;
	   return this.each(function(){
	   	  //args[1] = $.extend(true,{}, that.defaults, args[1] || {});
	   	  el = this;
		  if(args[0] == "spider"){//属性图
	           that.higfunB($(el),args[1]);
		  };
		  if(args[0] == "line"){//走势图
		  	that.higfunA($(el),args[1]);
		  }
		  //players_home.init();
	   });
     },
     bindFun:function(){
     	 var that = this,arr;
         $(".team_qushi").delegate("a","click",function(){
         	 arr = $(this).attr("arr");
         	 $(this).addClass("on");
         	 $(this).siblings().removeClass("on");
             that.higfunA($('#container2'),arr.split("/"));
         });
     },
     indexOf:function(arr,val){
        if(arr.indexOf){
            return arr.indexOf(val);
        }
        for(var i=0,l=arr.length;i<l;i++){
            if(val==arr[i]){
                return i;
            }
        }
        return -1;
     },
     higfunA:function(obj,arr){
     	function arrfun(s){
     		for(var i=0;i<s.length; i++){
     			s[i] = s[i]*1;
     		}
     		return s;
     	}
     	var arr1 = {data:[],name:[]},allarr = [],arrx = [],xAxis,formatters,years;
     	if(arr.num){
	        try{
	        	var numstr = arr.num.split("/");
	        	if(arr.pointStart && numstr[0].split(",").length > 6){
	        		for(var s=0;s<numstr.length;s++){//按时间自适应
		            	arrx[s] = {data:[],name:""};
		            	for(var p=0;p<arr.categories.split(",").length;p++){
					        var up = arrfun(arr.categories.split(",")[p].split("-"));
					        if(up.length > 1){
					        	arrx[s].data[p] = [Date.UTC(up[0],up[1]-1,up[2]),arrfun(arr.num.split("/")[s].split(","))[p]];
					        }else{
					        	arrx[s].data[p] = [Date.UTC(up[0],1,1),arrfun(arr.num.split("/")[s].split(","))[p]];
					        	years = true;
					        }
			        		arrx[s].name = arr.name.split("/")[s];
			        		if(arr.tipsTxt){
			        			arrx[s].tipsTxt = arr.tipsTxt.split(",");
			        		}
		            	}
		            }
		            allarr = arrx;
	        	}else{
	        		for(var s=0;s<numstr.length;s++){//固定参数
				        for(var p=0;p<numstr[s].split(",").length;p++){
				        	arr1.data[p] = {
			        			name:arr.categories.split(",")[p],
			        			y:arrfun(arr.num.split("/")[s].split(","))[p]
			        		}
			        		arr1.name = arr.name.split("/")[s];
				        }
				        allarr[s] = arr1;
				        arr1 = {data:[],name:[]}
		             }
	        	}
		    }catch(err){
	           return false;
		    }

		    if(arr.pointStart && numstr[0].split(",").length > 6){
	        	xAxis = {
			    	type: 'datetime',
			    	maxZoom: 48 * 3600 * 1000,
		            labels: {
		                formatter: function () {
		                	if(years){
		                		return  Highcharts.dateFormat('%Y', this.value);
		                	}else{
		                		return  Highcharts.dateFormat('%Y-%m-%d', this.value);
		                	}
		                },
		                style: {
		                    fontSize:"10px"
		                },
		                staggerLines:1,
		                rotation: 0,
		                align: 'center',
		                step:1.5,
		                x:-10,
		                y:20,
		                zIndex:20
		            }
			    }
			    formatters = function(obj){
			    	if(years){
			    		return Highcharts.dateFormat('%Y', obj.points[0].key);
			    	}else{
			    		return Highcharts.dateFormat('%Y-%m-%d', obj.points[0].key);
			    	}

			    }
	        }else{
	        	xAxis = {
			    	categories: arr.categories.split(",")
			    }
			    formatters = function(obj){
			    	return obj.points[0].key;
			    }
	        }
     	}else{
     		return false;
     	}

     	obj.highcharts({
	        chart: {
	            marginBottom: 80,
	            backgroundColor:"none"
	        },
	        colors: ['#a82328', '#3c9bdd', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655',
	'#FFF263', '#6AF9C4'],
	        rangeSelector : {
				selected : 1,
				inputEnabled : false
			},
	        credits:{
	            enabled:false   //脚底网址
	        },
	        exporting:{
	            enabled:false  //头上下拉框
	        },

	        title: {
		        text:arr.text,
		        style:{
		        	color:"#000",
		        	fontSize:"14px",
		        	fontWeight:"bold"
		        }
		    },
		    tooltip: {
		    	shared: true,
		        //pointFormat: '{series.name}: <b>{point.y}</b><br/>',
		        useHTML:true,
		        formatter: function() {
		        	var str = formatters(this) +"<br/>",
		        	    list,
		        	    ser;
		        	for(var i=0;i<this.points.length;i++){
		        		ser = this.points[i];
		        		list = highc.indexOf(ser.series.processedXData,this.x);
		        		try{
                           str += ser.series.userOptions.tipsTxt[list];
		        		}catch(err){
                            str += ser.series.name+":<b>"+ser.y+(arr.measure?arr.measure:"")+"</b><br/>"
		        		}

		        	}
	                return str
	            },
		        enabled:true,
		        borderColor:"#000"
		    },
	        xAxis: xAxis,
	        yAxis: {
	            labels: {
	                format: '{value}'+(arr.measure?arr.measure:"") //Y轴单位
	            },
	            title: {
			        text: ''
			    }
	        },

	        legend: {
		        enabled:false
		    },

	        series: allarr
	    });
     },
     higfunB:function(obj,arr){
     	function arrfun(s){
     		for(var i=0;i<s.length; i++){
     			s[i] = s[i]*1;
     		}
     		return s;
     	}
     	var arr1 = [];
     	try{
	     	for(var s=0;s<arr.length;s++){
	            arr1[s] = {
	                data: arr[s].num,
			        pointPlacement: 'on',
			        legendIndex: 1,
			        name:arr[s].name
	            };
	     	}
     	}catch(err){
           return false;
	    }

     	obj.highcharts({
		    chart: {
		        polar: true,
		        type: 'line',
		        plotBorderColor:"#ff6600",
		        backgroundColor:"none"
		    },
		    colors: ['#a82328', '#3c9bdd', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655',
	'#FFF263', '#6AF9C4'],
	        credits:{
	            enabled:false   //脚底网址
	        },
	        exporting:{
	            enabled:false  //头上下拉框
	        },
		    title: {
		        style: {display:'none'}
		    },
		    pane: {
		    	size: '65%'
		    },
		    xAxis: {
		        categories: ['<b style="font-size:12px; font-weight:bold; color:#444444;">场均得分</b>', '<b style="font-size:12px; font-weight:bold; color:#444444;">场均助攻</b>', '<b style="font-size:12px; font-weight:bold; color:#444444;">场均篮板</b>', '<b style="font-size:12px; font-weight:bold; color:#444444;">场均失分</b>',
		                '<b style="font-size:12px; font-weight:bold; color:#444444;">场均失误</b>'],
		        tickmarkPlacement: 'on',
		        lineWidth: 0,
		        gridLineColor:"#e4e3e3",
		        lineColor:"#e4e3e3"
		    },
		    yAxis: {
		        gridLineInterpolation: 'polygon',
		        lineWidth: 0,
		        min: 0,
		        gridLineColor:"#e4e3e3",
		        lineColor:"#e4e3e3",
		        labels : {
					style : {
					   color : '#000',
					   display:"none"
					},
					align : 'right',
					x : 0,
					y : -2,
					zIndex:-1
				}
		    },

		    tooltip: {
		    	shared: true,
		       // pointFormat: '{series.name}: <b>{point.y}</b><br/>',
		        formatter: function() {
		        	var str = this.x +"<br/>";
		        	for(var i=0;i<this.points.length;i++){
		        		str += this.points[i].series.name+"排名:<b>"+(31-this.points[i].y)+"</b><br/>";
		        	}
	                return str
	            },
		        enabled:true,
		        borderColor:"#000"
		    },

		    legend: {
		        align: 'left',
		        verticalAlign: 'top',
		        y: 170,
		        layout: 'vertical',
		        enabled:arr[0].enabled == false?arr[0].enabled:true
		    },

		    series: arr1

		});
     }
}

$.fn.extend({
    higs:highc.init
});

})(jQuery);
