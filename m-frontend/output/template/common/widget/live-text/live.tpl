{%if !empty($data)%}
<div class="m-row live-text" id="J_live_container">
<ul id="J_live_content">
{%foreach $data as $item%}
{%if !empty($item["title"]) %}
<li><a dace-node="{%$id4dace|f_escape_xml%}_scrollbar" href="{%$item["url"]|f_escape_xml%}">{%$item["title"]|f_escape_xml%}</a></li>
{%/if%}
{%/foreach%}
</ul>
</div>
{%/if%}