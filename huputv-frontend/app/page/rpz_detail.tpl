{%extends file="app/page/layout.tpl"%}

{%block name="title"%}人品值明细{%/block%}

{%block name="head_static"%}
	{%require name="app:static/rpz-detail/detail.scss"%}
	{%require name="app:static/rpz-detail/detail.js"%}
{%/block%}

{%block name="content"%}
    <section class="rpz-wrap" id="J-rpz-detail">
    	<header class="rpz-header">
    		可查询最近3个月饿人品值记录
    	</header>
    	<div class="rpz-detail">
    		<ul class="rpz-detail-wrap" id="J-rpz-detail-wrap">
    			<li class="item">
    				<div class="item-title">攒人品-[直播间名称可能有十六个字那么多的]参与攒人品</div>
    				<div class="item-date">
    					<div class="item-time">03/19  11:07</div>
    					<div class="zrp-score">
    						<span class="win">+100RP</span>
    						<span class="lose" style="display:none">-100RP</span>
    					</div>
    				</div>
    			</li>
    			<li class="item odd">
    				<div class="item-title">攒人品-[直播间名称可能有十六个字那么多的]参与攒人品</div>
    				<div class="item-date">
    					<div class="item-time">03/19  11:07</div>
    					<div class="zrp-score">
    						<span class="win" style="display:none">+100RP</span>
    						<span class="lose">-100RP</span>
    					</div>
    				</div>
    			</li>
    		</ul>
    		<div class="show-more" style="display: none;">
    			<span class="more-btn"><em></em>向上滑动查看更多</span>
    		</div>
    	</div>
    </section>
    <script id="J_lrwRpzDetailTpl" type="text/template">
		<@ _.each(datas,function(item,index){@>
			<li class="item">
				<div class="item-title">攒人品-[直播间名称可能有十六个字那么多的]参与攒人品</div>
				<div class="item-date">
					<div class="item-time">03/19  11:07</div>
					<div class="zrp-score">
						<span class="win">+100RP</span>
						<span class="lose" style="display:none">-100RP</span>
					</div>
				</div>
			</li>
		<@});@>
	</script>
{%/block%}