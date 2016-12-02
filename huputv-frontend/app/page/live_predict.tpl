{%extends file="app/page/layout.tpl"%}

{%block name="title"%}攒人品{%/block%}

{%block name="head_static"%}
    {%require name="app:static/predict/predict.scss"%}
    {%require name="app:static/predict/predict.js"%}
 	 {%script%}     
        !function(win){
            var HTV = win.HTV = {};
            // 用户id
            HTV.getUserId = "{%$user_predict_info.puid%}" || "";
            
            // 用户登陆状态
            HTV.isLogin = {%intval($is_login)%};

            // 用户胜率
            HTV.magnification='{%$user_predict_info.magnification%}';
            //平台
            HTV.platform='{%$platform%}';

            HTV.roomID = '{%$room_id%}';
            // 跳转登录
            HTV.jumpLogin = function() {
                {%if !$is_login && !empty($login_url)%}
                    window.location.href = '{%$login_url%}';
                {%/if%}
            };


        }(window);
    {%/script%}
{%/block%}

{%block name="content"%}
<div class="rpz_main" id="J_rpz_main">
	<div id="J_rpz_main_refresh">
		<section class="rpz_wrap">
			<a class="rpz_core" href="{%$user_predict_info.my_list_url%}">
				<div class="rpz_core_left">
					<span class="rpz_text">我的人品值</span><span class="rpz_total_num">{%$user_predict_info.score%}</span>
				</div>
				<div class="rpz_core_right"> > </div>
			</a>
			<a class="rpz_title_rank" href="/m/predict/ranking">
				<div class="rpz_rank_left"> 人品值排行</div>			
				<div class="rpz_rank_right"> > </div>
			</a>
		</section>
		{%if !empty($list)%}
		<section id="rpz_predict" class="rpz_predict_wrap">
			{%$number=0%}

			{%foreach $list as $item%}
				{%if $item.status ==0 %}
					{%$number = $number+1%}
				{%/if%}
			{%/foreach%}		

			<div class="rpz_title">本场攒人品 &nbsp;&nbsp;(可参与题目：<span>{%$number%}</span>)</div>
				<ul class="rpz_list">

					{%$number=22%}
					

					{%foreach $list as $item%}														
							
						<li class="rpz_predict_item" data-role="
								
									">
							<div class="rpz_predict_head">
								<div class="rpz_predict_item_left">
									<div class="rpz_predict_list_title">{%$item.title%}(PR &nbsp;{%$item.score%})</div>								
									<div class="rpz_predict_selected">
										{%if $item.status ==2 && $item.user_option !=0%}
											你的选择是“{%$item.user_option%}”,开奖结果“{%$item.right_option%}”
										{%/if%}
									</div>
									
								</div>						
								<div class="rpz_predict_item_right">
									{%if $item.status==0%}
										<span class="voting">进行中</span>
									{%else if $item.status==1 %}
										<span class="ready">待开奖</span>
									{%else if $item.status==2 %}
										<div class="ward-warp">
											<div class="ward">已开奖</div>
											<div class="ward-rpz 
												{%if $item.status==2 && $item.user_option !=0 &&$item.user_option==$item.right_option %}
													win
												{%/if%}
												">
												{%if $item.user_option !=0 && $item.user_option == $item.right_option %}
													RP+{%$item.score%}
												{%else if $item.user_option !=0 && $item.user_option != $item.right_option %}
													RP-{%$item.score%}
												{%/if%}
												</div>
										</div>
									{%else if $item.status == 3%}
										<span class="disappear">已流盘</span>
									{%/if%}
								</div>
							</div>
							<div class="rpz_predict_tap">
								<ul class="rpz_predict_option">
									{%foreach $item.option as $key%}								
										<li class="rpz_option_item 
										{%if $item.status == 0 && $item.user_option ==0%} 
											unselected										
										{%else if $key.option_id == intval($item.right_option) %}
											correct
										{%else if $key.option_id == intval($item.user_option) %}
											selected
										{%/if%}
											" data-id="{%$item.id%}" data-score="{%$item.score%}" data-status="{%$item.status %}" data-option="{%$key.option %}" data-sid="{%$key.option_id%}">
											{%$key.option%}
										</li>
									{%/foreach%}
								</ul>
							</div>
						</li>
					{%/foreach%}	
				</ul>
		</section>	
		{%/if%}
	</div>
</div>	
{%/block%}
