{%if !empty($data)%}
<div class="hotspot-list m-card-split-line" dace-node="{%$dace|f_escape_xml%}" {%if !empty($sectionExposure)%}section-exposure="{%$sectionExposure|f_escape_xml%}"{%/if%}>
<div class="title"><h2>推荐热点</h2></div>
<ul>
{%foreach from=$data item=val name=key%}
<li><a href="{%$val.href|f_escape_xml%}">{%$val.title|f_escape_xml%}</a></li>
{%/foreach%}
</ul>
</div>
{%/if%}
