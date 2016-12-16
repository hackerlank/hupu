<div class="lrwVideo" id="J-lrwVideoWrap"></div>


<script id="J_lrwVideoTpl" type="text/template">
	<section class="match-relate-content">
		<@if (!datas.length){@>
			<div class="no-video">暂无视频</div>
		<@}else{@>
		<ul class="match-wrap">
			<@ _.each(datas,function(item,index){@>		
				<li class="match-item">
					<a class="head"
						<@if (item.type == 1 && HTV.n == 0){@>
						 	 	href="/m/room/<@=item.id@>?client=<@=HTV.client@>" 
						<@}else if (item.type == 1 && HTV.n >=1 ){@>
							  	href="huputiyu://huputv/room/<@=item.id@>?entrance=<@=HTV.n@>" 
						<@}else if (item.type == 2 && HTV.n <= 1) {@>
								href="/m/video/<@=item.vid@>?client=<@=HTV.client@>"
						<@}else{@>
								href="huputiyu://huputv/video/<@=item.vid@>?entrance=<@=HTV.n@>"
						<@}@>
						>
						<@if (item.type == 1){@>
							<span class="live_status">Live</span>
						<@}@>
						<div class="item-video">					
							<img src="<@=item.cover@>"  width="100%" height="100%" alt="">
							<i><@=item.score@></i>
							<div class="mask"></div>
						</div>
						<div class="item-content">
							<div class="item-content-title J-match-video">						
								<@if(item.type == 2){@>
									<@=item.create_time@><@=item.title@>
								<@}else{@>
									<@=item.room_name@>
								<@}@>
							</div>
							<div class="item-content-label">
								<@if (item.type == 1){@>
									<div class="anchor-wrap">
										<div class="item-anchor">
											<span class="anchor-img">
												<i class="anchor-top"></i><i class="anchor-bottom"></i>
											</span>
											<span class="zhubo-name"><@=item.anchor_nickname@></span>										
										</div>
										<div class="online-number"><@=item.online@>人在线</div>
									</div>
								<@}else{@>
									<ul class="content-label-wrap">
										<@ _.each(item.tag,function(val,index){@>
											<li class="content-label-item">
												<@=val@>
											</li>
										<@});@>								
									</ul>
								<@}@>
							</div>
						</div>
					</a>
				</li>
			
			<@});@>
		</ul>
		<@}@>
	</section>
</script>