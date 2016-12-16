<section class="t-content introduce">
		<div class="score">
			<div class="star">
				<div class="star_title">{%$video.score%}</div>
				<div class="star_num">
					<ul class="clearfix">
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
					</ul>
					<div class="rating-stars">
					</div>
				</div>
			</div>
			<div class="star_confirm">
				
					<span {%if $video.is_rated == 0%} class="star_btn" {%/if%}>
						{%if $video.is_rated == 0%}
							评分
						{%else%}
							已评分
						{%/if%}
					</span>
				
			</div>
		</div>

		{%widget
        name="app:widget/target_video/video_list.tpl"
    %}	
</section>
