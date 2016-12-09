<div class="lrwVideo" id="J-lrwVideoWrap"></div>


<script id="J_lrwVideoTpl" type="text/template">
	<section class="match-relate-content">
		<ul class="match-wrap">
			<@ _.each(datas,function(item,index){@>
		
				<li class="match-item">
					<div class="item-video">					
						<img src="<@=item.cover@>"  width="130" height="73" alt="">
						<i><@=item.score@></i>
					</div>
					<div class="item-content">
						<div class="item-content-title J-match-video">						
							<@=item.title@>
						</div>
						<div class="item-content-label">
							<ul class="content-label-wrap">
								<@ _.each(item.tag,function(val,index){@>
									<li class="content-label-item">
										<@=item.tag[index]@>
									</li>
								<@});@>								
							</ul>
						</div>
					</div>
				</li>
			
			<@});@>
		</ul>
	</section>
</script>