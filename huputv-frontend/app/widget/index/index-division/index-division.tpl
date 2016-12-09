<div class="division-area">
	<ul class="division-wrap">
		<li class="division-item J-lrw-area active" data-id="0" data-name="全部站点">
			全部
		</li>
		{%foreach $data as $item%}
			<li class="division-item J-lrw-area" data-id="{%$item.id%}" data-name="{%$item.name%}">
				{%$item.name%}
			</li>
		{%/foreach%}
	</ul>
</div>