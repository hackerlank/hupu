<div class="live-play">

    <video id="live-video" width=725 height=602 style="width: 100%" class="video-js vjs-tv-skin" poster="">
        <source src="" type="rtmp/mp4">
    </video>

    <img src="./huputv.swf" id="J_flashPlayUrl" style="display: none"/>
</div>
{%script%}
// 播放器swf
videojs.options.flash.swf = $('#J_flashPlayUrl').attr('src');

var VideoPlay = require('live:widget/video-play/video.js');

VideoPlay.init();

// 休息中
//HTV.isLiveRest = {%!empty($videoAnnounceError)%};

{%/script%}
