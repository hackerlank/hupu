{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="my:static/home/home.scss"%}
{%require name="my:static/home/home.js"%}
{%/block%}
{%block name="content"%}
{%widget
    name="common:widget/top-title/top-title.tpl"
    banner="{%if $isself %}我{%else%}{%$userinfos.username|f_escape_xml%}{%/if%}的主页"
%}
<div class="personal-info">
<a href="{%$detailUrl|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_7001">
<div class="personal-list">
<div class="avatar" style="background-image: url({%$userinfos.header|f_escape_xml%});"></div>
<div class="user-col">
<div class="name">
{%$userinfos.username|f_escape_xml%}
</div>
<div class="level">论坛等级&nbsp;{%$userinfos.level|f_escape_xml%}级</div>
<div class="calories">卡路里&nbsp;{%$userinfos.bank.money|f_escape_xml%}</div>
</div>
</div>
</a>
</div>
{%if $isself %}
{%if $collectedForums|@count > 0 %}
<div class="m-card my-board m-card-split-line">
<div class="card-head">
<span class="card-title">我的版块</span>
</div>
<div id="J_boardItem" class="board-item">
<div class="board-list-wrap">
{%foreach from=$collectedForums item=val name=key%}
{%if !empty($val['name'])%}
<a href="{%$val['forumindex']|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_5052"><span>{%$val['name']|escape:none%}</span></a>
{%/if%}
{%/foreach%}
</div>
<a href="javascript:" class="button-unfold J_buttonUnfold"></a>
</div>
</div>
{%/if%}
<div class="m-card my-notif m-card-split-line">
<div class="card-head">
<span class="card-title" dace-node="{%$id4dace|f_escape_xml%}_msm_close">我的半场消息</span>
{%if $notifications.notificationsinfo|@count > 0%}
<span class="ignore-all" id="J_buttonIgnoreAll">新增{%$notifications.remind|f_escape_xml%}条</span>
{%/if%}
</div>
<div>
{%if $notifications.notificationsinfo|@count > 0%}
<ul id="J_notificationList">
{%foreach from=$notifications.notificationsinfo item=val name=key%}
<li class="no-view J_messageLi" data-mid="{%$val.id|f_escape_xml%}">
{%$val.title|escape:none%}
<i class="close J_buttonMessageClose"></i>
</li>
{%/foreach%}
</ul>
{%else%}
<div id="J_messageEmptyTip" style="display: block;" class="not-ignore">您暂时没有新的消息</div>
{%/if%}
<a href="/my/notifications" id="J_buttonIgnoreAll" class="button-view-all" dace-node="{%$id4dace|f_escape_xml%}_7002">查看全部消息</a>
</div>
</div>
<ul class="fn-list">
<li class="m-card-split-line">
<a href="{%$predictdata.url|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_" class="predict-link">
<span class="text-inner">我的预测</span>
<div class="predict-result">共参与{%$predictdata.times|f_escape_xml%}场，命中{%$predictdata.correct|f_escape_xml%}场</div>
</a>
</li>
<li>
<a href="{%$collectedthreadsUrl|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_7003">
<span class="text-inner">我的收藏</span>
</a>
</li>
<li>
<a href="{%$threadsUrl|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_7004">
<span class="text-inner">我的主题帖</span>
</a>
</li>
<li class="m-card-split-line">
<a href="{%$repliesUrl|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_7005">
<span class="text-inner">我的回帖</span>
</a>
</li>
<li>
<a href="https://passport.hupu.com/ucenter/mindex" dace-node="{%$id4dace|f_escape_xml%}_8800">
<span class="text-inner">帐号安全</span>
</a>
</li>
<li>
<a href="/my/usersetting" dace-node="{%$id4dace|f_escape_xml%}_7010">
<span class="text-inner">设置</span>
</a>
</li>
</ul>
{%else%}
<div class="m-card latest-activity m-card-split-line">
<div class="card-head">
<span class="card-title">最近动态</span>
</div>
{%widget
            name = "my:widget/personal-news-list/list.tpl"
            data = $userdynamic
        %}
{%if empty($userdynamic.error)%}
{%if $userdynamic.data|@count >= 10%}
{%if !empty($username) %}
<a href="{%$dynamicUrl|f_escape_xml%}" class="button-view-all" dace-node="{%$id4dace|f_escape_xml%}_7101">查看更多动态</a>
{%else%}
<a href="{%$loginurl|f_escape_xml%}" class="button-login">登录后可查看 TA 的更多动态</a>
{%/if%}
{%/if%}
{%/if%}
</div>
<ul class="fn-list">
<li class="m-card-split-line">
<a href="{%$predictdata.url|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_" class="predict-link">
<span class="text-inner">Ta的预测</span>
<div class="predict-result">共参与{%$predictdata.times|f_escape_xml%}场，命中{%$predictdata.correct|f_escape_xml%}场</div>
</a>
</li>
</ul>
{%/if%}
{%require name='my:page/home.tpl'%}{%/block%}