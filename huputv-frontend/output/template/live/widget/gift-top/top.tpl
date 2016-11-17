<div class="gift-top" id="J_giftTop">
<div class="gift-top-inner">
<div class="gift-top-tab">
<ul class="tab-list J_tabList">
<li class="active">
<a href="javascript:">本场排行</a>
</li>
<li>
<a href="javascript:">总排行</a>
</li>
</ul>
</div>
<div class="content J_content"></div>
</div>
</div>
<script id="gift-top-tpl" type="text/template">
    <div class="content-list J_contentList <@if(typeof active !== "undefined"){@>active<@}@>">
        <@if(datas.length >= 1){@>
            <ul class="gift-list gift-top-list">
                <@ _.each(datas, function(item,index) { @>
                    <li class="top-<@=index + 1@>">
                        <i class="count"><@=index + 1@></i>
                        <span class="name"><@=item.nickname@></span>
                        <span class="gift-count">
                            <i class="icon-beans"></i>
                            <@=item.total@>
                        </span>
                    </li>
                <@ }); @>
            </ul>
            <@if(isLogin){@>
                <@if(self.length != 0){@>
                    <ul class="gift-list self-gift-top" <@if(datas.length <= 2){@>style="display: block;"<@}@>>
                        <li>
                            <i class="count"><@=self.rank@></i>
                            <span class="name"><@=self.nickname@></span>
                            <span class="gift-count">
                                <i class="icon-beans"></i>
                                <@=self.total@>
                            </span>
                        </li>
                    </ul>
                <@}else{@>
                    <div class="self-gift-top self-not-gift" <@if(datas.length <= 2){@>style="display: block;"<@}@>>你还未参与过送礼，暂无排名</div>
                <@}@>
            <@}@>
        <@}else{@>
            <div class="not-gift">
                该主播还未收到礼物，快去打赏一下吧
            </div>
        <@}@>
    </div>
</script>
{%script%}
var GiftTop = require("live:widget/gift-top/top.es6");
GiftTop.init();
{%/script%}