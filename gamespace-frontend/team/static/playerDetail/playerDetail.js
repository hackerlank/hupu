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

		$(".loding_more").click(function(){
             if($(this).attr("click") == "true"){
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

players_home.init();
exports = players_home;
