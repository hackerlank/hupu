{%if !empty($tplType) && $tplType == "php"%}
<header class="artical-title">
<h1 class="headline">{%$news.title|f_escape_xml%}</h1>
<div class="artical-info">
<span class="times">{%$news.addtime|f_escape_xml%}</span>
{%if !empty($news.origin)%}
{%if !empty($news.origin_url)%}
<a class="new-source"
                    {%if !empty($news.app_url) && $smarty.server.HTTP_USER_AGENT|strpos:"kanqiu"%}
                    href="{%$news.app_url|f_escape_xml%}"
                    {%else if !empty($news.m_url) && !$smarty.server.HTTP_USER_AGENT|strpos:"kanqiu"%}
                    href="{%$news.m_url|f_escape_xml%}"
                    {%else%}
                    href="{%$news.origin_url|f_escape_xml%}"
                    {%/if%}
                    dace-node="news_origin">{%$news.origin|f_escape_xml%}</a>
{%else%}
<span class="news-source">{%$news.origin|f_escape_xml%}</span>
{%/if%}
{%/if%}
{%if $fromshare|default:true%}
<span class="news-source">{%$news.replies|f_escape_xml%}评论</span>
{%/if%}
</div>
</header>
{%else%}
<header class="artical-title">
<h1 class="headline"><@=title@></h1>
<div class="artical-info">
<span class="times"><@=addtime@></span>
<@if(origin){@>
<@if(origin_url){@>
<a class="new-source"
                    <@if(app_url && GM.is_app != -1){@>href="<@=app_url@>"<@}else if(m_url && GM.is_app == -1){@>
href="<@=m_url@>"<@}else{@>href="<@=origin_url@>"<@}@>
><@=origin@></a>
<@}else{@>
<span class="news-source">
<@=origin@>
</span>
<@}@>
<@}@>
</div>
</header>
{%/if%}