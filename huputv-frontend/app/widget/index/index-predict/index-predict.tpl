
<div class="match-formatch" id="J-match-pre"></div>
<div class="show-more-btn" id="J-more-btn">
	<i></i><span class="more-btn" id="J-more-btn">点击展开更多的预告</span>
</div>
<script id="J_lrwMatchPreTpl" type="text/template">
	<@if (!datas){@>
		<div class="no-match">
			<@=text@>近期暂无比赛,建议您去看看其它赛区
		</div>
	<@}else { @>
		<ul class="foreshow-wrap">	
			<@ _.each(datas,function(item,index){@>
				<li class="foreshow-item" data-id="<@=item.id@>">
					<div class="show-left">
						<span><@=item.game_date@></span>
						<span><@=item.game_time@>开赛</span>
					</div>
					<div class="show-mid">
						<span class="show-status">
							<@if (item.game_status == 0) {@>
								未开始
							<@}else if(item.game_status == 1){@>
								报名中
							<@}else if(item.game_status == 2){@>
								<i class="triggle"></i>
								即将抽签
							<@}else if(item.game_status == 3){@>
								待检录
							<@}else if(item.game_status == 5){@>
								比赛中
							<@}else if(item.game_status == 9){@>	
								已结束
							<@}@>
						</span>
						<span class="show-text"><@=item.title@></span>
					</div>
					<div class="show-right <@if(item.is_follow == 1){@> subscribed <@}@>" id="J-subscribe">
						<span class="subscribe-img"></span>
						<span class="subscribe-text">
						<@if(item.is_follow == 1){@> 
							取消订阅 
						<@}else{@>
							订阅
						<@}@>
						</span>
					</div>
				</li>
			<@});@>
		</ul>		
	<@}@>
</script>