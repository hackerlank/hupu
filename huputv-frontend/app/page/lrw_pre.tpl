{%extends file="app/page/layout.tpl"%}

{%block name="title"%}上海路人王第三轮{%/block%}

{%block name="head_static"%}
    <script src="http://b3.hoopchina.com.cn/code/zeroClipboard/1.3.5/ZeroClipboard.js"></script>
    {%require name="app:static/lrw_pre/lrw_pre.scss"%}
    {%require name="app:static/lrw_pre/lrw_pre.js"%}
    {%script%}     
        !function(win){
            var HTV = win.HTV = {};
            // 用户id
            HTV.getUserId = "{%$userInfo.uid%}" || "";
            HTV.userName = "{%$userInfo.username%}" || "";
            HTV.nickName = "{%$userInfo.nickname%}" || "";
            // 用户登陆状态
            HTV.isLogin = {%intval($is_login)%};
            //帖子ID
            HTV.tid = "{%$game.tid%}";
            //平台
            HTV.platform='{%$platform%}';
            //match_ID
            HTV.match_id = '{%$game.id%}';            
            //
            HTV.game_status = '{%$game.game_status%}'
            // 跳转登录
            HTV.jumpLogin = function() {
                {%if !$is_login && !empty($login_url)%}
                    window.location.href = '{%$login_url%}';
                {%/if%}
            };
         

        }(window);
    {%/script%}  
{%/block%}

{%block name="content"%}
    <div id="J-pre-main">
        <section class="lrw-header">
            <img src="{%$game.division.app_img%}">
        </section>
        <section class="lrw-wrap" id="J_lrw_pre">
            {%widget
              name = "app:widget/inner-tab/tab.tpl"
              channel = "lrw-pre"
              selected = "1"
            %}

            <div id="J-lrw-pre">
                <div class="lrw-pre-item visited actived">
                    {%widget
                        name = "app:widget/lrw-pre/game-introduce/introduce.tpl"
                        game =  $game
                        recommend = $video_recommend
                    %}
                </div>
                <div class="lrw-pre-item" >
                    {%widget
                        name="app:widget/target_video/player_statistics/statistics.tpl"
                    %}
                </div>
                <div class="lrw-pre-item">
                    {%widget
                        name="app:widget/target_video/end_discuss/discuss.tpl"
                    %}
                </div>
            </div>
        </section>
    </div>
{%/block%}
