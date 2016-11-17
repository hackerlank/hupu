<section class="t-content anchor-info">
<header class="hd">
<div class="info">
<div class="head">
<img src="{%$live.avatar.header_small|f_escape_xml%}" alt="" />
</div>
<div class="text">
<h2 class="anchor-name">{%$live.anchor_nickname|f_escape_xml%}</h2>
<div class="earnings">
<span class="coin"><i class="icon icon-coin"></i>{%$live.income.money|f_escape_xml%}</span>
<span class="beans"><i class="icon icon-beans"></i>{%$live.income.gold|f_escape_xml%}</span>
</div>
<div class="tags">
{%if !empty($live.tips)%}
{%foreach $live.tips as $val%}
<span>{%$val|f_escape_xml%}</span>
{%/foreach%}
{%/if%}
</div>
</div>
</div>
<div class="follow" id="J-follow-wrap">
{%if $live.is_follow == 1%}
<a href="javascript:;" class="btn btn-unfollow">取消关注</a>
{%else%}
<a href="javascript:;" class="btn btn-follow">关注</a>
{%/if%}
<span class="num {%if $live.is_follow == 1%}unfollow-num{%else%}follow-num{%/if%}">{%$live.following|f_escape_xml%}</span>
</div>
</header>
<div class="bd">
{%if !empty($live.notice)%}
<h3><i class="icon icon-anchor"></i>主播公告</h3>
<p>{%$live.notice|escape:none%}</p>
{%else%}
<div class="no-notice">
<img src="http://b1.hoopchina.com.cn/web/tv/static/app/widget/anchor_info/no-gift_b378bc2.png" width="80" alt="" />
<p>主播未发布公告</p>
</div>
{%/if%}
</div>
</section>
{%script%}
    var anchorInfo = require("app:widget/anchor_info/anchor_info");
    anchorInfo.init();
{%/script%}
