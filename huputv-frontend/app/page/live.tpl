{%extends file="app/page/layout.tpl"%}

{%block name="title"%}{%$live.room_name%}{%/block%}

{%block name="meta"%}
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="renderer" content="webkit">
<meta name="msapplication-tap-highlight" content="no">
<meta name="apple-touch-fullscreen" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="msapplication-tap-highlight" content="no">
<meta name="application-name" content="亮了网">
{%/block%}

{%block name="head_static"%}
    {%require name="app:static/live/live.scss"%}
    {%require name="app:static/js/videojs/video-js.css"%}
    {%require name="app:static/js/videojs/video.js"%}
    {%require name="app:static/js/videojs/videojs-hls.min.js"%}

    {%script%}
        window.GM = $.extend(window.GM, {
          room_id: "{%$live.id%}"|| 0,
          anchor_puid: "{%$live.puid%}"|| 0,
          nickname: "{%$live.nickname%}",
          userInfo: "{%$userInfo.uid%}",
          hotline: {%json_encode($sub_server)%},
          match_id: "{%$live.match_id%}" || 9716,
          token: "{%$token%}",
          is_live: parseInt("{%$live.is_live%}"),
          sub_server: "{%$sub_server[0]%}"
        });
    {%/script%}
{%/block%}

{%block name="content"%}
    {%widget
        name="app:widget/update_tip/update_tip.tpl"
    %}
    <section class="layout-video">
        {%widget
            name="app:widget/video/video.tpl"
            data = $live
        %}
    </section>

    <section class="layout-tab">
        {%widget
            name="app:widget/live_tab/live_tab.tpl"
        %}
    </section>

    {%* 主要区域内滚动 *%}
    <section class="layout-main">
        {%widget
            name="app:widget/hotline/hotline.tpl"
        %}
        {%widget
            name="app:widget/anchor_info/anchor_info.tpl"
        %}
        {%widget
            name="app:widget/gift_rank/gift_rank.tpl"
        %}
    </section>
     <footer  class="send-info">
      <div class="writer-btn">
        <i></i>
        <input type="text" class="write-btn-input" readonly="readonly" placeholder="说点什么吧...">
      </div>
      <div class="writer-info" style="display:none;">
        <div class="event-info">
          <div class="writer-cancel">取消</div>
          <div class="writer-num">热线发言&nbsp;<b>0</b>/60</div>
          <div class="writer-submit">提交</div>
        </div>
        <div class="edit-info">
          <input type="text" class="edit-info-input" maxlength="60"  placeholder="和大家说点什么…" >
        </div>
      </div>
    </footer>
    <div class="mask" style="display:none;"></div>
{%/block%}
