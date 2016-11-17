<dl class="reply-list J-reply-{%$data.pid|f_escape_xml%}">
<dd class="operations-user">
<div class="user-info">
<div class="avatar">
<a href="/my/{%$data.authorid|f_escape_path%}" dace-node="{%$id4dace|f_escape_xml%}_7100">
<img src="{%$data.header|f_escape_xml%}" alt=""/>
</a>
</div>
<a href="/my/{%$data.authorid|f_escape_path%}" dace-node="{%$id4dace|f_escape_xml%}_7100" class="user-name">{%$data.author|f_escape_xml%}</a>{%if $data.is_author==1 || strstr($smarty.server.REQUEST_URI,"focusauthor")%}
<span class="reply-own">楼主</span>
{%/if%}
<div class="user-other">
{%if !empty($data.floor)%}
<span class="floor">{%$data.floor|f_escape_xml%}楼</span>
{%/if%}
<span class="times">
{%$data._postdate|f_escape_xml%}
</span>
</div>
</div>
<div class="operations">
<a href="javascript:" class="button-bright J_buttonBright" data-pid="{%$data.pid|f_escape_xml%}">
<i class="icon-bright"></i>
<span class="text">点亮<span class="bright-number-box {%if $data.light <= 0 %}fn-hide{%/if%}"><span class="J_brightNumber">{%$data.light|f_escape_xml%}</span></span>
</span>
</a>
</div>
</dd>
<dt class="reply-content" dace-node="{%$id4dace|f_escape_xml%}_quote">
{%if !empty($data.quote) && is_array($data.quote) && count($data.quote) > 0 %}
<div class="reply-quote-content J_contentParent">
<div class="reply-quote-hd">
{%$data.quote[0].header[0]|escape:none%}
{%if !empty($data.quote[0].togglecontent)%}
<a href="javascript:" class="button-open J_buttonOpenAll" title="展开"></a>
{%/if%}
</div>
{%if !empty($data.quote[0].togglecontent)%}
<div class="short-quote-content J_shortContent">
{%$data.quote[0].togglecontent|escape:none%}
</div>
<div class="reply-quote-bd J_allContent">
{%$data.quote[0].content|escape:none%}
</div>
{%else%}
<div class="short-quote-content">
{%$data.quote[0].content|escape:none%}
</div>
{%/if%}
</div>
{%/if%}
<div class="current-content J_contentParent J_currentContent">
<span class="short-content">
{%$data.content|escape:none%}
</span>
</div>
</dt>
<dd class="reply-bt">
<span class="source-left">
{%if !empty($data.viainfo)%}
<a href="{%$data.viainfo.url|f_escape_xml%}" class="source">{%$data.viainfo.text|escape:none%}</a>
{%/if%}
</span>
<a href="javascript:" dace-node="{%$id4dace|f_escape_xml%}_quote" class="button-quote J_buttonQuote" data-pid="{%$data.pid|f_escape_xml%}" data-floor="{%if !empty($data.floor)%}{%$data.floor|f_escape_xml%}{%else%}1{%/if%}">
<span class="qoute-smail-content">{%if !empty($data.smallcontent)%}{%$data.smallcontent|escape:none%}{%/if%}</span>
<span class="text">引用</span>
</a>
</dd>
</dl>
