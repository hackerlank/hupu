<section class="team-rank mod-rank swiper-slide swiper-no-swiping" id="J-team-rank">
{%$isAssistsAllEmpty = true%}
{%foreach $rank[1].ranks_data as $val%}
{%if $val.data%}
{%$isAssistsAllEmpty = false%}
{%/if%}
{%/foreach%}
{%if !$isAssistsAllEmpty%}
<div class="nav">
<ul>
{%foreach $rank[2].ranks_data as $val%}
<li {%if $val@index == 0%} class="active" {%/if%}><a href="javascript:void(0);">{%$val.name|f_escape_xml%}</a></li>
{%/foreach%}
</ul>
</div>
<ul class="main">
{%foreach $rank[2].ranks_data as $val%}
{%if $val.data%}
<li>
<table class="mod-title title">
<thead>
<tr>
<td width="70%" colspan="2" class="type"><span>{%$val.name|f_escape_xml%}榜</span></td>
<td width="30%" align="center">{%$val.title|f_escape_xml%}</td>
</tr>
</thead>
</table>
<table class="mod-table">
<tbody>
{%foreach $val.data as $subVal%}
{%if $subVal@index < 5%}
<tr class="link tap" link="kanqiu://soccerleagues/{%$league_name|f_escape_xml%}/team/{%$subVal.team_id|f_escape_xml%}">
<td width="70%" align="left">
<span {%if $subVal@index+1 == 1%} class="red num" {%else%} class="num" {%/if%}>{%$subVal@index+1%}</span>
<span class="logo">
<img data-original="{%$subVal.team_logo|f_escape_xml%}?t={%$val@index|f_escape_xml%}{%$subVal@index|f_escape_xml%}" width="34" class="lazy">
</span>
<span class="name">{%$subVal.team_name|f_escape_xml%}</span>
</td>
<td width="30%" align="center">
{%if $val.rank_type == "pass_per"%}
{%$subVal[$val.field]*100%}%{%else%}
{%$subVal[$val.field]|f_escape_xml%}
{%/if%}
</td>
</tr>
{%/if%}
{%/foreach%}
<tr class="last-tr">
<td colspan="3" align="center">
<span class="view-all link all-link tap" link="/data/footballAllRank" data-type="{%$val.rank_type|f_escape_xml%}"
							>查看全部 ></span>
</td>
</tr>
</tbody>
</table>
</li>
{%/if%}
{%/foreach%}
</ul>
{%else%}
<div class="mod-no-data">暂无球队榜数据</div>
{%/if%}
</section>
