<section class="mod-rank {%if $type == "men"%}men-basketball{%else if $type == "women"%}women-basketball{%/if%} basketball-wrap swiper-slide swiper-no-swiping" id="{%if $type == "men"%}J-men-basketball{%else if $type == "women"%}J-women-basketball{%/if%}">
{%if !empty($against_figure[$index-1])%}
{%widget
            name="match:widget/vs_soccer_data/vs_soccer_data.tpl"
            leagueName=$league_name
            type=$type
            index=$index
        %}
{%/if%}
{%if !empty($rank[$index].ranks_data["A"]) || !empty($rank[$index].ranks_data["B"])%}
{%foreach $rank[$index].ranks_data as $val%}
<table class="mod-title">
<thead>
<tr>
<td width="8%" align="center">{%if $val@index == 0%}A{%else if $val@index == 1%}B{%/if%}组</td>
<td width="34%" colspan="2" align="left">球队</td>
<td width="10%" align="center">场次</td>
<td width="6%" align="center">胜</td>
<td width="6%" align="center">负</td>
<td width="13%" align="center">总得分</td>
<td width="13%" align="center">净胜分</td>
<td width="10%" align="center">积分</td>
</tr>
</thead>
</table>
<table class="mod-table">
<tbody>
{%foreach $val as $subVal%}
<tr class="tap">
<td width="8%" align="center">
<span class="num {%if $subVal@index+1<5%}red{%/if%}">{%$subVal@index+1%}</span>
</td>
<td width="10%" align="left">
<span class="logo"><img class="lazy" width="28" data-original="{%$subVal.logo|f_escape_xml%}?{%$val@index|f_escape_xml%}{%$subVal@index|f_escape_xml%}" /></span>
</td>
<td width="24%" align="left">{%$subVal.name|f_escape_xml%}</td>
<td width="10%" align="center">{%$subVal.mp|f_escape_xml%}</td>
<td width="6%" align="center">{%$subVal.won|f_escape_xml%}</td>
<td width="6%" align="center">{%$subVal.lose|f_escape_xml%}</td>
<td width="13%" align="center">{%$subVal.tpts|f_escape_xml%}</td>
<td width="13%" align="center">{%$subVal.npts|f_escape_xml%}</td>
<td width="10%" align="center">{%$subVal.pts|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
{%/foreach%}
{%else%}
<div class="no-data">暂无{%if $type == "men"%}男{%else%}女{%/if%}篮数据</div>
{%/if%}
</section>
