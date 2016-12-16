<div class="content">
	<div class="title">
		<h4>接下来播放</h4>
		<div class="toggle">自动播放<i></i></div>
		<!--
		<p>更多视频<em></em></p>
		-->
	</div>
	<div class="list">
		<ul>
			{%foreach from=$recommend item=val name=key%}
				<li class="clearfix link" link="/video/{%$val.vid%}">
					<div class="img">
						<img src="{%$val.cover%}" alt="">
						<span class="video_score">7.5</span>
						<span class="video_btn"></span>
					</div>
					<div class="video_content">
						<p><span>{%$val.create_time%}</span>&nbsp;{%$val.title%}</p>
						<div class="video_tag clearfix">
							<ul>
								{%foreach from=$val.tag item=item name=key%}
									<li>{%$item%}</li>
								{%/foreach%}
							</ul>
						</div>
					</div>
				</li>
			{%/foreach%}
		</ul>
	</div>
</div>
<div class="share clearfix">
    <span class="share_word">分享到：</span>
    {%widget
        name="common:widget/share/share.tpl"
    %}
</div>