{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="teams:static/teams-data/teams.scss"%}
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
<section class="m-wrap teams-data-wrap">
{%widget
            name="teams:widget/team-header/header.tpl"
        %}
{%widget
            name="common:widget/inner-tab/tab.tpl"
            tabClass="team"
            selected=1
        %}
<div class="main-content">
<div class="table-col-1">
<table class="table table-2">
<thead>
<tr>
<th class="number-1">球员</th>
</tr>
</thead>
<tbody>
{%foreach from=$playerStats item=val key=keys %}
<tr>
<td class="number-1"><a href="{%$val.player_link|f_escape_xml%}">{%$val.alias|cut:7|f_escape_xml%}</a></td>
</tr>
{%/foreach%}
</tbody>
</table>
<div class="table-scroll">
<table class="table table-1">
<thead>
<tr>
<th class="number-13">位置</th>
<th class="number-2">场数</th>
<th class="number-3">首发数</th>
<th class="number-4">时间</th>
<th class="number-5">得分</th>
<th class="number-6">篮板</th>
<th class="number-7">助攻</th>
<th class="number-8">抢断</th>
<th class="number-9">盖帽</th>
<th class="number-10">失误</th>
<th class="number-11">三分</th>
<th class="number-12">罚球</th>
</tr>
</thead>
<tbody>
{%foreach from=$playerStats item=val key=keys %}
<tr>
<td class="number-13">{%$val["position"]|f_escape_xml%}</td>
<td class="number-2">{%$val["games"]|f_escape_xml%}</td>
<td class="number-3">{%$val["games_started"]|f_escape_xml%}</td>
<td class="number-4">{%$val["mins"]|f_escape_xml%}</td>
<td class="number-5">{%$val["pts"]|f_escape_xml%}</td>
<td class="number-6">{%$val["reb"]|f_escape_xml%}</td>
<td class="number-7">{%$val["asts"]|f_escape_xml%}</td>
<td class="number-8">{%$val["stl"]|f_escape_xml%}</td>
<td class="number-9">{%$val["blk"]|f_escape_xml%}</td>
<td class="number-10">{%$val["to"]|f_escape_xml%}</td>
<td class="number-11">{%$val["tpt"]|f_escape_xml%}</td>
<td class="number-12">{%$val["fpt"]|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
</div>
</div>
<table class="table table-3">
<thead>
<tr>
<th class="number-1">技术统计</th>
<th class="number-2">数值</th>
<th class="number-3">联盟排名</th>
</tr>
</thead>
<tbody>
<tr>
<td class="number-1">场均得分</td>
<td class="number-2">{%$teamsStats["pts_score"]|f_escape_xml%}</td>
<td class="number-3">{%$teamsStats["pts"]|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">场均篮板</td>
<td class="number-2">{%$teamsStats["reb_score"]|f_escape_xml%}</td>
<td class="number-3">{%$teamsStats["reb"]|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">场均助攻</td>
<td class="number-2">{%$teamsStats["ast_score"]|f_escape_xml%}</td>
<td class="number-3">{%$teamsStats["ast"]|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">场均失误</td>
<td class="number-2">{%$teamsStats["tno_score"]|f_escape_xml%}</td>
<td class="number-3">{%$teamsStats["tno"]|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">场均失分</td>
<td class="number-2">{%$teamsStats["lts_score"]|f_escape_xml%}</td>
<td class="number-3">{%$teamsStats["lts"]|f_escape_xml%}</td>
</tr>
</tbody>
</table>
</div>
</section>
{%require name='teams:page/teams-data.tpl'%}{%/block%}