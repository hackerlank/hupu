<div class="live-play">

    {%if $data.is_live == 1 && $data.live_addr.status == 200%}
        {%if $smarty.server.HTTP_USER_AGENT|ismobile%}
            <video id="mobile-live-video" style="width: 100%;height: 180px;" class="video-js vjs-tv-skin">
                {%if !empty($data.live_addr.result)%}
                    <source src="{%$data.live_addr.result[1].hls%}" type="application/x-mpegURL">
                {%/if%}
            </video>
        {%else%}

            <video id="live-video" width=725 height=602 style="width: 100%" class="video-js vjs-tv-skin">
                {%if !empty($data.live_addr.result)%}
                    <source src="" type="rtmp/mp4">
                {%/if%}
            </video>
        {%/if%}
    {%else%}
        {%assign var="liveError" value="1"%}
    {%/if%}

    <div id="J_liveVideoRest" class="live-video-rest" {%if !empty($liveError)%}style="display: block;"{%/if%}>

        {%if $data.is_live == 1 && $data.live_addr.status != 200 %}
            <div class="video-mark">
                {%$data.live_addr.result%}
            </div>
        {%else%}
            {%assign var="videoAnnounceError" value="1"%}
        {%/if%}

        <div class="live-play-recommend" {%if !empty($videoAnnounceError)%}style="display: block;"{%/if%}>
            <div class="recommend-title">
                {%$data.announce%}
            </div>
            <div class="recommend-bd">

            </div>
        </div>
    </div>

    <img src="./huputv.swf" id="J_flashPlayUrl" style="display: none"/>
</div>

<script id="play-recommend-tpl" type="text/template">
    <ul class="live-announce-list">
        <@ _.each(datas, function(item,index) { @>
            <li>
                <a href="/<@=item.id@>">
                    <div class="pic">
                        <img src="<@=item.cover@>" alt=""/>
                    </div>
                    <div class="recommend-mark"></div>
                    <div class="title">
                        <@=item.room_name@>
                    </div>
                    <div class="bottom">
                        <div class="people-number">
                            <i class="icon-people"></i>
                            <@=item.online@>
                        </div>
                        <div class="name">
                            <@=item.anchor_nickname@>
                        </div>
                    </div>
                </a>
            </li>
        <@ }); @>
    </ul>
</script>

{%script%}
// 播放器swf
videojs.options.flash.swf = $('#J_flashPlayUrl').attr('src');

var VideoPlay = require('live:widget/video-play/video.js');

VideoPlay.init();

// 休息中
HTV.isLiveRest = {%!empty($videoAnnounceError)%};

{%/script%}
