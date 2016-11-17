<div class="players_left" style="margin-bottom:10px;">
{%if $type == "schedule_team"%}
<div class="all_teams">
<a href="/schedule/"><img src="//w1.hoopchina.com.cn/channel/gamespace/static/common/widget/team-nav/allteam_cbd1a21.jpg"></a>
</div>
{%/if%}
{%foreach $team_list as $val%}
<div class="title">{%$val.division|f_escape_xml%}</div>
<ul class="players_list">
{%foreach $val.team_list as $subVal%}
<li {%if $subVal.full_name == $team.full_name || $subVal.name == $team_cn_name%}class="on"{%/if%}>
<img src="{%$subVal.logo|f_escape_xml%}"><span class="team_name"><a href="{%if $type == 'schedule_team' || $type == 'schedule_all'%}{%$subVal.schedule_link|f_escape_path%}{%else if $type == 'player'%}{%$subVal.players_link|f_escape_path%}{%/if%}">{%$subVal.full_name|f_escape_xml%}</a></span>
<div class="bgs" {%if $subVal.full_name == $team.full_name || $subVal.name == $team_cn_name%}style="display: block"{%/if%}></div>
</li>
{%/foreach%}
</ul>
{%/foreach%}
</div>
