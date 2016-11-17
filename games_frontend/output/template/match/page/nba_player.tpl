{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}
{%if !empty($profile.player_name)%}
{%$profile.player_name|f_escape_xml%}
{%else%}
{%$profile.player_enname|f_escape_xml%}
{%/if%}
{%/block%}
{%block name="head_static"%}
{%require name="common:static/js/zepto/zepto.js"%}
{%require name="common:static/js/swiper/js/swiper.jquery.js"%}
{%require name="common:static/js/swiper/css/swiper.css"%}
{%require name="common:static/js/underscore/underscore.js"%}
<script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
{%require name="match:static/page/nba_player.scss"%}
{%script%}

		window.GM = {
            "client": "{%$client|f_escape_js%}" || "x",
            "version":"{%$version|f_escape_js%}"|| "7.0.6",
            "islogin": !!parseInt("{%$is_login|f_escape_js%}", 10),
            "night": !!parseInt("{%$night|f_escape_js%}", 10),
            "player_name": "{%$profile.player_name|f_escape_js%}",
            "player_enname": "{%$profile.player_enname|f_escape_js%}",
            "isBirth": !!parseInt("{%$profile.is_birthday|f_escape_js%}", 10),
            "tid": "{%$profile.tid|f_escape_js%}"
        };

        var nbaPlayer = require("match:widget/nba_player/nba_player.js");

        nbaPlayer.init();
    {%/script%}
{%/block%}
{%block name="content"%}
<section class="nba-player-wrap" id="J-nba-player-wrap">
<section class="info">
<div class="head">
<img {%if !empty($profile.player_header)%} src="{%$profile.player_header|f_escape_xml%}" {%else%} src="//b1.hoopchina.com.cn/games/default/nba_head.png" {%/if%} height="50">
{%if !empty($night)%}<div class="mask"></div>{%/if%}
</div>
<ul class="detail">
<li>
<span>{%$team_info.full_name|f_escape_xml%}</span>
{%if !empty($team_info.full_name) || !empty($profile.number) && !empty($profile.position)%}
<i class="separator">|</i>
{%/if%}
{%if $profile.number!=""%}
<span>{%$profile.number|f_escape_xml%}号</span>
{%/if%}
{%if $profile.number!="" && !empty($profile.position)%}
<i class="separator">|</i>
{%/if%}
<span>{%$profile.position|f_escape_xml%}</span>
</li>
<li>
{%if !empty($profile.death_time)%}
<span>逝世({%$profile.birth_date|f_escape_xml%}-{%$profile.death_time|f_escape_xml%})</span>
{%else%}
<span>
<span class="birth-status J-birth-status">
<img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/2x/1f382.png?t=1" width="15" height="15">
</span>
{%if $profile.tid != 0%}
{%$profile.age|f_escape_xml%}
{%/if%}
<span class="birth-status J-birth-status">
<img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/2x/1f382.png" width="15" height="15">
</span>
</span>
{%if !empty($profile.age) && !empty($profile.birth_date)%}
{%if $profile.tid != 0%}
<i class="separator">|</i>
{%/if%}
{%/if%}
<span id="J-birth-date">{%$profile.birth_date|f_escape_xml%}</span>
{%/if%}
</li>
</ul>
</section>
<ul class="tab clearfix" id="J-tab">
<li class="active">资料</li>
<li class="tab-map" data-playerid="{%$profile.player_id|f_escape_xml%}">投篮热图</li>
<li>数据</li>
</ul>
<div class="swiper-container">
<div class="swiper-wrapper">
<section class="t-content swiper-slide t-info">
<ul class="body-list">
<li>
<div class="type">身高</div>
<div class="num">{%$profile.height|f_escape_xml%}</div>
</li>
<li>
<div class="type">臂展</div>
<div class="num">{%$profile.wingspan|f_escape_xml%}</div>
</li>
<li>
<div class="type">站立摸高</div>
<div class="num">{%$profile.standing_reach|f_escape_xml%}</div>
</li>
<li>
<div class="type">体重</div>
<div class="num">{%$profile.weight|f_escape_xml%}</div>
</li>
</ul>
{%if !empty($profile.draft)||!empty($profile.college)||!empty($profile.salary)||!empty($profile.contract)%}
<div class="info-list">
<table width="100%">
{%if !empty($injury)%}
<tr>
{%if $injury.injury_state == "1" %}
<td  class="td1" width="26%"><img src="//w10.hoopchina.com.cn/hybrid/static/match/page/img/player_add_2ac1dfe.png" alt="22" width="19" height="19"></td>
{%else%}
<td  class="td1" width="26%"><img src="//w10.hoopchina.com.cn/hybrid/static/match/page/img/player_doubt_871bf29.png" alt="22" width="19" height="19"></td>
{%/if%}
<td width="20%">伤停</br>
<span>
{%if !empty($injury.injury_part_cn) %}
{%$injury.injury_part_cn|f_escape_xml%}
{%else%}
{%$injury.injury_part|f_escape_xml%}
{%/if%}
</span>
</td>
<td width="25%">起始时间</br><span>{%date('n月j日', strtotime($injury.injury_date))%}</span></td>
<td>最新进展</br>
<span>
{%if !empty($injury.injury_returns_cn) %}
{%$injury.injury_returns_cn|f_escape_xml%}
{%else%}
<span class="injury_returns_en">{%$injury.injury_returns|f_escape_xml%}</span>
{%/if%}
</span>
</td>
</tr>
<tr>
<td></td>
<td colspan="3" class="hurt-detail">
{%if !empty($injury.injury_detail_cn) %}
{%$injury.injury_detail_cn|f_escape_xml%}
{%else%}
{%$injury.injury_detail|f_escape_xml%}
{%/if%}
</td>
</tr>
{%/if%}
{%if !empty($profile.draft)%}
<tr>
<td  width="26%" class="td1">选秀</td>
<td class="td2" colspan="3">{%$profile.draft|f_escape_xml%}</td>
</tr>
{%/if%}
{%if !empty($profile.college)%}
<tr>
<td  width="26%" class="td1">来自</td>
<td class="td2" colspan="3">{%$profile.college|f_escape_xml%}</td>
</tr>
{%/if%}
{%if !empty($profile.salary)%}
<tr>
<td  width="26%" class="td1">薪水</td>
<td class="td2" colspan="3">{%$profile.salary|f_escape_xml%}</td>
</tr>
{%/if%}
{%if !empty($profile.contract)%}
<tr>
<td  width="26%" class="td1" valign="top">合同</td>
<td class="td2" class="no-copy" colspan="3">
<div>{%$profile.contract|f_escape_xml%}</div>
<div class="contract-details">
{%$profile.contract_details|f_escape_xml%}
</div>
</td>
</tr>
{%/if%}
</table>
</div>
{%/if%}
{%if !empty($profile.extend)%}
<div class="analyze">
<h2>扩展阅读</h2>
<ul>
{%foreach $profile.extend as $val%}
<li>
<a href="{%$val.link|escape:none%}" dace-node="nbawiki">
<div class="link-title">
<p class="title">{%$val.title|f_escape_xml%}</p>
</div>
<em><i></i></em>
</a>
</li>
{%/foreach%}
</ul>
</div>
{%/if%}
<div class="data-list">
<h2>赛季数据</h2>
<ul class="clearfix">
{%foreach $season_stats as $val%}
{%if $val@index < 6 %}
{%if $val@index < 3 %}
<li class="mb">
{%else%}
<li>
{%/if%}
<div class="type">{%$val[0]|f_escape_xml%}</div>
<div class="num">{%$val[1]|f_escape_xml%}</div>
{%if !empty($val[2])%}
<div class="rank">({%$val[2]|f_escape_xml%})</div>
{%/if%}
</li>
{%/if%}
{%/foreach%}
</ul>
</div>
</section>
<section class="t-content swiper-slide t-map" id="J-t-map">
<div class="map-data" id="J-map-data">
<script id="J-map-tpl" type="text/template">
							<@ $(datas).each(function(index,item){ @>
							<input type="hidden" class="area_<@=item.areaId@>" data-fgp="<@=item.fgp@>" data-fgs="<@=item.fgs@>" <@ if(item.level ==1){ @>data-color="#ff7838"<@ }else if(item.level ==2){ @>data-color="#ffd303"<@ }else if(item.level ==3){ @>data-color="#58cce0"<@ }else{ @>data-color="#eeebeb"<@ } @> data-fgm="<@=item.fgm@>">
							<@ }); @>
						</script>
