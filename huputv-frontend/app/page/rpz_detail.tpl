{%extends file="app/page/layout.tpl"%}

{%block name="title"%}人品值明细{%/block%}

{%block name="head_static"%}
	{%require name="app:static/rpz-detail/detail.scss"%}
	{%require name="app:static/rpz-detail/detail.js"%}
{%/block%}

{%block name="content"%}
    <section class="rpz-wrap" id="J-rpz-detail">
    	<header class="rpz-header">
    		可查询最近3个月的人品值记录
    	</header>
    	<div class="rpz-detail">
    		<ul class="rpz-detail-wrap" id="J-rpz-detail-wrap" data-next="">
    			
    		</ul>
    		<div class="show-more"  id= "J-show-more" style="display: none;">
    			<span class="more-btn"><em></em>向上滑动查看更多</span>
    		</div>
    	</div>
    </section>
    <script id="J_lrwRpzDetailTpl" type="text/template">
		<@ _.each(datas,function(item,index){@>
			<li class="item  <@if (index%2 == 1){@> odd <@ }@>">
				<div class="item-title"><@=item.title@></div>
				<div class="item-date">
					<div class="item-time"><@=item.create_time@></div>
					<div class="zrp-score">
                        <@if (item.rp>0){@>
						   <span class="win">+<@=item.rp@>RP</span>
                        <@}else {@>
						   <span class="lose"><@=item.rp@>RP</span>
                        <@}@>
					</div>
				</div>
			</li>
		<@});@>
	</script>
{%/block%}