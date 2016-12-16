{%extends file="app/page/layout-empty.tpl"%}

{%block name="title"%}{%$title%}{%/block%}

{%block name="head_static"%}
	{%require name="app:widget/target_video/player_statistics/statistics.scss"%}
    {%require name="app:static/live/live_player/live_player.js"%}
    {%script%}
    	!function(win){
			var HTV = win.HTV = {};

			 // 用户登陆状态
            HTV.isLogin = {%intval($is_login)%};
			// 人品值
            HTV.score = {%$userInfo.score%};
            //胜率
            HTV.is_rated = {%$userInfo.is_rated%};
            

    	}(window)
    {%/script%}
{%/block%}

{%block name="content"%}
<div class="content">
   <section class="t-content statistics">
	<div id="J_lrwPlayerWrap">
	{%if !empty($player)%}
		<div class="null">			
			<p>获取球员信息失败，请重试！</p>				
		</div>
	{%else%}
		<div class="statistics_list">
			<ul>
				{%foreach $player as $item %}		
					<li>
						<div class="avatar">
								<div class="avatar_index">										
									<span 
										{%if $item@index == 0%}
											class="select"
										{%/if%}>
											{%$item@index+1%}
									</span>
								</div>
								<img src="{%$item.header%}" alt="">
						</div>
						<div class="content">
							<h3>
								{%$item.nickname%}
								<span>{%$item.group_name%}</span>
								<img src="../static/target_video/img/fight.png" width="15" alt="">
							</h3>
							<div class="detail">
								<div>
									<p>{%$item.height%}cm| {%$item.weight%}kg</p>
									<p>
										{%if $item.total_game%}
											胜 {%$item.total_win%}	负{%$item.total_game-$item.total_win%} 胜率{%$item.rate%}%	
										{%else%}
											新晋球员
										{%/if%}
									</p>
								</div>
								<div class="zan_bain">
									<span class="zan" data-id="{%=item.id%}"><i></i><small>{%$item.top%}</small></span>
									<span class="bian" data-id="{%=item.id%}"><i></i><small>{%$item.step%}</small></span>
								</div>								
																
							</div>
						</div>
					</li>
				{%/foreach%}						
			</ul>
		</div>
	{%/if%}
	</div>
</section>
</div>
{%/block%}
