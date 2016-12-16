<div class="discuss J_discuss">
</div>

<script type="text/template" id="J-discuss-tpl">
		<h2>JRs讨论</h2>
		<div class="title">
			<p><@=thread_info.title@></p>
			<span><@=thread_info.replies@> 回复</span>
			<span><@=thread_info.visits@> 浏览</span>
			<span class="addReply">新怎10条数据</span>
		</div>

		<@_.each(light_reply.lights, function(item,index){@>
			<div class="replay_light">
				<div class="use clearfix">
					<div class="user-info">
						<a href="#" class="user-avatar"><img src="<@=item.header@>?<@=index@>" alt=""></a>
						<div class="user-name">
							<p><@=item.username@></p>
							<@if(item.time){@>
				  				<p class="user-time"><@=item.time@></p>
				  			<@}@>
						</div>
					</div>
					<span>亮了 <@=item.light_count@></span>
				</div>
				<div class="reply-content">
					<@_.each(item.quote, function(val){@>
						<div class="reply-quote-content">
							<div class="reply-quote-hd">
								<@=val.header@>
							</div>
							<div class="short-quote-content">
								<@=val.content@>
							</div>
						</div>
					<@})@>
					<div class="current-content">
						<div class="short-content">
							<@=item.content@>
						</div>
					</div>
				</div>
			</div>
		<@})@>
		<div class="more">
			<a href="http://bbs.hupu.com/<@=thread_info.tid@>">
				更多精彩回帖
				<em></em>
			</a>
		</div>
	</div>
</script>



