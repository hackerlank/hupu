{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="match:static/match-rank/match-rank.scss"%}
{%script%}
        $("#J-table tr").bind("click", function(e){
            var target = $(e.currentTarget);
            var href = target.attr("data-href");
            if(href){
                location.href = href;
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
    	selected=1
    %}
<div class="table-scroll east-match">
<table class="table" id="J-table">
<thead>
<tr>
<th class="col-header">东部排行</th>
<th class="number-1">胜</th>
<th class="number-1">负</th>
<th class="number-1">胜场差</th>
<th class="number-1">近况</th>
</tr>
</thead>
<tbody dace-node="{%$id4dace|f_escape_xml%}_team">
{%foreach from=$standing.east item=team%}
<tr data-href="{%$team.team.link|f_escape_xml%}">
<td class="col-header">
<span class="rank{%if $team@index < 8%} red{%/if%}">{%$team@index+1%}</span>
<a href="{%$team.team.link|f_escape_xml%}">{%$team.team.name|f_escape_xml%}</a>
</td>
<td class="number-1">{%$team["win"]|f_escape_xml%}</td>
<td class="number-1">{%$team["lost"]|f_escape_xml%}</td>
<td class="number-1">{%$team["gb"]|f_escape_xml%}</td>
<td class="number-1">{%$team["strk"]|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
</div>
<div class="table-scroll west-match">
<table class="table">
<thead>
<tr>
<th class="col-header">西部排行</th>
<th class="number-1">胜</th>
<th class="number-1">负</th>
<th class="number-1">胜场差</th>
<th class="number-1">近况</th>
</tr>
</thead>
<tbody dace-node="{%$id4dace|f_escape_xml%}_team">
{%foreach from=$standing.west item=team%}
<tr data-href="{%$team.team.link|f_escape_xml%}">
<td class="col-header">
<span class="rank {%if $team@index < 8%} red{%/if%}">{%$team@index+1%}</span>
<a href="{%$team.team.link|f_escape_xml%}">{%$team.team.name|f_escape_xml%}</a>
</td>
<td class="number-1">{%$team["win"]|f_escape_xml%}</td>
<td class="number-1">{%$team["lost"]|f_escape_xml%}</td>
<td class="number-1">{%$team["gb"]|f_escape_xml%}</td>
<td class="number-1">{%$team["strk"]|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
</div>
{%require name='match:page/match-rank.tpl'%}{%/block%}