
var io = require('common:widget/socket/socket-1.4.5/socket.js'),
		n,
		totalscoreHome,
		totalscoreAway;
var playbyplay = {
	init: function(){
		//比赛进行中
		if(GM.is_live){
			this.websocket();
			//this.scrollBottom();
		}
	},
	scrollBottom: function() {
		//自动滚动到底部
  		var $content = $(".table_overflow table").height(),
  				$scroll = $(".table_overflow");
	   	$scroll.scrollTop($content);
	},
	websocket:function() {
		var self = this;
		var socket = io.connect(GM.websocket);
	  socket.on('connect', function () {
	      socket.emit('join', {"id": GM.match_id, "type": "live"});
	  });
	  socket.on('live', function(data) {  
	  	self.bind(data);
	  })
	},
	bind:function(data) {
		var self = this;
		var repeatId = GM.sequence_ids;
	  var flag = true;
	  	//数组重新排序，以防一错再错
	  	repeatId.sort(self.sortNumber);
	  	if(flag){
	  		flag = false;
		  	if(data.team == "home") {
					var	team_name = GM.home_name;
				}else{
					var	team_name = GM.away_name;
				}
		     	n = data.vs.indexOf("-");
					totalscoreHome = data.vs.substr(0,n);
					totalscoreAway = data.vs.substr(n+1);
				//判断球队id是否重复，重复为错误信息
				for(var i=0;i<repeatId.length;i++) {
					if(data.event_type == 1 || data.event_type == 3) {
						var style = "font-weight:bold";
					}
					//修正信息
					if(repeatId[i] == data.sequence_id) {
						$("#"+repeatId[i]).html("");
						if(data.event_type == 11 || data.event_type == 14 || data.event_type == 15 || data.event_type == 19) {
				  		$("#"+repeatId[i]).append(
							'<td colspan="4" style="font-weight:bold;" align="center">'+data.event+'</td>'
							);
				  		flag = true;
			        return false;
				  	}

						$("#"+repeatId[i]).append(
							'<td class="tdw-1 left" width="69">'+data.time+'</td>'+
		         	'<td width="69">'+team_name+'</td>' +
		         	'<td width="380" style='+style+ '>'+data.event+'</td>'+
		         	'<td align="center" width="157">'+totalscoreAway+'-'+totalscoreHome+'<td>');
						flag = true;
						return false;
					}
					//判断是否小于第一个sequence_id的值
					if(repeatId[0] > data.sequence_id) {
						$(".table_overflow table").append(
							'<tr id='+data.sequence_id+'>'+
							'<td class="tdw-1 left" width="69">'+data.time+'</td>'+
		         	'<td width="69">'+team_name+'</td>' +
		         	'<td width="380" style='+style+ '>'+data.event+'</td>'+
		         	'<td align="center" width="157">'+totalscoreAway+'-'+totalscoreHome+'<td></tr>');
						repeatId.unshift(data.sequence_id);
						flag = true;
						return false;
					}
					//排序中间插入数据
					if(repeatId[i] < data.sequence_id && repeatId[i+1] > data.sequence_id) {
						$("#"+repeatId[i+1]).after(
							'<tr id='+data.sequence_id+'>'+
							'<td class="tdw-1 left" width="69">'+data.time+'</td>'+
		         	'<td width="69">'+team_name+'</td>' +
		         	'<td width="380" style='+style+ '>'+data.event+'</td>'+
		         	'<td align="center" width="157">'+totalscoreAway+'-'+totalscoreHome+'<td></tr>');
						repeatId.splice(i+1,0,data.sequence_id);
						flag = true;
						return false;
					}
				}
				repeatId.push(data.sequence_id);
		  	$(".team_num").text(data.process);
		  	$(".team_a h2").text(totalscoreAway);
				$(".team_b h2").text(totalscoreHome);
		  	if(data.event_type == 11 || data.event_type == 14 || data.event_type == 15 || data.event_type == 19) {
		  		$(".table_overflow table").prepend(
		  			'<tr id='+data.sequence_id+'><td colspan="4" style="font-weight:bold;" align="center">'+data.event+'</td>'+'</tr>');
		  			flag = true;
	        	return false;
		  	}
				//文字直播添加的内容
				if(data.event_type == 1 || data.event_type == 3 ) {
					var style = "font-weight:bold";
					//主客队比分
		  		playbyplay.homeVsaway(data);
				}
				 $(".table_overflow table").prepend(
			  		'<tr id='+data.sequence_id+'>'+
		         '<td class="tdw-1 left" width="69">'+data.time+'</td>'+
		         '<td width="69">'+team_name+'</td>' +
		         '<td width="380" style='+style+ '>'+data.event+'</td>'+
		         '<td align="center" width="157">'+totalscoreAway+'-'+totalscoreHome+'</td>'+
		        '</tr>')
			}
			flag = true;
		//自动滚动到底部
  		//playbyplay.scrollBottom();
	},
	//主客队比分表
	homeVsaway: function(data) {
		var scoreTable = $(".yuece_num_a .itinerary_table"),
				scoreTitle = $(".yuece_num_a .itinerary_table .title"),
				scoreHome = $(".yuece_num_a .itinerary_table .home_score"),
				scoreAway = $(".yuece_num_a .itinerary_table .away_score");
		if(data.stats != undefined){
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
				if(i>=4){
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
			scoreAway.append('<td>'+totalscoreAway+'</td>');
			//主队比分
			for(var i in data.stats.away) {
				if(data.stats.away[i] == 0 && data.stats.home[i] == 0) {
					scoreHome.append('<td></td>');
				}else{
					scoreHome.append('<td>'+data.stats.home[i]+'</td>');
				}
			}
			scoreHome.append('<td>'+totalscoreHome+'</td>');
		}
	},
	//数组排序
	sortNumber: function(a,b) {
		return a - b
	}
}

playbyplay.init();
