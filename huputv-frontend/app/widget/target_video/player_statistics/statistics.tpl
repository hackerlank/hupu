<section class="t-content statistics">
<div class="null">
	<p>报名已结束，请耐心等待</p>
</div>
	<div class="statistics_list">
		<ul>
			<li>
				<div class="avatar">
						<div class="avatar_index">
							<i></i>
							<span class="select">1</span>
						</div>
						<img src="../static/target_video/img/avatar.png?1" alt="">
				</div>
				<div class="content">
					<h3>
						虎扑的昵称八个字
						<span>	Gmyphe战团</span>
						<img src="../static/target_video/img/fight.png" width="15" alt="">
					</h3>
					
					<div class="detail">
						<div>
							<p>188cm | 76kg</p>
							<p>胜3 负2 胜率75%</p>
						</div>
						{%if $player == "statistics"%}
							<div class="zan_bain">
								<span class="zan"><i></i>22</span>
								<span class="bian"><i></i>33</span>
							</div>
						{%else if $player == "player"%}
							<div>
								<span class="select">神冠 234</span>
								<span class="finish">已选 234</span>
							</div>
						{%/if%}
					</div>
				</div>
			</li>
			<li>
				<div class="avatar">
						<div class="avatar_index">
							<span>1</span>
						</div>
						<img src="../static/target_video/img/avatar.png?2" alt="">
				</div>
				<div class="content">
					<h3>
						虎扑的昵称八个字
						<span>	Gmyphe战团</span>
						<img src="../static/target_video/img/fight.png" width="15" alt="">
					</h3>
					
					<div class="detail">
						<div>
							<p>188cm | 76kg</p>
							<p class="new_player">新晋球员</p>
						</div>
						<div class="zan_bain">
							<span class="zan"><i></i>22</span>
							<span class="bian"><i></i>33</span>
						</div>
					</div>
				</div>
			</li>
		</ul>
	</div>
</section>
