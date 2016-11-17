{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="match:static/soccer-shooter/shooter.scss"%}
{%script%}
        var dace = require("common:widget/ui/page-dace/page-dace.js");
        
        $("#J-table tr").bind("click", function(e){
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
<div class="table-scroll">
<table class="table" id="J-table">
<thead>
<tr>
<th class="number-2">&nbsp;</th>
<th class="number-1">球员</th>
<th class="number-1">球队</th>
<th class="number-1">进球(点)</th>
</tr>
</thead>
<tbody dace-node="{%$id4dace|f_escape_xml%}_team">
{%foreach from=$rankInfo item=team%}
<tr data-href="{%$team.url|f_escape_xml%}">
<td class="number-2">{%$team@index+1%}</td>
<td class="number-1">{%$team["player_name"]|f_escape_xml%}</td>
<td class="number-1">{%$team["team_name"]|f_escape_xml%}</td>
<td class="number-1">{%$team.goal_count|f_escape_xml%}{%if $team.pen_goal_count%}({%$team.pen_goal_count|f_escape_xml%}){%/if%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
</div>
{%require name='match:page/soccer-shooter.tpl'%}{%/block%}