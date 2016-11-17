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
{%$item.name|f_escape_xml%}
{%else%}
<a href="{%$item.link|f_escape_xml%}">{%$item.name|f_escape_xml%}</a>
{%/if%}
</div>
</div>
{%/foreach%}
</div>
