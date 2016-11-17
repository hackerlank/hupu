{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}前瞻{%/block%}
{%block name="head_static"%}
{%require name="match:static/preview_data/preview_data.scss"%}
{%script%}
        window.GM = {
            "version": "{%$version|f_escape_js%}"||"7.0.13"
        };

    	var tapLink = require("common:widget/tap-link/tap-link.js");
    	tapLink.init($("#J-preview-wrap"));

        var version = require("common:widget/ui-versions/ui-versions.js");
        if(version.gte(GM.version,"7.0.13")){
            $(".huputv").show();
        }
    {%/script%}
{%/block%}
{%block name="content"%}
{%if empty($summary) && empty($home) && empty($away) && empty($live_video_list) && empty($rank)%}
<script>
			var winHeight = window.innerHeight;
			var docHeight = document.body.offsetHeight;
			if(docHeight < winHeight){
				var style = document.createElement("style");
				style.innerHTML = "html,body{height:100%;}";
				document.body.appendChild(style);
			}
		</script>
<div class="no-recap">暂无前瞻，请先去其他比赛看看吧！</div>
{%else%}
<section class="preview-wrap" id="J-preview-wrap">
<section class="media" {%if empty($video_room_list) && empty($live_video_list.tv) && empty($live_video_list.huputv) && empty($live_video_list.net)%} style="margin-bottom: 0;"{%/if%}>
{%if !empty($live_video_list.net)%}
<div class="live">
<h2>网络直播</h2>
<ul class="clearfix">
{%foreach $live_video_list.net as $val%}
<li>
<a {%if !empty($val.url)%}href="{%$val.url|f_escape_xml%}" dace-node="livevideo"{%else%}href="javascript:void(0);" {%/if%} class="item ellipsis {%if empty($val.url)%}no-link{%/if%}">{%$val.name|default:"网络直播{%$val@index+1|f_escape_xml%}"%}</a>
{%if !empty($val.pay)%}
<span class="pay">付费</span>
{%/if%}
</li>
{%/foreach%}
</ul>
</div>
{%/if%}
{%if !empty($live_video_list.tv)%}
<div class="tv">
<h2>电视直播</h2>
<ul class="clearfix">
{%foreach $live_video_list.tv as $val%}
<li>
<a {%if !empty($val.url)%} href="{%$val.url|f_escape_xml%}" dace-node="livevideo"{%else%}href="javascript:void(0);"{%/if%} class="item ellipsis {%if empty($val.url)%}no-link{%/if%}">{%$val.name|default:"电视直播{%$val@index+1|f_escape_xml%}"%}</a>
{%if !empty($val.pay)%}
<span class="pay">付费</span>
{%/if%}
</li>
{%/foreach%}
</ul>
</div>
{%/if%}
{%if !empty($live_video_list.huputv)%}
<div class="huputv" style="display:none;">
<h2>虎扑TV</h2>
<ul class="clearfix">
{%foreach $live_video_list.huputv as $val%}
<li>
<a {%if !empty($val.url)%} href="{%$val.url|f_escape_xml%}" dace-node="livevideo"{%else%}href="javascript:void(0);"{%/if%} class="item ellipsis {%if empty($val.url)%}no-link{%/if%}">{%$val.name|default:"虎扑TV直播{%$val@index+1|f_escape_xml%}"%}</a>
</li>
{%/foreach%}
</ul>
</div>
{%/if%}
</section>
{%if !empty($summary) || !empty($home) || !empty($away)%}
<section class="main">
<ul>
{%if !empty($summary)%}
<li>
<div class="left">
<span style="font-size: 10px;">前瞻</span>
</div>
<div class="right">{%$summary|escape:none%}</div>
</li>
{%/if%}
{%if !empty($home)%}
<li>
<div class="left">
{%if !empty($home_logo)%}<img src="{%$home_logo|f_escape_xml%}?t=1">{%/if%}
</div>
<div class="right">{%$home|escape:none%}</div>
</li>
{%/if%}
{%if !empty($away)%}
<li>
<div class="left">
{%if !empty($away_logo)%}<img src="{%$away_logo|f_escape_xml%}?t=2">{%/if%}
</div>
<div class="right">{%$away|escape:none%}</div>
</li>
{%/if%}
</ul>
</section>
{%/if%}
{%if isset($absence)%}
<section class="absence">
<h2>缺席比赛</h2>
<div class="teams clearfix">
<div class="left fl">
<span class="logo">{%if !empty($home_logo)%}<img src="{%$home_logo|f_escape_xml%}?t=3">{%/if%}</span><span class="name">{%$home_name|f_escape_xml%}</span>
</div>
<div class="right fr">
<span class="name">{%$away_name|f_escape_xml%}</span><span class="logo">{%if !empty($away_logo)%}<img src="{%$away_logo|f_escape_xml%}?t=4">{%/if%}</span>
</div>
</div>
{%if empty($absence)%}
{%else%}
<div class="tables">
<div class="left">
<table>
{%foreach $absence[$home_tid] as $val%}
<tr>
<td>
{%if $val.reason == 1%}
<span class="yellow">
<span class="card1"></span>
<span class="card2"></span>
</span>
{%else if $val.reason == 2%}
<span class="red"></span>
{%else if $val.reason == 3%}
<span class="suspended">停赛</span>
{%else if $val.reason == 4%}
<span class="injured">受伤</span>
{%else%}
<span>无</span>
{%/if%}
</td>
<td class="link" link="kanqiu://soccerleagues/{%$league_name|f_escape_xml%}/player/{%$val.player_id|f_escape_xml%}">
<div class="link-inner">
<span class="player">{%$val.number|f_escape_xml%}</span>
<span class="name ellipsis">{%$val.player_name|f_escape_xml%}</span>
</div>
</td>
</tr>
{%/foreach%}
{%if $absence[$home_tid]|count <  $absence[$away_tid]|count%}
{%$loop = $absence[$away_tid]|count-$absence[$home_tid]|count%}
{%if $absence[$home_tid]|count == 0%}
{%section name=list loop=$loop%}
{%if $smarty.section.list.index == 0%}
<tr>
<td colspan="2" style="text-align: left; padding-left: 40px;">全员健康</td>
</tr>
{%else%}
<tr>
<td>&nbsp;&nbsp;</td>
<td>&nbsp;&nbsp;</td>
</tr>
{%/if%}
{%/section%}
{%else%}
{%section name=list loop=$loop%}
<tr>
<td>&nbsp;&nbsp;</td>
<td>&nbsp;&nbsp;</td>
</tr>
{%/section%}
{%/if%}
{%/if%}
</table>
</div>
<div class="right">
<table>
{%foreach $absence[$away_tid] as $val%}
<tr>
<td>
{%if $val.reason == 1%}
<span class="yellow">
<span class="card1"></span>
<span class="card2"></span>
</span>
{%else if $val.reason == 2%}
<span class="red"></span>
{%else if $val.reason == 3%}
<span class="suspended">停赛</span>
{%else if $val.reason == 4%}
<span class="injured">受伤</span>
{%else%}
<span>无</span>
{%/if%}
</td>
<td class="link" link="kanqiu://soccerleagues/{%$league_name|f_escape_xml%}/player/{%$val.player_id|f_escape_xml%}">
<div class="link-inner">
<span class="player">{%$val.number|f_escape_xml%}</span>
<span class="name ellipsis">{%$val.player_name|f_escape_xml%}</span>
</div>
</td>
</tr>
{%/foreach%}
{%if $absence[$away_tid]|count <  $absence[$home_tid]|count%}
{%$loop = $absence[$home_tid]|count-$absence[$away_tid]|count%}
{%if $absence[$away_tid]|count == 0%}
{%section name=list loop=$loop%}
{%if $smarty.section.list.index == 0%}
<tr>
<td colspan="2" style="text-align: right; padding-right: 40px;">全员健康</td>
</tr>
{%else%}
<tr>
<td>&nbsp;&nbsp;</td>
<td>&nbsp;&nbsp;</td>
</tr>
{%/if%}
{%/section%}
{%else%}
{%section name=list loop=$loop%}
<tr>
<td>&nbsp;&nbsp;</td>
<td>&nbsp;&nbsp;</td>
</tr>
{%/section%}
{%/if%}
{%/if%}
</table>
</div>
</div>
{%/if%}
</section>
{%/if%}
{%if isset($rank)%}
{%if !empty($rank)%}
<section class="rank">
<table>
<tr>
<th>排行</th>
<th>球队</th>
<th>场次</th>
<th>胜</th>
<th>平</th>
<th>负</th>
<th>进/失</th>
<th>积分</th>
</tr>
{%foreach $rank as $val%}
<tr class="link" link="kanqiu://soccerleagues/{%$league_name|f_escape_xml%}/team/{%$val.team_id|f_escape_xml%}">
<td class="num {%if $val.ranking == 1%} red {%/if%}">{%$val.ranking|f_escape_xml%}</td>
<td class="logo">{%if !empty($val.team_logo)%}<img src="{%$val.team_logo|f_escape_xml%}?t=1{%$val@index|f_escape_path%}">{%/if%}</td>
<td>{%$val.played|f_escape_xml%}</td>
<td>{%$val.wins|f_escape_xml%}</td>
<td>{%$val.ties|f_escape_xml%}</td>
<td>{%$val.losses|f_escape_xml%}</td>
<td>{%$val.goalsFor_goalsAgainst|f_escape_xml%}</td>
<td>{%$val.points|f_escape_xml%}</td>
</tr>
{%/foreach%}
</table>
</section>
{%/if%}
{%/if%}
{%if !empty($odds)%}
<section class="odds">
<ul>
<li>
欧赔即时：<span class="mod-circle circle-win">胜</span><span class="num">{%$odds.win|f_escape_xml%}</span><span class="mod-circle circle-draw">平</span><span class="num">{%$odds.draw|f_escape_xml%}</span><span class="mod-circle circle-lose">负</span><span class="num">{%$odds.lost|f_escape_xml%}</span>
</li>
<li>
<a href="{%$odds.url|f_escape_xml%}" dace-node="matchlottery">更多赔率数据 ></a>
</li>
</ul>
</section>
{%/if%}
</section>
{%/if%}
{%require name='match:page/preview_data.tpl'%}{%/block%}
