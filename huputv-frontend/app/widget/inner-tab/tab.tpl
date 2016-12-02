{%$data=[]%}

{%if $channel == "lrw"%}
  {%$data=[
    [
      "name" => "车轮战",
      "url" => "javascript:"
    ],
    [
      "name" => "8强赛",
      "url" => "javascript:"
    ],
    [
      "name" => "战绩表",
      "url" => "javascript:"
    ]
  ]%}
{%/if%}
{%if $channel == "lrw-pre"%}
  {%$data=[
    [
      "name" => "比赛介绍",
      "url" => "javascript:"
    ],
    [
      "name" => "参赛选手",
      "url" => "javascript:"
    ],
    [
      "name" => "赛前讨论",
      "url" => "javascript:"
    ]
  ]%}
{%/if%}

<div class="ui-inner-tab" id="J_innerTab">
	<ul class="ui-inner-tab-list">
		{%foreach from=$data item=val key=keys%}
			{%$isSelected = (($val@index+1) == $selected) || ($val.name == $selected)%}
    	<li {%if $isSelected%}class="active"{%/if%}>
				<a href="{%$val.url%}">{%$val.name%}</a>
			</li>
    {%/foreach%}
	</ul>
</div>
