{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
	{%require name="home:static/followList/followList.scss"%}
	{%require name="common:static/js/jquery/jquery-1.12.0.min.js"%}
	{%require name="home:static/followList/followList.js"%}

	{%script%}
	{%/script%}
{%/block%}

{%block name="content"%}
	<div class="myfollow-wrap" id="J-myfollow-wrap">
		<div class="user-content">
			{%widget
	            name="home:widget/user-nav/user-nav.tpl"
	            index=1
	        %}
	        <div class="list" id="J-list">
	        	{%if !empty($followList.list)%}
		        <ul class="inner">
		        	{%foreach $followList.list as $val%}
		        	<li>
		        		<a href="{%$val.abs_url%}" class="cover-wrap">
			        		<div class="cover">
								<img src="{%$val.cover%}" alt="">
                                <i class="game-status {%if $val.is_live == 1%}game-status-live{%/if%}">{%$val.status_text%}</i>
								<div class="mask">
								    <i class="icon-hptv-play-o"></i>
								</div>
							</div>
						</a>
						<div class="text">
							<h3 class="room-name mod-overflow"><a href="{%$val.abs_url%}">{%$val.room_name%}</a></h3>
							<div class="info">
								<div class="user">
									主播：<span>{%$val.anchor_nickname%}</span>
								</div>
								{%if !empty($show_online)%}
								<div class="audience">
									<i class="icon-audience"></i>
									<span>{%$val.online%}</span>
								</div>
								{%/if%}
							</div>
							<div class="tags mod-overflow">{%if !empty($val.tips)%}{%$val.tips%}{%/if%}</div>
							<div class="follow">
								{%if !empty($show_follow)%}
								<div class="num">关注人数：{%$val.following%}</div>
								{%/if%}
								<a href="javascript:void(0);" data-id="{%$val.id%}" data-type="unfollow" class="btn">取消关注</a>
							</div>
						</div>
		        	</li>
		        	{%/foreach%}
		        </ul>
		        {%else%}
		        <p class="no-follow">你还没有关注主播，点击房间右上角的“关注”按钮，可以关注你喜欢的主播</p>
		        {%/if%}
	        </div>
		</div>
	</div>
{%/block%}
