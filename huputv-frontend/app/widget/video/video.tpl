<div class="video" id="J-videocontainer">
   {%if $live.is_live == 1%}
      <video id="html5player-video" class="video-js vjs-tv-skin" controls="controls" autoplay preload width="100%" height="100%" poster="{%$live.cover%}" webkit-playsinline>
        {%foreach $live.live_addr.result as $addr%}
          {%**播放普清**%}
          {%if $addr@index == 2%}
            <source src="{%$addr.hls%}" type="application/x-mpegURL">
          {%/if%}
        {%/foreach%}
      </video>
    {%else%}
      <div class="live-announce">{%$live.announce%}</div>
    {%/if%}
</div>
{%widget
    name="app:widget/video_tool/video_tool.tpl"
%}
{%script%}
var video = require("./video.es6");
video.init();
{%/script%}
