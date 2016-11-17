{%if !empty($right_photos)%}
<div class="pic_ul clearfix">
<ul>
{%foreach $right_photos as $val%}
<li>
<div class="img">
<a href="{%$val.url|f_escape_xml%}"><img src="{%$val.titlepic|f_escape_xml%}" alt="{%$val.title|f_escape_xml%}"></a>
</div>
<p>{%$val.title|f_escape_xml%}</p>
</li>
{%/foreach%}
</ul>
</div>
{%/if%}
