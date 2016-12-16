
<div class="match-relate-content">
	<ul class="match-wrap">
		{%foreach $data as $item%} 		
			<li class="match-item">
				<a href="/video/{%$item.vid%}" title="{%$item.title%}">
					<div class="item-video">					
						<img src="{%$item.cover%}"  width="100%" height="100%" alt="" />
						<i>{%if $item.score > 0%}
							{%$item.score|string_format:'%.1f'%}
							{%else%}
							{%$item.score%}
							{%/if%}
						</i>
					</div>
					<div class="item-content">
						<div class="item-content-title J-match-video">	
						{%if $video_recommend.type == 2%}					
							{%$item.create_time%}{%$item.title%}
						{%/if%}
						</div>
						<div class="item-content-label">
							<ul class="content-label-wrap">
								{%foreach $item.tag as $val%} 	
									<li class="content-label-item">
										{%$val%}
									</li>
								{%/foreach%}  								
							</ul>
						</div>
					</div>
				</a>
			</li>			
		{%/foreach%}  
	</ul>
</div>
