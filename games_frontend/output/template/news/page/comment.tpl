{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}全部评论{%/block%}
{%block name="head_static"%}
<script type="text/javascript" src="//w10.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
{%require name="common:static/js/zepto/zepto.js"%}
{%require name="news:static/comment/comment.scss"%}
<script>
        window.GM = {
            "nid": "{%$nid|f_escape_js%}",
            "hid": "{%$hid|f_escape_js%}",
            "islogin": !!parseInt("{%$is_login|f_escape_js%}", 10),
            "client": "{%$client|f_escape_js%}" || "x",
            "projectId":"{%$projectId|f_escape_js%}"||"null",
            "version":"{%$version|f_escape_js%}"||"7.0.6.0",
            "token": "{%$token|f_escape_js%}",
            "night":!!parseInt("{%$night|f_escape_js%}", 10),
            "nopic":!!parseInt("{%$nopic|f_escape_js%}", 10),
            "cid": "{%$cid|f_escape_js%}" || "",
            "top_ncid": "{%$top_ncid|f_escape_js%}" || "",
            "uid": "{%$uid|f_escape_js%}" || "",
            "user_name": "{%$user_name|f_escape_js%}" || "",
            "puid": "{%$puid|f_escape_js%}" || "",
            "header": "{%$header|f_escape_js%}" || "//b3.hoopchina.com.cn/games/images/man.jpg",
            "leaguesEn": "{%$leaguesEn|f_escape_js%}" || "epl",
            "is_admin": !!parseInt("{%$is_admin|f_escape_js%}", 10),
            "ft": "{%if intval($ft) < 14 %}16{%else%}{%$ft|f_escape_js%}{%/if%}"
        };
    </script>
{%script%}
        var app = require("common:widget/ui-app/ui-app.js");
        app.init(function(){
            var Reply = require("news:widget/reply/reply.js");
            Reply.init();
        }, ~location.search.indexOf("debug"));
    {%/script%}
{%/block%}
{%block name="content"%}
<section class="detail-wrap" id="J_replyWrap">
<script type="text/template" id="J_titleTpl">
        {%widget
            name="news:widget/artical-title/title.tpl"
            tplType= "js"
        %}
    </script>
<div id="J_replyTitle">
</div>
{%widget
        name="news:widget/reply/reply.tpl"
        replyType="comment"
    %}
</section>
{%require name='news:page/comment.tpl'%}{%/block%}
