{%if !empty($data)%}
{%foreach from=$data item=val key=keys%}
{%if  isset($isTopline) && $isTopline && $keys > 0 %}
{%break%}
{%/if%}
{%if !isset($isTopline) && $keys == 0 %}
{%continue%}
{%/if%}
{%** 无图 **%}
{%if $val["pic"] == ""%}
<section class="card-col-2" dace-node="{%$dace|f_escape_xml%}">
<a href="{%$val["url"]|f_escape_xml%}{%if isset($smarty.get.m_from) && $smarty.get.m_from == "tieba"%}{%$fromurl|escape:none%}{%/if%}">
<article class="title">
{%if !empty($val["tag"]["name"])%}<span class="tag">{%$val["tag"]["name"]|f_escape_xml%}</span>{%/if%}
<span>{%$val["title"]|f_escape_xml%}</span>
</article>
<div class="other-info">
{%if !empty($val["from"])%}<div class="source">{%$val["from"]|f_escape_xml%}</div>
{%/if%}
{%if !empty($val["replies"])%}<span class="view-number">
<i class="icon-comment"></i>
{%$val["replies"]|f_escape_xml%}
</span>
{%/if%}
</div>
</a>
</section>
{%else%}
{%** 大图 **%}
{%if !empty($val["large"])%}
<section class="card-col-1" dace-node="{%$dace|f_escape_xml%}">
<article class="big-title">
<figure class="pic">
<a href="{%$val["url"]|f_escape_xml%}{%if isset($smarty.get.m_from) && $smarty.get.m_from == "tieba"%}{%$fromurl|escape:none%}{%/if%}">
<img src="{%$val["pic"]|f_escape_xml%}" alt="{%$val["title"]|f_escape_xml%}"/>
</a>
</figure>
<figcaption class="text">
<a href="{%$val["url"]|f_escape_xml%}{%if isset($smarty.get.m_from) && $smarty.get.m_from == "tieba"%}{%$fromurl|escape:none%}{%/if%}">
{%if !empty($val["tag"]["name"])%}<span class="tag">{%$val["tag"]["name"]|f_escape_xml%}</span>{%/if%}
{%$val["title"]|f_escape_xml%}
</a>
</figcaption>
</article>
{%if !empty($val["content"])%}
<ul class="list">
{%foreach from=$val["content"] item=val1 key=keys1%}
{%if !empty($val1["title"])%}
<li>
<a href="{%$val1["url"]|f_escape_xml%}{%if isset($smarty.get.m_from) && $smarty.get.m_from == "tieba"%}{%$fromurl|escape:none%}{%/if%}">
{%if isset($val1["isvideo"]) && $val1["isvideo"] == "on" %}
<i class="icons-video"></i>
{%else%}
<i class="icons-news"></i>
{%/if%}
{%$val1["title"]|f_escape_xml%}
</a>
</li>
{%/if%}
{%/foreach%}
</ul>
{%/if%}
</section>
{%/if%}
{%** 小图 **%}
{%if !isset($val["large"])%}
<section class="card-col-3" dace-node="{%$dace|f_escape_xml%}">
<a href="{%$val["url"]|f_escape_xml%}{%if isset($smarty.get.m_from) && $smarty.get.m_from == "tieba"%}{%$fromurl|escape:none%}{%/if%}">
<figcaption class="pic" style="background-image: url({%$val["pic"]|f_escape_xml%});">
</figcaption>
<div class="info-txt">
<article class="title">
{%if !empty($val["tag"]["name"])%}<span class="tag">{%$val["tag"]["name"]|f_escape_xml%}</span>{%/if%}
{%$val["title"]|f_escape_xml%}
</article>
<div class="other-info">
{%if !empty($val["from"])%}<div class="source">{%$val["from"]|f_escape_xml%}</div>
{%/if%}
{%if !empty($val["replies"])%}<span class="view-number">
<i class="icon-comment"></i>
{%$val["replies"]|f_escape_xml%}
</span>
{%/if%}
</div>
</div>
</a>
</section>
{%/if%}
{%/if%}
{%/foreach%}
{%/if%}
