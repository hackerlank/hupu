{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}{%$league_chinese|f_escape_xml%}{%/block%}
{%block name="head_static"%}
{%require name="common:static/js/zepto/zepto.js"%}
{%require name="common:static/js/swiper/js/swiper.jquery.js"%}
{%require name="common:static/js/swiper/css/swiper.css"%}
{%require name="match:static/rank_public/rank_public.scss"%}
{%require name="match:static/fifa_rank_data/fifa_rank_data.scss"%}
{%script%}
		window.GM = {
            "client": "{%$client|f_escape_js%}" || "x",
            "islogin": !!parseInt("{%$is_login|f_escape_js%}", 10),
            "night":!!parseInt("{%$night|f_escape_js%}", 10)
        };

		var fifaRankData = require("match:widget/fifa_rank_data/fifa_rank_data.js");
		fifaRankData.init();
    {%/script%}
{%/block%}
{%block name="content"%}
<section class="mod-rank-wrap" id="J-mod-rank-wrap">
{%widget
            name="match:widget/mod_tab/mod_tab.tpl"
            leagueName = {%$league_name|f_escape_xml%}
        %}
<section class="swiper-container">
<section class="swiper-wrapper">
<section class="world mod-rank swiper-slide swiper-no-swiping" id="J-world">
<div class="main">
{%if !empty($world)%}
<table class="mod-title title">
<thead>
<td width="10%" align="center">排名</td>
<td width="6%" align="center">&nbsp;</td>
<td width="64%" colspan="2" align="left">球队</td>
<td width="20%" align="center">本月积分</td>
</thead>
</table>
<table class="mod-table">
<tbody>
{%foreach $world as $val%}
<tr class="tap link {%if $val.name_zh == "中国"%}tr-china{%/if%}" {%if !empty($val.team_id)%}link="kanqiu://soccerleagues/{%$league_name|f_escape_xml%}/team/{%$val.team_id|f_escape_xml%}"{%/if%}>
<td width="10%" align="center">
<span class="num">{%$val.rank|f_escape_xml%}</span>
</td>
<td width="6%" align="center">
{%if $val.rank == $val.previous_rank%}
<span class="state-stable">-</span>
{%else if $val.rank < $val.previous_rank%}
<span class="state-up"><i><small>{%$val.previous_rank-$val.rank%}</small></i></span>
{%else if $val.rank > $val.previous_rank%}
<span class="state-down"><i><small>{%$val.rank-$val.previous_rank%}</small></i></span>
{%/if%}
</td>
<td width="10%" align="left">
<span class="logo"><img class="lazy" width="28" data-original="{%$val.team_logo|f_escape_xml%}?{%$val@index|f_escape_xml%}" /></span>
</td>
<td width="54%" align="left">{%$val.name_zh|f_escape_xml%}</td>
<td width="20%" align="center">{%$val.points|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
{%else%}
<div class="no-data">暂无数据</div>
{%/if%}
</div>
</section>
<section class="asia mod-rank swiper-slide swiper-no-swiping" id="J-asia">
<div class="main">
{%if !empty($aisa)%}
<table class="mod-title title">
<thead>
<td width="10%" align="center">排名</td>
<td width="6%" align="center">&nbsp;</td>
<td width="54%" colspan="2" align="left">球队</td>
<td width="15%" align="center">亚洲</td>
<td width="15%" align="center">本月积分</td>
</thead>
</table>
<table class="mod-table">
<tbody>
{%foreach $aisa as $val%}
<tr class="tap link {%if $val.name_zh == "中国"%}tr-china{%/if%}" {%if !empty($val.team_id)%}link="kanqiu://soccerleagues/{%$league_name|f_escape_xml%}/team/{%$val.team_id|f_escape_xml%}"{%/if%}>
<td width="10%" align="center">
<span class="num">{%$val.rank|f_escape_xml%}</span>
</td>
<td width="6%" align="center">
{%if $val.rank == $val.previous_rank%}
<span class="state-stable">-</span>
{%else if $val.rank < $val.previous_rank%}
<span class="state-up"><i><small>{%$val.previous_rank-$val.rank%}</small></i></span>
{%else if $val.rank > $val.previous_rank%}
<span class="state-down"><i><small>{%$val.rank-$val.previous_rank%}</small></i></span>
{%/if%}
</td>
<td width="10%" align="left">
<span class="logo"><img class="lazy" width="28" data-original="{%$val.team_logo|f_escape_xml%}?{%$val@index|f_escape_xml%}" /></span>
</td>
<td width="44%" align="left">{%$val.name_zh|f_escape_xml%}</td>
<td width="15%" align="center">{%$val.afc_rank|f_escape_xml%}</td>
<td width="15%" align="center">{%$val.points|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
{%else%}
<div class="no-data">暂无数据</div>
{%/if%}
</div>
</section>
</section>
</section>
</section>
{%require name='match:page/fifa_rank_data.tpl'%}{%/block%}
