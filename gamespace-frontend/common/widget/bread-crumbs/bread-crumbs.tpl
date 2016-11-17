<p class="bread-crumbs">
  <a href="{%$nav_link.home%}">{%$title1|escape:none%}</a>
  &gt;&nbsp;
  {%if empty($title3)%}
  	<b>{%$title2|escape:none%}</b>
  {%else%}
  	<a href="{%$link2%}">{%$title2|escape:none%}</a>
  	&gt;&nbsp;
  	<b>{%$title3|escape:none%}</b>
  {%/if%}
</p>
