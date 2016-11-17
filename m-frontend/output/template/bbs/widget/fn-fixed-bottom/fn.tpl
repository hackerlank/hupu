<div class="fn-fixed-bottom">
{%if !empty($bottom)%}
<a href="{%$thread.mobileurl|f_escape_xml%}" class="button-returnList" dace-node="{%$id4dace|f_escape_xml%}_5050_floatingbar">正文</a>
{%else%}
<a href="{%$thread.mobileeboardurl|f_escape_xml%}" class="button-returnList" dace-node="{%$id4dace|f_escape_xml%}_5050_floatingbar">专区</a>
{%/if%}
<a href="javascript:" class="button-reply" id="J_buttonReply" dace-node="{%$id4dace|f_escape_xml%}_reply">回复本帖</a>
<ul class="fn-list-right">
{%if $bottom != "commentsDetail"%}
<li>
{%$commentURL = "/bbs/allreplies/{%$thread.tid%}-1.html#pn=1"%}
<a href="{%$commentURL|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_readmorecomment">
{%if !empty($thread.replies)%}
<span class="comment-number">
{%$thread.replies|f_escape_xml%}
</span>
{%/if%}
<i class="icon-comment"></i>
</a>
</li>
{%/if%}
<li id="J_top_star" data-uid="{%$uid|f_escape_xml%}" data-tid="{%$thread.tid|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_fav">
<i class="icon-collect"></i>
</li>
<li id="J_buttonShare" dace-node="{%$id4dace|f_escape_xml%}_share">
<i class="icon-share"></i>
</li>
</ul>
</div>
{%script%}
    var FnFixedButton = require('bbs:widget/fn-fixed-bottom/fn.js');

    FnFixedButton.init();
{%/script%}