{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}足球球队页{%/block%}
{%block name="head_static"%}
{%require name="common:static/js/zepto/zepto.js"%}
<script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
{%require name="match:static/page/football_team_data.scss"%}
{%/block%}
final_ent_avg saves goals_setpiece{%block name="content"%}
<section class="football-team-data">
<div class="data-list">
<ul>
{%foreach from=$data item=val key=key%}
<li>
<a href="/data/footballAllRank?client={%$client|f_escape_path%}&league_name={%$league_name|f_escape_path%}&rank_type={%$key|f_escape_path%}&from_type=2%}">
{%if $key == possession_percentage || $key == pass_per%}
<div class="score">{%($val.value_avg*100)|round:1%}%</div>
{%elseif $key == goals || $key == goals_conceded || $key == clean_sheet || $key == total_yel_card  || $key == total_red_card%}
<div class="score">{%$val.value_count|f_escape_xml%}</div>
{%else%}
<div class="score">{%$val.value_avg|f_escape_xml%}</div>
{%/if%}
<div>{%$val.title|f_escape_xml%}</div>
{%if $val.rank_index != "-"%}
<span>联赛第<b>{%$val.rank_index|f_escape_xml%}</b><img height=9; src="//w10.hoopchina.com.cn/hybrid/static/match/page/img/arrow-right-day_ad31f94.png" alt="arrow"></span>
{%/if%}
</a>
</li>
{%/foreach%}</ul>
</div>
</section>
{%require name='match:page/football_team_data.tpl'%}{%/block%}
