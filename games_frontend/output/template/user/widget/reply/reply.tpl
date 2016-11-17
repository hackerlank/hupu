<div class="m-reply" id="J-all-reply">
<div class="bright-reply" id="J-light-container"></div>
<div class="general-reply-container" id="J-scroll-wrapper">
<div class="general-reply" id="J-reply-container"></div>
</div>
<script type="text/template" id="J-reply-tpl">
        <@if(title){@>
        <div class="title">
            <h2><@=title@></h2>
        </div>
        <@}@>
        <div class="reply-inner">
            <@if(list && list.length){@>
            <@_.each(list, function(item){@>
                <dl class="reply-list" data-pid="<@=item.pid@>" data-uid="<@=item.puid@>" data-username="<@=item.userName@>" data-floor="<@=item.floor@>">
                    <dd class="operations-user">
                        <span class="user-avatar">
                            <img src="<@=item.userImg@>" class="J-user-avatar-img" alt="<@=item.userName@>"/>
                            <span class="mod-mask mask"></span>
                        </span>
                        <div class="user-info">
                            <@if (item.puid == author_puid){@>
                            <div class="user-name clearfix">
                                <span class="fl ellipsis"><@=item.userName@></span>
                                <i class="fr">楼主</i>
                            </div>
                            <@}else{@>
                            <div class="user-name clearfix">
                                <span class="fl"><@=item.userName@></span>
                            </div>
                            <@}@>
                            <div class="source-left">
                                <@if(item.floor){@>
                                    <span class="floor"><@=item.floor@>楼</span>
                                <@}@>
                                <@if(item.time){@>
                                    <span class="postdate"><@=item.time@></span>
                                <@}@>
                            </div>
                        </div>
                        <span class="reply-light" dace-node="pageLight">亮了(<@=item.light_count||0@>)</span>
                    </dd>
                    <dt class="reply-content">
                        <@if ((item.quote) && $.isArray(item.quote) && item.quote.length > 0){@>
                            <div class="reply-quote-content">
                                <div class="reply-quote-hd">
                                    <@=item.quote[0].header[0]@>
                                    <@if(item.quote[0].togglecontent){@>
                                        <a href="javascript:" class="button-open J_buttonOpenAll" title="展开"></a>
                                    <@}@>
                                </div>
                                <@if(item.quote[0].togglecontent){@>
                                    <div class="short-quote-content J_shortContent">
                                        <@=item.quote[0].togglecontent@>
                                    </div>
                                    <div class="reply-quote-bd J_allContent">
                                        <@=item.quote[0].content@>
                                    </div>
                                <@}else{@>
                                    <div class="short-quote-content">
                                        <@=fliter(item.quote[0].content)@>
                                    </div>
                                <@}@>
                            </div>
                        <@}@>
                        <div class="current-content J_contentParent">
                            <span class="short-content">
                                <@=fliter(item.content)@>
                            </span>
                        </div>
                    </dt>
                </dl>
           <@})@>
           <@}else{@>
            <div class="reply-empty">暂无回复</div>
           <@}@>
        </div>
    </script>
</div>
