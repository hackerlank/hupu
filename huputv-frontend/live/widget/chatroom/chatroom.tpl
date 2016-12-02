<div class="chatroom" id="J_chatroom">
    <div class="chatroom-list J_chatroomScroll">
      <ul class="list J_chatroomList"></ul>
    </div>
    <div class="gift-batter-tip" id="J_giftBatterTip">

    </div>
    <div class="send-hot-line J_sendHotline {%if !$login%}chatroom-notlogin{%/if%}">
        <div class="textarea-inner">
            <textarea name="" class="form-textarea J_formTextarea" placeholder="在这里输入弹幕文字" maxlength="60"></textarea>
            <div class="chat-error J_chatError">
                不能为空
            </div>
        </div>
        <div class="button-inner">
            <label class="shield">
                <input type="checkbox" class="J_shieldCheckbox" />
                屏蔽礼物信息
            </label>
            <div class="button-right">
                <span class="text-max-count">
                    <span class="J_canEnterCount">0</span>/60
                </span>
                <a class="button-send J_buttonSend" href="javascript:">发送</a>
            </div>
        </div>
        <div class="tips-islogin">
            <a href="{%$login_url%}" id="J_chatButtonLogin"><span class="red">登录</span>即可参与聊天</a>
        </div>
    </div>
</div>

<script id="hotline-tpl" type="text/template">
    <@if(item.username != ""){@>
        <li>
          <div class="chat-head">
              <@if(item.et === 3001){@>
                  <i class="icon-zhubo"></i>
              <@}@>
              <@if(typeof item.un == 'undefined'){@>
                  <span class="username"><@=item.an@></span>
              <@}else{@>
                  <span class="username"><@=item.un@></span>
              <@}@>
              <span class="rpz-number <@if(item.rp < 0){@>rpz-number-lost<@}@>"><@=item.rp || 0@></span>
              <@if(typeof item.via !== "undefined" && item.via != 5 ){@>
                  <a href="http://voice.hupu.com/other/2006264.html" target="_blank" class="icons-phone"></a>
              <@}@>
          </div>
          <div class="chat-content <@if(typeof conName != 'undefined'){@>chat-content-<@=conName@><@}@>">
            <@=item.cnt@>
          </div>
        </li>
    <@}@>
</script>

<script id="chaoneng-hotline-tpl" type="text/template">
    <li>
        <@if(item.et === 3012){@>
            <div class="chat-news">
                <i class="icon-news"></i>
                系统消息：<span class="red"><@=item.teamname@></span>购买了<span class="red"><@=item.skill_value@></span>个<span class="yellow"><@=item.skill_name@></span>
            </div>
        <@}@>

        <@if(item.et === 3011){@>
            <div class="chat-news">
                <i class="icon-news"></i>
                系统消息：<span class="red"><@=item.teamname@></span>正在使用<span class="yellow"><@=item.skill_name@></span>
            </div>
        <@}@>
    </li>
</script>

{%script%}
var Chatroom = require("live:widget/chatroom/chatroom");

Chatroom.init();
{%/script%}
