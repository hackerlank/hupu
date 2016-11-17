{%extends file="common/page/layout.tpl"%} 
{%if !empty($is_app)%}
{%block name="title"%}
{%if !empty($player_info.name) || !empty($player_info.name_en)%}
{%if !empty($player_info.name)%}
{%$player_info.name|f_escape_xml%}
{%else%}
{%$player_info.name_en|f_escape_xml%}
{%/if%}
{%else%}
饮水机守护神{%/if%}
{%/block%}
{%/if%}
{%block name="block_head_static"%}
{%require name="common:static/js/swiper_new/swiper.css"%}
{%require name="common:static/js/swiper_new/swiper.jquery.js"%}
{%require name="teams:static/app-soccer-player/app-soccer-player.scss"%}
<script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
{%script%}
		{%if empty($is_app)%}
			var toShare = require("common:widget/ui/share/share.js");
			//全局分享事件, 每个页面单独注册.
			$(document).on("page:share", function(){
				toShare();
			});
		{%/if%}

		window.GM = {
			"client": "{%$kanqiu.client|f_escape_js%}" || "x",
            "projectId": "{%$kanqiu.projectId|f_escape_js%}" || "3",
            "version": "{%$kanqiu.version|f_escape_js%}" || "x",
            "night": !!parseInt("{%$kanqiu.night|f_escape_js%}", 10),
            "type": "{%$type|f_escape_js%}"|| "soccer",
            "player_name": "{%$player_info.name|f_escape_js%}" || "",
            "player_enname": "{%$player_info.name_en|f_escape_js%}",
			"avator": "{%$player_info.image_130x180_url|f_escape_js%}",
			"cur_url": "{%$cur_url|f_escape_js%}",
			"player_id": "{%$player_info.player_id|f_escape_js%}",
            "isBirth": !!parseInt("{%$is_birthday|f_escape_js%}", 10),
			"isApp": !!parseInt("{%$is_app|f_escape_js%}", 10)
        };

        var birth = require("teams:widget/birth/birth.js");
        var localKey = "soccerplayer_" + $(".playerid").val() + "_dropTimes";
        birth.init(localKey);

		var soccerPlayer = require("teams:widget/app-soccer-player/app-soccer-player.js");
        soccerPlayer.init();
    {%/script%}
{%/block%}
{%block name="content"%}
{%if empty($is_app)%}
{%widget
			name="common:widget/inner-top-nav/nav.tpl"
		%}
{%/if%}
<div class="iHeight"></div>
<div class="foreign-player-wrap">
<section class="info">
<div class="head">
<img src="{%$player_info.image_86x120_url|f_escape_xml%}">
{%if !empty($kanqiu.night)%}<div class="mask"></div>{%/if%}
</div>
<ul class="detail" {%if empty($is_app)%}style="line-height:1.42;"{%/if%}>
{%if empty($is_app)%}
<li>
<span>{%$player_info.name|f_escape_xml%}</span>
{%if !empty($player_info.name) && !empty($player_info.name_en)%}
<i class="separator">|</i>
{%/if%}
<span>{%$player_info.name_en|f_escape_xml%}</span>
</li>
{%/if%}
{%if $player_info.team_info|count != 0%}
<li>
{%foreach $player_info.team_info as $val%}
{%if $val@index !=0%}<i class="separator">|</i>{%/if%}
<span>{%$val.name|f_escape_xml%}</span>
<span>{%if !empty($val.number)%}{%$val.number|f_escape_xml%}号{%/if%}</span>
{%if $val.is_captain == "1"%}
<span class="captain">c</span>
{%/if%}
{%/foreach%}
</li>
{%/if%}
{%if $player_info.height!="" || $player_info.weight!="" || $player_info.preferred_foot!=""%}
<li>
<span>{%if $player_info.height!="不详"%}{%$player_info.height|f_escape_xml%}米{%/if%}</span>
{%if ($player_info.height!="" && $player_info.weight!="") || ($player_info.height!="" && $player_info.preferred_foot!="")%}
<i class="separator">|</i>
{%/if%}
<span>{%if $player_info.weight!="不详"%}{%$player_info.weight|f_escape_xml%}公斤{%/if%}</span>
{%if $player_info.weight!="" && $player_info.preferred_foot!=""%}
<i class="separator">|</i>
{%/if%}
<span>{%$player_info.preferred_foot|f_escape_xml%}</span>
</li>
{%/if%}
{%if !empty($player_info.country)%}
{%foreach $player_info.country as $val%}
<li class="country">
<span class="flag" style="background-image:url(//b3.hoopchina.com.cn/images/country/{%$val|f_escape_xml%}.jpg);">
{%if !empty($kanqiu.night)%}<span class="mask"></span>{%/if%}
</span>
<span class="name">{%$val|f_escape_xml%}</span>
</li>
{%/foreach%}
{%/if%}
</ul>
</section>
<ul class="tab" id="J-tab">
<li class="tab-info active">资料</li>
<li class="tab-data">数据</li>
<li class="tab-career">生涯</li>
<li class="tab-news">新闻</li>
</ul>
<div class="swiper-container">
<div class="swiper-wrapper">
<div class="swiper-slide swiper-info">
<section class="base-info">
<div class="base-item">
<span id="J-birth-date">{%$player_info.birth_date|default:"不详"|f_escape_xml%}</span>
<strong>
<i class="birth-status">
<img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/2x/1f382.png?t=1" width="15" height="15">
</i>
{%$player_info.age|default:"不详"|f_escape_xml%}{%if !empty($player_info.age)%}岁{%/if%}
<i class="birth-status">
<img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/1f382.png" width="15" height="15">
</i>
</strong>
</div>
<div class="base-item">
<span>参考身价</span>
<strong>{%$player_info.market_value|default:"不详"|f_escape_xml%}</strong>
</div>
<div class="base-item">
<span>合同到期</span>
<strong>{%$player_info.contract_until|default:"不详"|f_escape_xml%}</strong>
</div>
</section>
{%if !empty($player_info.detailed_position)%}
<section class="position">
<h2>球场位置</h2>
<div class="court-wrap">
<div class="court-bg">
{%if !empty($player_info.detailed_position.main_position)%}
<div class="pos pos{%$player_info.detailed_position.main_position.type|f_escape_xml%} main">
<span></span>
<em>{%$player_info.detailed_position.main_position.name_zh|f_escape_xml%}(主要)</em>
</div>
{%/if%}
{%if !empty($player_info.detailed_position.side_position)%}
{%foreach $player_info.detailed_position.side_position as $val%}
<div class="pos pos{%$val.type|f_escape_xml%}">
<span></span>
<em>{%$val.name_zh|f_escape_xml%}</em>
</div>
{%/foreach%}
{%/if%}
</div>
<div class="hupu-logo"></div>
</div>
</section>
{%/if%}
{%if !empty($player_info.description) || !empty($player_info.player_article)%}
<section class="intro">
{%if !empty($player_info.description)%}
<h2>球员简介</h2>
<p class="intro-con">{%$player_info.description|f_escape_xml%}</p>
{%/if%}
{%if !empty($player_info.player_article)%}
<div class="analyze">
<h2>深度剖析</h2>
<ul>
{%foreach $player_info.player_article as $val%}
<li>
<a href="{%$val.video_link|f_escape_xml%}" dace-node="weblinks">
<div class="link-title">
<p class="title">{%$val.video_title|f_escape_xml%}</p>
<span class="time">{%$val.video_date|f_escape_xml%}</span>
</div>
<em><i></i></em>
</a>
</li>
{%/foreach%}
</ul>
</div>
{%/if%}
</section>
{%/if%}
{%if !empty($player_info.player_video)%}
<section class="video">
<h2>球员视频</h2>
{%foreach $player_info.player_video as $val%}
<a href="{%$val.video_link|f_escape_xml%}" class="video-link" dace-node="playervideo">
<div class="video-img">
<em></em>
<img data-src="{%$val.video_thumbnails|f_escape_xml%}" class="swiper-lazy" alt="">
</div>
<p>{%$val.video_title|f_escape_xml%}</p>
</a>
{%/foreach%}
</section>
{%/if%}
<div class="source">
<div>数据支持：</div>
</div>
</div>
<div class="swiper-slide swiper-data">
{%if !empty($playerStats) || !empty($player_season_data)%}
{%if !empty($playerStats.league_dataTotal) || !empty($playerStats.league_data)%}
<div class="data-club">
<table>
<thead>
<tr>
<td width="36%" colspan="2" class="rb">俱乐部</td>
<td align="center">出场</td>
<td align="center">首发</td>
<td align="center">时间</td>
<td align="center">进球</td>
<td align="center">助攻</td>
</tr>
</thead>
<tbody>
{%foreach from=$playerStats.league_dataTotal key=key item=val%}
<tr class="first-item">
<td>{%$val.season|f_escape_xml%}</td>
<td align="right" class="rb">{%$val.team_name|f_escape_xml%}</td>
<td align="center">{%$val.played|f_escape_xml%}</td>
<td align="center">{%$val.shoufa|f_escape_xml%}</td>
<td align="center">{%$val.mins_played|f_escape_xml%}</td>
<td align="center">{%$val.goals|f_escape_xml%}</td>
<td align="center">{%$val.goal_assist|f_escape_xml%}</td>
</tr>
{%foreach $playerStats.league_data[$key] as $val2%}
<tr>
<td align="right" colspan="2" class="rb">{%$val2.league|f_escape_xml%}</td>
<td align="center">{%$val2.played|f_escape_xml%}</td>
<td align="center">{%$val2.shoufa|f_escape_xml%}</td>
<td align="center">{%$val2.mins_played|f_escape_xml%}</td>
<td align="center">{%$val2.goals|f_escape_xml%}</td>
<td align="center">{%$val2.goal_assist|f_escape_xml%}</td>
</tr>
{%/foreach%}
{%/foreach%}
</tbody>
</table>
</div>
{%/if%}
{%if !empty($playerStats.cups_data)%}
<div class="data-country">
<table>
<thead>
<tr>
<td width="36%">国家队</td>
<td align="center">出场</td>
<td align="center">首发</td>
<td align="center">时间</td>
<td align="center">进球</td>
<td align="center">助攻</td>
</tr>
</thead>
<tbody>
{%foreach $playerStats.cups_data as $val%}
<tr>
<td>{%$val.league|f_escape_xml%}</td>
<td align="center">{%$val.played|f_escape_xml%}</td>
<td align="center">{%$val.shoufa|f_escape_xml%}</td>
<td align="center">{%$val.mins_played|f_escape_xml%}</td>
<td align="center">{%$val.goals|f_escape_xml%}</td>
<td align="center">{%$val.goal_assist|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
</div>
{%/if%}
{%if !empty($player_season_data)%}
<div class="data-list">
<div class="title">
<h2>{%$player_season_data[0].season|f_escape_xml%}赛季 详情数据</h2>
{%if $player_season_data|count >= 1%}
<div class="data-tab">
{%foreach $player_season_data as $val%}
{%if !empty($val.league_name)%}
<span {%if $val@index == 0%}class="active"{%/if%}>{%$val.league_name|f_escape_xml%}</span>
{%/if%}
{%/foreach%}
</div>
{%/if%}
</div>
{%foreach $player_season_data as $val%}
<ul class="data-tab-content clearfix"{%if $val@index != 0%}style="display:none;"{%/if%}>
{%foreach $val.data as $subVal%}
{%if $subVal@index < 8 %}
<li class="mb {%if $subVal@index < 4%}li-1{%else if $subVal@index >= 8%}li-3{%else%}li-2{%/if%}">
{%else%}
<li class="{%if $subVal@index < 4%}li-1{%else if $subVal@index >= 8%}li-3{%else%}li-2{%/if%}">
{%/if%}
<div class="num">{%$subVal.value|f_escape_xml%}</div>
<div class="type">{%$subVal.item|f_escape_xml%}</div>
{%if $subVal.order != "-"%}
<div class="rank">
<a href="{%if !empty($is_app)%}{%$subVal.url|escape:none%}{%else%}javascript:void(0);{%/if%}">联赛第<span>{%$subVal.order|f_escape_xml%}</span>&nbsp;{%if !empty($is_app)%}<i></i>{%/if%}</a>
</div>
{%/if%}
</li>
{%/foreach%}
</ul>
{%/foreach%}
</div>
{%/if%}
<div class="source">
<div>数据支持：</div>
</div>
{%else%}
<div class="no-data">暂无该球员相关数据</div>
{%/if%}
</div>
<div class="swiper-slide swiper-career">
{%if !empty($player_transfer) || !empty($player_career)%}
{%if !empty($player_transfer)%}
<section class="transfer">
<h2>转会纪录</h2>
<div class="table-wrap">
<table>
<tr>
<th>时间</th>
<th>转会至</th>
<th>转会费</th>
</tr>
{%foreach $player_transfer as $val%}
<tr>
<td>{%$val.transfer_date|f_escape_xml%}</td>
<td>{%$val.moving_to_team_name_zh|f_escape_xml%}</td>
<td>
{%if !empty($val.transfer_fee)%}
{%$val.transfer_fee|f_escape_xml%}
{%else%}
{%$val.other|f_escape_xml%}
{%/if%}
</td>
</tr>
{%/foreach%}
</table>
</div>
</section>
{%/if%}
{%if !empty($player_career)%}
<section class="career-history">
<h2>职业生涯</h2>
<div class="table-wrap">
<table>
<tr>
<th><span>球队</span></th>
<th>进球</th>
<th>{%if !empty($is_goalkeeper)%}黄牌{%else%}助攻{%/if%}</th>
</tr>
{%foreach $player_career as $val%}
<tr>
<td>{%$val.team_name|f_escape_xml%}</td>
<td><span>{%$val.goals|f_escape_xml%}</span></td>
<td><span>{%if !empty($is_goalkeeper)%}{%$val.yellow_card|f_escape_xml%}{%else%}{%$val.assists|f_escape_xml%}{%/if%}</span></td>
</tr>
{%/foreach%}
</table>
</div>
</section>
{%/if%}
<div class="source">
<div>数据支持：</div>
</div>
{%else%}
<div class="no-data">暂无该球员相关数据</div>
{%/if%}
</div>
<div class="swiper-slide swiper-news" id="J-t-news">
<ul id="J-news-wrap">
<script id="J-news-tpl" type="text/template">
                            <@ $(datas).each(function(index,item){ @>
                            <li>
                                <a href="<@if(GM.isApp){@><@=item.app_url@><@}else{@><@=item.m_url@><@}@>">
                                    <div class="pic" style="background-image:url(<@=item.img@>);"><@if(GM.night){@><span class="mask"></span><@}@></div>
                                    <div class="text">
                                        <div class="title"><@=item.title@></div>
                                        <div class="intro"><@=item.summary@></div>
                                    </div>
                                    <div class="comment"><i></i><@=item.replies@></div>
                                </a>
                            </li>
                            <@ }); @>
                        </script>
</ul>
</div>
</div>
</div>
</div>
{%require name='teams:page/app-soccer-player.tpl'%}{%/block%}
