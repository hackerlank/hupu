 <div class="task-left">
    {%if !empty($user)%}
        <a href="javascript:;" class="task-btn task-item">任务<em></em></a>

        {%if !$chaoneng|default:false%}
            {%if $task.online.status == 2%}
                <a href="javascript:;" class="getbeans-btn task-item">
                    <span class="beans">
                        x{%$task.online.cur_score%}
                    </span>
                    <span class="text">
                        <span>领取</span>
                    </span>
                </a>
            {%elseif $task.online.status == 1%}
                <a href="javascript:;" class="getbeans-btn task-item disabled">
                    <span class="beans"></span>
                    <span class="text">
                        <span class="btn-timing">{%$task.online.rest_time_str%}</span>
                        <span>x{%$task.online.cur_score%}</span>
                    </span>
                </a>
            {%/if%}
        {%/if%}


        <div class="mask-board">
            <div class="mask-nav">
                <div class="mask-tab-wrap">
                    <div class="mask-tab first-item J_signTab {%if !$task.sign.has_sign%}notice{%/if%}">
                        <span>签到领金豆</span>
                        <em>已连续签到<em id="J_signDays">{%$task.sign.keep_days%}</em>天</em>
                    </div>
                    <div class="mask-tab J_onlineTab {%if $task.online.status == 2%}notice{%/if%}">
                        <span>在线领金豆</span>
                        <em class="tab-timing">
                            {%if $task.online.status == 1%}
                                {%$task.online.rest_time_str%}后可领取
                            {%elseif $task.online.status == 2%}
                                可领取
                            {%elseif $task.online.status == 3%}
                                已完成
                            {%/if%}
                        </em>
                    </div>
                    <div class="mask-tab J_shareTab {%if $task.share.status == 1%}notice{%/if%}">
                        <span>分享有礼</span>
                        <em>还可领取 <em class="J_shareTimesRest">{%$task.share.rest_times%}</em> 次</em>
                    </div>
                </div>
                <span class="close" id="J_close"></span>
            </div>
            <div class="mask-con-wrap">
                <div class="mask-con">
                    <h3>任务说明</h3>
                    <p>完成签到任务，每日可获得5个金豆。连续签到可在第3天、第7天分别额外获得10个金豆和30个金豆</p>
                    <div class="sign-info" id="J_signInfo">
                        {%if $task.sign.has_sign%}
                            <div class="sign-tip">
                               今日已签到，获得 <span id="J_signBeans">{%$task.sign.now_bean%}</span> 个金豆
                            </div>
                            <a href="javascript:;" class="sign-btn signed" id="J_signBtn">已签到</a>
                        {%else%}
                            <div class="sign-tip">
                                你已连续签到 <span>{%$task.sign.keep_days%}</span> 天
                            </div>
                            <a href="javascript:;" class="sign-btn" id="J_signBtn">立即签到</a>
                        {%/if%}
                    </div>
                </div>
                <div class="mask-con online-con">
                    <h3>任务说明</h3>
                    <p>点击倒计时图标即可领取金豆，连续在线分别满10分钟、20分钟、30分钟、1小时、2小时，可依次免费领取5、10、15、20、30金豆。</p>
                    <ul class="online-list">
                        {%foreach from=$task.online.scene_list item=val key=keys%}
                            {%assign var=beanClass value=['beans-num1','beans-num2','beans-num2','beans-num3','beans-num3']%}
                            {%assign var=beansNum value=[5,10,15,20,30]%}
                            <li class="online-item {%if $val@index == 4%}last-item{%/if%}">
                                <div class="beans-num {%$beanClass[$val@index]%}">
                                    {%$beansNum[$val@index]%}
                                </div>
                                {%if $val.status == 0%}
                                    <a href="javascript:;" class="online-btn wait">等待中</a>
                                {%elseif $val.status == 1%}
                                    <a href="javascript:;" class="online-btn disable item-timing">{%$task.online.rest_time_str%}</a>
                                {%elseif $val.status == 2%}
                                    <a href="javascript:;" class="online-btn able">领取</a>
                                {%else%}
                                    <a href="javascript:;" class="online-btn disable">已领取</a>
                                {%/if%}
                            </li>
                        {%/foreach%}

                    </ul>
                </div>
                <div class="mask-con J_shareCon">
                    <h3>任务说明</h3>
                    <p>点击播放窗口右上方的分享图标，将自己喜爱的直播分享给更多人，即可领取5金豆（每分享一个直播间并有其他用户访问，即可获得金豆奖励，每天最多可分享10个不同的直播间）</p>
                    <div class="share-info" id="J_shareInfo">
                        <div class="share-tip">
                            你已领取 <span>{%$task.share.times%}</span> 次金豆，还可以领取 <span>{%$task.share.rest_times%}</span> 次。
                        </div>
                        {%if $task.share.status == 0%}
                            <a href="javascript:;" class="share-btn unGet" data-cls="unGet" id="J_shareBtn">未完成</a>
                        {%elseif $task.share.status == 1%}
                            <a href="javascript:;" class="share-btn canGet" data-cls="canGet" id="J_shareBtn">领取金豆</a>
                        {%else%}
                            <a href="javascript:;" class="share-btn fullGet" data-cls="fullGet" id="J_shareBtn">已完成</a>
                        {%/if%}
                    </div>
                </div>
            </div>
        </div>
    {%else%}
        {%if !$chaoneng|default:false%}
            <a href="javascript:;" class="login4task" id="J_login4task">登录领取金豆</a>
        {%else%}
            <a href="javascript:;" class="task-btn task-item" id="J_login4task">登录<em></em></a>
        {%/if%}
    {%/if%}
