{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="match:static/post-season/post-season.scss"%}
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
{%widget
    	name="common:widget/inner-tab/tab.tpl"
    	tabClass="matchafter"
    	selected=2
    %}
<div class="table-scroll post-season">
<table class="table" id="J-table">
<thead>
<tr>
<th class="col-header">排行</th>
<th class="number-1">得分</th>
<th class="number-1">篮板</th>
<th class="number-1">助攻</th>
<th class="number-1">抢断</th>
<th class="number-1">盖帽</th>
<th class="number-1">失误</th>
</tr>
</thead>
<tbody dace-node="{%$id4dace|f_escape_xml%}_team">
{%foreach from=$stats item=team%}
<tr data-href="{%$team.team_link|f_escape_xml%}">
<td class="col-header">
<span class="rank">{%$team.rank|f_escape_xml%}</span>
<a href="{%$team.team_link|f_escape_xml%}">{%$team["team_name"]|f_escape_xml%}</a>
</td>
<td class="number-1">{%$team.pts|f_escape_xml%}</td>
<td class="number-1">{%$team.reb|f_escape_xml%}</td>
<td class="number-1">{%$team.ast|f_escape_xml%}</td>
<td class="number-1">{%$team.st|f_escape_xml%}</td>
<td class="number-1">{%$team.blk|f_escape_xml%}</td>
<td class="number-1">{%$team.to|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
</div>
{%require name='match:page/post-season.tpl'%}{%/block%}