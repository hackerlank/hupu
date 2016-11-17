<style>
/*
Safari下面样式兼容
*/
</style>
<div class="w-header" id="J-w-header">
	<div class="inner clearfix">
		<h1 class="logo">
			<a href="/" title="亮了网">
                <img src="./img/logo.png" alt="">         
            </a>
		</h1>
		<div class="nav">
            {%if !empty($category) %}
                <ul>
                    {%foreach $category as $val%}
                        {%if !empty($val.display)%}
                            {%$category_arr[$val@index]=$val.sid%}
                        {%/if%}
                    {%/foreach%}

                    {%foreach $category as $val%}
                        {%if !empty($val.display)%}
                        <li><a href="{%$val.abs_url%}" dace-node="nav_channelClick" {%if isset($category_id) && $category_id == $val.sid && $current_page!="center"%}class="active"{%/if%}>{%$val.sname%}</a></li>
                        {%/if%}
                    {%/foreach%}
                </ul>
            {%/if%}
		</div>
		<div class="right">
			{%if !empty($user)%}
			<div class="login">
				<span class="app"><i class="icon icon-phone"></i><a {%if $smarty.server.HTTP_USER_AGENT|ismobile%}href="http://mobile.hupu.com/?_r=shareRoom"{%else%}href="http://voice.hupu.com/other/2006264.html"{%/if%} target="_blank" dace-node="nav_appDownloadClick">手机客户端</a></span>
				<span class="myfollow">
					{%if !empty($open_soon.new)%}
					    <span class="num"></span>
					{%/if%}
					<a class="link-myfollow" href="/user/follow-list"><i class="icon icon-love"></i>我的关注</a>
					<div class="myfollow-list">
						{%if !empty($open_soon.list)%}
                            <dl class="inner">
                                {%if sizeof($open_soon.list)!=1%}
                                    <dt>你关注的主播有<span>{%sizeof($open_soon.list)%}</span>个已开播</dt>
                                {%else%}
                                    <dt><span>{%$open_soon.list[0].anchor_nickname%}</span>&nbsp;已开播</dt>
                                {%/if%}
                                {%foreach $open_soon.list as $val%}
                                    <dd>
                                        <a href="{%$val.abs_url%}" title="{%$val.room_name%}" dace-node="nav_myfollowRoomClick">
                                            <div class="cover">
                                                <img src="{%$val.cover%}" width="78" height="45" alt="">
                                            </div>
                                            <div class="text">
                                                <h3 class="room-name mod-overflow">{%$val.room_name%}</h3>
                                                <div class="info">
                                                    <div class="user fl">
                                                        主播：<span>{%$val.anchor_nickname%}</span>
                                                    </div>
                                                    {%if !empty($show_online)%}
                                                    <div class="audience fr">
                                                        <i class="icon-audience"></i>
                                                        <span>{%$val.online%}</span>
                                                    </div>
                                                    {%/if%}
                                                </div>
                                            </div>
                                        </a>
                                    </dd>
                                {%/foreach%}
                            </dl>
                            <div class="bottom-inner">
                                <a href="/user/follow-list" class="button-all-follow">全部关注</a>
                            </div>
						{%else%}
						    <p class="no-live">暂无关注主播开播。</p>
						{%/if%}
					</div>
				</span>
				<span class="user">
                    <a href="/user/follow-list" class="mod-overflow">
                        <span class="head"><img src="{%$user.avatar.header_small%}" alt=""></span>
                        <span class="name">{%$user.username%}</span>
                    </a>
					<ul class="user-list">
            <li><a href="/user/wallet" dace-node="nav_myfollowClick">我的钱包</a></li>
						<li><a href="/predict/user/info">人品值</a></li>
						<li><a href="http://voice.hupu.com/other/1997628.html" target="_blank" dace-node="nav_roomApply">申请成为主播</a></li>
						<li><a href="http://b.qq.com/webc.htm?new=0&sid=800021359&o=hupu.tv&q=7" target="_blank" dace-node="nav_customService">客服支持</a></li>
						<li class="last-item"><a href="{%$logout_url%}">退出登录</a></li>
					</ul>
				</span>
			</div>
			{%else%}
                <div class="unlogin">
                    <span class="app"><i class="icon icon-phone"></i><a {%if $smarty.server.HTTP_USER_AGENT|ismobile%}href="http://mobile.hupu.com/?_r=shareRoom"{%else%}href="http://voice.hupu.com/other/2006264.html"{%/if%} target="_blank" dace-node="nav_appDownloadClick">手机客户端</a></span>
                    <span class="logreg">
                        <i class="icon icon-user"></i>
                        <a href="{%$login_url%}" id="J_loginUrl">登录</a>
                        <i class="line">|</i>
                        <a href="{%$register_url%}" id="J_registerUrl">注册</a></span>
                </div>
			{%/if%}
		</div>
	</div>
</div>
{%script%}
	var header = require("common:widget/header/header.js");
    header.init();
{%/script%}
