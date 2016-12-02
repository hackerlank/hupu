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
<div class="ui-inner-tab" id="J_innerTab">
<ul class="ui-inner-tab-list">
{%foreach from=$data item=val key=keys%}
{%$isSelected = (($val@index+1) == $selected) || ($val.name == $selected)%}
<li {%if $isSelected%}class="active"{%/if%}>
<a href="{%$val.url|f_escape_xml%}">{%$val.name|f_escape_xml%}</a>
</li>
{%/foreach%}
</ul>
</div>
