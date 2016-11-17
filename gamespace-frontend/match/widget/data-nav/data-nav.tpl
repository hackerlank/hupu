{%$nav=[
  [
   "name" => "球员",
   "type" => "player",
   "link" => "/stats/players/pts"
  ],
  [
   "name" => "球队",
   "type" => "teams",
   "link" => "/stats/teams"
  ]
]%}
<div class="top_tables clearfix">
    {%foreach $nav as $item%}
      <div class="t1 {%if $item.type == $type|default:'player'%}bg_red{%/if%}">
          <div class="ft">
            {%if $item.type == $type|default:'index'%}
              {%$item.name%}
            {%else%}
              <a href="{%$item.link%}">{%$item.name%}</a>
            {%/if%}
          </div>
      </div>
    {%/foreach%}
</div>
