{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}{%$title|f_escape_xml%}{%/block%}
{%block name="head_static"%}
<script type="text/javascript" src="//w10.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
{%require name="common:static/js/underscore/underscore.js"%}
{%require name="common:static/js/zepto/zepto.js"%}
{%require name="bbs:static/detail/detail.scss"%}
{%script%}
    {%if empty($smarty.get.page)%}
        {%$page = 1%}
    {%else%}
        {%$page = intval($smarty.get.page)%}
    {%/if%}

    window.GM = {
        "prev": !!parseInt("{%$smarty.get.prev|f_escape_js%}"),
        "tid": "{%$tid|f_escape_js%}",
        "last": !!parseInt("{%$smarty.get.last|f_escape_js%}"),
        "isNew": !!parseInt("{%$smarty.get.isnew|f_escape_js%}", 10) || 0,
        "author_puid": "{%$author_puid|f_escape_js%}",
        "unlights_enable": !!parseInt("{%$forum.unlights_enable|f_escape_js%}"),
        "hasPraise": !!parseInt("{%$show_post_praise|f_escape_js%}"),
        "pid": "{%$smarty.get.pid|f_escape_js%}" || 0,
        "fid": "{%$fid|f_escape_js%}",
        "puid": "{%$puid|f_escape_js%}" || "",
        "isOwner": parseInt("{%$smarty.get.postAuthorPuid|f_escape_js%}", 10) || 0,
        "page": parseInt("{%$page|f_escape_js%}", 10) || 1,
        "islogin": !!parseInt("{%$is_login|f_escape_js%}", 10),
        "totalPage": parseInt("{%$totalPage|f_escape_js%}", 10) || 1,
        "client": "{%$client|f_escape_js%}" || "x",
        "projectId":"{%$projectId|f_escape_js%}"||"null",
        "version":"{%$version|f_escape_js%}"||"7.0.5.0",
        "title":"{%$title|f_escape_js%}",
        "night":parseInt("{%$night|f_escape_js%}", 10),
        "nopic":parseInt("{%$nopic|f_escape_js%}", 10),
        "wasError": !!parseInt("{%!!$error%}" , 10),
        "ft": "{%if intval($ft) < 14 && !empty($ft)%}18{%else%}{%$ft|f_escape_js%}{%/if%}"
    };

    var app = require("common:widget/ui-app/ui-app.js");
    app.init(function(){
        var reply = require("bbs:widget/reply/reply.js");
        reply.init();
    }, ~location.search.indexOf("debug"));

    {%/script%}
{%/block%}
{%block name="content"%}
{%if empty($smarty.get.page)%}
{%$page = 1%}
{%else%}
{%$page = intval($smarty.get.page)%}
{%/if%}
<section class="detail-wrap">
<section class="detail-content" id="J-page-container" {%if $page != 1%}style="display:none"{%/if%}>
{%if empty($error)%}
{%if !empty($merge_title)%}<p class="tips"><em></em>{%$merge_title|f_escape_xml%}</p>{%/if%}
<header class="artical-title">
<h1 class="headline">{%$title|f_escape_xml%}</h1>
<div class="artical-info">
<span class="times">{%$time|f_escape_xml%}</span>
<span class="post-board">
{%if !empty($is_admin)%}
<em>版务操作<select class="J-bbsrecommend-manage">
{%if empty($is_recommend_filter)%}
<option value="1">隐藏推荐</option>
{%else%}
<option value="-1">取消隐藏推荐</option>
{%/if%}
<option value="0" selected="selected">取消</option>
</select>
</em>
{%/if%}
<a href="kanqiu://bbs/board/{%$fid|f_escape_path%}" dace-node="postBoard">{%if !empty($forum.name)%}{%$forum.name|f_escape_xml%}{%/if%}</a>
</span>
</div>
<div class="line"></div>
</header>
<article class="article-content">
<div class="article-author clearfix">
<a href="kanqiu://people/{%$author_puid|f_escape_path%}" dace-node="postuser"><img src="{%$userImg|f_escape_xml%}" class="author-icon J-user-avatar-img" />{%$username|f_escape_xml%}
<span class="mod-mask mask"></span>
</a>
<a href="{%$cert_url|f_escape_xml%}" class="certification">
{%if $cert_type == 2%}
<img src="//w10.hoopchina.com.cn/hybrid/static/bbs/page/img/official_ic_day_a41111e.png" alt="official" height="22">
{%/if%}
{%if $cert_type == 1%}
<img src="//w10.hoopchina.com.cn/hybrid/static/bbs/page/img/author_ic_day_ad41382.png" alt="author" height="22">
{%/if%}
<span>{%$cert_info|f_escape_xml%}</span>
</a>
</div>
<div class="J-article-content" style="font-size:{%if !empty($ft)%}{%if intval($ft) < 14%}18{%else%}{%$ft|f_escape_xml%}{%/if%}{%else%}17{%/if%}px;">
{%$content|escape:none%}
</div>
</article>
{%if !empty($praise) && $praise.status == 200%}
{%widget
              name="common:widget/mod-zan/mod-zan.tpl"
              author=$praise.userinfo
              users=$praise.list.goldUsers
              type="bbs"
              callname="楼主"
              userCount=$praise.list.userCount
              goldCount=$praise.list.goldCount
              typeid=$tid
              fid=$forum.fid
              tips=$praise.tips
            %}
{%/if%}
{%/if%}
</section>
{%widget
        name="bbs:widget/reply/reply.tpl"
    %}
</section>
{%if !empty($error)%}
<div class="detail-error">
<p>{%$error.text|f_escape_xml%}</p>
</div>
{%/if%}
{%require name='bbs:page/detail.tpl'%}{%/block%}
