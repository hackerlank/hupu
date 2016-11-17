{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    <!-- {%require name="home:static/followList/followList.scss"%} -->
	{%require name="home:static/purse/purse.scss"%}
	{%require name="common:static/js/jquery/jquery-1.12.0.min.js"%}
	{%require name="home:static/purse/purse.js"%}

	{%script%}
	{%/script%}
{%/block%}

{%block name="content"%}
	<div class="myfollow-wrap" id="J-myfollow-wrap">
		<div class="user-content">
			{%widget
	            name="home:widget/user-nav/user-nav.tpl"
	            index=2
	        %}
	        <div class="purse-main">
		        <div class="top-content">
			        <div class="hupu-coin">
			            <div class="top-inner">
			            	<div class="clearfix">
			            		<div class="fl">
				        			<span class="span_1">虎扑币余额 </span><span class="span_2">{%$balance["6"]%}</span>
				        		</div>
				        		<a href="{%$recharge_url%}" target="_blank" id="rechange">充值</a>
				        	</div>
				        	<p class="text">虎扑币可用于购买不同价值的礼物赠送给喜欢的主播以及购买金豆。</p>
			        	</div>
			        </div>
			        <div class="goldbean">
			            <div class="top-inner">
							<div class="clearfix">
								<div class="fl">
				        			<span class="span_1">金豆余额</span> <span class="span_2">{%$balance["1"]%}</span>
				        		</div>
				        		<a href="{%$beans_recharge_url%}" id="buy">购买</a>
				        	</div>
				        	<p class="text">金豆可用于赠送给喜欢的主播，提升主播的经验等级以及参与直播间的互动竞猜。</p>
				        	<p>金豆可由虎扑币购买，购买比率为1:1。</p>
			        	</div>
			        </div>

		        </div>

		        <div class="tradingrecord">
		            <div class="trading-top">
			        	<span class="span_3">交易记录</span><span class="span_4">可查询最近5个月的交易记录</span>
			        	<div class="two-hr">
				        	<hr class="purse-hr1">
				        	<hr class="purse-hr2">
			        	</div>
		        	</div>

		        	<div class="records-table">
		        		<div class="tab-con" id="J_tab">
		        			<span class="tab coin-tab active" id="J_coinTab">虎扑币</span>
		        			<span class="sep"></span>
							<span class="tab bean-tab" id="J_beanTab">金豆</span>
		        		</div>
		        		<div class="table-wrap">
		        			<div class="table-con coin-tablecon" id="J_coinWrap">
		        				<table class="coin-table" id="J_coinTable">

		        				</table>
								<div class="table-footer">
									<a href="javascript:;" class="disabled" id="J_coinPrev">上一页</a>
									<select name="" id="J_coinSelect">
										<option value="1">第1页</option>
									</select>
									<a href="javascript:;" id="J_coinNext">下一页</a>
								</div>
		        			</div>

		        			<div class="table-con bean-tablecon" id="J_beanWrap">
		        				<table class="bean-table" id="J_beanTable">


		        				</table>
								<div class="table-footer">
									<a href="javascript:;" class="disabled" id="J_beanPrev">上一页</a>
									<select name="" id="J_beanSelect">
										<option value="1">第1页</option>
									</select>
									<a href="javascript:;" id="J_beanNext">下一页</a>
								</div>
		        			</div>

		        		</div>

		        	</div>
		        </div>
	        </div>
		</div>

	</div>

	<script id="recordTpl" type="text/template">
		<@ _.each(datas, function(item,index) { @>
			<tr>
				<td class="td-time"><@=item.timestr@></td>
				<td class="td-title">
					<@=item.title@>
				</td>
				<td class="td-result <@ if(item.direction == 1){ @>plus<@ }else{@>minus<@ }@>">
					<@=item.record@>
				</td>
			</tr>
		<@ }); @>
	</script>
{%/block%}
