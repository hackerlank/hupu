{%extends file="common/page/layout.tpl"%} 
{%block name="head_static"%}
{%require name="team:static/playerDetail/playerDetail.css"%}
{%require name="common:static/js/highcharts/highcharts.js"%}
{%require name="common:static/js/highcharts/highcharts-more.js"%}
{%require name="team:static/playerDetail/playerDetail.js"%}
{%require name="team:static/playerDetail/player.js"%}
{%require name="common:static/js/center.js"%}
{%/block%}
{%block name="content"%}
<div class="gamecenter_livestart">
<div class="bgs_png" style="display:none;"></div>
{%widget name="common:widget/ad-980/ad-980.tpl"%}
{%widget name="common:widget/page-tab/page-tab.tpl" title="球员"%}
{%widget
        name="common:widget/bread-crumbs/bread-crumbs.tpl"
        title1="NBA比赛中心"
        title2="NBA球员"
        title3="{%$player_info.name|f_escape_xml%}"
        link2="{%$nav_link.player|f_escape_xml%}"
    %}
<div class="gamecenter_content">
<div class="gamecenter_content_l">
<div class="team_data">
<h2>
{%if !empty($player_info.name)%}
{%$player_info.name|f_escape_xml%}（{%$player_info.eng_name|f_escape_xml%}）{%else%}
{%$player_info.eng_name|f_escape_xml%}
{%/if%}
</h2>
<div class="content">
<div class="content_a">
<div class="clearfix">
<div class="img">
<img src="{%$player_info.photo_link|f_escape_xml%}">
</div>
<div class="font">
<p>位置：{%$player_info.position|default:"不详"|f_escape_xml%}{%if !empty($player_info.number)%}（{%$player_info.number|f_escape_xml%}号）{%/if%}</p>
<p>身高：{%$player_info.height|default:"不详"|f_escape_xml%}</p>
<p>体重：{%$player_info.weight|default:"不详"|f_escape_xml%}</p>
<p>生日：{%$player_info.birth_date|default:"不详"|f_escape_xml%}</p>
<p>球队：<a target="_blank" title="{%$player_info.team_full_name|f_escape_xml%}" style="color:red" href="{%$player_info.team_link|f_escape_xml%}">{%$player_info.team_full_name|default:"不详"|f_escape_xml%}</a></p>
{%if !empty($player_info.college_school)%}<p>学校：{%$player_info.college_school|f_escape_xml%}</p>{%/if%}
<p>选秀：{%if !empty($player_info.draft_year) || !empty($player_info.draft_round) || !empty($player_info.draft_year) %}{%$player_info.draft_year|f_escape_xml%}年第{%$player_info.draft_round|f_escape_xml%}轮第{%$player_info.draft_pick|f_escape_xml%}顺位{%/if%}</p>
<p>国籍：{%$player_info.country|default:"不详"|f_escape_xml%}</p>
<p>本赛季薪金：{%if !empty($player_info.salary)%}{%$player_info.salary|f_escape_xml%}万美元{%else%}不详{%/if%}</p>
<p>合同：{%$player_info.wage|default:"不详"|f_escape_xml%}</p>
</div>
</div>
</div>
<div class="table_team_box">
<div class="list">
<div class="border">
<span class="a">技术统计</span><span class="b">数值</span><span class="c">联盟排名</span>
</div>
<div class="border">
<span class="a">场均得分</span><span class="b"><b>{%$player_stats_rank.pts.score|f_escape_xml%}</b></span><span class="c"><b>{%$player_stats_rank.pts.rank|f_escape_xml%}</b></span>
</div>
<div class="border">
<span class="a">场均助攻</span><span class="b"><b>{%$player_stats_rank.asts.score|f_escape_xml%}</b></span><span class="c"><b>{%$player_stats_rank.asts.rank|f_escape_xml%}</b></span>
</div>
<div class="border">
<span class="a">场均篮板</span><span class="b"><b>{%$player_stats_rank.reb.score|f_escape_xml%}</b></span><span class="c"><b>{%$player_stats_rank.reb.rank|f_escape_xml%}</b></span>
</div>
<div class="border">
<span class="a">命中率</span><span class="b"><b>{%$player_stats_rank.fgp.score|f_escape_xml%}</b></span><span class="c"><b>{%$player_stats_rank.fgp.rank|f_escape_xml%}</b></span>
</div>
<div class="border">
<span class="a">三分命中率</span><span class="b"><b>{%$player_stats_rank.tpp.score|f_escape_xml%}</b></span><span class="c"><b>{%$player_stats_rank.tpp.rank|f_escape_xml%}</b></span>
</div>
<div class="border">
<span class="a">罚球命中率</span><span class="b"><b>{%$player_stats_rank.ftp.score|f_escape_xml%}</b></span><span class="c"><b>{%$player_stats_rank.ftp.rank|f_escape_xml%}</b></span>
</div>
<div class="border">
<span class="a">场均盖帽</span><span class="b"><b>{%$player_stats_rank.blk.score|f_escape_xml%}</b></span><span class="c"><b>{%$player_stats_rank.blk.rank|f_escape_xml%}</b></span>
</div>
<div class="border">
<span class="a">场均抢断</span><span class="b"><b>{%$player_stats_rank.stl.score|f_escape_xml%}</b></span><span class="c"><b>{%$player_stats_rank.stl.rank|f_escape_xml%}</b></span>
</div>
</div>
</div>
</div>
</div>
<div class="team_hig">
<div class="title_style">
<div class="boreder"></div>
<div class="tab_span_box">
<span class="title_border Js_click_c" style="cursor:pointer" atr="0">
<span class="title_font">{%$player_info.name|f_escape_xml%}常规赛表现</span>
</span>
<span class="title_border Js_click_c title_border2" style="cursor:pointer" atr="1">
<span class="title_font title_font2">{%$player_info.name|f_escape_xml%}季后赛表现</span>
</span>
</div>
<div class="table_chick" style="display: none;">切换至<b>表格</b>模式</div>
<div class="table_chick2" style="display: block;">切换至<b>图表</b>模式</div>
</div>
<div class="tables_check Js_playe_line" style="display: none;">
<div class="Js_show_line" style="display: block;">
{%widget
            		        name="team:widget/data-chart/data-chart.tpl"
            		        type="cur_regular_data"
                            data=$cur_regular_data
            		    %}
