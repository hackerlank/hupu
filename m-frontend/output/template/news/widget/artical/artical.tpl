
{%$isTieba = isset($smarty.get.m_from) && $smarty.get.m_from == "tieba"%}
<header class="artical-title">
<h1 class="headline">{%$detail.title|f_escape_xml%}</h1>
<div class="artical-info">
<span class="author-name">
<span class="media">{%$detail.media|f_escape_xml%}</span>
</span>
<span class="times">{%$detail.date|f_escape_xml%}</span>
{%if !empty($commentsCount) && !$isTieba %}
<span class="comment-number">
<i class="icon-comment"></i>
{%$commentsCount|f_escape_xml%}
</span>
{%/if%}
{%if $isTieba%}
<a href="http://mobile.hupu.com/download/games/?_r=tieba" dace-node="{%$id4dace|f_escape_xml%}_tiebadownload" class="down-app-spread">下载虎扑体育查看↓</a>
{%/if%}
</div>
</header>
<article class="article-content">
<a href="{%$detail.img_url|f_escape_xml%}">
<img src="{%$detail.img|f_escape_xml%}">
</a>
{%$detail.content|escape:none%}
</article>
