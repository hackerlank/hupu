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

            //平台
            HTV.platform='{%$platform%}';
           
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
    <section class="lrw-header">
        <img src="{%$game.division.app_img%}">
    </section>
    <section class="lrw-wrap" id="J_lrw_pre">
        {%widget
          name = "app:widget/inner-tab/tab.tpl"
          channel = "lrw-pre"
          selected = "1"
        %}

        <div id="J_lrwContent"></div>

        {%widget
          name = "app:widget/lrw-pre/game-introduce/introduce.tpl"
          game =  $game
          recommend = $video_recommend

        %}

        {%widget
          name="app:widget/lrw/play-list/play-list.tpl"
        %}

        
  </section>
{%/block%}
