{%if !empty($news)%}
<div class="bbs_a">
 <div class="title">
  {%$title%}
 </div>
 <ul class="hour">
 	{%foreach $news as $val%}
  	<li>
  		{%if $val@index+1 <= 3%}
  			<i>{%$val@index+1%}</i>
  		{%else%}
  			<i class="news_rank" style="font-weight:normal;color: #999999;">{%$val@index+1%}</i>
  		{%/if%}
  		<a href="{%$val.url%}" target="_blank" title="{%$val.title%}">{%$val.title%}</a></li>
  {%/foreach%}
 </ul>
</div>
{%/if%}
