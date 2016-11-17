<script id="J_more_reply_template" type="text/template">
    <@ _.each(datas, function(item,index) { @>
    <dl class="reply-list J-reply-<@=item.pid@>">
        <dd class="operations-user">
            <div class="user-info">
                <div class="avatar">
                    <a href="/my/<@=item.authorid@>" dace-node="{%$id4dace|f_escape_js%}_7100">
                        <img src="<@=item.header@>" alt=""/>
                    </a>
                </div>
                <a href="/my/<@=item.authorid@>" dace-node="{%$id4dace|f_escape_js%}_7100" class="user-name"><@=item.author@></a>
                <@if(item.is_author==1||HPM.type==1){@>
                    <span class="reply-own">楼主</span>
                 <@}@>   
                <div class="user-other">
                    <@ if (item.floor) { @>
                        <span class="floor"><@=item.floor@>楼</span>
                    <@ } @>
                    <span class="times">
                        <@=item._postdate@>
                    </span>
                </div>
            </div>
            <div class="operations">
                <a href="javascript:" class="button-bright J_buttonBright" data-pid="<@=item.pid@>">
                    <i class="icon-bright"></i>
                    <span class="text">点亮<span class="bright-number-box <@ if( item.light <= 0 ) { @>fn-hide<@ } @>"><span class="J_brightNumber"><@=item.light@></span></span>
                    </span>
                </a>
            </div>
        </dd>

        <dt class="reply-content" dace-node="{%$id4dace|f_escape_js%}_quote">
            <@ if( !_.isEmpty(item.quote) && _.isArray(item.quote) && item.quote.length > 0 ) { @>
                <div class="reply-quote-content J_contentParent">
                    <div class="reply-quote-hd">
                        <@=item.quote[0].header[0]@>
                        <@ if( !_.isEmpty(item.quote[0].togglecontent) ) { @>
                            <a href="javascript:" class="button-open J_buttonOpenAll" title="展开"></a>
                        }
                        <@ } @>
                    </div>
                    <@ if( !_.isEmpty( item.quote[0].togglecontent ) ) { @>
                        <div class="short-quote-content J_shortContent">
                            <@=item.quote[0].togglecontent@>
                        </div>
                        <div class="reply-quote-bd J_allContent">
                            <@=item.quote[0].content@>
                        </div>
                    <@ }else{ @>
                        <div class="short-quote-content">
                            <@=item.quote[0].content@>
                        </div>
                    <@ } @>
                </div>
            <@ } @>
            <div class="current-content J_contentParent J_currentContent">
                <span class="short-content">
                    <@=item.content@>
                </span>
            </div>
        </dt>

        <dd class="reply-bt">
            <span class="source-left">
                <@ if( !_.isEmpty(item.viainfo) ) { @>
                    <a href="<@=item.viainfo.url@>" class="source"><@=item.viainfo.text@></a>
                <@ } @>
            </span>
            <a href="javascript:" dace-node="{%$id4dace%}_quote" class="button-quote J_buttonQuote" data-pid="<@=item.pid@>" data-floor="
                <@ if(item.floor) { @> <@=item.floor@> <@ }else{ @> 1 <@ } @>">
                <span class="qoute-smail-content">
                    <@ if( !_.isEmpty(item.smallcontent) ) { @>
                        <@=item.smallcontent@>
                    <@ } @>
                </span>
                <span class="text">引用</span>
            </a>
        </dd>
    </dl>
    <@ }); @>
</script>
<div class="m-popup-reply J_popupReply">
<div class="topbar-operations">
<a class="button-cancel J_buttonClosePopup" href="javascript:" dace-node="{%$id4dace|f_escape_xml%}_cancelComment">取消</a>
<h2 class="title">发表回贴</h2>
<a href="javascript:" class="button-submit J_buttonSubmit">提交</a>
</div>
<div class="popup-reply-wrap">
<section class="popup-reply-inner">
<div class="quote-content J_popupQuoteContent"></div>
<textarea placeholder="说说你的看法..." class="reply-textarea J_replyTexttarea" maxlength="400"></textarea>
<span class="words-number">6-400字</span>
</section>
{%widget
            name = "common:widget/ui/upload-image/upload-image.tpl"
        %}
</div>
</div>
