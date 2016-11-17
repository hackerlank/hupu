var teamDetail = {
	init: function (){
		 this.highcharts();
		 this.bind();
	},
	bind: function() {
		//右边区域东部 西部tab切换
    	$(".region_box .title").find("span").on("click", function(){
            $(this).removeClass("active").siblings().addClass("active");
            $(".area_table").eq($(this).index()).show().siblings(".area_table").hide();
        });
        //基本数据和比赛数据tab切换
        $(".jiben_title").find("span").on("click", function(){
            $(this).addClass("on").siblings().removeClass("on");
            $(".box_post").eq($(this).index()).show().siblings(".box_post").hide();
            if($(this).index() == 0) {
            	$(".c").hide();
            	$(".post_click_a").hide();
            	$(".post_click_b").hide();
            }else{
            	$(".c").show();
                $("#table_post2").css("left",0)
            	$(".post_click_b").show();
            }
        });
        var flag = true;
        //比赛数据向右移动
        $(".post_click_b").on("click",function() {
            if(!flag) return;
            flag = false;
            $("#table_post2").animate({
                left:"-=475px"
              },500,function() {
                var table_post2 = $("#table_post2");
                if(parseInt(table_post2.css("left")) <= -1425) {
                    $(".post_click_b").css("display","none");
                }
                $(".post_click_a").css("display","block");
                flag = true;
              });
        })
        //比赛数据向左移动
        $(".post_click_a").on("click",function() {
        	if(!flag) return;
            flag = false;
          $(".post_click_b").css("display","block");
        	$("#table_post2").animate({
            left:"+=475px"
          },500,function() {
            var table_post2 = $("#table_post2");
            if(parseInt(table_post2.css("left")) >= 0) {
                $(".post_click_a").css("display","none");
            }
            flag = true;
          });
        })
	},
	highcharts: function() {
		$('#highcharts_0').highcharts({
            chart: {
                polar: true,
                type: 'line'
            },
            title: {
                text:null
            },
            pane: {
                size: '65%'
            },
            xAxis: {
                categories: ['场均得分', '场均助攻', '场均篮板', '场均失误',
                             '场均失分'],
                tickmarkPlacement: 'on',
                lineWidth: 0
            },
            yAxis: {
                gridLineInterpolation: 'polygon',
                lineWidth: 0,
                labels:{  
                   enabled:false  //不显示刻度
                 } ,
                tickPositions: [30, 15, 0],
                min: 0
            },
            tooltip: {
                shared: true,
                useHTML: true,
                headerFormat: '<div style="font-weight:bold">{point.key}</div><table>',
                pointFormat: '<tr><td style="text-align: right;">{series.name}:<b>{point.y:,.0f}</b></td></tr>',
                footerFormat: '</table>',
                valueDecimals: 2
            },
            legend: {
                enabled:false
            },
            credits: {
                 enabled: false
            },
            series: [{
        		name: GM.name + '排名',
                color: "#a82328",
                data: [{
                    //name: '场均得分',
                    color: '#000',
                    y: GM.team_rank_info.pts.rank || 0
                }, {
                    //name: '场均助攻',
                    color: '#000',
                    y: GM.team_rank_info.ast.rank || 0
                },{
                    //name: '场均篮板',
                    color: '#000',
                    y: GM.team_rank_info.reb.rank || 0
                }, {
                    //name: '场均失误',
                    color: '#000',
                    y: GM.team_rank_info.to.rank || 0
                }, {
                    //name: '场均失分',
                    color: '#000',
                    y: GM.team_rank_info.lts.rank || 0
                }],
                pointPlacement: 'on'
            }]
        });
	}
}

teamDetail.init();
