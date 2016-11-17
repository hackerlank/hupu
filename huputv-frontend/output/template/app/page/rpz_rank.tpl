{%extends file="app/page/layout.tpl"%} 
{%block name="title"%}人品值排行榜{%/block%}
{%block name="head_static"%}
{%require name="app:static/rpz_rank/rpz_rank.scss"%}
{%script%}
        window.GM = $.extend(window.GM, {
          "today_next": !!parseInt("{%$today_rank_list_next|f_escape_js%}", 10),
          "month_next": !!parseInt("{%$month_rank_list_next|f_escape_js%}", 10),
          "username": "{%$userInfo.username|f_escape_js%}",
          "night": !!parseInt("{%$night|f_escape_js%}", 10)
        });

        var rpz_rank = require("app:widget/rpz_rank/rpz_rank");
        rpz_rank.init();

        initBridge(function(){
           HupuBridge.send("hupu.ui.header", {
                title: "人品值排行榜",
                subtitle: ""
           }, function(){
           });
        });

        function initBridge(callback) {
            if(window.HupuBridge){
                callback();
            }else{
                document.addEventListener("hupuBridgeReady", function(){
                    callback();
                });
            }
        }
    {%/script%}
{%/block%}
{%block name="content"%}
<section class="rpz-rule" id="J-rpz-rule">
<i class="icon icon-close" id="J-close"></i>
<ul>
<li>
<i class="dot"></i>
<p>
所有榜单数据每小时更新一次。</p>
</li>
<li>
<i class="dot"></i>
<p>
只有为球队贡献过人品值的用户才会出现在榜单中。</p>
</li>
<li>
<i class="dot"></i>
<p>
日榜：按照日新增人品值数值大小进行排序；数值相同的情况，则人品值高的用户、参与人品赛场次高的用户排在前面。</p>
</li>
<li>
<i class="dot"></i>
<p>
月榜：按照人品值数值大小进行排序；数值相同的情况，则日新增人品值高的用户、参与人品赛场次多的用户排在前面。</p>
</li>
<li>
<i class="dot"></i>
<p>
截止到每个月1日 0点，产生的月榜前200名用户，将获得亮了网提供的专属礼物。上榜用户届时请主动联系我们。<span class="red">礼物领取截止日期为：每个月7日18点。</span>
</p>
</li>
</ul>
<div class="contact">
联系方式：<br>
QQ公众号：800021359；微信号：hupukanqiu</div>
</section>
<header class="layout-header" id="J-layout-header">
<div class="tab" id="J-tab">
<a href="javascript:;" data-type="1" class="active">日榜({%$smarty.now|date_format:"%m/%d"%})</a>
<a href="javascript:;" data-type="2">月榜({%$smarty.now|date_format:"%m"%}月)</a>
</div>
<div class="explain">
<span id="J-open"><i></i>排行榜说明</span>
</div>
</header>
<section class="layout-main" id="J-layout-main">
{%**
        *
        *   change  名次变化 0:持平，1:上升,2:下降,3:新增
        *
        **%}
<div class="t-content day-rank" id="today_rank_list">
{%if !empty($today_rank_list)%}
<table>
<tbody>
{%foreach $today_rank_list as $val%}
<tr>
<td class="rank" align="center">{%$val.rank|f_escape_xml%}</td>
<td class="state
                    {%if $val.change == 0%}
                    state-stable
                    {%else if $val.change == 1%}
                    state-up
                    {%else if $val.change == 2%}
                    state-down
                    {%else if $val.change == 3%}
                    state-new
                    {%/if%}
                    " align="center">
{%if $val.change == 0%}
-{%else if $val.change == 1 || $val.change == 2%}
<i></i>
{%else if $val.change == 3%}
new{%/if%}
</td>
<td class="head">
<div class="inner">
<img src="{%$val.header|f_escape_xml%}" alt="" />
{%if !empty($night)%}<span class="mask"></span>{%/if%}
</div>
</td>
<td class="name {%if $val.username == $userInfo.username%}mine{%/if%}">{%$val.username|f_escape_xml%}</td>
<td class="score-wrap" align="right">
<span class="score {%if $val.win_score >= 0%}score-plus{%else%}score-minus{%/if%}">{%if $val.win_score >= 0%}+{%/if%}{%$val.win_score|f_escape_xml%}</span>
<span class="all {%if $val.score >= 0%}all-positive{%else%}all-negative{%/if%}">{%$val.score|f_escape_xml%}</span>
</td>
</tr>
{%/foreach%}
</tbody>
</table>
{%else%}
<div class="no-data">
今日暂无数据</div>
{%/if%}
<div class="loading">加载中...</div>
</div>
<div class="t-content month-rank" id="month_rank_list" style="display:none;">
{%if !empty($month_rank_list)%}
<table>
<tbody>
{%foreach $month_rank_list as $val%}
<tr>
<td class="rank" align="center">{%$val.rank|f_escape_xml%}</td>
<td class="state
                    {%if $val.change == 0%}
                    state-stable
                    {%else if $val.change == 1%}
                    state-up
                    {%else if $val.change == 2%}
                    state-down
                    {%else if $val.change == 3%}
                    state-new
                    {%/if%}
                    " align="center">
{%if $val.change == 0%}
-{%else if $val.change == 1 || $val.change == 2%}
<i></i>
{%else if $val.change == 3%}
new{%/if%}
</td>
<td class="head">
<div class="inner">
<img src="{%$val.header|f_escape_xml%}" alt="" />
{%if !empty($night)%}<span class="mask"></span>{%/if%}
</div>
</td>
<td class="name {%if $val.username == $userInfo.username%}mine{%/if%}">{%$val.username|f_escape_xml%}</td>
<td class="score-wrap" align="right">
<span class="all {%if $val.score >= 0%}all-positive{%else%}all-negative{%/if%}">{%$val.score|f_escape_xml%}</span>
</td>
</tr>
{%/foreach%}
</tbody>
</table>
{%else%}
<div class="no-data">
当月暂无数据</div>
{%/if%}
<div class="loading">加载中...</div>
</div>
{%* 前端模板 *%}
<script id="J-rank-tpl" type="text/template">
            <@ $(datas).each(function(index,item) { @>
            <tr>
                <td class="rank" align="center"><@=item.rank@></td>
                <td class="state
                <@if(item.change == 0){@>
                state-stable
                <@}else if(item.change == 1){@>
                state-up
                <@}else if(item.change == 2){@>
                state-down
                <@}else if(item.change == 3){@>
                state-new
                <@}@>
                " align="center">
                    <@if(item.change == 0){@>
                    -
                    <@}else if(item.change == 1 || item.change == 2){@>
                    <i></i>
                    <@}else if(item.change == 3){@>
                    new
                    <@}@>
                </td>
                <td class="head">
                    <div class="inner">
                        <img src="<@=item.header@>" alt="" />
                        <@if(GM.night){@><span class="mask"></span><@}@>
                    </div>
                </td>
                <td class="name <@if(item.username == GM.username){@>mine<@}@>"><@=item.username@></td>
                <td class="score-wrap" align="right">
                    <@if(type == 1){@>
                    <span class="score <@if(item.win_score >= 0){@>score-plus<@}else{@>score-minus<@}@>"><@if (item.win_score >= 0){@>+<@}@><@=item.win_score@></span>
                    <@}@>
                    <span class="all <@if(item.score >= 0){@>all-positive<@}else{@>all-negative<@}@>"><@=item.score@></span>
                </td>
            </tr>
            <@ }); @>
        </script>
</section>
{%require name='app:page/rpz_rank.tpl'%}{%/block%}
