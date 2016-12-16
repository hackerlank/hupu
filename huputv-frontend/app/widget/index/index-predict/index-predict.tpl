
<div class="match-formatch" id="J-match-pre"></div>
<div class="show-more-btn" id="J-more-btn">
	<i class="arrow"></i>&nbsp;&nbsp;<span class="more-btn" id="J-more-btn">点击展开更多的预告</span>
</div>
<script id="J_lrwMatchPreTpl" type="text/template">
	<@if (!datas.length){@>
		<div class="no-match">
			<@=text@>&nbsp;近期暂无比赛,建议您去看看其它赛区
		</div>
	<@}else { @>
		<ul class="foreshow-wrap">	
			<@ _.each(datas,function(item,index){@>
				<li class="foreshow-item" data-id="<@=item.id@>">
					<div class="show-left">
						<span><@=item.game_date@></span><br/>
						<span><@=item.game_time@>开赛</span>
					</div>
					<div class="show-mid">
						<a href="/m/passerbyking/game/before/<@=item.id@>?client=<@=HTV.client@>">	
								<span class="show-status-wrap">						
								<@if(item.game_status == 1){@>
									<span class="show-status"> 报名中 </span>
								<@}else if(item.game_status == 2){@>
									
									<span class="show-status"> 即将抽签 </span>
								<@}else if(item.game_status == 3){@>
									<span class="show-status"> <i class="triggle"></i><i>抽签中</i></span>
								<@}else if(item.game_status == 4){@>
									<span class="show-status"> 即将开赛	</span>	 						
								<@}@>
								</span>							
							<span class="show-text"><@=sub(item.title,8,'...')@></span>
						</a>
					</div>
					<div class="show-right <@if(item.is_follow == 1){@> subscribed <@}@> J-subscribe" data-status="<@=item.is_follow@>" data-roomid ="<@=item.room_id@>">
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
