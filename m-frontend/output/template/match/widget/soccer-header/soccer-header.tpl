<header class="match-header">
<div class="match-name">
{%if !empty($gameInfo["round_type_str"])%}
{%$gameInfo["leagueCN"]|f_escape_xml%}{%$gameInfo["round_type_str"]|f_escape_xml%}
{%else%}
{%$gameInfo["leagueCN"]|f_escape_xml%}第{%$gameInfo["match_day"]|f_escape_xml%}轮{%/if%}
</div>
<div class="match-info">
<div class="team-logo home-team-name">
<a href="{%$gameInfo["home_url"]|f_escape_xml%}">
<img src="{%$gameInfo["home_logo"]|f_escape_xml%}" alt="{%$gameInfo["home_name"]|f_escape_xml%}"/>
</a>
</div>
<div class="score-number">
{%** 比赛状态 未开始 **%}
{%if $gameInfo["game_status"] == 0%}
<div class="times">{%$gameInfo["date"][0]|f_escape_xml%}<br />{%$gameInfo["date"][1]|f_escape_xml%}</div>
{%else%}
{%$gameInfo["home_score"]|f_escape_xml%}<span class="line">-</span>{%$gameInfo["away_score"]|f_escape_xml%}
{%/if%}
</div>
<div class="team-logo away-team-name">
<a href="{%$gameInfo["away_url"]|f_escape_xml%}">
<img src="{%$gameInfo["away_logo"]|f_escape_xml%}" alt="{%$gameInfo["away_name"]|f_escape_xml%}"/>
</a>
</div>
</div>
<div class="team-name-state">
<div class="team-name home-team-name">
<a href="{%$gameInfo["home_url"]|f_escape_xml%}">{%$gameInfo["home_name"]|f_escape_xml%}</a>
</div>
<div class="match-state">
{%** 比赛状态 未开始 **%}
{%if $gameInfo["game_status"] == 0%}
{%** 比赛状态 结束 **%}
{%elseif $gameInfo["game_status"] == 30%}
已结束{%else%}
<div class="match-state-competition">{%$gameInfo["game_period_cn"]|f_escape_xml%}{%$gameInfo["game_time"]|f_escape_xml%}</div>
{%/if%}
</div>
<div class="team-name away-team-name">
<a href="{%$gameInfo["away_url"]|f_escape_xml%}">{%$gameInfo["away_name"]|f_escape_xml%}</a>
</div>
</div>
</header>