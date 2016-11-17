{%if !(isset($data.is_hide) && $data.is_hide)%}
<dl class="reply-list">
{%else%}
<dl class="reply-list" style="display: none;">
{%/if%}
<dd class="operations-user">
<span class="user-name">
{%if !(isset($smarty.get.m_from) && $smarty.get.m_from == "tieba") %}
<a dace-node="{%$id4dace|f_escape_xml%}_home" href="/my/{%$data.uid|f_escape_path%}">
{%$data.user|f_escape_xml%}
</a>
{%else%}
{%$data.user|f_escape_xml%}
{%/if%}
</span>
{%** 合作tieba **%}
{%if !(isset($smarty.get.m_from) && $smarty.get.m_from == "tieba") %}
<span class="operations">
<a href="javascript:" class="button-bright J_buttonBright" data-pid="{%$data.id|f_escape_xml%}" data-uid="{%$data.uid|f_escape_xml%}">
<i class="icon-bright"></i>
{%if !empty($data.light)%}
<span class="text">亮了({%$data.light|f_escape_xml%})</span>
{%else%}
<span class="text">亮了</span>
{%/if%}
</a>
<a href="javascript:" dace-node="{%$id4dace|f_escape_xml%}_quote" class="button-quote J_buttonQuote" data-pid="{%$data.id|f_escape_xml%}" data-floor="{%$data.floor|f_escape_xml%}">
<span class="qoute-smail-content">{%if !empty($data.smallcontent)%}{%$data.smallcontent|escape:none%}{%/if%}</span>
<i class="icon-quote"></i>
<span class="text">引用</span>
</a>
</span>
{%/if%}
</dd>
<dt class="reply-content">
{%if !empty($data.quote) && is_array($data.quote) && count($data.quote) > 0 %}
<div class="reply-quote-content J_contentParent">
<div class="reply-quote-hd">
{%$data.quote.header|escape:none%}
{%if $data.quote.togglecontent != ''%}
<a href="javascript:" class="button-open J_buttonOpenAll" title="展开"></a>
{%/if%}
</div>
{%if !empty($data.quote.togglecontent) && $data.quote.togglecontent != ''%}
<div class="short-quote-content J_shortContent">
{%$data.quote.togglecontent|escape:none%}
</div>
<div class="reply-quote-bd J_allContent">
{%$data.quote.content|escape:none%}
</div>
{%else%}
<div class="short-quote-content">
{%$data.quote.content|escape:none%}
</div>
{%/if%}
</div>
{%/if%}
<div class="current-content J_contentParent">
<span class="short-content">
{%$data.content|escape:none%}
</span>
</div>
</dt>
<dd class="reply-bt">
<span class="times">{%$data.time|f_escape_xml%}</span>
</dd>
</dl>