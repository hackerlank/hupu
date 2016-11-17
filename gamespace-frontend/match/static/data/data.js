$(function(){
   choose.init();
});

var choose = {
	scro:false,
	init:function(){
		var atr = $(".gamecenter_livestart").attr("id");
        switch(atr){
		    case "rank_js": //战绩排行
		       this.bindFun($(".players_table"));
               break;
		    case "data_js":  //数据排队
               //this.bindFun($(".tables"));
               teamData.init();
               break;
		    case "teamNba":  //篮球比赛赛程
		       this.teamNba();
               break;
            case "allteamNba":  //篮球比赛全部赛程
		       this.teamNba();
		       this.dateTable();
               break;
		    default :
		}
	},
	bindFun:function(objects){
        // var obj = $(".top_tables").find(".t1"),
        //     obj2 = objects;
        // obj.click(function(){
        // 	obj.removeClass("bg_red");
        // 	$(this).addClass("bg_red");
        // 	obj2.hide();
        // 	obj2.eq($(this).index()).show();
        // });
	},
	teamNba:function(){
		var obj = $(".players_list").find("li"),
		    obj2 = $(".players_table");
		obj.each(function(i){
            obj.eq(i).click(function(){
            	/*
               obj.removeClass("on");
               $(this).addClass("on");
               obj2.hide();
               obj2.eq(i).show();
               */
               var url = $(this).find("a").attr("href");
                if(window.location.href != url){
                    window.location = url;
                }
            });
		});
	},
	dateTable:function(){
		var obj = $(".players_right .choosedare .b"),
		    obj2 = $("#date"),
		    mar_height = $(".mar_height"),
		    top = $(".choosedare").offset().top
		    that = this;
		obj.click(function(event){
	          obj2.css({
	            	top:40
	          });
			event.stopPropagation();
		});

		obj2.click(function(event){
            event.stopPropagation();
		});

		$(document).click(function(){
	         obj2.css("top",-9999);
	     });
		$(window).scroll(function(){
	         if(that.getpageScroll() > top){
	             $(".postfix_bg").show();
	             $(".choosedare").addClass("choosedare2");
	         }else{
	             $(".postfix_bg").hide();
	             $(".choosedare").removeClass("choosedare2");
	         };
	     });
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
    isie: !!$.browser.msie,
    isie6: (!!$.browser.msie && parseInt($.browser.version) <= 6)
}

var teamData = {
	init:function(){
		this.bindFun();
		this.pageShow();
	},
	bindFun:function(){
		var jslist_a = ['.jslist_a','.jslist_b','.jslist_c',".jslist_d"],
		    numa = [[87,227],[230,370],[370,510],[510,650]],
		    numb = [[105,245],[240,380],[373,513],[510,650]],
		    that = this;
		for(var i=0; i<jslist_a.length; i++){
			(function(i){
               var m = $(jslist_a[i]);
				m.hover(function(){
					if($.browser.webkit){
                        $(".postborder,.postborder3").css("left",numb[i][0]).show();
						$(".postborder2").css("left",numb[i][1]).show();
					}else{
                        $(".postborder,.postborder3").css("left",numa[i][0]).show();
						$(".postborder2").css("left",numa[i][1]).show();
					}
				},function(){
					$(".postborder,.postborder3,.postborder2").hide();
				});
			})(i);
		}

		$(".up_downs").click(function(){
            $(".up_downs").removeAttr("style");
            $(".up_downs").find("s").removeClass();
			if($(this).data("sort") == "up"){
               $(this).data("sort","down");
               $(this).find("s").removeClass().addClass("on2");
			}else{
			   $(this).data("sort","up");
               $(this).find("s").removeClass().addClass("on1");
			}
            $(this).css({
                color:"#bb1215"
            });

            if($(this).parent().attr("class") == "jslist_f" || $(this).parent().attr("class") == "jslist_i"){
                that.arrSort($(this).find("s").attr("atr"),$(this).data("sort"),true);
            }else{
                that.arrSort($(this).find("s").attr("atr"),$(this).data("sort"),false);
            }
			$(".color_font1").find("td").eq($(this).attr("atr")).addClass("bg_b");
		});

        setTimeout(function(){
           $(".jslist_j").find(".up_downs").click();
        },200);
	},
	arrSort:function(o,s,m){
        var arr1 = [],
            obj = $("#data_js_sort").find("tr");
            obj.find("td").removeClass("bg_b");
            obj.each(function(i){
                if(i > 1){
                	arr1.push({
                		value:$(this).find("td").eq(o).html(),
                		list:i
                	});
                }
            });

            if(s == "up"){
            	$(arr1.sort(this.compareA)).each(function(i){
            		obj.eq(arr1[i].list).find("td").eq(o).addClass("bg_b");
	                obj.eq(arr1[i].list).appendTo("#data_js_sort");
                    if(m){
                        obj.eq(arr1[i].list).find("td").eq(0).html(arr1.sort(this.compareA).length-i);
                    }else{
                        obj.eq(arr1[i].list).find("td").eq(0).html(i+1);
                    }
	            });
            }else{
            	$(arr1.sort(this.compareB)).each(function(i){
            		obj.eq(arr1[i].list).find("td").eq(o).addClass("bg_b");
	                obj.eq(arr1[i].list).appendTo("#data_js_sort");

                    if(m){
                        obj.eq(arr1[i].list).find("td").eq(0).html(i+1);
                    }else{
                        obj.eq(arr1[i].list).find("td").eq(0).html(arr1.sort(this.compareA).length-i);
                    }
	            });
            }
	},
	compareA:function(a,b){
         var s = a["value"].replace("%","")*1,
             m = b["value"].replace("%","")*1;
         return s < m ? 1 : s == m ? 0 : -1;
	},
	compareB:function(a,b){
        var s = a["value"].replace("%","")*1,
             m = b["value"].replace("%","")*1;
         return s < m ? -1 : s == m ? 0 : 1;
	}
}

teamData.pageShow = function(){
     var pages_box = $(".pages_box"),
         post_page = $(".post_page"),
         numbox = pages_box.find(".pagelist"),
         t,w,l;

         numbox.css({
         	width:numbox.find("a").length * (numbox.find("a").outerWidth()+15)
         });

         w = numbox.width()+10,
         l = (pages_box.width() - w)/2;
     post_page.css({
     	width:w,
     	left:l
     });

     pages_box.find(".page_num").mouseover(function(){
         post_page.fadeIn(500);
     });

     pages_box.find(".page_num").mouseout(function(){
     	t = setTimeout(function(){
          post_page.hide();
     	},200);
     });

     post_page.hover(function(){
     	t?clearTimeout(t):"";
     },function(){
         $(this).hide();
     });
}
