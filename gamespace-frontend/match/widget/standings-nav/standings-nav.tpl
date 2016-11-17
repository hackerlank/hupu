{%$nav=[
  [
   "name" => "按东/西部",
   "type" => "index",
   "link" => "/standings"
  ],
  [
   "name" => "按赛区",
   "type" => "division",
   "link" => "/standings/division"
  ]
]%}
<div class="top_tables clearfix">
    {%foreach $nav as $item%}
      <div class="t1 {%if $item.type == $type|default:'index'%}bg_red{%/if%}">
          <div class="ft">
            {%if $item.type == $type|default:'index'%}
              {%$item.name%}
            {%else%}
              <a href="{%$item.link%}">{%$item.name%}</a>
            {%/if%}
          </div>
      </div>
    {%/foreach%}
    <a target="_blank" href="/games"><span class="tips"><b>今日NBA战况&gt;&gt;</b></span></a>
</div>
