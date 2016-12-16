<div class="introduce introduce-date">
	<div class="introduce-signup">
		<div class="signup-left">报名</div>
		<div class="signup-right">
			<span>				
				{%$game.signup_start|date_format:'%m'%}月{%$game.signup_start|date_format:'%d'%}日 - {%$game.signup_end|date_format:'%m'%}月{%$game.signup_end|date_format:'%d'%}日</span><br/>
			<span class="contact">欢迎加入虎扑路人王官方报名QQ群</span><br/>
			<span class="signup-copy" data-type="copy" id="J-sign-copy">300507990</span>
			<span class="copyqq-tips">复制成功，现在就去添加QQ号报名比赛吧</span>
		</div>
	</div>	
	<div class="introduce-signup">
		<div class="signup-left">抽签</div>
		<div class="signup-right lrw-date">
			<span>{%$game.lottery_time|date_format:'%m'%}月{%$game.lottery_time|date_format:'%d'%}日</span>
			{%if $game.game_status == 3 %}
				<a href ="/{%$game.lottery_room%}">
					<i class="triggle"></i><span class="signup-status">正在直播</span>				
				</a>
			{%/if%}
		</div>
	</div>
	<div class="introduce-signup">
		<div class="signup-left">比赛</div>
		<div class="signup-right ">
			<span class="match">
					<i>{%$game.game_start|date_format:'%m'%}月{%$game.game_start|date_format:'%d'%}日</i><i> {%$game.game_start|date_format:'%H:%M'%}</i>&nbsp;&nbsp;  
				{%if $game.game_status == 5%}
					<a href ="/{%$game.room_id%}">
						<i class="triggle"></i><span class="signup-status">正在直播</span>
					</a>
				{%else if $data.is_live >= 9%}
					<a href = "/{%$game.vid%}">
						<i class="triggle"></i><span class="signup-status">回放</span>
					</a>
				{%/if%}
				<br/><i>{%$game.division.address%}</i>
			</span>
		</div>
	</div>
	<div class="introduce match-rule">
		<a href="http://bbs.hupu.com/17821464.html" >比赛规则介绍 ></a>
	</div>
</div>
