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
            selected=3
        %}
<div class="season-content career-content">
<div class="main-title">
<h2>职业生涯常规赛平均数据</h2>
</div>
<div class="table-scroll general-table">
<table class="table">
<thead>
<tr>
<th class="number-1">场次</th>
<th class="number-2">上场时间</th>
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
<td class="number-1">{%$playerStats.REGULAR_AVG.count|f_escape_xml%}</td>
<td class="number-2">{%$playerStats.REGULAR_AVG.mins|f_escape_xml%}</td>
<td class="number-3">{%$playerStats.REGULAR_AVG.pts|f_escape_xml%}</td>
<td class="number-4">{%$playerStats.REGULAR_AVG.reb|f_escape_xml%}</td>
<td class="number-5">{%$playerStats.REGULAR_AVG.asts|f_escape_xml%}</td>
<td class="number-6">{%$playerStats.REGULAR_AVG.stl|f_escape_xml%}</td>
<td class="number-7">{%$playerStats.REGULAR_AVG.blk|f_escape_xml%}</td>
<td class="number-8">{%$playerStats.REGULAR_AVG.to|f_escape_xml%}</td>
<td class="number-9">{%$playerStats.REGULAR_AVG.fgm|f_escape_xml%}-{%$playerStats.REGULAR_AVG.fga|f_escape_xml%}</td>
<td class="number-10">{%$playerStats.REGULAR_AVG.fgp|f_escape_xml%}</td>
<td class="number-11">{%$playerStats.REGULAR_AVG.tpm|f_escape_xml%}-{%$playerStats.REGULAR_AVG.tpa|f_escape_xml%}</td>
<td class="number-12">{%$playerStats.REGULAR_AVG.tpp|f_escape_xml%}</td>
<td class="number-13">{%$playerStats.REGULAR_AVG.ftm|f_escape_xml%}-{%$playerStats.REGULAR_AVG.fta|f_escape_xml%}</td>
<td class="number-14">{%$playerStats.REGULAR_AVG.ftp|f_escape_xml%}</td>
<td class="number-15">{%$playerStats.REGULAR_AVG.foul|f_escape_xml%}</td>
</tr>
</tbody>
</table>
</div>
<div class="table-scroll">
<table class="table table-2">
<thead>
<tr>
<th class="number-1">赛季</th>
<th class="number-2">球队</th>
<th class="number-3">场次</th>
<th class="number-4">首发</th>
<th class="number-5">时间</th>
<th class="number-6">得分</th>
<th class="number-7">篮板</th>
<th class="number-8">助攻</th>
<th class="number-9">抢断</th>
<th class="number-10">盖帽</th>
<th class="number-11">失误</th>
<th class="number-12">投篮</th>
<th class="number-13">投篮命中率</th>
<th class="number-14">三分</th>
<th class="number-15">三分命中率</th>
<th class="number-16">罚球</th>
<th class="number-17">罚球命中率</th>
<th class="number-18">犯规</th>
</tr>
</thead>
<tbody>
{%foreach from=$playerStats.REGULAR item=val key=keys %}
<tr>
<td class="number-1">{%$val.season|f_escape_xml%}</td>
<td class="number-2">{%$val.team_name|f_escape_xml%}</td>
<td class="number-3">{%$val.games|f_escape_xml%}</td>
<td class="number-4">{%$val.games_started|f_escape_xml%}</td>
<td class="number-5">{%$val.mins|f_escape_xml%}</td>
<td class="number-6">{%$val.pts|f_escape_xml%}</td>
<td class="number-7">{%$val.reb|f_escape_xml%}</td>
<td class="number-8">{%$val.asts|f_escape_xml%}</td>
<td class="number-9">{%$val.stl|f_escape_xml%}</td>
<td class="number-10">{%$val.blk|f_escape_xml%}</td>
<td class="number-11">{%$val.to|f_escape_xml%}</td>
<td class="number-12">{%$val.fgm|f_escape_xml%}-{%$val.fga|f_escape_xml%}</td>
<td class="number-13">{%$val.fgp|f_escape_xml%}%</td>
<td class="number-14">{%$val.tpm|f_escape_xml%}-{%$val.tpa|f_escape_xml%}</td>
<td class="number-15">{%$val.tpp|f_escape_xml%}%</td>
<td class="number-16">{%$val.ftm|f_escape_xml%}-{%$val.fta|f_escape_xml%}</td>
<td class="number-17">{%$val.ftp|f_escape_xml%}%</td>
<td class="number-18">{%$val.foul|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
</div>
{%if isset($playerStats["PLAYOFF_AVG"]) && !empty($playerStats["PLAYOFF_AVG"])%}
<div class="main-title">
<h2>职业生涯季后赛平均数据</h2>
</div>
<div class="table-scroll general-table">
<table class="table">
<thead>
<tr>
<th class="number-1">场次</th>
<th class="number-2">上场时间</th>
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
<td class="number-1">{%$playerStats.PLAYOFF_AVG.count|f_escape_xml%}</td>
<td class="number-2">{%$playerStats.PLAYOFF_AVG.mins|f_escape_xml%}</td>
<td class="number-3">{%$playerStats.PLAYOFF_AVG.pts|f_escape_xml%}</td>
<td class="number-4">{%$playerStats.PLAYOFF_AVG.reb|f_escape_xml%}</td>
<td class="number-5">{%$playerStats.PLAYOFF_AVG.asts|f_escape_xml%}</td>
<td class="number-6">{%$playerStats.PLAYOFF_AVG.stl|f_escape_xml%}</td>
<td class="number-7">{%$playerStats.PLAYOFF_AVG.blk|f_escape_xml%}</td>
<td class="number-8">{%$playerStats.PLAYOFF_AVG.to|f_escape_xml%}</td>
<td class="number-9">{%$playerStats.PLAYOFF_AVG.fgm|f_escape_xml%}-{%$playerStats.PLAYOFF_AVG.fga|f_escape_xml%}</td>
<td class="number-10">{%$playerStats.PLAYOFF_AVG.fgp|f_escape_xml%}</td>
<td class="number-11">{%$playerStats.PLAYOFF_AVG.tpm|f_escape_xml%}-{%$playerStats.PLAYOFF_AVG.tpa|f_escape_xml%}</td>
<td class="number-12">{%$playerStats.PLAYOFF_AVG.tpp|f_escape_xml%}</td>
<td class="number-13">{%$playerStats.PLAYOFF_AVG.ftm|f_escape_xml%}-{%$playerStats.PLAYOFF_AVG.fta|f_escape_xml%}</td>
<td class="number-14">{%$playerStats.PLAYOFF_AVG.ftp|f_escape_xml%}</td>
<td class="number-15">{%$playerStats.PLAYOFF_AVG.foul|f_escape_xml%}</td>
</tr>
</tbody>
</table>
</div>
<div class="table-scroll">
<table class="table table-2">
<thead>
<tr>
<th class="number-1">赛季</th>
<th class="number-2">球队</th>
<th class="number-3">场次</th>
<th class="number-4">首发</th>
<th class="number-5">时间</th>
<th class="number-6">得分</th>
<th class="number-7">篮板</th>
<th class="number-8">助攻</th>
<th class="number-9">抢断</th>
<th class="number-10">盖帽</th>
<th class="number-11">失误</th>
<th class="number-12">投篮</th>
<th class="number-13">投篮命中率</th>
<th class="number-14">三分</th>
<th class="number-15">三分命中率</th>
<th class="number-16">罚球</th>
<th class="number-17">罚球命中率</th>
<th class="number-18">犯规</th>
</tr>
</thead>
<tbody>
{%foreach from=$playerStats.PLAYOFF item=val key=keys %}
<tr>
<td class="number-1">{%$val.season|f_escape_xml%}</td>
<td class="number-2">{%$val.team_name|f_escape_xml%}</td>
<td class="number-3">{%$val.games|f_escape_xml%}</td>
<td class="number-4">{%$val.games_started|f_escape_xml%}</td>
<td class="number-5">{%$val.mins|f_escape_xml%}</td>
<td class="number-6">{%$val.pts|f_escape_xml%}</td>
<td class="number-7">{%$val.reb|f_escape_xml%}</td>
<td class="number-8">{%$val.asts|f_escape_xml%}</td>
<td class="number-9">{%$val.stl|f_escape_xml%}</td>
<td class="number-10">{%$val.blk|f_escape_xml%}</td>
<td class="number-11">{%$val.to|f_escape_xml%}</td>
<td class="number-12">{%$val.fgm|f_escape_xml%}-{%$val.fga|f_escape_xml%}</td>
<td class="number-13">{%$val.fgp|f_escape_xml%}%</td>
<td class="number-14">{%$val.tpm|f_escape_xml%}-{%$val.tpa|f_escape_xml%}</td>
<td class="number-15">{%$val.tpp|f_escape_xml%}%</td>
<td class="number-16">{%$val.ftm|f_escape_xml%}-{%$val.fta|f_escape_xml%}</td>
<td class="number-17">{%$val.ftp|f_escape_xml%}%</td>
<td class="number-18">{%$val.foul|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
</div>
{%/if%}
</div>
</section>
{%require name='teams:page/players-career.tpl'%}{%/block%}