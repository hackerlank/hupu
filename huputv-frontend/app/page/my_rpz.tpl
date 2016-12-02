{%extends file="app/page/layout.tpl"%}

{%block name="title"%}我的人品值{%/block%}

{%block name="head_static"%}
    {%require name="app:static/my_rpz/my_rpz.scss"%}

    {%script%}
        window.GM = $.extend(window.GM, {
          "rpz_max": parseInt("{%$userTopicList.max%}"),
          "rpz_min": parseInt("{%$userTopicList.min%}"),
          "rpz_rank": parseInt("{%$userPredictionInfo.month_rank%}")
        });

        var my_rpz = require("app:widget/my_rpz/my_rpz.js");
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
<div class="rpz-main" id="J-rpz-main">   
        <section class="rpz-explain" id="J-rpz-explain">
            <i class="icon icon-close" id="J-close"></i>
            <ul>
                <li>
                    <h2><i class="dot"></i>什么是人品值？</h2>
                    <p>
                        亮了网全新上线“人品值”系统，通过为正在直播的参赛阵营攒人品，你也有机会分享胜利获得人品值奖励。JRs在直播间热线发言时会同步展示人品等级，在个人中心里可以查看亮了网的“人品值”排行。每个直播赛季为一个月，赛季末会对“人品值”进行清零，并对当<span class="red">月排行榜前200</span>的用户发放<span class="red">实物奖品</span>。
                    </p>
                </li>
                <li>
                    <h2><i class="dot"></i>如何获取人品值？</h2>
                    <p>
                        你只需在直播间参与“攒人品”互动，为选中的阵营攒人品，系统会根据你选中的阵营在比赛中的胜负为你增加或扣除“人品值”积分。
                    </p><br>
                    <p class="red">
                        人品值增加＝系统分数＊当前爆棚状态
                    </p>
                    <p>
                        人品值扣除＝系统分数
                    </p><br>
                    <p>
                        系统分数有<span class="red">20、40、60</span>三种。
                    </p>
                </li>
                <li>
                    <h2><i class="dot"></i>如何获取人品值？</h2>
                    <p>
                        在“攒人品”互动中连续多场命中，将获得额外的爆棚状态。如果选中的阵营在比赛中为负，则爆棚状态还原为1。最高爆棚状态为1.9；且<span class="red">爆棚状态不会被清零</span>。
                    </p><br>
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
                        做一个人品爆棚的JRs，为支持的选手攒人品，与同阵营的观众一起哈啤一起分享胜利感！
                    </p>
                </li>
            </ul>
        </section>
        <section class="my-rpz-wrap" id="J-rpz-wrap">
            <section class="info">
                <header class="info-header">
                    <div class="all-rpz">我的人品值：{%$userPredictionInfo.score|default:0%}</div>
                    <span class="intro" id="J-open">
                        <i></i>人品值介绍
                    </span>
                </header>
                <section class="info-main">
                    <div class="summary">
                        参与人品赛 {%$userPredictionInfo.frequency|default:0%}场，命中{%$userTopicStatus.win%}场，命中率：{%$userTopicStatus.rate|default:0%}%
                        <br>
                        连续命中{%$userPredictionInfo.win|default:0%}场，赢率{%$userPredictionInfo.magnification|default:0%}
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
                <a href="/m/predict/ranking?n={%$in_kanqiu%}&client={%$client%}">人品值排行榜 ></a>
            </section>
           {%if !empty($userTopicList)%}
            <section class="rpz-predict">            
                <ul class="pre-list" id="J-detail-list" data-more="{%$userTopicList.next%}">
                    <li class="pre-list-head">
                        <div class="rpz-preTitle">
                            <span>{%$userTopicList.timeFormat.date%} &nbsp;{%$userTopicList.timeFormat.cn%}</span><span class="status">人品值 
                            {%if $userTopicList.days_score[$userTopicList.day]  >= 0 %}
                                <i class="pre-num pre-add">&nbsp;+{%$userTopicList.days_score[$userTopicList.day]  %}</i>
                            {%else%}
                                <i class="pre-num pre-reduce">{%$userTopicList.days_score[$userTopicList.day]  %}</i>    
                            {%/if%}
                             </span>
                        </div>
                    </li>
                    {%foreach $userTopicList.data as $val%}
                        <li class="pre-item">
                            <div class="pre-item-left">
                                <div class="pre-item-title">{%$val.topicInfo.title%}</div>
                                <div class="pre-item-option">
                                    <ul class="option-wrap">
                                    {%foreach $val.topicInfo.option as $item%}
                                        <li class="option-item 
                                        {%if $val.option == $item.option_id && $item.option_id != $val.topicInfo.right_option%}
                                            status-checked
                                        {%else if $val.option != $item.option_id && $item.option_id == $val.topicInfo.right_option%}
                                            status-correct
                                        {%else if $val.option == $item.option_id && $item.option_id == $val.topicInfo.right_option%}
                                            status-correct-checked
                                        {%else%}
                                            status-default
                                        {%/if%}
                                        ">{%$item.option%}</li>
                                    {%/foreach%}
                                    </ul>
                                </div>
                            </div>
                            <div class="pre-item-right">
                               {%if intval($val.status) == 0%}
                                    <span class="voting">进行中</span>
                                {%else if intval($val.status) == 1%}
                                    <span class="ready">待开奖</span>
                                {%else if intval($val.status) ==2%} 
                                    <span class="{%if $val.option==$val.topicInfo.right_option%}
                                     win
                                     {%else%}
                                     lose
                                     {%/if%}">
                                     {%if $val.option==$val.topicInfo.right_option%}
                                        +{%$val.win_score%}
                                     {%else%}
                                        {%$val.win_score%}
                                     {%/if%}</span>
                                     {%else if intval($val.status) ==3%}
                                    <span class="disappear">已流盘</span>
                                {%/if%}                             
                            </div>
                        </li>
                    {%/foreach%}
                </ul>                        
            </section>
           {%/if%}
            <script id="J-rpz-tpl" type="text/template">
                    <li class="pre-list-head">
                        <div class="rpz-preTitle">
                            <span><@=datas.timeFormat.date@> &nbsp;<@=datas.timeFormat.cn@></span><span class="status">人品值 
                            <@if (datas.days_score[datas.day]  >= 0) {@>
                                <i class="pre-num pre-add">&nbsp;+<@=datas.days_score[datas.day]  @></i>
                            <@}else{@>
                                <i class="pre-num pre-reduce"><@=datas.days_score[datas.day]  @></i>    
                            <@}@>
                             </span>
                        </div>
                    </li>
                <@ _.each(datas.data, function(val,index) { @>
                    <li class="pre-item">
                        <div class="pre-item-left">
                            <div class="pre-item-title"><@=val.topicInfo.title@></div>
                            <div class="pre-item-option">
                                <ul class="option-wrap">
                                <@ _.each(val.topicInfo.option, function(item,index) {@>
                                    <li class="option-item
                                    <@if (parseInt(val.option) == item.option_id && item.option_id != parseInt(val.topicInfo.right_option)){@>
                                        status-checked
                                    <@}else if (parseInt(val.option) != item.option_id && item.option_id == parseInt(val.topicInfo.right_option)){@>
                                        status-correct
                                    <@}else if (parseInt(val.option) == item.option_id && item.option_id == parseInt(val.topicInfo.right_option)){@>
                                        status-correct-checked
                                    <@}else{@>
                                        status-default
                                    <@}@>
                                    "><@=item.option@></li>
                                <@})@>
                                </ul>
                            </div>
                        </div>
                        <div class="pre-item-right">
                            <@if (parseInt(val.status) == 0) {@>
                                <span class="voting">进行中</span>
                            <@} else if (parseInt(val.status) == 1){@>
                                <span class="ready">待开奖</span>
                            <@} else if (parseInt(val.status) == 2){@>                                              
                                <span class="<@if (val.option == val.topicInfo.right_option){@>
                                 win
                                 <@}else{@>
                                 lose
                                 <@}@>">
                                 <@if (val.option==val.topicInfo.right_option){@>
                                    +<@=val.win_score@>
                                 <@}else{@>
                                    <@=val.win_score@>
                                 <@}@></span>
                            <@}else if (parseInt(val.status) ==3){@>
                                <span class="disappear">已流盘</span>
                            <@}@>
                        </div>
                    </li>
                <@})@>
            </script>
        </section>
</div>  
{%/block%}
