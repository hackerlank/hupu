{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="home:static/rpz/rpz.scss"%}
{%require name="common:static/js/jquery/jquery-1.12.0.min.js"%}
{%require name="common:static/js/echarts/echarts.js"%}
{%require name="home:static/rpz/rpz.js"%}
{%script%}

	{%/script%}
<script>
		HTV.rpzDays = {%json_encode(array_keys($userTopicList.days))|default:['']%};
		HTV.rpzDatas = {%json_encode($userTopicList.days)|default:['']%};
		HTV.nextDate = '{%$userTopicList.next|default:""|f_escape_js%}' ;
	</script>
{%/block%}
{%block name="content"%}
<div class="rpz-wrap" id="J-rpz-wrap">
<div class="user-content">
{%widget
	            name="home:widget/user-nav/user-nav.tpl"
	            index=3
	        %}
{%if !empty($userPredictionInfo)%}
<div class="main-con">
<div class="rpz-record">
<div class="title">
<a href="/predict/rank/list" target="_blank" class="today-rank">
今日排行 ></a>
<div class="record">
人品值成长记录</div>
<a href="javascript:;" class="desc">
人品值说明{%widget
			        			    name="home:widget/tips/tips.tpl"
			        			%}
</a>
</div>
<div class="rpz-grid">
<div class="grid-title">
<div class="title-right">
当前连胜：<span>{%$userPredictionInfo.win|f_escape_xml%}</span><em>(x{%$userPredictionInfo.magnification|f_escape_xml%})</em>
</div>
<div class="title-left">
<span>{%$userTopicStatus.win|default:0|f_escape_xml%}胜{%$userTopicStatus.lose|default:0|f_escape_xml%}负</span>
<span>命中率{%$userTopicStatus.rate|default:0|f_escape_xml%}%</span>
</div>
</div>
{%if $userTopicStatus%}
<div id="grid-main" style="width:625px;height:330px">
</div>
{%else%}
<div style="line-height:100px;text-align:center;color:#999;">
暂无人品值成长记录</div>
{%/if%}
</div>
</div>
{%if !empty($userTopicList.data)%}
<div class="rpz-list">
<ul class="list" id="J_recordList">
<li class="section">
<div class="title">
<span>{%$userTopicList.timeFormat.date|f_escape_xml%}</span>
&nbsp;&nbsp;<span>{%$userTopicList.timeFormat.cn|f_escape_xml%}</span>
<span class="status">
人品值&nbsp;{%assign var=score value=$userTopicList.days_score[$userTopicList.day]%}
{%if $score|string_format:'%d' >= 0%}
<em class="win">+{%$score|f_escape_xml%}</em>
{%else%}
<em class="lose">{%$score|f_escape_xml%}</em>
{%/if%}
</span>
</div>
{%foreach $userTopicList.data as $val%}
{%assign var=info value=$val.topicInfo%}
{%assign var=win value=$val.win_score%}
<div class="item">
<div class="team-name">
{%if $info.right_option == 1%}
{%if $val.option == 1%}
<div>{%$info.option1|f_escape_xml%}<span>已选</span></div>
<div class="lose">{%$info.option2|f_escape_xml%}</div>
{%else%}
<div>{%$info.option1|f_escape_xml%}</div>
<div class="lose">{%$info.option2|f_escape_xml%}<span>已选</span></div>
{%/if%}
{%else%}
{%if $val.option == 2%}
<div>{%$info.option2|f_escape_xml%}<span>已选</span></div>
<div class="lose">{%$info.option1|f_escape_xml%}</div>
{%else%}
<div>{%$info.option2|f_escape_xml%}</div>
<div class="lose">{%$info.option1|f_escape_xml%}<span>已选</span></div>
{%/if%}
{%/if%}
</div>
{%if ($val.status == 0 || $val.status == 1 || $val.status == 3)%}
<div class="status">
<span>--</span>
<span class="lose">--</span>
</div>
{%else%}
<div class="status">
<span>胜</span>
<span class="lose">负</span>
</div>
{%/if%}
<div class="result">
{%if $val.status == 2%}
{%if $win|string_format:'%d' >= 0%}
<div class="win">+{%$win|f_escape_xml%}</div>
{%else%}
<div class="lose">{%$win|f_escape_xml%}</div>
{%/if%}
{%elseif $val.status == 0 || $val.status == 1%}
<div class="wait">待开奖</div>
{%else%}
<div class="wait">已流盘</div>
{%/if%}
</div>
</div>
{%/foreach%}
</li>
</ul>
{%if !empty($userTopicList.next)%}
<a href="javascript:;" class="more-record" id="J_more">
<div class="arrow"><span></span></div>
<span class="txt">向下展开查看更多</span>
</a>
{%/if%}
<div class="more-record" id="J_loadmore" style="display:none"><span class="txt">加载完毕</span></div>
</div>
{%/if%}
</div>
{%else%}
<div class="main-con">
<div class="rpz-record">
<div class="title">
<a href="/predict/rank/list" target="_blank" class="today-rank">
今日排行 ></a>
<div class="record">
人品值成长记录</div>
<a href="javascript:;" class="desc">
人品值说明{%widget
			        			    name="home:widget/tips/tips.tpl"
			        			%}
</a>
</div>
<div class="empty-tips">
暂无人品值成长记录</div>
</div>
</div>
{%/if%}
</div>
</div>
<script id="record-tpl" type="text/template">
		<li class="section">
			<div class="title">
				<span><@=data.timeFormat.date@></span>
				&nbsp;&nbsp;
				<span><@=data.timeFormat.cn@></span>
				<span class="status">
					人品值&nbsp;
					<@ var score = data.days_score[data.day] @>
					<@if (parseInt(score) >= 0) {@>
						<em class="win">+<@=score@></em>
					<@ } else { @>
						<em class="lose"><@=score@></em>
					<@ } @>
				</span>
			</div>
			<@ _.each(data.data, function(item,index) { @>
				<@ var info = item.topicInfo @>
				<@ var win = parseInt(item.win_score) @>

				<div class="item">
					<div class="team-name">
						<@ if(info.right_option == 1) { @>
							<@ if(item.option == 1){ @>
								<div><@=info.option1@> <span>已选</span></div>
								<div class="lose"><@=info.option2@></div>
							<@ } else { @>
								<div><@=info.option1@> </div>
								<div class="lose"><@=info.option2@> <span>已选</span></div>
							<@ } @>
						<@ } else { @>
							<@ if(item.option == 2){ @>
								<div><@=info.option2@> <span>已选</span></div>
								<div class="lose"><@=info.option1@></div>
							<@ } else { @>
								<div><@=info.option2@> </div>
								<div class="lose"><@=info.option1@> <span>已选</span></div>
							<@ } @>
						<@ } @>
					</div>
					<@if(item.status == 0 || item.status == 1 || item.status == 3) { @>
						<div class="status">
							<span>--</span>
							<span class="lose">--</span>
						</div>
					<@} else{@>
					 <div class="status">
						 <span>胜</span>
						 <span class="lose">负</span>
					 </div>
					<@} @>
					<div class="result">
						<@ if(item.status == 2){ @>
							<@ if(win >= 0){ @>
								<div class="win">+<@=win@></div>
							<@ }else{ @>
								<div class="lose"><@=win@></div>
							<@ } @>
						<@ }else if(item.status == 0 || item.status == 1) { @>
							<div class="wait">待开奖</div>
						<@ }else{ @>
							<div class="wait">已流盘</div>
						<@ } @>

					</div>
				</div>
			<@ }) @>
		</li>
	</script>
{%require name='home:page/rpz.tpl'%}{%/block%}
