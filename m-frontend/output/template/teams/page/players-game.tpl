{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="teams:static/players-game/game-data.scss"%}
{%script%}
        var toShare = require("common:widget/ui/share/share.js");

        //全局分享事件, 每个页面单独注册.
        $(document).on("page:share", function(){
        toShare();
        });
    {%/script%}
{%/block%}
{%block name="content"%}
{%widget
        name="common:widget/inner-top-nav/nav.tpl"
    %}
<section class="m-wrap playersGameData-wrap">
{%widget
            name="teams:widget/player-header/header.tpl"
        %}
{%widget
            name="common:widget/inner-tab/tab.tpl"
            tabClass="players"
            selected=2
        %}
{%assign var="regular" value=[
            "title"=>"本赛季常规赛平均数据",
            "avg"=>$playerStats.playerStatsAvg,
            "playerStats"=>$playerStats.playerStats
        ]%}
{%assign var="playoff" value=[
            "title"=>"本赛季季后赛平均数据",
            "avg"=>$playerStats.playerStatsAvg,
            "playerStats"=>$playerStats.playerStats
        ]%}
{%$playerData=[]%}
{%if $isPlayOff %}
{%$playerData=$playoff%}
{%else%}
{%$playerData=$regular%}
{%/if%}
<div class="season-content">
<div class="main-title">
<h2>{%$playerData["title"]|f_escape_xml%}</h2>
</div>
<div class="table-scroll">
<table class="table">
<thead>
<tr>
<th class="number-1">场次</th>
<th class="number-2">时间</th>
<th class="number-3">得分</th>
<th class="number-4">篮板</th>
<th class="number-5">助攻</th>
<th class="number-6">抢断</th>
<th class="number-7">盖帽</th>
<th class="number-8">失误</th>
<th class="number-9">投篮</th>
<th class="number-10">投篮命中率</th>
<th class="number-11">三分</th>
<th class="number-12">三分命中率</th>
<th class="number-13">罚球</th>
<th class="number-14">罚球命中率</th>
<th class="number-15">犯规</th>
</tr>
</thead>
<tbody>
<tr>
<td class="number-1">{%$playerData.avg.count|f_escape_xml%}</td>
<td class="number-2">{%$playerData.avg.mins|f_escape_xml%}</td>
<td class="number-3">{%$playerData.avg.pts|f_escape_xml%}</td>
<td class="number-4">{%$playerData.avg.reb|f_escape_xml%}</td>
<td class="number-5">{%$playerData.avg.asts|f_escape_xml%}</td>
<td class="number-6">{%$playerData.avg.stl|f_escape_xml%}</td>
<td class="number-7">{%$playerData.avg.blk|f_escape_xml%}</td>
<td class="number-8">{%$playerData.avg.to|f_escape_xml%}</td>
<td class="number-9">{%$playerData.avg.fgm|f_escape_xml%}-{%$playerData.avg.fga|f_escape_xml%}</td>
<td class="number-10">{%$playerData.avg.fgp|f_escape_xml%}</td>
<td class="number-11">{%$playerData.avg.tpm|f_escape_xml%}-{%$playerData.avg.tpa|f_escape_xml%}</td>
<td class="number-12">{%$playerData.avg.tpp|f_escape_xml%}</td>
<td class="number-13">{%$playerStats.playerStatsAvg.ftm|f_escape_xml%}-{%$playerData.avg.fta|f_escape_xml%}</td>
<td class="number-14">{%$playerData.avg.ftp|f_escape_xml%}</td>
<td class="number-15">{%$playerData.avg.foul|f_escape_xml%}</td>
</tr>
</tbody>
</table>
</div>
{%foreach from=$playerStats.playerStats item=contact key=keys %}
<div class="month-title">
<h4>{%$keys|f_escape_xml%}月</h4>
</div>
<div class="table-scroll">
<table class="table table-1">
<thead>
<tr>
<th class="number-1">日期</th>
<th class="number-2">对手</th>
<th class="number-3">比分</th>
<th class="number-4">时间</th>
<th class="number-5">得分</th>
<th class="number-6">篮板</th>
<th class="number-7">助攻</th>
<th class="number-8">抢断</th>
<th class="number-9">盖帽</th>
<th class="number-10">失误</th>
<th class="number-11">投篮</th>
<th class="number-12">投篮命中率</th>
<th class="number-13">三分</th>
<th class="number-14">三分命中率</th>
<th class="number-15">罚球</th>
<th class="number-16">罚球命中率</th>
<th class="number-17">犯规</th>
</tr>
</thead>
<tbody>
{%foreach from=$contact item=val key=k %}
<tr>
<td class="number-1">{%$val.china_time_fix|f_escape_xml%}</td>
<td class="number-2">{%$val.opt_team_name|f_escape_xml%}</td>
<td class="number-3">{%$val.vs|f_escape_xml%}</td>
<td class="number-4">{%$val.mins|f_escape_xml%}</td>
<td class="number-5">{%$val.pts|f_escape_xml%}</td>
<td class="number-6">{%$val.reb|f_escape_xml%}</td>
<td class="number-7">{%$val.asts|f_escape_xml%}</td>
<td class="number-8">{%$val.stl|f_escape_xml%}</td>
<td class="number-9">{%$val.blk|f_escape_xml%}</td>
<td class="number-10">{%$val.to|f_escape_xml%}</td>
<td class="number-11">{%$val.fgm|f_escape_xml%}-{%$val.fga|f_escape_xml%}</td>
<td class="number-12">{%$val.fgp|f_escape_xml%}%</td>
<td class="number-13">{%$val.tpm|f_escape_xml%}-{%$val.tpa|f_escape_xml%}</td>
<td class="number-14">{%$val.tpp|f_escape_xml%}%</td>
<td class="number-15">{%$val.ftm|f_escape_xml%}-{%$val.fta|f_escape_xml%}</td>
<td class="number-16">{%$val.ftp|f_escape_xml%}%</td>
<td class="number-17">{%$val.foul|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
</div>
{%/foreach%}
</div>
</section>
{%require name='teams:page/players-game.tpl'%}{%/block%}