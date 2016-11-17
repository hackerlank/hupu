{%extends file="common/page/layout.tpl"%} 
{%block name="head_static"%}
{%require name="match:static/schedule/schedule.css"%}
{%require name="common:static/js/center.js"%}
{%script%}
    playersList.init();//队伍列表事件
    {%/script%}
{%/block%}
{%block name="content"%}
<div class="gamecenter_livestart">
<div class="bgs_png" style="display:none;"></div>
{%widget name="common:widget/ad-980/ad-980.tpl"%}
{%widget name="common:widget/page-tab/page-tab.tpl" title="比赛赛程"%}
{%widget
        name="common:widget/team-nav/team-nav.tpl"
        type="schedule_team"
    %}
<div class="players_right">
<table class="players_table" style="display:block;">
<tbody>
<tr class="title">
<td colspan="5" class="left" width="165"><b>{%$sub_title|f_escape_xml%}</b></td>
</tr>
{%foreach from=$match item=val key=key%}
<tr class="left linglei">
<td colspan="5" class="left" width="145">{%$key|f_escape_xml%}</td>
</tr>
<tr class="left color_font1">
<td class="left" width="155">客队vs主队</td>
<td class="left" width="135">比分</td>
<td class="left" width="120">结果</td>
<td class="left" width="145">北京时间</td>
<td class="left" width="125"></td>
</tr>
{%foreach $val as $subVal%}
<tr class="left">
<td class="left">
<a href="{%$subVal.away_link|f_escape_xml%}" target="_blank" {%if $subVal.away_name == $team.name%}style="font-weight:bold;"{%/if%}>{%$subVal.away_name|f_escape_xml%}</a>&nbsp;vs&nbsp;<a href="{%$subVal.home_link|f_escape_xml%}" target="_blank" {%if $subVal.home_name == $team.name%}style="font-weight:bold;"{%/if%}>{%$subVal.home_name|f_escape_xml%}</a>
</td>
<td class="left">
{%if $subVal.status == 1 || $subVal.status == 2%}
{%$subVal.away_score|f_escape_xml%}&nbsp;-&nbsp;{%$subVal.home_score|f_escape_xml%}
{%else%}
-{%/if%}
</td>
<td class="left">
{%if $subVal.status == 1 || $subVal.status == 2%}
{%$subVal.score_result|f_escape_xml%}
{%else%}
-{%/if%}
</td>
<td class="left">{%$subVal.time|f_escape_xml%}</td>
<td>
{%if $subVal.status == 1%}
<a target="_blank" href="{%$subVal.boxscore_link|f_escape_xml%}">数据统计</a>&nbsp;&nbsp;&nbsp;<a target="_blank" href="{%$subVal.video_link|f_escape_xml%}">比赛视频</a>
{%else if $subVal.status == 2%}
<a target="_blank" href="{%$subVal.boxscore_link|f_escape_xml%}">数据直播</a>&nbsp;&nbsp;&nbsp;<a target="_blank" href="http://goto.hupu.com/?a=goClick&id=3727">视频直播</a>
{%else%}
<a target="_blank" href="{%$subVal.boxscore_link|f_escape_xml%}">比赛前瞻</a>&nbsp;&nbsp;&nbsp;<a target="_blank" href="http://goto.hupu.com/?a=goClick&id=3727">视频直播</a>
{%/if%}
</td>
</tr>
{%/foreach%}
{%/foreach%}
</tbody>
</table>
</div>
</div>
{%require name='match:page/teamSchedule.tpl'%}{%/block%}
