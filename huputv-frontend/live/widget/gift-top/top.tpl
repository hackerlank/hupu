<div class="gift-top" id="J_giftTop">
  <div class="J_giftContent"></div>
  <div class="tip-text">礼物排行数据不包含金豆礼物</div>
</div>

<script id="gift-top-tpl" type="text/template">
  <div class="gift-top-current">
    <div class="gift-top-title">
      <h4><@=title@></h4>
      <div class="title-right">
        <@if(isLogin){@>
          <@if(self.length != 0){@>
            <div class="self-gift">
              送出 <i class="icons-money"></i> <@=self.total@> 当前排名 <span class="red"><@=self.rank@></span>
            </div>
          <@}else{@>
            <div class="self-send-not">
              未参与送礼，暂无排名
            </div>
          <@}@>
        <@}@>
      </div>
    </div>
    <div class="gift-top-bd">
      <@if(datas.length >= 1){@>
        <ul class="gift-top-list">
          <@ _.each(datas, function(item,index) { @>
            <li class="top-<@=index + 1@>">
              <i class="count"><@=index + 1@></i>
              <span class="name"><@=sub(item.nickname)@></span>
              <span class="gift-count">
                <i class="icons-money"></i>
                <@=item.total@>
              </span>
            </li>
          <@ }); @>
        </ul>
      <@}else{@>
        <div class="not-content">
          该主播还未收到礼物，快去打赏一下吧
        </div>
      <@}@>
    </div>
  </div>
</script>

{%script%}
var GiftTop = require("live:widget/gift-top/top");
GiftTop.init();
{%/script%}