</div>
<div class="Js_show_line" style="display: none;">
{%widget
            		        name="team:widget/data-chart/data-chart.tpl"
            		        type="cur_playoff_data"
                            data=$cur_playoff_data
            		    %}
</div>
</div>
<div class="tables_check2 Js_playe_table">
<div class="loding_more">
<div class="list_a" style="display: none;">
<div class="loding_bg"></div>
<div class="fonts">+ 展开更多</div>
</div>
<div class="list_b" style="display: none;">
<div class="loding_bg2"></div>
<div class="fonts2">- 收起</div>
</div>
</div>
<div class="all_tables_check">
<div class="Js-show-table" style="display: block;">
{%widget
                		        name="team:widget/data-cur-table/data-cur-table.tpl"
                		        type="cur_regular_data"
                                data=$cur_regular_data
                		    %}
</div>
<div class="Js-show-table" style="display: none;">
<div class="list_table_box">
{%widget
                    		        name="team:widget/data-cur-table/data-cur-table.tpl"
                    		        type="cur_playoff_data"
                                    data=$cur_playoff_data
                    		    %}
</div>
</div>
</div>
</div>
</div>
<div class="team_hig">
<div class="title_style">
<div class="boreder"></div>
<div class="tab_span_box">
<span class="title_border clickchoose" style="cursor:pointer" atm="0">
<span class="title_font">{%$player_info.name|f_escape_xml%}生涯常规赛表现</span>
</span>
<span class="title_border clickchoose title_border2" style="cursor:pointer" atm="1">
<span class="title_font title_font2">{%$player_info.name|f_escape_xml%}生涯季后赛表现</span>
</span>
</div>
<div class="table_chick" style="display: none;">切换至<b>表格</b>模式</div>
<div class="table_chick2" style="display: block;">切换至<b>图表</b>模式</div>
</div>
<div class="shengyasai_line" style="display: none;">
<div class="shengyasai" style="display: block;">
{%widget
            		        name="team:widget/data-chart/data-chart.tpl"
            		        type="career_regular_data"
                            data=$career_regular_data
            		    %}
