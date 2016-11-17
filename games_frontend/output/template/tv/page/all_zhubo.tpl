{%extends file="common/page/layout-empty.tpl"%} 
{%block name="title"%}虎扑TV{%/block%}
{%block name="head_static"%}
<script type="text/javascript" src="//w10.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
{%require name="common:static/js/underscore/underscore.js"%}
{%require name="common:static/js/zepto/zepto.js"%}
{%require name="tv:static/all_zhubo/all_zhubo.scss"%}
{%if $smarty.get.pagetab==='all'%}
{%$active="all"%}
{%else%}
{%$active="follow"%}
{%/if%}
{%script%}
        window.GM = {
            "client": "{%$client|f_escape_js%}" || "x",
            "islogin": !!parseInt("{%$is_login|f_escape_js%}", 10),
            "show": "{%$active|f_escape_js%}"||1,
            "projectId": "{%$projectId|f_escape_js%}"|| 1,
            "version":"{%$version|f_escape_js%}"||"7.0.6"
        };

        var zhubo_list = require("tv:widget/zhubo_list/zhubo_list.js");
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
{%foreach $roomList as $val%}
<li>
<a href="kanqiu://room/{%$val.id|f_escape_path%}/2" class="left">
<div class="head">
{%if $val.is_live == 0 %}
<span class="img"><img src="{%$val.avator|f_escape_xml%}" width="60" /></span>
<span class="mask"></span>
<span class="status-label live-label">LIVE</span>
{%else%}
<span class="img"><img src="{%$val.avator|f_escape_xml%}" width="60" class="gray" /></span>
<span class="mask"></span>
<span class="status-label rest-label">休息中</span>
{%/if%}
</div>
<div class="info">
<div class="inner">
<div class="title">{%$val.anchor_nickname|escape:"html"|f_escape_xml%}</div>
{%if isset($val.tips)%}<div class="labels">{%$val.tips|escape:"html"|f_escape_xml%}</div>{%/if%}
</div>
</div>
</a>
<div class="right">
{%if $val.follow %}
<a href="javascript:void(0);" class="J-follow-btn follow-btn followed" data-id="{%$val.uid|f_escape_xml%}">已关注</a>
{%else%}
<a href="javascript:void(0);" class="J-follow-btn follow-btn" data-id="{%$val.uid|f_escape_xml%}">关注</a>
{%/if%}
</div>
</li>
{%/foreach%}
</ul>
<ul id="J-myFollow-list" {%if $active=="all"%}style="display:none"{%/if%}></ul>
<script id="J-follow-list" type="text/template">
            <@ $(datas).each(function(index,item) { @>
                <li>
                    <a href="kanqiu://room/<@=item.id@>/2" class="left">
                        <div class="head">
                            <@ if(item.is_live == 0){ @>
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
                        <@if(typeof(item.follow) === "undefined" || item.follow){@>
                        <a href="javascript:void(0);" class="J-follow-btn follow-btn followed" data-id="<@=item.uid@>">已关注</a>
                        <@}else{@>
                        <a href="javascript:void(0);" class="J-follow-btn follow-btn" data-id="<@=item.uid@>">关注</a>
                        <@}@>
                    </div>
                </li>
            <@ }); @>
        </script>
</section>
</section>
{%require name='tv:page/all_zhubo.tpl'%}{%/block%}
