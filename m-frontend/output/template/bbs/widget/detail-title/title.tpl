
<header class="m-row artical-title">
<h1 class="headline">{%$thread.subject|escape:none%}</h1>
<div class="artical-info">
<span class="author-name">
<a href="{%$thread.my|f_escape_xml%}">{%$thread.username|f_escape_xml%}</a>
</span>
<span class="times">{%$thread._postdate|f_escape_xml%}</span>
{%if !empty($from) && $from == "comments"%}
<div class="show-comments">
{%if $onlyauthor == 0%}<span class="comment-control">只看楼主</span>
{%else%}
<span class="comment-control all-commment">全部评论</span>
{%/if%}
</div>
{%script%}
                var showComment = require("bbs:widget/detail-title/title.js");
                showComment.init();
            {%/script%}
{%else%}
<span class="topic-link">
<a href="{%$thread.mobileeboardurl|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_5050">{%$thread.boardname|f_escape_xml%}</a>
</span>
{%/if%}
</div>
</header>
