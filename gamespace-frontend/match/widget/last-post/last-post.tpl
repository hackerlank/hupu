<div class="bbs_a">
 <div class="title">
  <img alt="{%$title%}" src="{%$logo%}" height="40" width="40" />{%$title%}论坛最新帖子
 </div>
 <ul>
 	{%if $title == $match_info.home_name%}
 		{%foreach $home_news as $val%}
  		<li><a href="{%$val.url%}" target="_blank" title="{%$val.title%}">{%$val.title%}</a></li>
		{%/foreach%}
  {%else%}
		{%foreach $away_news as $val%}
  		<li><a href="{%$val.url%}" target="_blank" title="{%$val.title%}">{%$val.title%}</a></li>
		{%/foreach%}
  {%/if%}
 </ul>
</div>
