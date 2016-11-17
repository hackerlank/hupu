{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}NBA{%/block%}
{%block name="head_static"%}
{%require name="common:static/js/underscore/underscore.js"%}
{%require name="common:static/js/zepto/zepto.js"%}
{%require name="match:widget/rank_list/rank_list.scss"%}
{%script%}
        window.GM = {
            "client": "{%$client|f_escape_js%}" || "x",
            "islogin": !!parseInt("{%$is_login|f_escape_js%}", 10),
            "night": !!parseInt("{%$night|f_escape_js%}", 10)
        };

        var allRank = require("match:widget/all_rank/all_rank.js");
        allRank.init();
    {%/script%}
{%/block%}
{%block name="content"%}
<section class="all-rank mod-rank" id="J-all-rank-wrap">
<table class="mod-title fixed">
<thead>
<tr>
<td width="60%" class="type">{%$chinese|f_escape_xml%}排行榜</td>
<td width="20%" align="center">球队</td>
<td width="20%" align="center">数据</td>
</tr>
</thead>
</table>
{%if !empty($data)%}
<section id="J-scroll-wrapper">
<table class="mod-table">
<tbody id="J-all-rank">
{%foreach $data as $val%}
<tr class="link" link="kanqiu://nba/nba/player/{%$val.player_id|f_escape_xml%}">
<td width="60%">
{%if $val.rank==1%}
<span class="red num">{%$val.rank|f_escape_xml%}</span>
{%else%}
<span class="num">{%$val.rank|f_escape_xml%}</span>
{%/if%}<span class="logo"><img src="{%$val.player_header|f_escape_xml%}?t={%$val@index|f_escape_path%}" width="30" height="34" />{%if !empty($night)%}<span class="mask"></span>{%/if%}</span>
<span class="detail">
<span class="name">{%$val.player_name|f_escape_xml%}</span>
<span class="others">
{%$val.pts|f_escape_xml%}分{%$val.reb|f_escape_xml%}板{%$val.asts|f_escape_xml%}助</span>
</span>
</td>
<td width="20%" align="center">{%$val.team_name|f_escape_xml%}</td>
<td width="20%" align="center">{%$val.val|f_escape_xml%}</td>
</tr>
{%/foreach%}
<script id="J-all-rank-tpl" type="text/template">
                <@ $(datas).each(function(index,item) { @>
                <tr class="link" link="kanqiu://nba/nba/player/<@=item.player_id@>">
                    <td width="60%">
                        <@ if(item.rank == 1){ @>
                        <span class="red num"><@=item.rank@></span>
                        <@ }else{ @>
                        <span class="num"><@=item.rank@></span>
                        <@ } @><span class="logo"><img src="<@=item.player_header@>?t=<@=index@>" width="30" height="34" /><@if(GM.night){ @><span class="mask"></span><@ } @></span>
                        <span class="detail">
                            <span class="name"><@=item.player_name@></span>
                            <span class="others">
                                <@=item.pts@>分
                                <@=item.reb@>板
                                <@=item.asts@>助
                            </span>
                        </span>
                    </td>
                    <td width="20%" align="center"><@=item.team_name@></td>
                    <td width="20%" align="center"><@=item.val@></td>
                </tr>
                <@ }); @>
                </script>
</tbody>
</table>
</section>
{%else%}
<div class="mod-no-result">暂无比赛数据</div>
{%/if%}
</section>
{%require name='match:page/all_rank.tpl'%}{%/block%}
