<div class="video" id="J-videocontainer">
{%if $data.is_live == 1%}
<video id="html5player-video" class="video-js vjs-tv-skin" controls="controls" autoplay preload width="100%" height="100%" poster="{%$live.cover|f_escape_xml%}" webkit-playsinline>
{%foreach $data.live_addr.result as $addr%}
{%**播放普清**%}
{%if $addr@index == 2%}
<source src="{%$addr.hls|f_escape_xml%}" type="application/x-mpegURL">
{%/if%}
{%/foreach%}
</video>
{%else%}
<div class="live-announce">{%$data.announce|f_escape_xml%}</div>
{%/if%}
</div>
{%widget
    name="app:widget/video_tool/video_tool.tpl"
%}
{%script%}
var video = require("app:widget/video/video.es6");
video.init();
{%/script%}
