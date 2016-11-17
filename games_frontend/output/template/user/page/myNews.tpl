{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}
{%if !empty($title)%}
{%$title|f_escape_xml%}
{%else%}
新闻评论{%/if%}
{%/block%}
{%block name="head_static"%}
<script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
<script type="text/javascript">
    window.GM = {
        "tid": "{%$tid|f_escape_js%}",
        "uid": "{%$uid|f_escape_js%}",
        "pid": "{%$smarty.get.pid|f_escape_js%}" || 0,
        "fid": "{%$fid|f_escape_js%}",
        "islogin": !!parseInt("{%$is_login|f_escape_js%}", 10),
        "client": "{%$client|f_escape_js%}" || "x",
        "projectId":"{%$projectId|f_escape_js%}"||"null",
        "version":"{%$version|f_escape_js%}"||"7.0.6.0",
        "title":"{%$title|f_escape_js%}",
        "night":!!parseInt("{%$night|f_escape_js%}", 10),
        "nopic":!!parseInt("{%$nopic|f_escape_js%}", 10),
        "nextPage": !!parseInt("{%$hasNextPage|f_escape_js%}",10) || 0
    };

    </script>
{%require name="common:static/js/underscore/underscore.js"%}
{%require name="common:static/js/zepto/zepto.js"%}
{%require name="user:static/myNews/myNews.scss"%}
{%require name="common:static/js/fastclick/fastclick.js"%}
{%require name="user:static/myNews/myNews.js"%}
{%/block%}
{%block name="content"%}
{%if empty($data)%}
<div class="reply-empty">
{%if $uid != 0 && $uid == $login_uid%}
你{%elseif $uid == 0%}
TA{%else%}
TA{%/if%}
还没有发表过评论哦</div>
{%else%}
<section class="my-news-wrap">
<div class="news-inner" id="J_content">
{%foreach from=$data item=val name=key%}
{%if empty($val.is_delete)%}
<dl class="reply-list {%if !empty($val.is_hide)%}reply-list-hide{%/if%}" data-ncid="{%$val.ncid|f_escape_xml%}" data-jump="kanqiu://news/comment/{%$val.nid|f_escape_xml%}?ncid={%$val.ncid|f_escape_xml%}">
{%if !empty($val.is_hide)%}
<dd class="reply-hide J_preventName" data-type="replyHide" data-hide="1">
**该评论被灭过多，已被折叠**</dd>
{%/if%}
<dd class="operations-info">
<div class="time">
{%$val.format_time|f_escape_xml%}
</div>
<div class="operations">
<a href="javascript:" class="button-light">
亮了({%$val.light_count-$val.unlight_count%})</a>
</div>
</dd>
<dt class="reply-content">
{%if !empty($val.quote_data)%}
{%if !empty($val.quote_data.is_delete)%}
<div class="reply-quote-delete">
**该评论涉及违规，已被删除**</div>
{%else%}
{%if !empty($val.quote_data.is_hide)%}
<div class="reply-quote-hide J_preventName" data-type="replyQuoteHide" data-hide="1">
**该评论被灭过多，已被折叠**</div>
<div class="reply-quote-content J_contentParent" style="display:none;">
{%else%}
<div class="reply-quote-content J_contentParent">
{%/if%}
<div class="reply-quote-hd">
{%$val.quote_data.user_name|f_escape_xml%}
</div>
{%if !empty($val.quote_data.short_content)%}
<div class="short-quote-content J_quoteShortContent">
{%$val.quote_data.short_content|escape:none%}
</div>
<div class="reply-quote-bd J_quoteAllContent">
{%$val.quote_data.content|escape:none%}
</div>
<div class="button-open-inner">
<a href="javascript:" class="button-open J_preventName J_buttonOpenAll" title="展开" data-type="replyQuoteButtonOpen">显示全部<s class="arrow"></s></a>
</div>
{%else%}
<div class="short-quote-content">
{%$val.quote_data.content|escape:none%}
</div>
{%/if%}
</div>
{%/if%}
{%/if%}
<div class="current-content J_contentParent J_currentContent">
<span class="short-content">
{%$val.content|escape:none%}
</span>
</div>
</dt>
<dt class="source">
来自：<a href="{%$val.news_url|f_escape_xml%}">{%$val.news_title|escape:none%}</a>
</dt>
</dl>
{%/if%}
{%/foreach%}
</div>
<script type="text/template" id="J_replyListTpl">
        <@ _.each(datas, function(item,index) { @>
            <@if(typeof item.is_delete === "undefined"){@>
                <@if(item.audit_status == 1 && (GM.cid != item.cid || GM.uid != item.uid)){@>
                <@}else{@>
                    <dl class="reply-list <@if(typeof item.is_hide !== "undefined"){@>reply-list-hide<@}@>" data-jump="kanqiu://news/comment/<@=item.nid@>?ncid=<@=item.ncid@>">
                    <@if(typeof item.is_hide !== "undefined"){@>
                        <dd class="reply-hide J_preventName" data-type="replyHide" data-hide="1">
                            **该评论被灭过多，已被折叠**
                        </dd>
                    <@}@>
                    <dd class="operations-info">
                        <div class="time">
                            <@=item.format_time@>
                        </div>
                        <div class="operations">
                            <a href="javascript:" class="button-light">
                                亮了(<@=item.light_count-item.unlight_count@>)
                            </a>
                        </div>
                    </dd>
                    <dt class="reply-content">
                        <@if(typeof item.quote_data !== "undefined"){@>
                            <@if(typeof item.quote_data.is_delete !== "undefined"){@>
                                <div class="reply-quote-delete">
                                    **该评论涉及违规，已被删除**
                                </div>
                            <@}else{@>
                                <@if(typeof item.quote_data.is_hide !== "undefined"){@>
                                    <div class="reply-quote-hide J_preventName" data-type="replyQuoteHide" data-hide="1">
                                        **该评论被灭过多，已被折叠**
                                    </div>
                                    <div class="reply-quote-content J_contentParent" style="display:none;">
                                <@}else{@>
                                    <div class="reply-quote-content J_contentParent">
                                <@}@>
                                    <div class="reply-quote-hd">
                                        <@=item.quote_data.user_name@>
                                    </div>
                                    <@if(typeof item.quote_data.short_content !== "undefined"){@>
                                        <div class="short-quote-content J_quoteShortContent">
                                            <@=item.quote_data.short_content@>
                                        </div>
                                        <div class="reply-quote-bd J_quoteAllContent">
                                            <@=item.quote_data.content@>
                                        </div>
                                        <div class="button-open-inner">
                                            <a href="javascript:" class="button-open J_preventName J_buttonOpenAll" title="展开" data-type="replyQuoteButtonOpen">显示全部 <s class="arrow"></s></a>
                                        </div>
                                    <@}else{@>
                                        <div class="short-quote-content">
                                            <@=item.quote_data.content@>
                                        </div>
                                    <@}@>
                                </div>
                            <@}@>
                        <@}@>
                        <div class="current-content J_contentParent J_currentContent">
                            <span class="short-content">
                                <@=item.content@>
                            </span>
                        </div>
                    </dt>
                    <dt class="source">
                        来自：<a href="<@=item.news_url@>"><@=item.news_title@></a>
                    </dt>
                    </dl>
                <@}@>
            <@}@>
        <@})@>

    </script>
</section>
{%/if%}
{%require name='user:page/myNews.tpl'%}{%/block%}
