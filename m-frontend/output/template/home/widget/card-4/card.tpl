{%if isset($data) && !empty($data)%}
<section class="card-col-4" dace-node="{%$dace|f_escape_xml%}">
<div class="card-wrap">
<article class="title">
<h2>{%$banner|f_escape_xml%}</h2>
</article>
<article class="bd card-shihuo">
{%foreach $data as $key => $val%}
{%if $val@index === 0%}
<div class="list pic-list">
<a href="{%$val.detail_url|f_escape_xml%}" class="small-pic" style="background-image: url({%$val.img_path|f_escape_xml%})"></a>
<div class="title">
<a href="{%$val.detail_url|f_escape_xml%}">
<h4>{%$val.title|f_escape_xml%}</h4>
<span>{%$val.subtitle|f_escape_xml%}</span>
</a>
</div>
</div>
{%else%}
<div class="list general-list">
<div class="news-text">
<div class="name">
<a href="{%$val.detail_url|f_escape_xml%}">{%$val.title|f_escape_xml%}</a>
</div>
</div>
</div>
{%/if%}
{%/foreach%}
</article>
</div>
</section>
{%/if%}