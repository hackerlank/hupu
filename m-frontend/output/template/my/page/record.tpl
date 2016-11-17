{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="my:static/record/record.scss"%}
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
<span class="info">Zheng</span>
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
<span class="info">82747476</span>
</li>
<li>
<span class="lable-title">性别</span>
<span class="info">女</span>
</li>
<li>
<span class="lable-title">生日</span>
<span class="info">1986-02-04</span>
</li>
<li>
<span class="lable-title">出生地</span>
<span class="info">上海</span>
</li>
<li>
<span class="lable-title">论坛等级</span>
<span class="info">4级</span>
</li>
<li>
<span class="lable-title">所属社团</span>
<span class="info">hooper</span>
</li>
<li>
<span class="lable-title">银行现金</span>
<span class="info">524卡路里</span>
</li>
<li>
<span class="lable-title">在线时长</span>
<span class="info">119小时</span>
</li>
<li>
<span class="lable-title">注册时间</span>
<span class="info">2015-09-04</span>
</li>
<li>
<span class="lable-title">最后登录时间</span>
<span class="info">2015-09-04</span>
</li>
<li>
<span class="lable-title">自我介绍</span>
<span class="info">克利夫兰骑士与洛杉矶快船的下一个相遇将在哪里？</span>
</li>
</ul>
</div>
</div>
<div class="record-col personal-interests m-card-split-line">
<div class="title">
个人兴趣</div>
<div class="bd">
<ul class="record-list">
<li>
<span class="lable-title">喜欢的运动</span>
<span class="info">篮球  足球</span>
</li>
<li>
<span class="lable-title">喜欢的联赛</span>
<span class="info">英超</span>
</li>
<li>
<span class="lable-title">喜欢的队伍</span>
<span class="info">
<a href="#">湖人</a>
<a href="#">拜仁</a>
<a href="#">巴萨</a>
</span>
</li>
</ul>
</div>
</div>
<div class="record-col personal-home-team m-card-split-line">
<div class="title">
个人主队</div>
<div class="bd">
<ul class="record-list">
<li>
<span class="lable-title">NBA主队</span>
<span class="info">
<a href="#">凯尔特人</a>
</span>
</li>
<li>
<span class="lable-title">西甲主队</span>
<span class="info">
<a href="#">巴萨</a>
</span>
</li>
<li>
<span class="lable-title">德甲主队</span>
<span class="info">
<a href="#">拜仁</a>
</span>
</li>
</ul>
</div>
</div>
</div>
{%require name='my:page/record.tpl'%}{%/block%}