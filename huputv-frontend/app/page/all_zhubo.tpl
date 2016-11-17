{%extends file="app/page/layout.tpl"%}

{%block name="title"%}亮了网{%/block%}

{%block name="head_static"%}
    {%require name="app:static/all_zhubo/all_zhubo.scss"%}
    {%if $smarty.get.pagetab==='all'%}
        {%$active="all"%}
    {%else%}
        {%$active="follow"%}
    {%/if%}

    {%script%}
        window.GM = $.extend(window.GM, {
          show: "{%$active%}"||1,
          pagetab: "{%$pagetab%}"
        });

        var zhubo_list = require("app:widget/zhubo_list/zhubo_list.js");
        zhubo_list.init();
    {%/script%}
{%/block%}

{%block name="content"%}
<section class="widget-list-wrap" id="J-widget-list-wrap">
    <section class="hd" id="J-tab-page">
        <span id="J-all" {%if $active=="all"%}class="active"{%/if%}>全部主播</span>
        <span id="J-myfollow" {%if $active=="follow"%}class="active"{%/if%}>我的关注</span>
    </section>
    <section class="bd">
        <section class="follow-null-wrap" id="J-follow-null-wrap" style="display: none;">
            <div class="inner">
                <p>还没有关注的主播</p>
            </div>
        </section>
        <ul id="J-zhubo-list" {%if $active=="follow"%}style="display:none"{%/if%}>
        </ul>
        <ul id="J-myFollow-list" {%if $active=="all"%}style="display:none"{%/if%}></ul>

        <script id="J-follow-list" type="text/template">
            <@ $(datas).each(function(index,item) { @>
                <li>
                    <a href="<@=withRoomUrl(item.id)@>" class="left">
                        <div class="head">
                            <@ if(item.is_live == 1){ @>
                            <span class="img"><img src="<@=item.avator@>" width="60" /></span>
                            <span class="mask"></span>
                            <span class="status-label live-label">LIVE</span>
                            <@ }else{ @>
                            <span class="img"><img src="<@=item.avator@>" width="60" class="gray" /></span>
                            <span class="mask"></span>
                            <span class="status-label rest-label">休息中</span>
                            <@ } @>
                        </div>
                        <div class="info">
                            <div class="inner">
                                <div class="title">
                                <@if(type == "all"){@>
                                    <@=_escape(item.anchor_nickname)@>
                                <@}else{@>
                                    <@=_escape(item.name)@>
                                <@}@>
                                </div>
                                <div class="labels">
                                <@if(type == "all"){@>
                                    <@=_escape(item.tips)@>
                                <@}else{@>
                                    <@=_escape(item.anchor_nickname)@>
                                <@}@>
                                </div>
                            </div>
                        </div>
                    </a>
                    <div class="right">
                        <@if(typeof(item.is_follow) === "undefined" || item.is_follow){@>
                        <a href="javascript:void(0);" class="J-follow-btn follow-btn followed" data-id="<@=item.id@>">已关注</a>
                        <@}else{@>
                        <a href="javascript:void(0);" class="J-follow-btn follow-btn" data-id="<@=item.id@>">关注</a>
                        <@}@>
                    </div>
                </li>
            <@ }); @>
        </script>
    </section>
</section>
{%/block%}
