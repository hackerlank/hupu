<div class="video_title">
	<h2>相关视频</h2>
	<p>更多视频<em></em></p>
</div>
<div class="introduce_list">
	<ul class="J_video_list">
	</ul>
</div>
<script type="text/template" id="J-video-tpl">
	<@_.each(datas, function(item){@>
		<li class="list clearfix link" link="huputiyu://huputv/video/<@=item.vid@>?entrance=1">
			<div class="img">
				<img src="../static/target_video/img/video.png" alt="">
				<span class="video_score"><@=item.score@></span>
				<span class="video_btn"></span>
			</div>
			<div class="video_content">
				<p><span>10/25</span><@=item.title@></p>
				<div class="video_tag clearfix">
					<ul>
						<@_.each(item.tag, function(val,index){@>
							<li>
								<a href="#" ><@=val@></a>
							</li>
						<@})@>
					</ul>
				</div>
			</div>
		</li>
	<@})@>
</script>



