<a href="{%$gameData.innerurl|f_escape_xml%}" class="match-wrap">
<div class="match-info">
<p class="game-type">
NBA{%if $gameList.nba[0].gameinfo[0].match_type == "PRESEASON"%}
季前赛{%else if $gameList.nba[0].gameinfo[0].match_type == "REGULAR"%}
常规赛{%else%}
季后赛{%/if%}
</p>
<div class="match-team-info">
<div class="team home-team">
<span class="team-name">{%$gameData.home.name|f_escape_xml%}</span>
<img src="{%$gameData.home.logourl|f_escape_xml%}" alt="">
</div>
<strong>
<span>{%$gameData.scoreortime|f_escape_xml%}</span>
</strong>
<div class="team away-team">
<img src="{%$gameData.away.logourl|f_escape_xml%}" alt="">
<span class="team-name">{%$gameData.away.name|f_escape_xml%}</span>
</div>
</div>
<div class="match-status-info">
<div class="score home-score">
{%if isset($gameData.home_win)%}
({%$gameData.home_win|f_escape_xml%}){%/if%}
</div>
{%if isset($gameData.isovertime)%}
{%if {%$gameData.isover|f_escape_xml%} == 0%}
<div class="match-status-txt overtime-ing">{%$gameData.process|f_escape_xml%}</div>
{%else%}
<div class="match-status-txt overtime">{%$gameData.process|f_escape_xml%}</div>
{%/if%}
{%else%}
<div class="match-status-txt">{%$gameData.process|f_escape_xml%}</div>
{%/if%}
<div class="score away-score">
{%if isset($gameData.home_win)%}
({%$gameData.away_win|f_escape_xml%}){%/if%}
</div>
</div>
</div>
</a>