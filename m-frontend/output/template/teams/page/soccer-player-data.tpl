{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="teams:static/soccer-player-data/soccer-player-data.scss"%}
{%require name="teams:static/soccer-player-data/soccer-player-data.js"%}
{%script%}
        var toShare = require("common:widget/ui/share/share.js");
		
		var url = window.location.href.replace("stats", "player");

        //全局分享事件, 每个页面单独注册.
        $(document).on("page:share", function(){
        	toShare({
        		url: url
        	});
        });
    {%/script%}
{%/block%}
{%block name="content"%}
{%widget
        name="common:widget/inner-top-nav/nav.tpl" shareOpen=false
    %}
<section class="m-wrap soccerPlayerData-wrap">
{%widget
            name="teams:widget/player-header/player-header.tpl"
            type="soccer"
        %}
<nav>
<a href="{%$playerInfo.page_urls.info_url|f_escape_xml%}" class="info">基本信息</a><a href="javascript:void(0);" class="active">赛季数据</a>
</nav>
<section class="league-data">
<h2 class="mod-title-h2"><span class="icon"></span>联赛数据</h2>
{%if !empty($gameStats)%}
<div class="bd">
<dl class="match-list">
<dt>球员数据/赛事最高值</dt>
{%if !empty($gameStats)%}
{%foreach $gameStats as $item%}
{%if $playerInfo.position_type == 3 || $playerInfo.position_type == 4%}
<dd>
<div class="match">{%$item.league_name|f_escape_xml%}</div>
<ul>
<li>
<div class="progress">
<div class="inner" style="width: {%if $item.goals_best.val == 0%}100%{%else%}{%$item.goals/$item.goals_best.val*100%}%{%/if%}">
<span class="text">
<span class="rank">
{%if !empty($item.goals_sort)%}
(赛事第{%$item.goals_sort|f_escape_xml%}){%/if%}
</span>进球{%$item.goals|f_escape_xml%}{%if !empty($item.att_pen_goal)%}(点球{%$item.att_pen_goal|f_escape_xml%}){%/if%}
</span>
</div>
</div>
<div class="num">{%$item.goals_best.val|f_escape_xml%}</div>
</li>
<li>
<div class="progress">
<div class="inner" style="width: {%if $item.goal_assist_best.val == 0%}100%{%else%}{%$item.goal_assist/$item.goal_assist_best.val*100%}%{%/if%}">
<span class="text">
<span class="rank">
{%if !empty($item.goal_assist_sort)%}
(赛事第{%$item.goal_assist_sort|f_escape_xml%}){%/if%}
</span>
助攻{%$item.goal_assist|f_escape_xml%}
</span>
</div>
</div>
<div class="num">{%$item.goal_assist_best.val|f_escape_xml%}</div>
</li>
<li>
<div class="progress">
<div class="inner" style="width: {%if $item.total_pass_best.val == 0%}100%{%else%}{%$item.total_pass/$item.total_pass_best.val*100%}%{%/if%}">
<span class="text">传球{%$item.total_pass|f_escape_xml%}</span>
</div>
</div>
<div class="num">{%$item.total_pass_best.val|f_escape_xml%}</div>
</li>
</ul>
</dd>
{%else if $playerInfo.position_type == 2%}
<dd>
<div class="match">{%$item.league_name|f_escape_xml%}</div>
<ul>
<li>
<div class="progress">
<div class="inner" style="width: {%if $item.total_tackle_best.val == 0%}100%{%else%}{%$item.total_tackle/$item.total_tackle_best.val*100%}%{%/if%}">
<span class="text">抢断{%$item.total_tackle|f_escape_xml%}</span>
</div>
</div>
<div class="num">{%$item.total_tackle_best.val|f_escape_xml%}</div>
</li>
<li>
<div class="progress">
<div class="inner" style="width: {%if $item.total_clearance_best.val == 0%}100%{%else%}{%$item.total_clearance/$item.total_clearance_best.val*100%}%{%/if%}">
<span class="text">解围{%$item.total_clearance|f_escape_xml%}</span>
</div>
</div>
<div class="num">{%$item.total_clearance_best.val|f_escape_xml%}</div>
</li>
<li>
<div class="progress">
<div class="inner" style="width: {%if $item.interception_best.val == 0%}100%{%else%}{%$item.interception/$item.interception_best.val*100%}%{%/if%}">
<span class="text">拦截{%$item.interception|f_escape_xml%}</span>
</div>
</div>
<div class="num">{%$item.interception_best.val|f_escape_xml%}</div>
</li>
</ul>
</dd>
{%else if $playerInfo.position_type == 1%}
<dd>
<div class="match">{%$item.league_name|f_escape_xml%}</div>
<ul>
<li>
<div class="progress">
<div class="inner" style="width: {%if $item.saves_best.val == 0%}100%{%else%}{%$item.saves/$item.saves_best.val*100%}%{%/if%}">
<span class="text">扑救{%$item.saves|f_escape_xml%}</span>
</div>
</div>
<div class="num">{%$item.saves_best.val|f_escape_xml%}</div>
</li>
<li>
<div class="progress">
<div class="inner" style="width: {%if $item.total_pass_best.val == 0%}100%{%else%}{%$item.total_pass/$item.total_pass_best.val*100%}%{%/if%}">
<span class="text">传球{%$item.total_pass|f_escape_xml%}</span>
</div>
</div>
<div class="num">{%$item.total_pass_best.val|f_escape_xml%}</div>
</li>
</ul>
</dd>
{%else%}
<dd>
<div class="match">{%$item.league_name|f_escape_xml%}</div>
<ul>
<li>
<div class="progress">
<div class="inner" style="width: {%if $item.goals_best.val == 0%}100%{%else%}{%$item.goals/$item.goals_best.val*100%}%{%/if%}">
<span class="text">
<span class="rank">
{%if !empty($item.goals_sort)%}
(赛事第{%$item.goals_sort|f_escape_xml%}){%/if%}
</span>进球{%$item.goals|f_escape_xml%}{%if !empty($item.att_pen_goal)%}(点球{%$item.att_pen_goal|f_escape_xml%}){%/if%}
</span>
</div>
</div>
<div class="num">{%$item.goals_best.val|f_escape_xml%}</div>
</li>
<li>
<div class="progress">
<div class="inner" style="width: {%if $item.goal_assist_best.val == 0%}100%{%else%}{%$item.goal_assist/$item.goal_assist_best.val*100%}%{%/if%}">
<span class="text">
<span class="rank">
{%if !empty($item.goal_assist_sort)%}
(赛事第{%$item.goal_assist_sort|f_escape_xml%}){%/if%}
</span>
助攻{%$item.goal_assist|f_escape_xml%}
</span>
</div>
</div>
<div class="num">{%$item.goal_assist_best.val|f_escape_xml%}</div>
</li>
<li>
<div class="progress">
<div class="inner" style="width: {%if $item.total_pass_best.val == 0%}100%{%else%}{%$item.total_pass/$item.total_pass_best.val*100%}%{%/if%}">
<span class="text">传球{%$item.total_pass|f_escape_xml%}</span>
</div>
</div>
<div class="num">{%$item.total_pass_best.val|f_escape_xml%}</div>
</li>
</ul>
</dd>
{%/if%}
{%/foreach%}
{%/if%}
</dl>
<ul class="detail-list">
{%if !empty($gameStats)%}
{%foreach $gameStats as $val%}
<li>
<div>
<span class="title-col col1">
<span class="key">赛事</span>
<span class="value">{%$val.league_name|f_escape_xml%}</span>
</span>
<span class="title-col col2">
<span class="line">|</span><span class="key">球队</span>
<span class="value">{%$val.team_name|f_escape_xml%}</span>
</span>
</div>
{%if $playerInfo.position_type == 1%}
<div>
<span class="col">
<span class="key">进球/点球</span>
<span class="value">{%$val.goals|f_escape_xml%}/{%$val.att_pen_goal|f_escape_xml%}</span>
</span>
<span class="col">
<span class="key">扑救</span>
<span class="value">{%$val.saves|f_escape_xml%}</span>
</span>
<span class="col">
<span class="key">助攻</span>
<span class="value">{%$val.goal_assist|f_escape_xml%}</span>
</span>
</div>
<div>
<span class="col">
<span class="key">传球</span>
<span class="value">{%$val.total_pass|f_escape_xml%}</span>
</span>
<span class="col">
<span class="key">抢断</span>
<span class="value">{%$val.total_tackle|f_escape_xml%}</span>
</span>
<span class="col">
<span class="key">解围</span>
<span class="value">{%$val.total_clearance|f_escape_xml%}</span>
</span>
</div>
<div>
<span class="col">
<span class="key">拦截</span>
<span class="value">{%$val.interception|f_escape_xml%}</span>
</span>
<span class="col">
<span class="key">黄/红牌</span>
<span class="value">{%$val.yellow_card|f_escape_xml%}/{%$val.red_card|f_escape_xml%}</span>
</span>
<span class="col">
<span class="key">出场/首发</span>
<span class="value">{%$val.played|f_escape_xml%}/{%$val.status|f_escape_xml%}</span>
</span>
</div>
<div>
<span class="col">
<span class="key">上场时间</span>
<span class="value">{%$val.mins_played|f_escape_xml%}'</span>
</span>
</div>
{%else%}
<div>
<span class="col">
<span class="key">进球/点球</span>
<span class="value">{%$val.goals|f_escape_xml%}/{%$val.att_pen_goal|f_escape_xml%}</span>
</span>
<span class="col">
<span class="key">助攻</span>
<span class="value">{%$val.goal_assist|f_escape_xml%}</span>
</span>
<span class="col">
<span class="key">传球</span>
<span class="value">{%$val.total_pass|f_escape_xml%}</span>
</span>
</div>
<div>
<span class="col">
<span class="key">抢断</span>
<span class="value">{%$val.total_tackle|f_escape_xml%}</span>
</span>
<span class="col">
<span class="key">解围</span>
<span class="value">{%$val.total_clearance|f_escape_xml%}</span>
</span>
<span class="col">
<span class="key">拦截</span>
<span class="value">{%$val.interception|f_escape_xml%}</span>
</span>
</div>
<div>
<span class="col">
<span class="key">黄/红牌</span>
<span class="value">{%$val.yellow_card|f_escape_xml%}/{%$val.red_card|f_escape_xml%}</span>
</span>
<span class="col">
<span class="key">出场/首发</span>
<span class="value">{%$val.played|f_escape_xml%}/{%$val.status|f_escape_xml%}</span>
</span>
<span class="col">
<span class="key">上场时间</span>
<span class="value">{%$val.mins_played|f_escape_xml%}'</span>
</span>
</div>
{%/if%}
</li>
{%/foreach%}
{%/if%}
</ul>
</div>
{%else%}
<div class="mod_no_result">暂无联赛数据</div>
{%/if%}
</section>
<section class="recent-data" id="J-recent-data">
<h2 class="mod-title-h2"><span class="icon"></span>最近比赛</h2>
{%if !empty($lastgames)%}
{%if $playerInfo.position_type == 3 || $playerInfo.position_type == 4%}
<table>
<thead>
<tr>
<th>日期</th>
<th>对手</th>
<th>比分</th>
<th>进球/点球</th>
<th>助攻</th>
<th>传球</th>
</tr>
</thead>
<tbody>
{%foreach $lastgames as $val%}
<tr class="item" link="{%$val.link_url|f_escape_xml%}">
<td>{%$val.gtime|f_escape_xml%}</td>
<td width="35%">{%$val.opt_team_name|f_escape_xml%}</td>
<td>{%$val.vs|escape:none%}</td>
<td>{%$val.goals|f_escape_xml%}/{%$val.att_pen_goal|f_escape_xml%}</td>
<td>{%$val.goal_assist|f_escape_xml%}</td>
<td>{%$val.total_pass|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
{%else if $playerInfo.position_type == 2%}
<table>
<thead>
<tr>
<th>日期</th>
<th>对手</th>
<th>比分</th>
<th>抢断</th>
<th>解围</th>
<th>拦截</th>
</tr>
</thead>
<tbody>
{%foreach $lastgames as $val%}
<tr class="item" link="{%$val.link_url|f_escape_xml%}">
<td>{%$val.gtime|f_escape_xml%}</td>
<td width="40%">{%$val.opt_team_name|f_escape_xml%}</td>
<td>{%$val.vs|escape:none%}</td>
<td>{%$val.total_tackle|f_escape_xml%}</td>
<td>{%$val.total_clearance|f_escape_xml%}</td>
<td>{%$val.interception|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
{%else if $playerInfo.position_type == 1%}
<table>
<thead>
<tr>
<th>日期</th>
<th>对手</th>
<th>比分</th>
<th>扑救</th>
<th>传球</th>
</tr>
</thead>
<tbody>
{%foreach $lastgames as $val%}
<tr class="item" link="{%$val.link_url|f_escape_xml%}">
<td>{%$val.gtime|f_escape_xml%}</td>
<td width="40%">{%$val.opt_team_name|f_escape_xml%}</td>
<td>{%$val.vs|escape:none%}</td>
<td>{%$val.saves|f_escape_xml%}</td>
<td>{%$val.total_pass|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
{%/if%}
{%else%}
<div class="mod_no_result">暂无最近比赛</div>
{%/if%}
</section>
</section>
{%require name='teams:page/soccer-player-data.tpl'%}{%/block%}