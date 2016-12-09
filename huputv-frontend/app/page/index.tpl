{%extends file="app/page/layout.tpl"%}

{%block name="title"%}路人王{%/block%}

{%block name="head_static"%}
	{%require name="app:static/js/swiper/swipe.js"%}
	{%require name="app:static/index/index.scss"%}
	{%require name="app:static/index/index.js"%}
{%/block%}

{%block name="content"%}
	<div id="lrw-wrap">
		<header class="header">
			{%widget
	            name="app:widget/index/index-tab/index-tab.tpl"
	            selected = "1"	            
	            data = $catalog
	        %}			
		</header>
		<div class="item-wrap active-show">	
			<section class="slide">
				{%widget
		            name="app:widget/index/index-slide/index-slide.tpl"	
		            data= $recommend	            
	        	%}
			</section> 
			<section class="division">
				{%widget
		            name="app:widget/index/index-division/index-division.tpl"	
		            data= $catalog[0].division	            
	        	%}
			</section>
			<section class="foreshow">
				<div class="foreshow-title">比赛预告</div>	
				{%widget
		            name="app:widget/index/index-predict/index-predict.tpl"		                      
	        	%}		
				
			</section>
			<section class="past-match">
				<div class="foreshow-title">往期比赛</div>	
				{%widget
		            name="app:widget/lrw-video/lrw-video.tpl"
		        %}
			</section>
		</div>
		{%$datalist=0%}
		{%foreach from=$catalog item=val key=keys%}
			{%if $val@index >0 %}
				{%$datalist = $val@index%}
			{%/if%}
		{%/foreach%}
		{%foreach from=$catalog item=val key=keys%}
		<div class="item-wrap">
			{%widget
	            name="app:widget/lrw-video/lrw-video.tpl"
	        %}
		</div>
		{%/foreach%}
	</div>
	{%$datalist%}
{%/block%}