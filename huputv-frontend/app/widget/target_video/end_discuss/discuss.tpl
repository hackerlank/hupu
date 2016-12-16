<section class="t-content discuss">
<div class="J_discuss">
	
</div>
</section>

<script type="text/template" id="J-discuss-tpl">
	<@if (code != 1){@>
		<div class="null">
				<p>暂无数据</p>
		</div>
	<@}else {@>
		<div class="title link" link="kanqiu://bbs/topic/<@=thread_info.tid@>">
			<h2><@=thread_info.title@></h2>
			<span><@=thread_info.replies@> 回复</span>
			<span><@=thread_info.visits@> 浏览</span>
		</div>

		<div class="reply">
			<@_.each(light_reply.lights, function(item,index){@>
				<dl>
				  <dd class="operations-user">
				  	<a href="#" class="user-avatar"><img src="<@=item.header@>?<@=index@>" alt=""></a>
				  	<div class="user-info">
				  		<div class="user-name clearfix">
				  			<span class="fl">
				  				<a href="#"><@=item.username@></a>
				  			</span>
				  		</div>
				  		<div class="source-left">
				  			<@if(item.time){@>
				  				<span><@=item.time@></span>
				  			<@}@>
				  		</div>
				  	</div>
				  	<span class="reply-light">亮了 <@=item.light_count@></span>
				  </dd>
					<dt class="reply-content">
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
					</dt>
				</dl>
			<@})@>
		</div>
		<div class="more">
			<a href="kanqiu://bbs/topic/<@=thread_info.tid@>">
				更多精彩回帖
				<em></em>
			</a>
		</div>
	<@}@>
</script>
