{%extends file="app/page/layout.tpl"%} 
{%block name="title"%}我的人品值{%/block%}
{%block name="head_static"%}
{%require name="app:static/my_rpz/my_rpz.scss"%}
{%script%}
        window.GM = $.extend(window.GM, {
          "rpz_max": parseInt("{%$userTopicList.max|f_escape_js%}"),
          "rpz_min": parseInt("{%$userTopicList.min|f_escape_js%}"),
          "rpz_rank": parseInt("{%$userPredictionInfo.month_rank|f_escape_js%}")
        });

        var my_rpz = require("app:widget/my_rpz/my_rpz");
        my_rpz.init();

        initBridge(function(){
           HupuBridge.send("hupu.ui.header", {
                title: "我的人品值",
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
<section class="rpz-explain" id="J-rpz-explain">
<i class="icon icon-close" id="J-close"></i>
<ul>
<li>
<h2><i class="dot"></i>什么是人品值？</h2>
<p>
亮了网全新上线“人品值”系统，通过为正在直播的参赛阵营攒人品，你也有机会分享胜利获得人品值奖励。JRs在直播间热线发言时会同步展示人品等级，在个人中心里可以查看亮了网的“人品值”排行。每个直播赛季为一个月，赛季末会对“人品值”进行清零，并对当<span class="red">月排行榜前200</span>的用户发放<span class="red">实物奖品</span>。</p>
</li>
<li>
<h2><i class="dot"></i>如何获取人品值？</h2>
<p>
你只需在直播间参与“攒人品”互动，为选中的阵营攒人品，系统会根据你选中的阵营在比赛中的胜负为你增加或扣除“人品值”积分。</p><br>
<p class="red">
人品值增加＝系统分数＊当前爆棚状态</p>
<p>
人品值扣除＝系统分数</p><br>
<p>
系统分数有<span class="red">20、40、60</span>三种。</p>
</li>
<li>
<h2><i class="dot"></i>如何获取人品值？</h2>
<p>
在“攒人品”互动中连续多场命中，将获得额外的爆棚状态。如果选中的阵营在比赛中为负，则爆棚状态还原为1。最高爆棚状态为1.9；且<span class="red">爆棚状态不会被清零</span>。</p><br>
<table>
<tr>
<td>当前连续命中场数</td>
<td>0</td>
<td>1</td>
<td>2</td>
<td>3</td>
<td>4</td>
<td>5</td>
<td>6</td>
<td>7</td>
<td>8</td>
<td>9</td>
<td>10</td>
<td>...</td>
<td>100</td>
</tr>
<tr>
<td>爆棚状态（赢率）</td>
<td>1</td>
<td>1</td>
<td>1.1</td>
<td>1.2</td>
<td>1.3</td>
<td>1.4</td>
<td>1.5</td>
<td>1.6</td>
<td>1.7</td>
<td>1.8</td>
<td>1.9</td>
<td>1.9</td>
<td>1.9</td>
</tr>
</table><br>
<p>
做一个人品爆棚的JRs，为支持的选手攒人品，与同阵营的观众一起哈啤一起分享胜利感！</p>
</li>
</ul>
</section>
<section class="my-rpz-wrap">
<section class="info">
<header class="info-header">
<div class="all-rpz">我的人品值：{%$userPredictionInfo.score|default:0|f_escape_xml%}</div>
<span class="intro" id="J-open">
<i></i>人品值介绍</span>
</header>
<section class="info-main">
<div class="summary">
参与人品赛{%$userPredictionInfo.frequency|default:0|f_escape_xml%}场，命中{%$userTopicStatus.win|f_escape_xml%}场，命中率：{%$userTopicStatus.rate|default:0|f_escape_xml%}%<br>
连续命中{%$userPredictionInfo.win|default:0|f_escape_xml%}场，赢率{%$userPredictionInfo.magnification|default:0|f_escape_xml%}
</div>
{%if !empty($userTopicList)%}
<div class="chart" id="J-chart">
<div class="line"></div>
<div class="line"></div>
<div class="line"></div>
<div class="line"></div>
<div class="line"></div>
<div class="data" id="J-data">
{%foreach from=$userTopicList.chart_data item=val%}
<span style="height:{%math equation = abs($val)%}px;" class="{%if $val<0%}negative{%/if%}{%if $val == $userTopicList.max%}active{%/if%}"></span>
{%/foreach%}
</div>
</div>
<div class="time" id="J-time"></div>
{%else%}
<div class="no-chart">暂无人品值成长记录</div>
{%/if%}
</section>
</section>
<section class="rank-link">
<a href="/m/predict/ranking?n={%$in_kanqiu|f_escape_path%}&client={%$client|f_escape_path%}">人品值排行榜 ></a>
</section>
{%if !empty($userTopicList)%}
<section class="detail-list">
<ul id="J-detail-list">
<li>
<dl>
<dt>{%$userTopicList.timeFormat.date|f_escape_xml%}&nbsp;&nbsp;{%$userTopicList.timeFormat.cn|f_escape_xml%}<span class="cor">人品值</span>
{%if $userTopicList.days_score[$userTopicList.day] >= 0%}
<span class="score score-plus">+{%$userTopicList.days_score[$userTopicList.day]|f_escape_xml%}</span></dt>
{%else%}
<span class="score score-minus">{%$userTopicList.days_score[$userTopicList.day]|f_escape_xml%}</span></dt>
{%/if%}
</dl>
{%foreach $userTopicList.data as $val%}
<dd>
<div class="left">
<div class="home {%if $val.topicInfo.right_option == 1%}home-win{%/if%}">
<span class="team">{%$val.topicInfo.option1|f_escape_xml%}</span>&nbsp;&nbsp;{%if $val.topicInfo.right_option == 1%}<span class="win">胜</span>{%/if%}&nbsp;&nbsp;{%if $val.option == 1%}<span class="checked">已选</span>{%/if%}
</div>
<div class="away {%if $val.topicInfo.right_option == 2%}away-win{%/if%}">
<span class="team">{%$val.topicInfo.option2|f_escape_xml%}</span>&nbsp;&nbsp;{%if $val.topicInfo.right_option == 2%}<span class="win">胜</span>{%/if%}&nbsp;&nbsp;{%if $val.option == 2%}<span class="checked">已选</span>{%/if%}
</div>
</div>
<div class="right">
{%if $val.topicInfo.status == 0%}
<span class="status-inprogress">进行中</span>
{%else if $val.topicInfo.status == 1%}
<span class="status-wait">待开奖</span>
{%else if $val.topicInfo.status == 2%}
{%if $val.win_score >= 0%}
<span class="score score-plus">+{%$val.win_score|f_escape_xml%}</span>
{%else%}
<span class="score score-minus">{%$val.win_score|f_escape_xml%}</span>
{%/if%}
{%else if $val.topicInfo.status == 3%}
<span class="status-flow">流盘</span>
{%/if%}
</div>
</dd>
{%/foreach%}
</li>
<script id="J-rpz-tpl" type="text/template">
                <li>
                    <dl>
                        <dt>
                            <@=result.timeFormat.date@>&nbsp;&nbsp;<@=result.timeFormat.cn@><span class="cor">人品值</span>
                            <@if(result.days_score[result.day] >= 0){@>
                                <span class="score score-plus">+<@=result.days_score[result.day]@></span></dt>
                            <@}else{@>
                                <span class="score score-minus"><@=result.days_score[result.day]@></span></dt>
                            <@}@>
                        </dt>
                    </dl>
                    <@ $(datas).each(function(index,item) { @>
                    <dd>
                        <div class="left">
                            <div class="home <@if(item.topicInfo.right_option == 1){@>home-win<@}@>">
                                <span class="team"><@=item.topicInfo.option1@></span>&nbsp;&nbsp;
                                <@if(item.topicInfo.right_option == 1){@><span class="win">胜</span><@}@>&nbsp;&nbsp;
                                <@if(item.option == 1){@><span class="checked">已选</span><@}@>
                            </div>
                            <div class="away <@if(item.topicInfo.right_option == 2){@>away-win<@}@>">
                                <span class="team"><@=item.topicInfo.option2@></span>&nbsp;&nbsp;
                                <@if(item.topicInfo.right_option == 2){@><span class="win">胜</span><@}@>&nbsp;&nbsp;
                                <@if(item.option == 2){@><span class="checked">已选</span><@}@>
                            </div>
                        </div>
                        <div class="right">
                            <@if(item.topicInfo.status == 0){@>
                            <span class="status-inprogress">进行中</span>
                            <@}else if(item.topicInfo.status == 1){@>
                            <span class="status-wait">待开奖</span>
                            <@}else if(item.topicInfo.status == 2){@>
                                <@if(item.win_score >= 0){@>
                                <span class="score score-plus">+<@=item.win_score@></span>
                                <@}else{@>
                                <span class="score score-minus"><@=item.win_score@></span>
                                <@}@>
                            <@}else if(item.topicInfo.status == 3){@>
                            <span class="status-flow">流盘</span>
                            <@}@>
                        </div>
                    </dd>
                    <@ }); @>
                </li>
                </script>
</ul>
<div class="more">
{%if !empty($userTopicList.next)%}
<a href="javascript:;" id="J-more-btn" data-more="{%$userTopicList.next|f_escape_xml%}">加载更多</a>
{%else%}
<a href="javascript:;" id="J-more-btn" data-more="">暂无更多数据~</a>
{%/if%}
</div>
</section>
</section>
{%/if%}
{%require name='app:page/my_rpz.tpl'%}{%/block%}
