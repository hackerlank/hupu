{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
	{%require name="home:static/buying_guide/buying_guide.scss"%}
	{%require name="common:static/js/jquery/jquery-1.12.0.min.js"%}
	{%require name="home:static/followList/followList.js"%}
	{%require name="home:static/buying_guide/buying_guide.js"%}

	<script>
		var restCoin = '{%$balance["6"]%}',
			isEnough = '{%$balance["6"] > $bears_recharge_step[$bears_recharge_step|count - 1]%}',
			recharge_url = '{%$recharge_url%}',
			referer = '{%$referer%}';
			
	</script>
{%/block%}

{%block name="content"%}
	 <div class="myfollow-wrap" id="J-myfollow-wrap">
		
	    <div class="buying_goldbeans">
	        <div class="buying-guide-top">
        	<span class="span_3">购买金豆</span>
        	<div class="two-hr">
	        	<hr class="purse-hr1">
	        	<hr class="purse-hr2">
        	</div>
    	    </div>
		    <div class="buying_top">
			    <div class="top_content">
			        <div class="buying_top_l">
				        <span class="span_1">金豆余额 </span>
				        <span class="span_2" id="J_bean">{%$balance["1"]%}</span>
				    </div>
				    <div class="buying_top_r">
				        <span class="span_1">虎扑币余额 </span><span class="span_2" id="J_coin">{%$balance["6"]%}</span>
				    </div>
				</div>
			    <p>说明：您可以使用虎扑币购买金豆，虎扑币与金豆的购买比例为1:1，即1个虎扑币可购买1个金豆</p>
		    </div>
		  <div class="buy_choise">
		  	<form action="" method="post" autocomplete="off">
			  	<p>请选择需要购买的金豆数额</p>
			  	<hr />
			  	<div class="choise_content">
					<ul id="J-get-beans">
					{%foreach $bears_recharge_step as $val%}
					<li class="{%if ($val > $balance["6"])%}disabled{%/if%}">
						<label for="beans_{%$val%}">
							<input 
								name = "beans" 
								type = "radio" 
								value = "{%$val%}" 
								class = "c_radio" 
								id = "beans_{%$val%}" 
								data-index = "0"
								{%if ($val > $balance["6"])%}disabled{%/if%}
							/>
							{%$val%}金豆
						</label>
					</li>
					{%/foreach%}
					</ul>
			  	</div>
			  	<div class="buttons">
				   	<button type="reset"  id="cancel">重置</button>
				   	<button type="submit" id="confirm">确认购买</button>
				   	<span class="error-tips">
				   		
				   	</span>
			  	</div>
			</form>
		  </div>  
		</div>
		
	</div>
{%/block%}