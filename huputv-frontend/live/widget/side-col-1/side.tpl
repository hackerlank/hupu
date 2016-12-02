<div class="live-sidebar-col-1" id="J_sideTab">
  <div class="side-tab-inner">
    <ul class="tab-list J_tabList">
      <li class="active">
        <a href="javascript:">热线</a>
      </li>
      <li>
        <a href="javascript:">攒人品 <i class="new-message J_predNewMessage"></i></a>
      </li>
      <li>
        <a href="javascript:">礼物排行</a>
      </li>
    </ul>
  </div>
  <div class="content J_content">
    <div class="content-list J_contentList active">
      {%widget
        name="live:widget/chatroom/chatroom.tpl"
      %}
    </div>

    <div class="content-list J_contentList">
      {%widget
        name="live:widget/pred-game/pred.tpl"
      %}
    </div>

    <div class="content-list J_contentList">
      {%widget
          name="live:widget/gift-top/top.tpl"
          data=$gift
      %}
    </div>
  </div>
</div>

{%script%}
var SideTab = require("live:widget/side-col-1/side");
SideTab.init();
{%/script%}
