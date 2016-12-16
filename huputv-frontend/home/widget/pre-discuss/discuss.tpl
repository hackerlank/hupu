<div class="t-content discuss" style="display:none">
	<div class="title">
		<h2>帖子标题帖子标题帖子标题帖子标题帖子标题帖子标题帖子标题帖子标题帖子标题帖子标题帖子标题</h2>
		<span>267 回复</span>
		<span>3678 浏览</span>
	</div>
	<div class="reply">
		<dl>
		  <dd class="operations-user">
		  	<a href="#" class="user-avatar"><img src="../static/target_video/img/avatar.png" alt=""></a>
		  	<div class="user-info">
		  		<div class="user-name clearfix">
		  			<span class="fl">
		  				<a href="#">email</a>
		  			</span>
		  		</div>
		  		<div class="source-left">
		  			<span>4分钟前</span>
		  		</div>
		  	</div>
		  	<span class="reply-light">亮了 188</span>
		  </dd>
			<dt class="reply-content">
				<div class="reply-quote-content">
					<div class="reply-quote-hd">
						引用 1楼 @
						<a href="#">email</a>
						 发表的
					</div>
					<div class="short-quote-content">
						他老公知道吗
					</div>
				</div>
				<div class="current-content">
					<div class="short-content">
						帖子说了，妹子小姑娘，直觉可能不是处，但确实没男票的。
					</div>
				</div>
			</dt>
		</dl>
		<dl>
		  <dd class="operations-user">
		  	<a href="#" class="user-avatar"><img src="../static/target_video/img/avatar.png" alt=""></a>
		  	<div class="user-info">
		  		<div class="user-name clearfix">
		  			<span class="fl">
		  				<a href="#">email</a>
		  			</span>
		  		</div>
		  		<div class="source-left">
		  			<span>4分钟前</span>
		  		</div>
		  	</div>
		  	<span class="reply-light">亮了 188</span>
		  </dd>
			<dt class="reply-content">
				<div class="reply-quote-content">
					<div class="reply-quote-hd">
						引用 1楼 @
						<a href="#">email</a>
						 发表的
					</div>
					<div class="short-quote-content">
						他老公知道吗
					</div>
				</div>
				<div class="current-content">
					<div class="short-content">
						帖子说了，妹子小姑娘，直觉可能不是处，但确实没男票的。
					</div>
				</div>
			</dt>
		</dl>
	</div>
	<div class="more">
		<a  href="javascript:;">查看更多精彩回帖 > </a>
	</div>
	
</div>
<div class="t-content discuss" id="J_discuss">

</div>
<script type="text/template" id="J-discuss-tpl">
		<div class="title link" link="kanqiu://bbs/topic/<@=thread_info.tid@>">
			<h2><@=thread_info.title@></h2>
			<span><@=thread_info.replies@> 回复</span>
			<span><@=thread_info.visits@> 浏览</span>
		</div>

		<div class="reply">
			<@_.each(light_reply.lights, function(item){@>
				<dl>
				  <dd class="operations-user">
				  	<a href="#" class="user-avatar"><img src="<@=item.header@>" alt=""></a>
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
			<a href="kanqiu://bbs/topic/<@=HTV.tid@>">
				更多精彩回帖
				<em></em>
			</a>
		</div>
</script>
