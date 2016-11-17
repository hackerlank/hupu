{%if !empty($data)%}
<div class="match-board">
<ul>
{%foreach $data as $game%}
<li class="{%if $game.status == 0%}end{%elseif $game.status == 1%}ing{%else%}wait{%/if%}">
<a href="{%$game.gameurl|f_escape_xml%}" class="game-link">
<div class="game-info">
{%if !empty($from)%}
<div class="league {%if $game.leaguetype == 0%}basketball{%else%}soccer{%/if%}">
{%$game.leaguename|f_escape_xml%}
</div>
{%/if%}
<div class="team">
{%if $game.leaguetype == 0%}
{%$game.awayteam|f_escape_xml%}vs{%$game.hometeam|f_escape_xml%}
{%else%}
{%$game.hometeam|f_escape_xml%}vs{%$game.awayteam|f_escape_xml%}
{%/if%}
</div>
<div class="result">
{%$game.score|escape:none%}
</div>
</div>
<div class="game-status">
<div class="status-info">
<p>{%$game.progress|f_escape_xml%}</p>
<p>{%$game.gamestatus|f_escape_xml%}</p>
</div>
</div>
</a>
</li>
{%/foreach%}
</ul>
</div>
{%if !empty($isPredict)%}
<div class="prediction-entry">
<a href="{%$predicturl|f_escape_xml%}"><span>查看今明全部赛程，并参与预测</span><i></i></a>
</div>
{%/if%}
{%/if%}