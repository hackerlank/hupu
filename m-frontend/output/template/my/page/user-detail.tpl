{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="my:static/user-detail/user-detail.scss"%}
{%/block%}
{%block name="content"%}
{%widget
    name="common:widget/top-title/top-title.tpl"
    banner="{%if $isself %}我{%else%}{%$userinfos.username|f_escape_xml%}{%/if%}的档案"
%}
<div class="record-wrap">
<div class="record-col name-col m-card-split-line">
<ul class="record-list">
<li>
<span class="lable-title">昵称</span>
<span class="info">{%$userinfos["username"]|f_escape_xml%}</span>
</li>
</ul>
</div>
<div class="record-col basic-info m-card-split-line">
<div class="title">
基本信息</div>
<div class="bd">
<ul class="record-list">
<li>
<span class="lable-title">数字ID</span>
<span class="info">{%$userinfos["uid"]|f_escape_xml%}</span>
</li>
<li>
<span class="lable-title">性别</span>
<span class="info">{%$moreuserinfos["sex"]|f_escape_xml%}</span>
</li>
<li>
<span class="lable-title">生日</span>
<span class="info">{%$moreuserinfos["birthday"]|f_escape_xml%}</span>
</li>
<li>
<span class="lable-title">论坛等级</span>
<span class="info">{%$userinfos["level"]|f_escape_xml%}级</span>
</li>
<li>
<span class="lable-title">银行现金</span>
<span class="info">{%$userinfos["bank"]["money"]|f_escape_xml%}卡路里</span>
</li>
<li>
<span class="lable-title">在线时长</span>
<span class="info">{%$moreuserinfos["onlinetime"]|f_escape_xml%}小时</span>
</li>
<li>
<span class="lable-title">注册时间</span>
<span class="info">{%$moreuserinfos["regdate"]|f_escape_xml%}</span>
</li>
<li>
<span class="lable-title">最后登录时间</span>
<span class="info">{%$moreuserinfos["lastvisit"]|f_escape_xml%}</span>
</li>
<li>
<span class="lable-title">自我介绍</span>
<span class="info">{%$moreuserinfos["aboutme"|escape:none]%}</span>
</li>
</ul>
</div>
</div>
{%if !empty($moreuserinfos.lovesports) || !empty($moreuserinfos.loveleague) || !empty($moreuserinfos.loveteam)%}
<div class="record-col personal-interests m-card-split-line">
<div class="title">
个人兴趣</div>
<div class="bd">
<ul class="record-list">
{%if !empty($moreuserinfos.lovesports)%}
<li>
<span class="lable-title">喜欢的运动</span>
<span class="info">
{%foreach from=$moreuserinfos.lovesports item=val name=key%}
{%$val|f_escape_xml%}
{%/foreach%}
</span>
</li>
{%/if%}
{%if !empty($moreuserinfos.loveleague)%}
<li>
<span class="lable-title">喜欢的联赛</span>
<span class="info">
{%foreach from=$moreuserinfos.loveleague item=val name=key%}
{%$val|f_escape_xml%}
{%/foreach%}
</span>
</li>
{%/if%}
{%if !empty($moreuserinfos.loveteam)%}
<li>
<span class="lable-title">喜欢的队伍</span>
<span class="info">
{%foreach from=$moreuserinfos.loveteam item=val name=key%}
{%$val|f_escape_xml%}
{%/foreach%}
</span>
</li>
{%/if%}
</ul>
</div>
</div>
{%/if%}
{%if $moreuserinfos.hometeam%}
<div class="record-col personal-home-team m-card-split-line">
<div class="title">
个人主队</div>
<div class="bd">
<ul class="record-list">
{%foreach from=$moreuserinfos.hometeam item=val name=key%}
<li>
<span class="lable-title">{%$val.sportCN|f_escape_xml%}主队</span>
<span class="info">
{%if !empty($val.url)%}
<a href="{%$val.url|f_escape_xml%}">{%$val.name|f_escape_xml%}</a>
{%else%}
{%$val.name|f_escape_xml%}
{%/if%}
</span>
</li>
{%/foreach%}
</ul>
</div>
</div>
{%/if%}
</div>
{%require name='my:page/user-detail.tpl'%}{%/block%}