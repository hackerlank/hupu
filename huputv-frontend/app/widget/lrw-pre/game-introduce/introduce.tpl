
<div class="introduce introduce-title">
	<p class="introduce-content">
		{%$game.desc%}		
	</p>
</div>
<div class="introduce introduce-date">
	<div class="introduce-signup">
		<span class="signup-left">报名日期</span>
		<span class="signup-right">{%$game.signup_start|date_format:'%m'%}月{%$game.signup_start|date_format:'%d'%}日 - {%$game.signup_end|date_format:'%m'%}月{%$game.signup_end|date_format:'%d'%}日</span>
	</div>
	<div class="introduce-signup-btn">
		<span class="contact">欢迎加入虎扑路人王官方报名QQ群：</span><span class="signup-copy" data-type="copy" id="J-sign-copy">300507990</span>
	</div>
	<div class="introduce-signup-btn">
		<span class="signup-left">抽签日期</span><span class="signup-right">{%$game.lottery_time|date_format:'%m'%}月{%$game.lottery_time|date_format:'%d'%}日</span>
		{%if $game.game_status == 3 %}
			<a href ="{%withRoomUrl roomid=$game.room_id inkanqiu=$in_kanqiu client=$client%}">
				<i class="triggle"></i><span class="signup-status">正在直播</span>				
			</a>
		{%/if%}
	</div>
	<div class="introduce-signup-match">
		<span class="signup-left">比赛时间</span>
		<span class="signup-right align">
				<i>{%$game.game_start|date_format:'%m'%}月{%$game.game_start|date_format:'%d'%}日</i><i> {%$game.game_start|date_format:'%H:%M'%}</i>&nbsp;&nbsp;  
			{%if $game.game_status == 5%}
				<a href ="{%withRoomUrl roomid=$game.room_id inkanqiu=$in_kanqiu client=$client%}">
					<i class="triggle"></i><span class="signup-status">正在直播</span>
				</a>
			{%else if $data.is_live >= 9%}
				<a href = "{%withRoomUrl roomid=$game.room_id inkanqiu=$in_kanqiu client=$client%}">
					<i class="triggle"></i><span class="signup-status">回放</span>
				</a>
			{%/if%}
			<div>{%$game.division.address%}</div>
		</span>
	</div>
</div>
<div class="introduce match-rule">
	<a href="http://bbs.hupu.com/17821464.html" >比赛规则介绍</a><em></em>
</div>
<div class="match-relate">
	<div class="match-relate-head">
		<span class="match-relate-title">相关视频</span>
		<!-- <a class="match-relate-more" href="{%withRoomUrl  inkanqiu=$in_kanqiu client=$client%}">更多视频</a><em></em> -->
	</div>
	<div class="match-relate-content">
		{%if !empty($recommend)%}
			<ul class="match-wrap">			
				{%foreach $recommend as $item%} 		
					<li class="match-item">
						<a class="head" 
							{%if $item.type == 1 && $n == 0 %}
						 	 		href="/m/room/{%$item.room_id%}?client={$client%}" 
							{%else if $item.type == 1 && $n >=1 %}
								  	href="huputiyu://huputv/room/{%$item.room_id%}?entrance={%$n%}" 
							{%else if $item.type == 2 && $n <= 1 %}
									href="/m/video/{%$item.vid%}?client={%$client%}"
							{%else%}
									href="huputiyu://huputv/video/{%$item.vid%}?entrance={%$n%}"
							{%/if%}>
							{%if $item.type == 1%}
								<span class="live_status">Live</span>
							{%/if%}
							<div class="item-video">					
								<img src="{%$item.cover%}"  width="100%"  height="100%" alt="" />
								<i>{%$item.score%}</i>
							</div>
							<div class="item-content">
								<h3 class="item-content-title J-match-video">						
									{%if $item.type == 2%}
										{%$item.create_time%}{%$item.title%}
									{%else%}
										{%$item.title%}
									{%/if%}
								</h3>
								<div class="item-content-label">
									<ul class="content-label-wrap">
										{%foreach $item.tag as $val%} 	
											<li class="content-label-item">											
												{%$val%}
											</li>
										{%/foreach%}  								
									</ul>
								</div>
							</div>
						</a>
					</li>
				
				{%/foreach%}  
			</ul>
		{%else%}
			<div class="no-match-relate">
				暂无推荐的视频
			</div>
	{%/if%}
</div>
</div>

