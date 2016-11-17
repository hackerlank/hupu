<section class="t-content anchor-info">
    <header class="hd">
        <div class="info">
            <div class="head">
                <img src="{%$live.avatar.header_small%}" alt="" />
            </div>
            <div class="text">
                <h2 class="anchor-name">{%$live.anchor_nickname%}</h2>
                <div class="earnings">
                    <span class="coin"><i class="icon icon-coin"></i>{%$live.income.money%}</span>
                    <span class="beans"><i class="icon icon-beans"></i>{%$live.income.gold%}</span>
                </div>
                <div class="tags">
                    {%if !empty($live.tips)%}
                        {%foreach $live.tips as $val%}
                        <span>{%$val%}</span>
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
            <span class="num {%if $live.is_follow == 1%}unfollow-num{%else%}follow-num{%/if%}">{%$live.following%}</span>
        </div>
    </header>
    <div class="bd">
        {%if !empty($live.notice)%}
        <h3><i class="icon icon-anchor"></i>主播公告</h3>
        <p>{%$live.notice|escape:none%}</p>
        {%else%}
        <div class="no-notice">
            <img src="./no-gift.png" width="80" alt="" />
            <p>主播未发布公告</p>
        </div>
        {%/if%}
    </div>
</section>

{%script%}
    var anchorInfo = require("app:widget/anchor_info/anchor_info.js");
    anchorInfo.init();
{%/script%}
