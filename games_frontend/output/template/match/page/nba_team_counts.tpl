{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}{%$result.profile.player_name|f_escape_xml%}{%/block%}
{%block name="head_static"%}
{%require name="common:static/js/zepto/zepto.js"%}
<script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
{%require name="match:static/page/football_team_data.scss"%}
{%script%}
        window.GM = {
            "client": "{%$client|f_escape_js%}" || "x",
            "version":"{%$version|f_escape_js%}"|| "7.0.6",
            "islogin": !!parseInt("{%$is_login|f_escape_js%}", 10),
            "player_name": "{%$profile.player_name|f_escape_js%}",
            "player_enname": "{%$profile.player_enname|f_escape_js%}"
        };
        var nbaTeam = require("match:widget/nba_team/nba_team.js");
        nbaTeam.init();
    {%/script%}
{%/block%}
{%block name="content"%}
<section class="football-team-data">
<div class="data-list">
<ul>
<li>
<a href="{%if isset($rankData.ptsavg) && $rankData.ptsavg != '-'%}/{%$projectId|f_escape_path%}/{%$version|f_escape_path%}/nba/getDataRank?rank_type=ptsavg{%else%}javascript:void(0){%/if%}">
<div class="score">
{%if !empty($countData.ptsavg) || $countData.ptsavg == 0%}
{%$countData.ptsavg|f_escape_xml%}
{%else%}
-{%/if%}
</div>
<div>得分</div>
{%if !empty($rankData.ptsavg) %}
<span>联盟第<b>{%$rankData.ptsavg|f_escape_xml%}</b><i></i></span>
{%/if%}
</a>
</li>
<li>
<a href="{%if isset($rankData.ortg) && $rankData.ortg != '-'%}/{%$projectId|f_escape_path%}/{%$version|f_escape_path%}/nba/getDataRank?rank_type=ortg{%else%}javascript:void(0) {%/if%}">
<div class="score">
{%if !empty($countData.ortg) || $countData.ortg == 0%}
{%$countData.ortg|round:1|f_escape_xml%}
{%else%}
-{%/if%}
</div>
<div>进攻效率</div>
{%if !empty($rankData.ortg)%}
<span>联盟第<b>{%$rankData.ortg|f_escape_xml%}</b><i></i></span>
{%/if%}
</a>
</li>
<li>
<a href="{%if isset($rankData.opptsavg) && $rankData.opptsavg != '-'%}/{%$projectId|f_escape_path%}/{%$version|f_escape_path%}/nba/getDataRank?rank_type=opptsavg{%else%}javascript:void(0) {%/if%}">
<div class="score">
{%if !empty($countData.opptsavg) || $countData.opptsavg == 0%}
{%$countData.opptsavg|f_escape_xml%}
{%else%}
-{%/if%}
</div>
<div>失分</div>
{%if !empty($rankData.opptsavg)%}
<span>联盟第<b>{%$rankData.opptsavg|f_escape_xml%}</b><i></i></span>
{%/if%}
</a>
</li>
<li>
<a href="{%if isset($rankData.drtg) && $rankData.drtg != '-'%}/{%$projectId|f_escape_path%}/{%$version|f_escape_path%}/nba/getDataRank?rank_type=drtg{%else%}javascript:void(0) {%/if%}">
<div class="score">
{%if !empty($countData.drtg) || $countData.drtg == 0%}
{%$countData.drtg|round:1|f_escape_xml%}
{%else%}
-{%/if%}
</div>
<div>防守效率</div>
{%if !empty($rankData.drtg)%}
<span>联盟第<b>{%$rankData.drtg|f_escape_xml%}</b><i></i></span>
{%/if%}
</a>
</li>
<li>
<a href="{%if isset($rankData.pace) && $rankData.pace != '-'%}/{%$projectId|f_escape_path%}/{%$version|f_escape_path%}/nba/getDataRank?rank_type=pace{%else%}javascript:void(0) {%/if%}">
<div class="score">
{%if !empty($countData.pace) || $countData.pace == 0%}
{%$countData.pace|f_escape_xml%}
{%else%}
-{%/if%}
</div>
<div>回合数</div>
{%if !empty($rankData.pace)%}
<span>联盟第<b>{%$rankData.pace|f_escape_xml%}</b><i></i></span>
{%/if%}
</a>
</li>
<li>
<a href="{%if isset($rankData.trbavg) && $rankData.trbavg != '-'%}/{%$projectId|f_escape_path%}/{%$version|f_escape_path%}/nba/getDataRank?rank_type=trbavg{%else%}javascript:void(0) {%/if%}">
<div class="score">
{%if !empty($countData.trbavg) || $countData.trbavg == 0%}
{%$countData.trbavg|f_escape_xml%}
{%else%}
-{%/if%}
</div>
<div>篮板</div>
{%if !empty($rankData.trbavg)%}
<span>联盟第<b>{%$rankData.trbavg|f_escape_xml%}</b><i></i></span>
{%/if%}
</a>
</li>
<li>
<a href="{%if isset($rankData.drbavg) && $rankData.drbavg != '-'%}/{%$projectId|f_escape_path%}/{%$version|f_escape_path%}/nba/getDataRank?rank_type=drbavg{%else%}javascript:void(0) {%/if%}">
<div class="score">
{%if !empty($countData.drbavg) || $countData.drbavg == 0%}
{%$countData.drbavg|f_escape_xml%}
{%else%}
-{%/if%}
</div>
<div>防守篮板</div>
{%if !empty($rankData.drbavg)%}
<span>联盟第<b>{%$rankData.drbavg|f_escape_xml%}</b><i></i></span>
{%/if%}
</a>
</li>
<li>
<a href="{%if isset($rankData.orbavg) && $rankData.orbavg != '-'%}/{%$projectId|f_escape_path%}/{%$version|f_escape_path%}/nba/getDataRank?rank_type=orbavg{%else%}javascript:void(0) {%/if%}">
<div class="score">
{%if !empty($countData.orbavg) || $countData.orbavg == 0%}
{%$countData.orbavg|f_escape_xml%}
{%else%}
-{%/if%}
</div>
<div>进攻篮板</div>
{%if !empty($rankData.orbavg)%}
<span>联盟第<b>{%$rankData.orbavg|f_escape_xml%}</b><i></i></span>
{%/if%}
</a>
</li>
<li>
<a href="{%if isset($rankData.astavg) && $rankData.astavg != '-'%}/{%$projectId|f_escape_path%}/{%$version|f_escape_path%}/nba/getDataRank?rank_type=astavg{%else%}javascript:void(0) {%/if%}">
<div class="score">
{%if !empty($countData.astavg) || $countData.astavg == 0%}
{%$countData.astavg|f_escape_xml%}
{%else%}
-{%/if%}
</div>
<div>助攻</div>
{%if !empty($rankData.astavg)%}
<span>联盟第<b>{%$rankData.astavg|f_escape_xml%}</b><i></i></span>
{%/if%}
</a>
</li>
<li>
<a href="{%if isset($rankData.toavg) && $rankData.toavg != '-'%}/{%$projectId|f_escape_path%}/{%$version|f_escape_path%}/nba/getDataRank?rank_type=toavg{%else%}javascript:void(0) {%/if%}">
<div class="score">
{%if !empty($countData.toavg) || $countData.toavg == 0%}
{%$countData.toavg|f_escape_xml%}
{%else%}
-{%/if%}
</div>
<div>失误</div>
{%if !empty($rankData.toavg)%}
<span>联盟第<b>{%$rankData.toavg|f_escape_xml%}</b><i></i></span>
{%/if%}
</a>
</li>
<li>
<a href="{%if isset($rankData.stavg) && $rankData.stavg != '-'%}/{%$projectId|f_escape_path%}/{%$version|f_escape_path%}/nba/getDataRank?rank_type=stavg{%else%}javascript:void(0) {%/if%}">
<div class="score">
{%if !empty($countData.stavg) || $countData.stavg == 0%}
{%$countData.stavg|f_escape_xml%}
{%else%}
-{%/if%}
</div>
<div>抢断</div>
{%if !empty($rankData.stavg)%}
<span>联盟第<b>{%$rankData.stavg|f_escape_xml%}</b><i></i></span>
{%/if%}
</a>
</li>
<li>
<a href="{%if isset($rankData.blkavg) && $rankData.blkavg != '-'%}/{%$projectId|f_escape_path%}/{%$version|f_escape_path%}/nba/getDataRank?rank_type=blkavg{%else%}javascript:void(0) {%/if%}">
<div class="score">
{%if !empty($countData.blkavg) || $countData.blkavg == 0%}
{%$countData.blkavg|f_escape_xml%}
{%else%}
-{%/if%}
</div>
<div>盖帽</div>
{%if !empty($rankData.blkavg)%}
<span>联盟第<b>{%$rankData.blkavg|f_escape_xml%}</b><i></i></span>
{%/if%}
</a>
</li>
<li>
<a href="{%if isset($rankData.fgp) && $rankData.fgp != '-'%}/{%$projectId|f_escape_path%}/{%$version|f_escape_path%}/nba/getDataRank?rank_type=fgp{%else%}javascript:void(0) {%/if%}">
<div class="score">
{%if !empty($countData.fgp) || $countData.fgp == 0%}
{%($countData.fgp*100)|round:1%}%{%else%}
-{%/if%}
</div>
<div>投篮命中率</div>
{%if !empty($rankData.fgp)%}
<span>联盟第<b>{%$rankData.fgp|f_escape_xml%}</b><i></i></span>
{%/if%}
</a>
</li>
<li>
<a href="{%if isset($rankData.tpp) && $rankData.tpp != '-'%}/{%$projectId|f_escape_path%}/{%$version|f_escape_path%}/nba/getDataRank?rank_type=tpp{%else%}javascript:void(0) {%/if%}">
<div class="score">
{%if !empty($countData.tpp) || $countData.tpp == 0%}
{%($countData.tpp*100)|round:1%}%{%else%}
-{%/if%}
</div>
<div>三分命中率</div>
{%if !empty($rankData.tpp)%}
<span>联盟第<b>{%$rankData.tpp|f_escape_xml%}</b><i></i></span>
{%/if%}
</a>
</li>
<li>
<a href="{%if isset($rankData.ftp) && $rankData.ftp != '-'%}/{%$projectId|f_escape_path%}/{%$version|f_escape_path%}/nba/getDataRank?rank_type=ftp{%else%}javascript:void(0) {%/if%}">
<div class="score">
{%if !empty($countData.ftp) || $countData.ftp == 0%}
{%($countData.ftp*100)|round:1%}%{%else%}
-{%/if%}
</div>
<div>罚球命中率</div>
{%if !empty($rankData.ftp)%}
<span>联盟第<b>{%$rankData.ftp|f_escape_xml%}</b><i></i></span>
{%/if%}
</a>
</li>
<li>
<a href="{%if isset($rankData.fta) && $rankData.fta != '-'%}/{%$projectId|f_escape_path%}/{%$version|f_escape_path%}/nba/getDataRank?rank_type=fta{%else%}javascript:void(0) {%/if%}">
<div class="score">
{%if !empty($countData.fta) || $countData.fta == 0%}
{%$countData.fta|f_escape_xml%}
{%else%}
-{%/if%}
</div>
<div>罚球</div>
{%if !empty($rankData.fta)%}
<span>联盟第<b>{%$rankData.fta|f_escape_xml%}</b><i></i></span>
{%/if%}
</a>
</li>
<li>
<a href="{%if isset($rankData.pf) && $rankData.pf != '-'%}/{%$projectId|f_escape_path%}/{%$version|f_escape_path%}/nba/getDataRank?rank_type=pf{%else%}javascript:void(0) {%/if%}">
<div class="score">
{%if !empty($countData.pf) || $countData.pf == 0%}
{%$countData.pf|f_escape_xml%}
{%else%}
-{%/if%}
</div>
<div>犯规</div>
{%if !empty($rankData.pf)%}
<span>联盟第<b>{%$rankData.pf|f_escape_xml%}</b><i></i></span>
{%/if%}
</a>
</li>
<li>
<a href="{%if isset($rankData.tf) && $rankData.tf != '-'%}/{%$projectId|f_escape_path%}/{%$version|f_escape_path%}/nba/getDataRank?rank_type=tf{%else%}javascript:void(0) {%/if%}">
<div class="score">
{%if !empty($countData.tf) || $countData.tf == 0%}
{%$countData.tf|f_escape_xml%}
{%else%}
-{%/if%}
</div>
<div>总技术犯规</div>
{%if !empty($rankData.tf)%}
<span>联盟第<b>{%$rankData.tf|f_escape_xml%}</b><i></i></span>
{%/if%}
</a>
</li>
<li>
<a href="{%if isset($rankData.ff) && $rankData.ff != '-'%}/{%$projectId|f_escape_path%}/{%$version|f_escape_path%}/nba/getDataRank?rank_type=ff{%else%}javascript:void(0) {%/if%}">
<div class="score">
{%if !empty($countData.ff)  || $countData.ff == 0%}
{%$countData.ff|f_escape_xml%}
{%else%}
-{%/if%}
</div>
<div>总恶意犯规</div>
{%if !empty($rankData.ff)%}
<span>联盟第<b>{%$rankData.ff|f_escape_xml%}</b><i></i></span>
{%/if%}
</a>
</li>
</ul>
</div>
</section>
{%require name='match:page/nba_team_counts.tpl'%}{%/block%}
