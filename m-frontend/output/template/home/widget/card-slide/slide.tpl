{%if isset($data) && $data|count %}
<div class="page-swipe" id="J_{%$block|f_escape_xml%}">
<div class="swipe-wrap">
{%foreach $data as $item%}
<figure  dace-node="{%$id4dace|f_escape_xml%}_banner_{%$item@index+1%}">
<a href="{%$item.url|f_escape_xml%}">
<div class="image" {%if $item@index == 0%}style="background-image:url({%$item.pic|f_escape_xml%})"{%else%}data-src="{%$item.pic|f_escape_xml%}"{%/if%}></div>
<div class="swipe-title">{%$item.title|cut:16|f_escape_xml%}</div>
</a>
</figure>
{%/foreach%}
</div>
<ul class="swipe-position" id="J_{%$block|f_escape_xml%}_pos">
{%foreach $data as $item%}
<li class="{%if $item@index == 0%}on{%/if%}"></li>
{%/foreach%}
</ul>
</div>
{%script%}
  var Swipe = require("common:widget/ui/swipe/swipe.js");
  var container = document.getElementById("J_{%$block|f_escape_js%}");
  var bullets = document.getElementById("J_{%$block|f_escape_js%}_pos").getElementsByTagName('li');
  var slideInstance = new Swipe(container, {
      continuous: true,
      auto: 3000,
      callback: function(pos) {
        var image = $(container).find(".image").eq(pos);
        var imageSrc = image.data("src");
        if(imageSrc){
          image.css("background-image", "url(" + imageSrc +")" );
          image.removeAttr("data-src");
        }
        var i = bullets.length;
        while (i--) {
          bullets[i].className = ' ';
        }
        bullets[pos].className = 'on';
      }
  });
{%/script%}
{%/if%}