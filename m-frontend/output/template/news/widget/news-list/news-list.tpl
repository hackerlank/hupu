{%$isTieba = isset($smarty.get.m_from) && $smarty.get.m_from == "tieba"%}
<li>
<a href="{%$data.url|f_escape_xml%}{%if $isTieba%}{%$fromurl|escape:none%}{%/if%}" class="news-link" dace-node="{%$id4dace|f_escape_xml%}_readNews">
<div class="news-wrap">
{%if $data.img != ''%}
<div class="img-wrap" style="background-image:url({%$data.img|f_escape_xml%});"></div>
{%/if%}
<div class="news-txt">
<h3>{%$data.title|f_escape_xml%}</h3>
<div class="news-status-bar">
<div class="news-info">
<span class="news-source">{%$data.media|f_escape_xml%}</span>
<span class="news-time">{%$data.date|f_escape_xml%}</span>
</div>
{%if !$isTieba && !empty($data.reply_count)%}
<div class="news-view">
<i class="icon-comment"></i><span>{%$data.reply_count|f_escape_xml%}</span>
</div>
{%/if%}
</div>
</div>
</div>
</a>
</li>
