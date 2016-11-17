{%if !empty($data)%}
<div class="hot-news-list news-list m-card-split-line" dace-node="{%$dace|f_escape_xml%}" {%if !empty($sectionExposure)%}section-exposure="{%$sectionExposure|f_escape_xml%}"{%/if%}>
<div class="title"><h2>热门新闻</h2></div>
<ul>
{%$isTieba = isset($smarty.get.m_from) && $smarty.get.m_from == "tieba"%}
{%foreach from=$data item=val name=key%}
<li>
<a href="{%$val.url|f_escape_xml%}{%if $isTieba%}{%$from|escape:none%}{%/if%}{%if !empty($urlfrom)%}{%if $isTieba%}&{%else%}?{%/if%}dace_from={%$urlfrom|f_escape_path%}{%/if%}" class="news-link">
<div class="news-wrap">
{%if !empty($val.img)%}
<div class="img-wrap" style="background-image:url({%$val.img|f_escape_xml%})"></div>
{%/if%}
<div class="news-txt">
<h3>{%$val.title|f_escape_xml%}</h3>
<div class="news-status-bar">
<div class="news-info">
<span class="news-source">{%$val.media|f_escape_xml%}</span>
<span class="news-time">{%$val.date|f_escape_xml%}</span>
</div>
{%if !(isset($smarty.get.m_from) && $smarty.get.m_from == "tieba") && !empty($val.reply_count)%}
<div class="news-view">
<i class="icon-comment"></i><span>{%$val.reply_count|f_escape_xml%}</span>
</div>
{%/if%}
</div>
</div>
</div>
</a>
</li>
{%/foreach%}
</ul>
</div>
{%/if%}