</div>
<div class="shengyasai" style="display: none;">
{%widget
            		        name="team:widget/data-chart/data-chart.tpl"
            		        type="career_playoff_data"
                            data=$career_playoff_data
            		    %}
</div>
</div>
<div class="shengyasai_tables">
<div id="in_box">
<div class="loding_more">
<div class="list_a" style="display: none;">
<div class="loding_bg"></div>
<div class="fonts">+ 展开更多</div>
</div>
<div class="list_b" style="display: none;">
<div class="loding_bg2"></div>
<div class="fonts2">- 收起</div>
</div>
</div>
<div class="all_tables_check">
<div class="list_table_box J_p_l" style="display: block;">
{%widget
                    		        name="team:widget/data-career-table/data-career-table.tpl"
                    		        type="career_regular_data"
                                    data=$career_regular_data
                    		    %}
</div>
<div class="list_table_box J_p_l" style="display: none;">
{%widget
                    		        name="team:widget/data-career-table/data-career-table.tpl"
                    		        type="career_playoff_data"
                                    data=$career_playoff_data
                    		    %}
</div>
</div>
</div>
</div>
</div>
</div>
<div class="gamecenter_content_r">
{%if !empty($player_rank)%}
<div class="region_box">
<div class="tiltle">
得分排行榜</div>
<table class="itinerary_table">
<tbody>
<tr>
<td width="50" height="40">排名</td>
<td>姓名</td>
<td>得分</td>
</tr>
</tbody>
</table>
<div class="border_red"></div>
<table class="itinerary_table">
<tbody>
{%foreach $player_rank as $val%}
<tr class="bg_color {%if !empty($val.is_self)%}on{%/if%}">
<td width="50" height="35"><span {%if !empty($val.is_self)%}class="bg_box"{%/if%}>{%$val.rank|f_escape_xml%}</span></td>
<td width="105"><a target="_blank" href="{%$val.player_link|f_escape_xml%}">{%$val.player_name|f_escape_xml%}</a></td>
<td>{%$val.rank_score|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
</div>
{%/if%}
{%if !empty($news)%}
<div class="bbs_a">
<div class="title">
相关新闻</div>
<ul class="hour">
{%foreach $news as $val%}
<li>
<a target="_blank" title="{%$val.title|f_escape_xml%}" href="{%$val.url|f_escape_xml%}">{%$val.title|f_escape_xml%}</a>
</li>
{%/foreach%}
</ul>
</div>
{%/if%}
{%if !empty($bbs)%}
<div class="bbs_a">
<div class="title">
相关帖子</div>
<ul class="hour">
{%foreach $bbs as $val%}
<li>
<a target="_blank" title="{%$val.title|f_escape_xml%}" href="{%$val.url|f_escape_xml%}">{%$val.title|f_escape_xml%}</a>
</li>
{%/foreach%}
</ul>
</div>
{%/if%}
{%if !empty($video)%}
<div class="video_box">
<div class="title">
{%$player_info.name|f_escape_xml%}相关视频</div>
<ul>
{%foreach $video as $val%}
<li style="background-color: rgb(255, 255, 255);">
<span class="a_1">
<a title="{%$val.title|f_escape_xml%}" href="{%$val.url|f_escape_xml%}" target="_blank">
<img src="{%$val.img|f_escape_xml%}" />
</a>
</span>
<span class="a_2">
<p>
<a href="{%$val.url|f_escape_xml%}" target="_blank">{%$val.title|f_escape_xml%}
</a>
</p>
<div class="num">
播放：{%$val.hits|f_escape_xml%}次</div>
</span>
</li>
{%/foreach%}
</ul>
</div>
{%/if%}
</div>
</div>
{%require name='team:page/playerDetail.tpl'%}{%/block%}
