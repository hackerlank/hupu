{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}{%$title|f_escape_xml%}{%/block%}
{%block name="head_static"%}
{%require name="common:static/js/zepto/zepto.js"%}
{%require name="common:widget/tap-link/tap-link.js"%}
{%require name="match:widget/rank_list/rank_list.scss"%}
{%script%}
        window.GM = {
            "client": "{%$client|f_escape_js%}" || "x",
            "islogin": !!parseInt("{%$is_login|f_escape_js%}", 10),
            "night": !!parseInt("{%$night|f_escape_js%}", 10)
        };
        var allRankWrapContainer = $("#J-all-rank-wrap");
        var current = null;

        allRankWrapContainer.delegate(".link", "click", function(e){
            current = $(e.currentTarget);
            window.location.href = current.attr("link");
        });

    {%/script%}
{%style%}
.detail span {        width: 95px;        display: inline-block;        line-height: normal;        word-wrap: break-word;        vertical-align: middle;    }{%/style%}
{%/block%}
{%block name="content"%}
<section class="all-rank mod-rank" id="J-all-rank-wrap">
<table class="mod-title fixed" style="position: fixed;">
<thead>
<tr>
<td width="50%" class="type">
{%$title|f_escape_xml%}
</td>
<td width="20%" align="center">{%$value_title|f_escape_xml%}</td>
</tr>
</thead>
</table>
{%if !empty($rankData)%}
<section id="J-scroll-wrapper">
<table class="mod-table">
<tbody id="J-all-rank">
{%foreach $rankData as $val%}
<tr class="link" link="kanqiu://nba/nba/team/{%$val.team_id|f_escape_xml%}">
<td width="50%">
{%if $val@index+1==1%}
<span class="red num">{%$val@index+1%}</span>
{%else%}
<span class="num">{%$val@index+1%}</span>
{%/if%}
<span class="team_logo"><img src="{%$val.team_logo|f_escape_xml%}?t={%$val@index|f_escape_path%}" width="22" /></span>
<span class="detail">
{%if !empty($val.team_alias)%}
<span class="name">{%$val.team_alias|f_escape_xml%}</span>
{%else%}
{%$val.team_alias_en|f_escape_xml%}
{%/if%}
</span>
</td>
<td width="20%" align="center">
{%if strstr($title,"率") && $title != "进攻效率" && $title != "防守效率"%}
{%($val.value*100)|round:1%}%{%else%}
{%$val.value|round:1|f_escape_xml%}
{%/if%}
</td>
</tr>
{%/foreach%}
</tbody>
</table>
</section>
{%else%}
<div class="mod-no-result">暂无比赛数据</div>
{%/if%}
</section>
{%require name='match:page/nba_data_rank.tpl'%}{%/block%}
