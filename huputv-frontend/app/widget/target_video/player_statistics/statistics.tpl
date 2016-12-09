<section class="t-content statistics" style="display:none">
	<div id="J_lrwPlayerWrap"></div>
</section>

<script id="J_lrwStatisticsTpl" type="text/template">
	<@ _.each(datas,function(item,index){@>		
			<@if (datas.length == 0){@>
				<div class="null">
					<@if (player == "statistics"){@>
						<p>报名已结束，请耐心等待</p>
					<@}else if(player == 'player'){@>
						<p>抽签已结束，工作人员正在努力的确认每一个参赛者信息，即将公布名单，敬请期待...</p>
					<@}@>
				</div>
			<@}else {@>
				<div class="statistics_list">
					<ul>
						<li>
							<div class="avatar">
									<div class="avatar_index">
										<@if (player == "statistics"){@>
											<@ if(index == 0){@>
												<i></i>
											<@}@>
										<@}@>
										<span <@ if(index == 0){@>class="select" <@}@>><@=index+1@></span>
									</div>
									<img src="<@=item.header@>" alt="">
							</div>
							<div class="content">
								<h3>
									<@=item.nickname@>
									<span><@=item.group_name@></span>
									<img src="../static/target_video/img/fight.png" width="15" alt="">
								</h3>
								
								<div class="detail">
									<div>
										<p><@=item.height@>| <@=item.weight@></p>
										<p>
											<@if (item.total_game){@>
												胜 <@=item.total_win@>	负<@=item.total_game-item.total_win@> 胜率<@=item.rate@>%	
											<@}else {@>
												新晋球员
											<@}@>
										</p>
									</div>
									<@if (player == "statistics"){@>
										<div class="zan_bain">
											<span class="zan" data-id="<@=item.id@>"><i></i><small><@=item.top@></small></span>
											<span class="bian" data-id="<@=item.id@>"><i></i><small><@=item.step@></small></span>
										</div>
									<@}else if(player == "player"){@>
										<div>
											<@if(player_id == item.id){@>
												<span class="finish">已选 <@=item.predict_champion_num@></span>
											<@}else if(status == '1') {@>
												<span class="selected">押冠 <@=item.predict_champion_num@></span>
											<@}else {@>
												<span class="select_win" data-playId="<@=item.id@>">押冠 <@=item.predict_champion_num@></span>
											<@}@>
										</div>
									<@}@>									
								</div>
							</div>
						</li>						
					</ul>
				</div>
			<@}@>		
	<@});@>
</script>

