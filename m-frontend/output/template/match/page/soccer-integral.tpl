{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="match:static/soccer-integral/integral.scss"%}
{%script%}
        var dace = require("common:widget/ui/page-dace/page-dace.js");
        
        $(".table tr").bind("click", function(e){
            var target = $(e.currentTarget);
            var href = target.attr("data-href");
            if(href){
                location.href = href;
                dace.send(__daceDataNameOfPage + "_team");
            }
        });
    {%/script%}
{%/block%}
{%block name="content"%}
{%widget
        name="common:widget/top-nav/top-nav.tpl"
    %}
{%$area=[]%}
{%if !empty($rankInfo)%}
<div class="table-col-1">
<div class="team-score table-fixed">
<table class="table">
<thead>
<tr>
<th>排名</th>
<th>球队</th>
</tr>
</thead>
<tbody>
{%foreach from=$rankInfo item=team name=infoKey%}
{%if !empty($team.grade)%}
{%$area = array_merge($area, [
                                   $team.grade.color => $team.grade.text
                                ])%}
{%/if%}
<tr data-href="{%$team.url|f_escape_xml%}">
<td class="text-center" {%if !empty($team.grade)%}style="color:{%$team.grade.color|f_escape_xml%}"{%/if%}>{%$team.rank_index|f_escape_xml%}</td>
<td>{%$team.known_name_zh|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
</div>
<div class="table-scroll team-score home">
<table class="table">
<thead>
<tr>
<th class="number-1">积分</th>
<th class="number-1">场次</th>
<th class="number-1">胜/平/负</th>
<th class="number-1">进球</th>
<th class="number-1">失球</th>
<th class="number-1">净胜球</th>
<th class="number-1">场均进球</th>
<th class="number-1">场均失球</th>
<th class="number-1">场均净胜</th>
<th class="number-1">场均积分</th>
</tr>
</thead>
<tbody>
{%foreach from=$rankInfo item=team name=infoKey%}
<tr data-href="{%$team.url|f_escape_xml%}">
<td class="number-1">{%$team.score|default:"--"|f_escape_xml%}</td>
<td class="number-1">{%$team.played|default:"--"|f_escape_xml%}</td>
<td class="number-1">{%$team.win|default:"-"|f_escape_xml%}/{%$team.draw|default:"-"|f_escape_xml%}/{%$team.lost|default:"-"|f_escape_xml%}</td>
<td class="number-1">{%$team.hits|default:"--"|f_escape_xml%}</td>
<td class="number-1">{%$team.miss|default:"--"|f_escape_xml%}</td>
<td class="number-1">{%$team.difference|default:"--"|f_escape_xml%}</td>
<td class="number-1">{%$team.avg_goal_hit|default:"--"|f_escape_xml%}</td>
<td class="number-1">{%$team.avg_goal_lost|default:"--"|f_escape_xml%}</td>
<td class="number-1">{%$team.avg_goal_win|default:"--"|f_escape_xml%}</td>
<td class="number-1">{%$team.avg_score|default:"--"|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
</div>
</div>
{%if !empty($area)%}
<div class="soccer-mark">
{%foreach $area as $key => $item%}
<div class="mark-item">
<span class="mark-icon" style="background-color:{%$key|f_escape_xml%}"></span>
{%$item|f_escape_xml%}
</div>
{%/foreach%}
</div>
{%/if%}
{%else%}
<div class="score-nodata">暂无数据</div>
{%/if%}
{%require name='match:page/soccer-integral.tpl'%}{%/block%}