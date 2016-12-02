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
		HTV.nextDate = '{%$userTopicList.next|default:""%}' ;
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
			        			今日排行 >
			        		</a>
			        		<div class="record">
			        			人品值成长记录
			        		</div>
			        		<a href="javascript:;" class="desc">
			        			人品值说明
			        			{%widget
			        			    name="home:widget/tips/tips.tpl"
			        			%}
			        		</a>
			        	</div>

			        	<div class="rpz-grid">
			        		<div class="grid-title">
			        			<div class="title-right">
			        				当前连胜：<span>{%$userPredictionInfo.win%}</span><em>(x{%$userPredictionInfo.magnification%})</em>
			        			</div>
			        			<div class="title-left">
			        				<span>{%$userTopicStatus.win|default:0%}胜{%$userTopicStatus.lose|default:0%}负</span>
			        				<span>命中率{%$userTopicStatus.rate|default:0%}%</span>
			        			</div>
			        		</div>
							{%if $userTopicStatus%}
			        		<div id="grid-main" style="width:625px;height:330px">

			        		</div>
							{%else%}
							<div style="line-height:100px;text-align:center;color:#999;">
								暂无人品值成长记录
							</div>
							{%/if%}
			        	</div>
		        	</div>
		        	<div class="rpz-tab">
		        		<a href="javascript:;" class="zrp-record active">攒人品记录</a>
		        		<a href="javascript:;" class="zrp-record">人品值明细</a>
		        	</div>
					<div class="rpz-predict-wrap" id="J-rpz-predict">
						<div class="zrp-detail active">
							{%if !empty($userTopicList)%}
								<div class="rpz-predict">							
									<ul class="pre-list" id="J_recordList">
											<li class="pre-list-title">
												<div class="rpz-preTitle">
													<span>{%$userTopicList.timeFormat.date%} &nbsp;&nbsp; {%$userTopicList.timeFormat.cn%}</span><span class="status">人品值&nbsp;
													{%if $userTopicList.days_score[$userTopicList.day] >= 0 %}
														<i class="pre-num pre-add">+{%$userTopicList.days_score[$userTopicList.day] %}</i>
													{%else%}
														<i class="pre-num pre-reduce">{%$userTopicList.days_score[$userTopicList.day] %}</i>
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
															{%if intval($val.option) == $item.option_id && $item.option_id != intval($val.topicInfo.right_option)%}
																status-checked
															{%else if intval($val.option) != $item.option_id && $item.option_id == intval($val.topicInfo.right_option)%}
																status-correct
															{%else if intval($val.option) == $item.option_id && $item.option_id == intval($val.topicInfo.right_option)%}
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
													{%if intval($val.topicInfo.status) == 0%}
														<span class="voting">进行中</span>
													{%else if intval($val.topicInfo.status) == 1%}
														<span class="ready">待开奖</span>
													{%else if intval($val.topicInfo.status) == 2%}												
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
													{%else if intval($val.topicInfo.status) ==3%}
														<span class="disappear">已流盘</span>
													{%/if%}
												</div>
											</li>
										{%/foreach%}
									</ul>
									 <div class="more">
						                {%if !empty($userTopicList.next)%}
					        			<a href="javascript:;" class="more-record" id="J_more">
					        				<div class="arrow"><span></span></div>
					        				<span class="txt">向下展开查看更多</span>
					        			</a>
										{%/if%}
										<div class="more-record" id="J_loadmore" style="display:none"><span class="txt">加载完毕</span></div>
						            </div>
								</div>
							{%else%}
								<div class="rpz-predict-empty">
									暂无攒人品记录
								</div>
							{%/if%}	
						</div>
						<div class="zrp-detail ">
							{%if empty($userTopicdetail)%}
								<div class="rpz-detail">
									<p class="rpz-header">
										<span class="rpz-title">人品值明细</span><span class="rpz-text">可查询最近3个月的人品值记录</span>
									</p>
									<ul class="rpz-detail-wrap" id="J-rpz-detail">
										<li class="rpz-item">
											<div class="rpz-date">
												2016/03/19  11:07
											</div>
											<div class="rpz-content">												
												攒人品 - [路人王上海站] 参与攒人品
											</div>
											<div class="rpz-score">
												+100RP
											</div>
											<div class="rpz-current">
												当前PR 700
											</div>
										</li>
									</ul>
									<div class="more">
						                {%if !empty($userTopicList.next)%}
					        			<a href="javascript:;" class="more-record" id="J_more_rpz">
					        				<div class="arrow"><span></span></div>
					        				<span class="txt">向下展开查看更多</span>
					        			</a>
										{%/if%}
										<div class="more-record" id="J_loadmore" style="display:none"><span class="txt">加载完毕</span></div>
						            </div>
								</div>
							{%else%}
								<div class="rpz-detail-empty">
									暂无人品值明细
								</div>
							{%/if%}
						</div>				
					</div>
		        </div>
		    {%else%}
		    	<div class="main-con">
		    		<div class="rpz-record">
		    			<div class="title">
			        		<a href="/predict/rank/list" target="_blank" class="today-rank">
			        			今日排行 >
			        		</a>
			        		<div class="record">
			        			人品值成长记录
			        		</div>
			        		<a href="javascript:;" class="desc">
			        			人品值说明
			        			{%widget
			        			    name="home:widget/tips/tips.tpl"
			        			%}
			        		</a>
			        	</div>
			        	<div class="empty-tips">
			        		暂无人品值成长记录
			        	</div>
		    		</div>

		    	</div>
	        {%/if%}
		</div>
	</div>
	<script id="record-tpl" type="text/template">
		<li class="pre-list-title">
			<div class="rpz-preTitle">
				<span><@=datas.timeFormat.date@> &nbsp;&nbsp; <@=datas.timeFormat.cn@></span><span class="status">人品值&nbsp;
				<@if (datas.days_score[datas.day] >= 0){ @>
					<i class="pre-num pre-add">+<@=datas.days_score[datas.day] @></i>
				<@}else{@>
					<i class="pre-num pre-reduce"><@=datas.days_score[datas.day] @></i>
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
				<@if (parseInt(val.topicInfo.status) == 0) {@>
					<span class="voting">进行中</span>
				<@} else if (parseInt(val.topicInfo.status) == 1){@>
					<span class="ready">待开奖</span>
				<@} else if (parseInt(val.topicInfo.status) == 2){@>												
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
				<@}else if (parseInt(val.topicInfo.status) ==3){@>
					<span class="disappear">已流盘</span>
				<@}@>
			</div>
		</li>
	<@})@>
	</script>
	<script id="detail-tpl" type="text/template">
		<@ _.each(datas.data, function(val,index) { @>
			<li class="rpz-item">
				<div class="rpz-date">
					2016/03/19  11:07
				</div>
				<div class="rpz-content">												
					攒人品 - [路人王上海站] 参与攒人品
				</div>
				<div class="rpz-score">
					+100RP
				</div>
				<div class="rpz-current">
					当前PR 700
				</div>
			</li>
		<@})@>
	</script>
{%/block%}
