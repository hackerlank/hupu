{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}{%$league_chinese|f_escape_xml%}{%/block%}
{%block name="head_static"%}
{%require name="common:static/js/zepto/zepto.js"%}
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
{%$name|f_escape_xml%}
</td>
{%if $rank_type == "goals" || $rank_type == "assits" ||  $rank_type|substr:"-2" === "_p"%}
<td width="30%" align="center">球队</td>
{%/if%}
<td width="20%" align="center">{%$title|f_escape_xml%}</td>
</tr>
</thead>
</table>
{%if !empty($data)%}
<section id="J-scroll-wrapper">
<table class="mod-table">
<tbody id="J-all-rank">
{%foreach $data as $val%}
<tr {%if $league_name != "afccl"%}class="link"{%/if%}
                {%if $rank_type == "goals" || $rank_type == "assits" || $rank_type|substr:"-2" === "_p"%}
                    {%if $league_name != "afccl"%}
                    link="kanqiu://soccerleagues/{%$league_name|f_escape_xml%}/player/{%$val.player_pid|f_escape_xml%}"
                    {%/if%}
                {%else%}
                link="kanqiu://soccerleagues/{%$league_name|f_escape_xml%}/team/{%$val.team_id|f_escape_xml%}"
                {%/if%}>
<td width="50%">
{%if $val@index+1==1%}
<span class="red num">{%$val@index+1%}</span>
{%else%}
<span class="num">{%$val@index+1%}</span>
{%/if%}
{%if $rank_type == "goals" || $rank_type == "assits" || $rank_type|substr:"-2" === "_p"%}
<span class="logo"><img src="{%$val.player_logo|f_escape_xml%}?t={%$val@index|f_escape_path%}" width="30" />{%if !empty($night)%}<span class="mask"></span>{%/if%}</span>
{%else%}
<span class="team_logo"><img src="{%$val.team_logo|f_escape_xml%}?t={%$val@index|f_escape_path%}" width="34" /></span>
{%/if%}
<span class="detail">
{%if $rank_type == "goals" || $rank_type == "assits" || $rank_type|substr:"-2" === "_p"%}
<span class="name">{%$val.player_name|f_escape_xml%}</span>
{%else%}
<span class="name">{%$val.team_name|f_escape_xml%}</span>
{%/if%}
</span>
</td>
{%if $rank_type == "goals" || $rank_type == "assits" || $rank_type|substr:"-2" === "_p"%}
<td width="30%" align="center" style="line-height: normal; vertical-align: middle;">{%$val.team_name|f_escape_xml%}</td>
<td width="20%" align="center">
{%if $rank_type == "pass_per_p"%}
{%$val[$rank_type]*100%}%{%else%}
{%if $league_name == "afccl" || $league_name == "chlg" || $league_name == "uefael"%}
{%$val[$field]|f_escape_xml%}
{%else%}
{%$val[$rank_type]|f_escape_xml%}
{%/if%}
{%/if%}
</td>
{%else%}
<td width="20%" align="center">
{%if $rank_type == "pass_per"%}
{%$val[$field]*100%}%{%else%}
{%$val[$field]|f_escape_xml%}
{%/if%}
</td>
{%/if%}
</tr>
{%/foreach%}
</tbody>
</table>
</section>
{%else%}
<div class="mod-no-result">暂无比赛数据</div>
{%/if%}
</section>
{%require name='match:page/all_rank_data.tpl'%}{%/block%}
