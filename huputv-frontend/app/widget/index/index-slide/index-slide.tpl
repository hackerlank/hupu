
<div class="page-swipe" id="J-lrw-slide">
  <div class="swipe-wrap">
    {%foreach $data as $item%}
      <figure class="swiper-slide"  dace-node="">
        <a href="{%$item.id%}">
          <div class="image" {%if $item@index == 0%}style="background-image:url({%$item.cover%})"{%else%}data-src="{%$item.cover%}"{%/if%}></div>
          <div class="swipe-title">
              <span class="swipe-text">{%$item.id%}</span>
              <span class="swipe-date">{%$item.create_time%}</span>
          </div>
        </a>
     </figure>
    {%/foreach%}
  </div>
  
  <ul class="swipe-position" id="J-lrw-pos">
   {%foreach $data as $item%}
      <li class="{%if $item@index == 0%}on{%/if%}"></li>
   {%/foreach%}
  </ul>
</div>
{%script%} 
  window.onload=function(){
    var container = document.getElementById("J-lrw-slide");
    var bullets = document.getElementById("J-lrw-pos").getElementsByTagName('li');
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
  }
  
  
{%/script%}