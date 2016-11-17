<div class="m-reply m-card-split-line" id="J_replyContent">
{%if !empty($lightReplies) %}
<div class="bright-reply">
<div class="title">
<h2>这些回帖亮了</h2>
</div>
<div class="reply-inner">
{%foreach from=$lightReplies item=val name=key%}
{%if $val.is_hide!=1%}
{%widget
                            name="bbs:widget/reply/reply-list.tpl"
                            data=$val
                        %}
{%/if%}
{%/foreach%}
</div>
</div>
{%/if%}
<div class="button-inner not-login-button">
<a href="/bbs/allreplies/{%$thread.tid|f_escape_path%}-1.html#pn=1" class="button-viewMore" dace-node="{%$id4dace|f_escape_xml%}_readMoreComment">查看全部回帖({%$thread.replies|f_escape_xml%}) ></a>
</div>
</div>
<section class="m-card-split-line" id="u2740419">
{%$adInfo.m_partner.m_thread_detail_bright_reply_downside.adcode|escape:none%}
</section>
{%widget
    name="bbs:widget/reply/popup-reply.tpl"
%}
{%script%}
    var reply = require("bbs:widget/reply/reply.js");
    reply.init();
{%/script%}
