
<div class="introduce introduce-title">
	<p class="introduce-content">
		{%$game.title%}
		{%$date%}
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
		{%if $game.game_status == 5 %}
			<a href ="{%withRoomUrl roomid=$game.room_id inkanqiu=$in_kanqiu client=$client%}">
				<i class="triggle"></i><span class="signup-status">正在直播</span>				
			</a>
		{%/if%}
	</div>
	<div class="introduce-signup-match">
		<span class="signup-left">比赛时间</span>
		<span class="signup-right">
				<i>{%$game.game_start|date_format:'%m'%}月{%$game.game_start|date_format:'%d'%}日</i><i> {%$game.game_start|date_format:'%H:%M'%}</i>&nbsp;&nbsp;  
			{%if $game.game_status == 5%}
				<a href ="{%withRoomUrl roomid=$game.room_id inkanqiu=$in_kanqiu client=$client%}">
					<i class="triggle"></i><span class="signup-status">正在直播</span>
				</a>
			{%else if $data.is_live > 9%}
				<a href = "{%withRoomUrl roomid=$game.room_id inkanqiu=$in_kanqiu client=$client%}">
					<i class="triggle"></i><span class="signup-status">回放</span>
				</a>
			{%/if%}
			<i>上海洛克篮球公园</i>
		</span>
	</div>
</div>
<div class="introduce match-rule">
	<a href="http://bbs.hupu.com/17821464.html" >比赛规则介绍</a><em></em>
</div>
<div class="match-relate">
	<div class="match-relate-head">
		<span class="match-relate-title">相关视频</span>
		<a class="match-relate-more" href="{%withRoomUrl  inkanqiu=$in_kanqiu client=$client%}">更多视频</a><em></em>
	</div>
	<div class="match-relate-content">
		<ul class="match-wrap">			
			<li class="match-item">
				<div class="item-video J-match-video">					
					<img src="./lrw-app.jpg" width="130" height="73" alt="">
					<i>7.5</i>
				</div>
				<div class="item-content">
					<div class="item-content-title J-match-video">
						10/25人王上海赛10/25路人王上海赛区第一轮比赛标题标
					</div>
					
				</div>
			</li>	
			<li class="match-item">
				<div class="item-video">					
					<img src="./lrw-app.jpg" width="130" height="73" alt="">
					<i>7.5</i>
				</div>
				<div class="item-content">
					<div class="item-content-title J-match-video">						
						10/25路人王上海赛区第一轮比赛标题标
					</div>
					<div class="item-content-label">
						<ul class="content-label-wrap">
							<li class="content-label-item">
								路人王
							</li>
							<li class="content-label-item">
								路人王
							</li>
							<li class="content-label-item">
								路人王
							</li>
							<li class="content-label-item">
								路人王
							</li>	

						</ul>
					</div>
				</div>
			</li>		
		</ul>
	</div>
</div>

