{%if {%$isOpen|f_escape_xml%} == 'on' && empty($smarty.cookies.matchtip) %}
<div class="top-tips" id="J_topTips">
<p><a href="{%$url|f_escape_xml%}">{%$content|f_escape_xml%}</a></p>
<span id="J_close"></span>
</div>
{%/if%}