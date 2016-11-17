<div class="m-detail-top-station">
<nav class="m-detail-top-nav">
<div class="top-nav-left">
<a href="{%$node[0].url|f_escape_xml%}" class="button-returnList" dace-node="{%$id4dace|f_escape_xml%}_navigation_1">{%$node[0].title|f_escape_xml%}</a>
</div>
<div class="top-nav-right">
{%if !empty($from) && $from == "comments"%}
<a href="javascript:" class="button-star icon-collect " id="J_top_star" data-uid="{%$uid|f_escape_xml%}" data-tid="{%$thread.tid|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_fav" title="收藏"></a>
{%/if%}
<a href="javascript:" class="button-share icon-share" id="J_top_share" dace-node="{%$id4dace|f_escape_xml%}_share" title="分享"></a>
</div>
</nav>
</div>
{%script%}
    var toShare = require("common:widget/ui/share/share.js");
    //全局分享事件, 每个页面单独注册.
    $(document).on("page:share", function(){
        toShare();
    });
    //触发挂载在document上的"page:share"事件. 
    $("#J_top_share").bind("click", function(){
        $(document).trigger("page:share");
    });
{%/script%}