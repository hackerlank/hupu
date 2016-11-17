<div class="players_left" style="margin-bottom:10px;">
    {%if $type == "schedule_team"%}
    <div class="all_teams">
        <a href="/schedule/"><img src="./allteam.jpg"></a>
    </div>
    {%/if%}
    {%foreach $team_list as $val%}
    <div class="title">{%$val.division%}</div>
    <ul class="players_list">
        {%foreach $val.team_list as $subVal%}
        <li
        {%if isset($team.full_name) || isset($team.name)%}
            {%if $subVal.full_name == $team.full_name || $subVal.name == $team.name%}class="on"{%/if%}
        {%/if%}>
            <img src="{%$subVal.logo%}"><span class="team_name"><a href="{%if $type == 'schedule_team' || $type == 'schedule_all'%}{%$subVal.schedule_link%}{%else if $type == 'player'%}{%$subVal.players_link%}{%/if%}">{%$subVal.full_name%}</a></span>
            <div class="bgs"
            {%if isset($team.full_name) || isset($team.name)%}
                {%if $subVal.full_name == $team.full_name || $subVal.name == $team.name%}style="display: block"{%/if%}
            {%/if%}></div>
        </li>
        {%/foreach%}
    </ul>
    {%/foreach%}
</div>
