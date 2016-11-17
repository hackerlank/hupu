var boxFuture = {
	init: function (){
		 this.highcharts();
		 this.bind();
	},
	bind: function() {
	},
	highcharts: function() {
		$('#box_b').highcharts({
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
                categories: ['场均得分', '场均助攻', '场均篮板', '场均失分',
                             '场均失误'],
                tickmarkPlacement: 'on',
                lineWidth: 0
            },
            yAxis: {
                gridLineInterpolation: 'polygon',
                lineWidth: 0,
                tickPositions: [30, 15, 0],
                min: 0,
                labels: {
                    style: {
                        color: '#fff'
                     }
                  }
            },
            tooltip: {
                shared: true,
                useHTML: true,
                headerFormat: '<div style="font-weight:bold">{point.key}</div><table>',
                pointFormat: '<tr><td style="text-align: left;">{series.name}:<b>{point.y:,.0f}</b></td></tr>',
                footerFormat: '</table>',
                valueDecimals: 2
            },
            legend: {
                align: 'left',
                verticalAlign: 'top',
                y: 180,
                layout: 'vertical'
            },
            credits: {
                 enabled: false
            },
            series: [{
                name: GM.home_name + '排名',
                color: "#a82328",
                data: [{
                    //name: '场均得分',
                    color: '#000',
                    y: GM.home_team_rank_info.pts.rank || 0
                }, {
                    //name: '场均助攻',
                    color: '#000',
                    y: GM.home_team_rank_info.ast.rank || 0
                },{
                    //name: '场均篮板',
                    color: '#000',
                    y: GM.home_team_rank_info.reb.rank || 0
                }, {
                    //name: '场均失误',
                    color: '#000',
                    y: GM.home_team_rank_info.to.rank || 0
                }, {
                    //name: '场均失分',
                    color: '#000',
                    y: GM.home_team_rank_info.lts.rank || 0
                }],
                pointPlacement: 'on'
            },{
                name: GM.away_name + '排名',
                color: "#3c9bdd",
                data: [{
                    //name: '场均得分',
                    color: '#000',
                    fontSize: "129px",
                    y: GM.away_team_rank_info.pts.rank || 0
                }, {
                    //name: '场均助攻',
                    color: '#000',
                    y: GM.away_team_rank_info.ast.rank || 0
                },{
                    //name: '场均篮板',
                    color: '#000',
                    y: GM.away_team_rank_info.reb.rank || 0
                }, {
                    //name: '场均失误',
                    color: '#000',
                    y: GM.away_team_rank_info.to.rank || 0
                    
                }, {
                    //name: '场均失分',
                    color: '#000',
                    y: GM.away_team_rank_info.lts.rank || 0
                }],
                pointPlacement: 'on'
            }]
        });
	}
}

boxFuture.init();


                 


