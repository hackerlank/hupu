{%extends file="common/page/layout.tpl"%} 
{%if !empty($is_app)%}
{%block name="title"%}
{%$info.name|f_escape_xml%}
{%/block%}
{%/if%}
{%block name="block_head_static"%}
{%require name="teams:static/app-nba-player/app-nba-player.scss"%}
{%require name="common:static/js/swiper_new/swiper.css"%}
{%require name="common:static/js/swiper_new/swiper.jquery.js"%}
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
            "type": "{%$type|f_escape_js%}" || "nba",
            "player_name": "{%$info.name|f_escape_js%}",
            "player_enname": "{%$info.eng_name|f_escape_js%}",
            "cur_url": "{%$cur_url|f_escape_js%}",
            "player_id": "{%$info.id|f_escape_js%}",
            "isBirth": !!parseInt("{%$info.is_birthday|f_escape_js%}", 10),
            "isApp": !!parseInt("{%$is_app|f_escape_js%}", 10)
        };

        var nbaPlayer = require("teams:widget/app-nba-player/app-nba-player.js");
        nbaPlayer.init();
    {%/script%}
{%/block%}
{%block name="content"%}
{%if empty($is_app)%}
{%widget
        name="common:widget/inner-top-nav/nav.tpl"
    %}
{%/if%}
<section class="nba-player-wrap" id="J-nba-player-wrap">
<section class="info">
<div class="head">
<img src="{%$info.big_photo|f_escape_xml%}">
{%if !empty($kanqiu.night)%}<div class="mask"></div>{%/if%}
</div>
<ul class="detail">
{%if !empty($is_app)%}
{%$arr=[]%}
{%if !empty($team_name)%}
{%$tmp=array_push($arr,$team_name)%}
{%/if%}
{%if $info.number != ""%}
{%$tmp=array_push($arr,$info.number|cat:"号")%}
{%/if%}
{%if !empty($info.positionZhName)%}
{%$tmp=array_push($arr,$info.positionZhName)%}
{%/if%}
<li>
{%foreach $arr as $val%}
<span>{%$val|f_escape_xml%}</span>
{%if $val@index != $arr|count - 1%}
<i class="separator">|</i>
{%/if%}
{%/foreach%}
</li>
<li>
{%if $info.team_id != 0%}
{%if !empty($info.death_time)%}
<span>逝世({%$info.birth_date_fix2|f_escape_xml%}-{%$info.death_time|f_escape_xml%})</span>
{%else%}
<span>
<span class="birth-status J-birth-status">
<img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/2x/1f382.png?t=1" width="15" height="15">
</span>
{%$info.age|f_escape_xml%}岁<span class="birth-status J-birth-status">
<img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/2x/1f382.png" width="15" height="15">
</span>
</span>
{%if !empty($info.birth_date_fix2) && !empty($info.age)%}
<i class="separator">|</i>
{%/if%}
<span id="J-birth-date">{%$info.birth_date_fix2|f_escape_xml%}</span>
{%/if%}
{%else%}
<span id="J-birth-date">{%$info.birth_date_fix2|f_escape_xml%}</span>
{%/if%}
</li>
<li>
{%if !empty($info.country)%}
{%foreach $info.country as $val%}
<span class="country">
<span class="flag" style="background-image:url(//b3.hoopchina.com.cn/images/country/{%$val|f_escape_xml%}.jpg);">{%if !empty($kanqiu.night)%}<div class="mask"></div>{%/if%}</span><span class="name">{%$val|f_escape_xml%}</span>
</span>&nbsp;&nbsp;{%/foreach%}
{%/if%}
</li>
{%else%}
<li>
{%if !empty($info.name)%}
<span>{%$info.name|f_escape_xml%}</span>
{%if !empty($info.name) && !empty($info.eng_name)%}
<i class="separator">|</i>
{%/if%}
<span>{%$info.eng_name|f_escape_xml%}</span>
{%else%}
<span>{%$info.eng_name|f_escape_xml%}</span>
{%/if%}
</li>
<li>
{%if $info.number!=""%}
<span>{%$info.number|f_escape_xml%}号</span>
{%/if%}
{%if ($info.number!="" && !empty($info.positionZhName)) || ($info.number!="" && !empty($info.country))%}
<i class="separator">|</i>
{%/if%}
<span>{%$info.positionZhName|f_escape_xml%}</span>
{%if !empty($info.positionZhName) && !empty($info.country)%}
<i class="separator">|</i>
{%/if%}
{%if !empty($info.country)%}
{%foreach $info.country as $val%}
<span class="country">
<span class="flag" style="background-image:url(//b3.hoopchina.com.cn/images/country/{%$val|f_escape_xml%}.jpg);">{%if !empty($kanqiu.night)%}<div class="mask"></div>{%/if%}</span><span class="name">{%$val|f_escape_xml%}</span>
</span>&nbsp;&nbsp;{%/foreach%}
{%/if%}
</li>
<li>
{%if $info.team_id != 0%}
{%if !empty($info.death_time)%}
<span>逝世({%$info.birth_date_fix2|f_escape_xml%}-{%$info.death_time|f_escape_xml%})</span>
{%else%}
<span>
<span class="birth-status J-birth-status">
<img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/2x/1f382.png?t=1" width="15" height="15">
</span>
{%$info.age|f_escape_xml%}岁<span class="birth-status J-birth-status">
<img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/2x/1f382.png" width="15" height="15">
</span>
</span>
{%if !empty($info.birth_date_fix2) && !empty($info.age)%}
<i class="separator">|</i>
{%/if%}
<span id="J-birth-date">{%$info.birth_date_fix2|f_escape_xml%}</span>
{%/if%}
{%else%}
<span id="J-birth-date">{%$info.birth_date_fix2|f_escape_xml%}</span>
{%/if%}
</li>
{%/if%}
</ul>
</section>
<ul class="tab clearfix" id="J-tab">
<li class="active">资料</li>
<li class="tab-map" data-playerid="{%$info.player_id|f_escape_xml%}">投篮热图</li>
<li>数据</li>
<li>新闻</li>
</ul>
<div class="swiper-container">
<div class="swiper-wrapper">
<section class="t-content swiper-slide t-info">
<ul class="section body-list">
<li>
<div class="num">
<span>{%$info.height_fix|default:"不详"|f_escape_xml%}
{%if !empty($info.height_fix)%}
<i>米</i>
{%/if%}
</span>
</div>
<div class="type">身高</div>
</li>
<li>
<div class="num">
<span>{%$info.wingspan|default:"不详"|f_escape_xml%}
{%if !empty($info.wingspan)%}
<i>米</i>
{%/if%}
</span>
</div>
<div class="type">臂展</div>
</li>
<li>
<div class="num">
<span>{%$info.standing_reach|default:"不详"|f_escape_xml%}
{%if !empty($info.standing_reach)%}
<i>米</i>
{%/if%}
</span>
</div>
<div class="type">站立摸高</div>
</li>
<li>
<div class="num">
<span>{%$info.weight_fix|default:"不详"|f_escape_xml%}
{%if !empty($info.weight_fix)%}
<i class="two">公斤</i>
{%/if%}
</span>
</div>
<div class="type">体重</div>
</li>
</ul>
{%if !empty($info.draft_year)||!empty($info.draft_round)||!empty($info.draft_pick)||!empty($info.college)||!empty($info.salary)||!empty($info.contract)%}
<div class="info-list">
<table width="100%">
{%if !empty($injury)%}
<tr>
{%if $injury.injury_state == "1" %}
<td  class="td1" width="26%"><img src="//b2.hoopchina.com.cn/touch/static/teams/app-nba-player/img/player_add_2ac1dfe.png" alt="22" width="19" height="19"></td>
{%else%}
<td  class="td1" width="26%"><img src="//b3.hoopchina.com.cn/touch/static/teams/app-nba-player/img/player_doubt_871bf29.png" alt="22" width="19" height="19"></td>
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
{%if !empty($info.draft_year) || !empty($info.draft_round) || !empty($info.draft_pick)%}
<tr>
<td  width="26%" class="td1">选秀</td>
<td class="td2" colspan="3">
{%if $info.territorial_pick == 1%}
{%$info.draft_year|f_escape_xml%}年 地域选秀<a href=" https://nba.hupu.com/wiki/%E5%9C%B0%E5%9F%9F%E9%80%89%E7%A7%80" rel="noreferrer">
<i class="icon-notice"></i>
</a>
{%else%}
{%$info.draft_year|f_escape_xml%}年第{%$info.draft_round|f_escape_xml%}轮第{%$info.draft_pick|f_escape_xml%}顺位{%/if%}
</td>
</tr>
{%/if%}
{%if !empty($info.college_school)%}
<tr>
<td  width="26%" class="td1">来自</td>
<td class="td2" colspan="3">{%$info.college_school|f_escape_xml%}</td>
</tr>
{%/if%}
{%if !empty($info.salary)%}
<tr>
<td  width="26%" class="td1">薪水</td>
<td class="td2" colspan="3">{%$info.salary|f_escape_xml%}万美元</td>
</tr>
{%/if%}
{%if !empty($info.wage)%}
<tr>
<td  width="26%" class="td1" valign="top">合同</td>
<td class="td2" class="no-copy" colspan="3">
<div>{%$info.wage|f_escape_xml%}</div>
<div class="contract-details" style="display:none;">
{%$info.contract_details|f_escape_xml%}
</div>
{%if !empty($info.contract_details)%}
<div class="btn-detail" id="J-btn-detail"><i class="icon icon-down"></i><span>详细</span></div>
{%/if%}
</td>
</tr>
{%/if%}
</table>
</div>
{%/if%}
{%if !empty($info.extend)%}
<div class="section analyze">
<h2>扩展阅读</h2>
<ul>
{%foreach $info.extend as $val%}
<li class="li-item
                                    {%if $info.extend|count <= 4%}
                                        {%if $val@index > 3%}more-li{%/if%}
                                    {%else%}
                                        {%if $val@index > 2%}more-li{%/if%}
                                    {%/if%}
                                ">
