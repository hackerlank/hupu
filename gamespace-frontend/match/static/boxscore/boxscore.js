var io = require('common:widget/socket/socket-1.4.5/socket.js'),
	  _ = require('underscore'),
		n,
		totalscoreHome,
		totalscoreAway,
		socket,
	  Section;
var flag = true;
var boxscore = {
	init: function(){
		this.bind();
		if(GM.is_live){
			this.websocket();
		}
	},
	bind:function() {
		$(".table_list_live .tips_layes").hover(function(){
			$(".tips_tems",$(this).parents($(".table_list_live"))).eq($(this).index()-1).css("display","block");
		},function() {
			$(".tips_tems").css("display","none");
		});
	},
	websocket:function() {
		socket = io.connect(GM.websocket);
	  socket.on('connect', function () {
	      socket.emit('join', {"id": GM.match_id, "type": "score"});
	  });
	  socket.on('score', function(data) {
	  	if(flag){
	  		flag = false;
		  	$(".team_num").text(data.process);
		  	if(data.score){
		  		boxscore.table_list_live(data);
		  	}
		  	if(data.vs){
		  		n = data.vs.indexOf("-");
					totalscoreHome = data.vs.substr(0,n);
					totalscoreAway = data.vs.substr(n+1);
					$(".team_a h2").text(totalscoreAway);
					$(".team_b h2").text(totalscoreHome);
		  	}	
		  	if(data.stats) {
			  	//主客队比分
			  	boxscore.homeVsaway(data);
		  	}
		  	if(data.event_type == 19) {
		  		$(".item-home-total").text(totalscoreHome);
		  		$(".item-away-total").text(totalscoreAway);
		  		$(".team_num").text("比赛结束");
					socket.close();
				}
				flag = true;
			}
	  })
	},
	//表格socket推送
	table_list_live:function(data) {
		$('#J_away_content').html("");
		$('#J_home_content').html("");
		var J_away_content = $('#J_away_content'),
				J_home_content = $('#J_home_content'),

			  data = {
					away_max_data: data.score.away_max_data,
					away_reserve:  data.score.away_reserve,
					away_start:  	 data.score.away_start,
					home_max_data: data.score.home_max_data,
					home_reserve:  data.score.home_reserve,
					home_start:    data.score.home_start
				};
		J_away_content.append(_.template( $('#J_awayTpl').html(),data));
		J_home_content.append(_.template( $('#J_homeTpl').html(),data));
		//判断是否为加时的类型(必须放在执行之后)
			if(data.section == 4){
				Section = 4;
			}
	},
	//主客队比分表
	homeVsaway: function(data) {
		var scoreTable = $(".yuece_num_a .itinerary_table"),
				scoreTitle = $(".yuece_num_a .itinerary_table .title"),
				scoreHome = $(".yuece_num_a .itinerary_table .home_score"),
				scoreAway = $(".yuece_num_a .itinerary_table .away_score");
		if(data.stats.home){
			scoreTitle.html("");
			scoreHome.html("");
			scoreAway.html("");

			scoreTitle.append(
				'<td></td><td>一</td><td>二</td><td>三</td><td>四</td>'
				)
			scoreAway.append(
				'<td>'+GM.away_name+'</td>'
				)
			scoreHome.append(
				'<td>'+GM.home_name+'</td>'
				)
			//比分标题
			for(var i in data.stats.home) {
				if(i>4){
					for(var j=4;j<i;j++){
						if(i==5){
							var key = "一";
						}
						if(i==6){
							var key = "二";
						}
						if(i==7){
							var key = "三";
						}
						if(i==8){
							var key = "四";
						}
						scoreTitle.append('<td class="addtime">加时'+key+'</td>');
					}
				}
			}
			scoreTitle.append('<td class="total">总分</td>');
			//客队比分
			for(var i in data.stats.away) {
				if(data.stats.away[i] == 0 && data.stats.home[i] == 0) {
					scoreAway.append('<td></td>');
				}else{
					scoreAway.append('<td>'+data.stats.away[i]+'</td>');
				}
			}
			scoreAway.append('<td class="item-away-total">'+totalscoreAway+'</td>');
			//主队比分
			for(var i in data.stats.away) {
				if(data.stats.away[i] == 0 && data.stats.home[i] == 0) {
					scoreHome.append('<td></td>');
				}else{
					scoreHome.append('<td>'+data.stats.home[i]+'</td>');
				}
			}
			scoreHome.append('<td class="item-home-total">'+totalscoreHome+'</td>');
		}
	}
}

boxscore.init();
