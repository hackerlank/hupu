
<div class="page-swipe" id="J-lrw-slide">
  <div class="swipe-wrap">
    {%foreach $data as $item%}
      <figure class="swiper-slide"  dace-node="">
        <a {%if $item.type == 1 && $n == 0%} 
              href="/m/room/{%$item.id%}?client={%$client%}" 
            {%else if $item.type == 1 && $n >= 1 %}
              href="huputiyu://huputv/room/{%$item.id%}?entrance={%$n%}" 
            {%else if $item.type == 2 && $n <= 1%}
                href="/m/video/{%$item.id%}?client={%$client%}"
            {%else%} 
                href="huputiyu://huputv/video{%$item.id%}?entrance={%$n%}"
            {%/if%}
        >
          {%if $item.is_live ==1%}
            <span class="live_status">Live</span>
          {%/if%}
          <div class="image" {%if $item@index == 0%}style="background-image:url({%$item.cover%})"{%else%}data-src="{%$item.cover%}"{%/if%}></div>
          <div class="image-mask"></div>
          <div class="swipe-title">
            {%if $item.video_type == 2%}
              <span class="swipe-text">路人王 &nbsp;{%$item.division_name%}</span>
              <span class="swipe-date">{%$item.create_time%}</span>
            {%else%}
              <span class="swipe-date">{%$item.title%}</span>
            {%/if%}
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
          return false;
        }
    });
  }
  
  
{%/script%}