<a href="{%$val.video_link|escape:none%}" dace-node="nbawiki" rel="noreferrer">
<div class="link-title">
<p class="title">{%$val.video_title|f_escape_xml%}</p>
</div>
<em><i></i></em>
</a>
</li>
{%/foreach%}
{%if $info.extend|count > 4%}
<li class="other-item">
<input type="hidden" name="name" id="left-video" value="{%$info.extend|count - 3%}">
<a href="javascript:;" id="J-more" class="more" data-more="1"><em>更多{%$info.extend|count - 3%}条</em><i class="icon icon-arrow-down"></i></a>
</li>
{%/if%}
</ul>
</div>
{%/if%}
<div class="section data-list data-list1">
<h2>赛季数据</h2>
<ul class="clearfix">
{%foreach $rank as $val%}
{%if $val@index < 12 %}
<li class="mb">
{%else%}
<li>
{%/if%}
<div class="num">{%$val[2]|f_escape_xml%}</div>
<div class="type">{%$val[0]|f_escape_xml%}</div>
{%if !empty($val[1]) && $val[1] < 100%}
<div class="rank">
<a href="{%if !empty($is_app)%}{%$val[3]|escape:none%}{%else%}javascript:void(0);{%/if%}">联盟第<span>{%$val[1]|f_escape_xml%}</span>&nbsp;{%if !empty($is_app)%}<i></i>{%/if%}</a>
</div>
{%/if%}
</li>
{%/foreach%}
</ul>
</div>
<div class="section data-list data-list2">
<h2>进阶数据</h2>
<ul class="clearfix">
{%foreach $advance as $val%}
{%if $val@index < 9 %}
<li class="mb">
{%else%}
<li>
{%/if%}
<div class="num">{%$val[2]|f_escape_xml%}</div>
<div class="type">{%$val[0]|f_escape_xml%}</div>
{%if !empty($val[1]) && $val[1] > 1000000%}
<div class="rank">
<a href="{%if !empty($is_app)%}{%$val[3]|escape:none%}{%else%}javascript:void(0);{%/if%}">联盟第<span>{%$val[1]|f_escape_xml%}</span>&nbsp;{%if !empty($is_app)%}<i></i>{%/if%}</a>
</div>
{%/if%}
</li>
{%/foreach%}
</ul>
<div class="analyze">
<ul>
<li class="li-item">
<a href="https://nba.hupu.com/wiki/%E8%BF%9B%E9%98%B6%E6%95%B0%E6%8D%AE" rel="noreferrer">
<div class="link-title">
<p class="title">虎扑篮球百科：eFG%、TS%等进阶数据说明</p>
</div>
<em><i></i></em>
</a>
</li>
</ul>
</div>
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
{%if empty($kanqiu.night)%}
<div class="hoop hoop-day"></div>
{%else%}
<div class="hoop hoop-night"></div>
{%/if%}
<canvas id="myCanvas" width="750" height="700"></canvas>
<div class="update-time">
<span></span>更新</div>
{%if !empty($kanqiu.night)%}
<div class="mask"></div>
{%/if%}
<div class="logo"></div>
</div>
<div class="condition clearfix">
<div class="select fl">
<div class="inner">
<div class="default"><span>{%$season|mb_substr:2:2:'utf-8'|f_escape_xml%}-{%$season|mb_substr:2:2:'utf-8' + 1%}</span>赛季<i></i></div>
<ul class="option" style="display: none;">
{%foreach $season_list as $val%}
<li data-season="20{%$val|truncate:2:''|f_escape_xml%}" data-text="{%$val|f_escape_xml%}">{%$val|f_escape_xml%}赛季</li>
{%/foreach%}
</ul>
</div>
</div>
<div class="radio fr">
<input type="hidden" id="J-season-type" value="{%$season_type|f_escape_xml%}">
<div class="inner">
{%if $season_type == "regular"%}
<span class="active" data-type="regular">常规赛</span><span data-type="playoff">季后赛</span>
{%else%}
<span data-type="regular">常规赛</span><span class="active" data-type="playoff">季后赛</span>
{%/if%}
</div>
</div>
</div>
<dl class="tips">
<dt>三个数据分别是：该区域的命中率、命中数和出手数</dt>
<dd><span class="red"></span>命中率高于联盟平均水平</dd>
<dd><span class="yellow"></span>命中率处于联盟平均水平</dd>
<dd><span class="blue"></span>命中率低于联盟平均水平</dd>
</dl>
</section>
<section class="t-content swiper-slide t-data">
<div class="section clearfix">
<div class="left-table fl">
<table>
<thead>
<tr>
<td>常规赛</td>
<td>球队</td>
</tr>
</thead>
<tbody>
{%foreach $career.regular as $val%}
<tr>
<td>{%$val.season|f_escape_xml%}</td>
<td>{%$val.team_name|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
<thead>
<tr>
<td>季后赛</td>
<td>球队</td>
</tr>
</thead>
<tbody>
{%foreach $career.playoff as $val%}
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
<td>年龄</td>
<td>出场</td>
<td>首发</td>
<td>时间</td>
<td>得分</td>
<td>篮板</td>
<td>前板</td>
<td>后板</td>
<td>助攻</td>
<td>抢断</td>
<td>盖帽</td>
<td>投篮</td>
<td>三分</td>
<td>eFG%</td>
<td>罚球</td>
<td>TS%</td>
<td>失误</td>
<td>犯规</td>
</tr>
</thead>
<tbody>
{%foreach $career.regular as $val%}
<tr>
<td>{%$val.age|f_escape_xml%}</td>
<td>{%$val.game_play|f_escape_xml%}</td>
<td>{%$val.game_start|f_escape_xml%}</td>
<td>{%$val.min|f_escape_xml%}</td>
<td>{%$val.pts|f_escape_xml%}</td>
<td>{%$val.reb|f_escape_xml%}</td>
<td>{%$val.oreb|f_escape_xml%}</td>
<td>{%$val.dreb|f_escape_xml%}</td>
<td>{%$val.asts|f_escape_xml%}</td>
<td>{%$val.stl|f_escape_xml%}</td>
<td>{%$val.blk|f_escape_xml%}</td>
<td>{%$val.fga|f_escape_xml%}</td>
<td>{%$val.tpa|f_escape_xml%}</td>
<td>{%$val.efgp|f_escape_xml%}</td>
<td>{%$val.fpt|f_escape_xml%}</td>
<td>{%$val.tsp|f_escape_xml%}</td>
<td>{%$val.to|f_escape_xml%}</td>
<td>{%$val.pf|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
<thead>
<tr>
<td>年龄</td>
<td>出场</td>
<td>首发</td>
<td>时间</td>
<td>得分</td>
<td>篮板</td>
<td>前板</td>
<td>后板</td>
<td>助攻</td>
<td>抢断</td>
<td>盖帽</td>
<td>投篮</td>
<td>三分</td>
<td>eFG%</td>
<td>罚球</td>
<td>TS%</td>
<td>失误</td>
<td>犯规</td>
</tr>
</thead>
<tbody>
{%foreach $career.playoff as $val%}
<tr>
<td>{%$val.age|f_escape_xml%}</td>
<td>{%$val.game_play|f_escape_xml%}</td>
<td>{%$val.game_start|f_escape_xml%}</td>
<td>{%$val.min|f_escape_xml%}</td>
<td>{%$val.pts|f_escape_xml%}</td>
<td>{%$val.reb|f_escape_xml%}</td>
<td>{%$val.oreb|f_escape_xml%}</td>
<td>{%$val.dreb|f_escape_xml%}</td>
<td>{%$val.asts|f_escape_xml%}</td>
<td>{%$val.stl|f_escape_xml%}</td>
<td>{%$val.blk|f_escape_xml%}</td>
<td>{%$val.fga|f_escape_xml%}</td>
<td>{%$val.tpa|f_escape_xml%}</td>
<td>{%$val.efgp|f_escape_xml%}</td>
<td>{%$val.fpt|f_escape_xml%}</td>
<td>{%$val.tsp|f_escape_xml%}</td>
<td>{%$val.to|f_escape_xml%}</td>
<td>{%$val.pf|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
</div>
</div>
<div class="section analyze">
<ul>
<li class="li-item">
<a href="https://nba.hupu.com/wiki/%E8%BF%9B%E9%98%B6%E6%95%B0%E6%8D%AE" rel="noreferrer">
<div class="link-title">
<p class="title">虎扑篮球百科：eFG%、TS%等进阶数据说明</p>
</div>
<em><i></i></em>
</a>
</li>
</ul>
</div>
</section>
<section class="t-content swiper-slide t-news" id="J-t-news">
<ul id="J-news-wrap">
<script id="J-news-tpl" type="text/template">
                            <@ $(datas).each(function(index,item){ @>
                            <li>
                                <a href="
                                <@if(GM.isApp){@>
                                    <@=item.app_url@>
                                <@}else{@>
                                    <@=item.m_url@>
                                <@}@>">
                                    <div class="pic" style="background-image:url(<@=item.img@>);"><@if(GM.night){@><div class="mask"></div><@}@></div>
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
</section>
</div>
</div>
</section>
{%require name='teams:page/app-nba-player.tpl'%}{%/block%}
