{%if !empty($news)%}
<div class="bbs_a">
<div class="title">
{%$title|f_escape_xml%}
</div>
<ul class="hour">
{%foreach $news as $val%}
<li>
{%if $val@index+1 <= 3%}
<i>{%$val@index+1%}</i>
{%else%}
<i class="news_rank" style="font-weight:normal;color: #999999;">{%$val@index+1%}</i>
{%/if%}
<a href="{%$val.url|f_escape_xml%}" target="_blank" title="{%$val.title|f_escape_xml%}">{%$val.title|f_escape_xml%}</a></li>
{%/foreach%}
</ul>
</div>
{%/if%}