</div>

<script id="sign-tpl" type="text/template">
    <@ if(datas.has_sign){ @>
        <div class="sign-tip">
           今日已签到，获得 <span id="J_signBeans"><@=datas.add_bean@></span> 个金豆
        </div>
        <a href="javascript:;" class="sign-btn signed" id="J_signBtn">已签到</a>
    <@ }else{ @>
        <div class="sign-tip">
            你已连续签到 <span><@=datas.keep_days@></span> 天
        </div>
        <a href="javascript:;" class="sign-btn" id="J_signBtn">立即签到</a>
    <@ } @>
</script>

<script id="online-tpl" type="text/template">
    <@ _.each(datas.scene_list, function(item,index) { @>
        <li class="online-item <@ if((index-1) == 4){ @>last-item<@}@>">
            <div class="beans-num <@=beanClass[index-1]@> ">
                <@=item.score@>
            </div>
            <@ if(item.status == 0){ @>
                <a href="javascript:;" class="online-btn wait">等待中</a>
            <@ }else if(item.status == 1){ @>
                <a href="javascript:;" class="online-btn disable item-timing"><@=time@></a>
            <@ }else if(item.status == 2){ @>
                <a href="javascript:;" class="online-btn able">领取</a>
            <@ }else{ @>
                <a href="javascript:;" class="online-btn disable">已领取</a>
            <@ } @>
        </li>
    <@ }); @>
</script>

<script id="share-tpl" type="text/template">
    <div class="share-tip">
        你已领取 <span><@=datas.times@></span> 次金豆，还可以领取 <span><@=datas.rest_times@></span> 次。
    </div>
    <@ if (datas.status == 0){ @>
        <a href="javascript:;" class="share-btn unGet">未完成</a>
    <@ }else if(datas.status == 1){ @>
        <a href="javascript:;" class="share-btn canGet">领取金豆</a>
    <@ }else{ @>
        <a href="javascript:;" class="share-btn fullGet">已完成</a>
    <@ } @>
</script>


<script id="btn-tpl" type="text/template">
    <@ if(datas.status != 3){ @>
        <a href="javascript:;" class="getbeans-btn task-item
            <@ if(datas.status == 1) { @> disabled <@ } @>">
            <span class="beans">
                <@ if(datas.status == 2) { @> x<@=datas.cur_score@>  <@ } @>
            </span>
            <@ if(datas.status == 1) { @>
                <span class="text">
                    <span class="btn-timing"><@=time@></span>
                    <span>x<@=datas.cur_score@></span>
                </span>
            <@ }else{ @>
                <span class="text">领取</span>
            <@ } @>
        </a>
    <@ } @>
</script>

{%script%}
var Task = require("live:widget/task/task");
Task.init({%$chaoneng|default:false%});

HTV.getBeans = Task.requestOnline;

{%/script%}
