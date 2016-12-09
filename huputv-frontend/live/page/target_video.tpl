{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="common:widget/rpz-board/rpz-board.scss"%}
    {%require name="live:static/live/live.scss"%}
    {%require name="common:static/js/videojs/video-js.css"%}
    {%require name="common:static/js/videojs/ie8/videojs-ie8.js"%}
    {%require name="common:static/js/videojs/video.js"%}
    {%require name="common:static/js/videojs/videojs-hls.min.js"%}
    {%require name="live:static/target_video/target_video.js"%}

    <script src="http://b3.hoopchina.com.cn/code/zeroClipboard/1.3.5/ZeroClipboard.js"></script>

    <script>
        HTV.roomID = "{%$live.id%}" || 0;
        HTV.shareUrl = "{%$live.abs_share_url%}";
        HTV.matchID = "{%$live.match_id%}" || 0;
        HTV.token = "{%$token%}"


        HTV.peopleScore = "{%$user.score%}";
        HTV.game_id = "{%$video.gid%}";
        HTV.vid = parseInt("{%$video.vid%}");
        HTV.score = "{%$video.score%}";
        HTV.is_rated = parseInt("{%$video.is_rated%}");
        HTV.isLogin = "{%$login%}"
        HTV.jumpLogin = function() {
            {%if !$login && !empty($login_url)%}
                window.location.href = '{%$login_url%}';
            {%/if%}
        };
        // 超能赛事
        {%if !empty($chaoneng_info)%}
          HTV.chaoneng = {%json_encode($chaoneng_info)%} || [];
          // videoJJ
          HPF.getVideoJJ = function(){
            return {
                 appkey: "{%$videojj.appkey%}",
                 referer: "{%$videojj.referer%}",
                 source: "{%$videojj.source%}",
                 type: parseInt('{%$videojj.type%}')
            }
          }
        {%/if%}
        // 分享数据
        HTV.shareData = HPF.shareData = {
        {%if !empty($live.online) && $live.online < 1000%}
            title: '我正在「{%$live.anchor_nickname%}」的房间「{%$live.room_name%}」观看直播，快来围观吧！#亮了网#正在直播',
        {%else%}
            title: '「{%$live.online%}」人正在和我一起观看「{%$live.anchor_nickname%}」直播「{%$live.room_name%}」，还不快来围观。#亮了网#正在直播',
        {%/if%}
            qqSubTitle: '亮了网主播：「{%$live.anchor_nickname%}」正在直播',
            url: '{%$task_share_url%}',
            pic: '{%$live.cover%}'
        };
        // 礼物列表数据
        HTV.giftData = {%json_encode($gift.list)%} || [];
        // 主播人品值
        HTV.rpzNumber = "{%$user.score%}";
        // 视频流
        HPF.flashStreamAddress = function(){
            return {%if $live.is_live == 1 && $live.live_addr.status == 200%}{%json_encode($live.live_addr.result)%}{%else%}[]{%/if%}
        };

        HTV.predData = {magnification: '{%$user.magnification%}'}

    </script>
{%/block%}

{%block name="content"%}
    <div class="live-wrap">
        <div class="col-1">
            <div class="live-main">
                {%widget
                    name="live:widget/video-play/video.tpl"
                    data = $live
                %}
                <div id="J_buttonFollow"><!--为了兼容live直播页js--></div>
                <div class="score clearfix">
                    <div class="video_num">
                        <span class="video_name">{%$video.title%}</span>
                        <span class="play"> 
                            <span class="play_word">播放</span>
                            <span>{%$video.play_num%}</span>
                        </span>
                    </div>
                    <div class="star">
                        <div class="star_title">视频打分</div>
                        <div class="star_num">
                            <ul class="clearfix">
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                                <li></li>
                            </ul>
                            <div class="rating-stars">
                            </div>
                        </div>
                        <span class="star_btn">评分</span>
                    </div>
                </div>
            </div>
            <div class="target-sidebar">
                {%widget
                  name="live:widget/target/target_sidebar.tpl"
                %}
            </div>
            
        </div>
        <div class="col-2">
            <div class="live-main">
                {%widget
                    name="live:widget/match_player/player.tpl"
                    data = $passerbyking_info
                %}
                <div class="pro_discuss">
                    {%widget
                        name="live:widget/pro_discuss/discuss.tpl"
                    %}
                </div>
            </div>
        </div>
        
    </div>
     {%if !empty($predict)%}
                 {%widget
                    name="live:widget/guide/guide.tpl"
                  %}
     {%/if%}
{%/block%}