</div>
<div class="canvas-wrap">
{%if empty($night)%}
<div class="hoop hoop-day"></div>
{%else%}
<div class="hoop hoop-night"></div>
{%/if%}
<canvas id="myCanvas" width="750" height="700"></canvas>
<div class="update-time">
<span></span>更新</div>
{%if !empty($night)%}
<div class="mask"></div>
{%/if%}
<div class="logo"></div>
</div>
<input type="hidden" id="J-season-type" value="{%$season_type|f_escape_xml%}">
<dl class="tips">
<dt>三个数据分别是：该区域的命中率、命中数和出手数</dt>
<dd><span class="red"></span>命中率高于联盟平均水平</dd>
<dd><span class="yellow"></span>命中率处于联盟平均水平</dd>
<dd><span class="blue"></span>命中率低于联盟平均水平</dd>
</dl>
</section>
<section class="t-content swiper-slide t-data clearfix">
<div class="left-table fl">
<table>
<thead>
<tr>
{%foreach $career_regular_glossary[1] as $val%}
{%if $val@index < 2 %}
<td>{%$val|f_escape_xml%}</td>
{%/if%}
{%/foreach%}
</tr>
</thead>
<tbody>
{%foreach $career_regular_stats as $val%}
<tr>
<td>{%$val.season|f_escape_xml%}</td>
<td>{%$val.team_name|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
<thead>
<tr>
{%foreach $career_playoff_glossary[1] as $val%}
{%if $val@index < 2 %}
<td>{%$val|f_escape_xml%}</td>
{%/if%}
{%/foreach%}
</tr>
</thead>
<tbody>
{%foreach $career_playoff_stats as $val%}
<tr>
<td>{%$val.season|f_escape_xml%}</td>
<td>{%$val.team_name|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
</div>
<div class="right-table fr swiper-no-swiping">
<table>
<thead>
<tr>
{%foreach $career_regular_glossary[1] as $val%}
{%if $val@index >= 2 %}
<td>{%$val|f_escape_xml%}</td>
{%/if%}
{%/foreach%}
</tr>
</thead>
<tbody>
{%foreach $career_regular_stats as $val%}
<tr>
<td>{%$val.game_play|f_escape_xml%}</td>
<td>{%$val.game_start|f_escape_xml%}</td>
<td>{%$val.min|f_escape_xml%}</td>
<td>{%$val.pts|f_escape_xml%}</td>
<td>{%$val.reb|f_escape_xml%}</td>
<td>{%$val.asts|f_escape_xml%}</td>
<td>{%$val.fga|f_escape_xml%}</td>
<td>{%$val.tpa|f_escape_xml%}</td>
<td>{%$val.fpt|f_escape_xml%}</td>
<td>{%$val.stl|f_escape_xml%}</td>
<td>{%$val.to|f_escape_xml%}</td>
<td>{%$val.blk|f_escape_xml%}</td>
<td>{%$val.pf|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
<thead>
<tr>
{%foreach $career_playoff_glossary[1] as $val%}
{%if $val@index >= 2 %}
<td>{%$val|f_escape_xml%}</td>
{%/if%}
{%/foreach%}
</tr>
</thead>
<tbody>
{%foreach $career_playoff_stats as $val%}
<tr>
<td>{%$val.game_play|f_escape_xml%}</td>
<td>{%$val.game_start|f_escape_xml%}</td>
<td>{%$val.min|f_escape_xml%}</td>
<td>{%$val.pts|f_escape_xml%}</td>
<td>{%$val.reb|f_escape_xml%}</td>
<td>{%$val.asts|f_escape_xml%}</td>
<td>{%$val.fga|f_escape_xml%}</td>
<td>{%$val.tpa|f_escape_xml%}</td>
<td>{%$val.fpt|f_escape_xml%}</td>
<td>{%$val.stl|f_escape_xml%}</td>
<td>{%$val.to|f_escape_xml%}</td>
<td>{%$val.blk|f_escape_xml%}</td>
<td>{%$val.pf|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
</div>
</section>
</div>
</div>
</section>
{%require name='match:page/nba_player.tpl'%}{%/block%}
