{%if !empty($data.adurl)%}
{%if $from|default:"home" == "home"%}
<section class="card-col-4 spread card-col-widget">
<div class="card-wrap">
<span class="spread-tag">推</span>
<article class="bd">
<a href="{%$data.adurl|f_escape_xml%}" target="_blank" dace-node="{%$id4dace|f_escape_xml%}_stream_{%$pos|default:'top'|f_escape_xml%}" class="list smail-pic-list">
<div class="news-text">
<div class="name">
<span>{%$data.adword|f_escape_xml%}</span>
</div>
</div>
<div class="small-pic" style="background-image: url({%$data.pic|f_escape_xml%})"></div>
</a>
</article>
</div>
</section>
{%else%}
<li class="spread">
<div class="card-wrap">
<span class="spread-tag">推</span>
<a href="{%$data.adurl|f_escape_xml%}" target="_blank" dace-node="{%$id4dace|f_escape_xml%}_stream" class="news-link">
<div class="news-txt">
<h3>{%$data.adword|f_escape_xml%}</h3>
</div>
<div class="img-wrap" style="background-image:url({%$data.pic|f_escape_xml%})"></div>
</a>
</div>
</li>
{%/if%}
{%/if%}
