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
        HTV.peopleScore = "{%$user.score%}";
        HTV.game_id = "{%$video.gid%}";
        HTV.vid = "{%$video.vid%}";
        HTV.tid = "{%$video.tid%}";
        HTV.score = "{%$video.score%}";
        HTV.is_rated = parseInt("{%$video.is_rated%}");
        HTV.isLogin = "{%$login%}";
        // 视频流
        HPF.flashStreamAddress = function() {
            return [
                {"http":"{%$video.url.sc%}","name":"超清"},
                {"http":"{%$video.url.hd%}","name":"高清"},
                {"http":"{%$video.url.sd%}","name":"普清"},
            ];
        };
        //视频打点值
        HPF.getVideoPoints = function() {
            var rbi = {%json_encode($video.rbi)%};
            return  rbi;
        }
        //返回vid  服务端调用
        HPF.getVid = function() {
            return  "{%$video.vid%}";
        }
        //视频播放完之后执行  服务端调用
        HPF.VideoEnd = function() {
            //视频播放开关是否开启
            if( !$(".toggle i").hasClass("close") ) {
              window.location.href = "/video/{%$recommend[0].vid%}";
            }
        }

        HTV.jumpLogin = function() {
            {%if !$login && !empty($login_url)%}
                window.location.href = '{%$login_url%}';
            {%/if%}
        };
        // 分享数据
        HTV.shareData  = {
            title: '{%$video.title%}',
        };



    </script>
{%/block%}

{%block name="content"%}
    <div class="live-wrap">
        <div class="col-1">
            <div class="live-main">
                {%widget
                    name="live:widget/target_video_play/video.tpl"
                    data = $video
                %}
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
