<div class="bbs_a">
<div class="title">
<img alt="{%$title|f_escape_xml%}" src="{%$logo|f_escape_xml%}" height="40" width="40" />{%$title|f_escape_xml%}论坛最新帖子</div>
<ul>
{%if $title == $match_info.home_name%}
{%foreach $home_news as $val%}
<li><a href="{%$val.url|f_escape_xml%}" target="_blank" title="{%$val.title|f_escape_xml%}">{%$val.title|f_escape_xml%}</a></li>
{%/foreach%}
{%else%}
{%foreach $away_news as $val%}
<li><a href="{%$val.url|f_escape_xml%}" target="_blank" title="{%$val.title|f_escape_xml%}">{%$val.title|f_escape_xml%}</a></li>
{%/foreach%}
{%/if%}
</ul>
</div>
