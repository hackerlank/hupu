{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}虎扑TV{%/block%}
{%block name="head_static"%}
{%require name="common:static/js/underscore/underscore.js"%}
{%require name="common:static/js/zepto/zepto.js"%}
{%require name="tv:static/list/list.css"%}
{%script%}
    window.GM = {
        "client": "{%$client|f_escape_js%}" || "x",
        "projectId": "{%$projectId|f_escape_js%}"|| 1,
        "version":"{%$version|f_escape_js%}"||"7.0.6"
    };
    var refresh = require("common:widget/ui-refresh/ui-refresh.js");
    var page = require("tv:widget/live/live.js");
    refresh({
        contentEl: '#J-page-container',
        isRefresh: true,
        isLoadingMore: false,
        refreshCallback: function(complete) {
             setTimeout(function() {
                 complete();
                 location.reload();
             }, 1000);
        }
    });
    $(window).on("load", function(){
        page.update();
    });
    {%/script%}
{%/block%}
{%block name="content"%}
<section class="room-list-wrap" id="J-page-container">
<div class="tv-header" id="J-zhubo-container">
{%if !$is_login || !$is_follow%}
<section>
<h3 class="title">你还没有关注的主播</h3>
<a class="goto" href="/{%$projectId|default:"1"|f_escape_path%}/{%$version|default:"7.0.6"|f_escape_path%}/room/getAllAnchor?pagetab=all&client={%$client|default:"x"|f_escape_path%}">去关注主播 &gt;</a>
</section>
{%else%}
<section>
<h3 class="title">我关注的主播<a class="manage" href="/{%$projectId|default:"1"|f_escape_path%}/{%$version|default:"7.0.6"|f_escape_path%}/room/getAllAnchor?pagetab=follow&client={%$client|default:"x"|f_escape_path%}">[管理]</a></h3>
<a class="goto" href="/{%$projectId|default:"1"|f_escape_path%}/{%$version|default:"7.0.6"|f_escape_path%}/room/getAllAnchor?pagetab=all&client={%$client|default:"x"|f_escape_path%}">发现更多的主播 &gt;</a>
</section>
{%if empty($followList)%}
{%if $is_follow%}
<div class="empty">
你关注的主播暂时还未开播</div>
{%/if%}
{%else%}
<div class="list">
<ul style="width:{%count($followList) * 80%}px">
{%foreach $followList as $item%}
<li class="{%if $item.is_live==0%}live{%else%}rest{%/if%}">
<a class="head" href="kanqiu://room/{%$item['id']|f_escape_path%}/2">
<img class="zhubo-avatar" src="{%$item.avator|f_escape_xml%}">
<span class="mod-mask mask"></span>
</a>
<span class="status-label {%if $item.is_live==0%}live-label{%else%}rest-label{%/if%}">{%if $item.is_live==0%}LIVE{%else%}休息中{%/if%}</span>
<a href="kanqiu://room/{%$item['id']|f_escape_path%}/2">{%$item.anchor_nickname|f_escape_xml%}</a>
</li>
{%/foreach%}
</ul>
</div>
{%/if%}
{%/if%}
</div>
<script type="text/template" id="J-page-tpl">
        <@if(!is_login || !is_follow){@>
        <section>
            <h3 class="title">你还没有关注的主播</h3>
            <a class="goto" href="/<@=GM.projectId@>/<@=GM.version@>/room/getAllAnchor?pagetab=all&client=<@=GM.client@>">去关注主播 &gt;</a>
        </section>
        <@}else{@>
        <section>
            <h3 class="title">我关注的主播<a class="manage" href="/room/getAllAnchor?pagetab=follow&client={%$client|f_escape_js%}">[管理]</a></h3>
            <a class="goto" href="/<@=GM.projectId@>/<@=GM.version@>/room/getAllAnchor?pagetab=all&client=<@=GM.client@>">发现更多的主播 &gt;</a>
        </section>
            <@if(!data || !data.length){@>
                <@if(is_follow){@>
                    <div class="empty">
                        你关注的主播暂时还未开播
                    </div>
                <@}@>
            <@}else{@>
            <div class="list">
            <ul style="width:<@=(data.length * 80)@>px">
                <@$(data).each(function(idx, item){@>
                <li class="<@if(item.is_live==0){@>live<@}else{@>rest<@}@>">
                    <a class="head" href="kanqiu://room/<@=item.id@>/2">
                        <img class="zhubo-avatar" src="<@=item.avator@>">
                        <span class="mod-mask mask"></span>
                    </a>
                    <span class="status-label <@if(item.is_live==0){@>live-label<@}else{@>rest-label<@}@>"><@if(item.is_live==0){@>LIVE<@}else{@>休息中<@}@></span>
                    <a href="kanqiu://room/<@=item.id@>/2"><@=item.anchor_nickname@></a>
                </li>
                <@})@>
            </ul>
            </div>
            <@}@>
        <@}@>
    </script>
{%foreach $roomList as $catgoryRoomList%}
<div class="tv-category clearfix">
<h3><span>{%$catgoryRoomList['name']|f_escape_xml%}</span></h3>
<ul class="list-item clearfix">
{%foreach $catgoryRoomList['list'] as $room%}
<li>
<a href="kanqiu://room/{%$room['id']|f_escape_path%}/2">
<div class="video-pic">
<img src="{%$room['cover']|f_escape_xml%}" width="100%" />
<span class="mod-mask mask"></span>
</div>
<div class="item-line">{%$room["name"]|f_escape_xml%}</div>
<div class="item-line clearfix"><i></i><span class="item-name">{%$room["anchor_nickname"]|f_escape_xml%}</span></div>
</a>
</li>
{%/foreach%}
</ul>
</div>
{%/foreach%}
</section>
{%require name='tv:page/list.tpl'%}{%/block%}
