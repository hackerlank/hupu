{%extends file="app/page/layout.tpl"%}

{%block name="title"%}路人王{%/block%}

{%block name="head_static"%}
    {%require name="app:static/js/underscore/underscore.js"%}
    {%require name="app:static/js/zepto/zepto.js"%}
    {%require name="app:static/list/list.scss"%}

    {%script%}
    var refresh = require("app:widget/ui-refresh/ui-refresh.js");
    var page = require("app:widget/list/list.js");
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
    page.initLoadCover();
    $(window).on("load", function(){
        page.update();
    });
    {%/script%}
{%/block%}

{%block name="content"%}
<section class="room-list-wrap" id="J-page-container">
    <div class="tv-top">
      {%if !empty($ad.img)%}
        <a href="{%$ad.url%}"><img src="{%$ad.img%}" /></a>
      {%/if%}
    </div>
    {%if $is_login && !empty($user_predict)%}
    <a class="tv-pred" href="/m/predict/my/list?n={%$in_kanqiu%}&client={%$client%}">
        <div class="user">
          <img src="{%$user_predict.header%}" />
          {%if !empty($night)%}<span class="mask"></span>{%/if%}
        </div>
        <div class="userinfo">
            <div class="rp_value"><span class="rpz-text {%if $user_predict.score >= 0%}rp-win{%else%}rp-lost{%/if%}">人品值：{%$user_predict.score%}</span>
                {%if $user_predict.month_rank <= 1000 && $user_predict.month_rank != 0%}
                    <span class="rpz-rank">你当前排名 {%$user_predict.month_rank%}</span>
                {%else if $user_predict.month_rank > 1000%}
                    <span class="rpz-rank">你已打败 {%(100-$user_predict.month_rank*100/$user_predict.userCount)|string_format:"%d"%}%的用户</span>
                {%else $user_predict.month_rank == 0%}
                    <span class="rpz-rank">暂无排行</span>
                {%/if%}
            </div>
            <div class="rp_log">今日 <span class="{%if $user_predict.today_win_score >= 0%}win{%else%}lose{%/if%}">
              {%if $user_predict.today_win_score >= 0%}+{%/if%}{%$user_predict.today_win_score%}</span>&nbsp;<span class="win">连胜{%$user_predict.win%}场</span></div>
            </div>
            <span class="myrpz arrow-right">记录<i class="icon-arrow"></i></span>
        </a>
    {%/if%}
    <div class="tv-header" id="J-zhubo-container">
        {%if !$is_login || !$is_follow%}
            <section>
                <h3 class="title">你还没有关注的主播</h3>
                <a class="goto" href="/m/anchor/list?pagetab=all&n={%$in_kanqiu%}&client={%$client%}">去关注主播<i class="icon-arrow"></i></a>
            </section>
        {%else%}
            <section>
                <h3 class="title">我关注的主播<a class="manage" href="/m/anchor/list?pagetab=follow&n={%$in_kanqiu%}&client={%$client%}">[管理]</a></h3>
                <a class="goto" href="/m/anchor/list?pagetab=all&n={%$in_kanqiu%}&client={%$client%}">发现更多的主播<i class="icon-arrow"></i></a>
            </section>

            {%$liveZhubo=[]%}
            {%foreach $followList as $item%}
              {%if $item.is_live==1%}
                {%$tmp = array_push($liveZhubo, $item)%}
              {%/if%}
            {%/foreach%}

            {%if empty($liveZhubo)%}
                {%if $is_follow%}
                    <div class="empty">
                        你关注的主播暂时还未开播
                    </div>
                {%/if%}
            {%else%}
            <div class="list">
                <ul style="width:{%count($liveZhubo) * 80%}px">
                    {%foreach $liveZhubo as $item%}
                    <li class="{%if $item.is_live==1%}live{%else%}rest{%/if%}">
                        <a class="head" href="{%withRoomUrl roomid=$item.id inkanqiu=$in_kanqiu client=$client%}">
                            <img class="zhubo-avatar" src="{%$item.avator%}">
                            <span class="mod-mask mask"></span>
                        </a>
                        <span class="status-label {%if $item.is_live==1%}live-label{%else%}rest-label{%/if%}">{%if $item.is_live==1%}LIVE{%else%}休息中{%/if%}</span>
                        <a href="{%withRoomUrl roomid=$item.id inkanqiu=$in_kanqiu client=$client%}">{%$item.anchor_nickname%}</a>
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
            <a class="goto" href="/m/anchor/list?pagetab=all&n={%$in_kanqiu%}&client={%$client%}">去关注主播<i class="icon-arrow"></i></a>
        </section>
        <@}else{@>
        <section>
            <h3 class="title">我关注的主播<a class="manage" href="/m/anchor/list?pagetab=follow&n={%$in_kanqiu%}&client={%$client%}">[管理]</a></h3>
            <a class="goto" href="/m/anchor/list?pagetab=all&n={%$in_kanqiu%}&client={%$client%}">发现更多的主播<i class="icon-arrow"></i></a>
        </section>
            <@var liveZhubo = [];@>
            <@$(data).each(function(idx, item){@>
                <@if(item.is_live==1){@>
                    <@liveZhubo.push(item)@>
                <@}@>
            <@})@>
            <@if(!liveZhubo || !liveZhubo.length){@>
                <@if(is_follow){@>
                    <div class="empty">
                        你关注的主播暂时还未开播
                    </div>
                <@}@>
            <@}else{@>
            <div class="list">
                <ul style="width:<@=(liveZhubo.length * 80)@>px">
                    <@$(liveZhubo).each(function(idx, item){@>
                    <li class="<@if(item.is_live==1){@>live<@}else{@>rest<@}@>">
                        <a class="head" href="<@=withRoomUrl(item.id)@>">
                            <img class="zhubo-avatar" src="<@=item.avator@>">
                            <span class="mod-mask mask"></span>
                        </a>
                        <span class="status-label <@if(item.is_live==1){@>live-label<@}else{@>rest-label<@}@>"><@if(item.is_live==1){@>LIVE<@}else{@>休息中<@}@></span>
                        <a href="<@=withRoomUrl(item.id)@>"><@=item.anchor_nickname@></a>
                    </li>
                    <@})@>
                </ul>
            </div>
            <@}@>
        <@}@>
    </script>

    <div id="J-page-liveroom">
    {%foreach $roomList as $catgoryRoomList%}
        <div class="tv-category clearfix">
             <h3><span>{%$catgoryRoomList['name']%}</span></h3>
                <ul class="list-item clearfix">
                {%foreach $catgoryRoomList['list'] as $room%}
                    <li>
                        <a href="{%withRoomUrl roomid=$room.id inkanqiu=$in_kanqiu client=$client%}">
                            <div class="video-pic">
                                <div class="tag">
                                    {%if !empty($room.rp)%}
                                        <span class="rp-tag">RP</span>
                                    {%/if%}
                                </div>
                                <img data-src="{%$room.cover%}" src="http://w1.hoopchina.com.cn/huputv/resource/img/cover.png" width="100%" />
                                <span class="mod-mask mask"></span>
                            </div>
                            <div class="item-line">{%$room.room_name%}</div>
                            <div class="item-line clearfix"><i></i><span class="item-name">{%$room["anchor_nickname"]%}</span></div>
                        </a>
                    </li>
                {%/foreach%}
             </ul>
        </div>
    {%/foreach%}
    </div>
</section>
{%/block%}