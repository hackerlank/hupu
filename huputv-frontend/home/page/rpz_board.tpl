{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
	{%require name="common:widget/rpz-board/rpz-board.scss"%}
	{%require name="common:static/js/jquery/jquery-1.12.0.min.js"%}
	{%require name="home:static/rpz/rpz_board.js"%}
	{%script%}
	{%/script%}
{%/block%}

{%block name="content"%}
	<div class="rpz-board-wrap user-rpz-board" id="J-rpz-board">
		<div class="clearfix">
			<div class="day-board">
				<div class="board-title">
					<div class="tag">人品值日榜  {%$smarty.now|date_format:' %m/%d'%}</div>
					<a href="#" class="rule">
						规则说明
						{%widget
						    name="home:widget/rule/rule.tpl"
						%}
					</a>
				</div>
				{%if !empty($today_rank_list)%}
					<div class="rpz-list">
						<ul id="J_dayList">
						{%$rankCls = ["","no1","no2","no3"]%}
	                    {%$statusCls = ["tie","up","down"]%}
						{%foreach $today_rank_list as $val%}

							<li class="{%if $val.puid == $user.puid%}current-user{%/if%}">
								<div class="list-left">
									<span class="rank {%if intval($val.rank) < 4%}{%$rankCls[$val.rank]%}{%/if%}">
	                                        {%$val.rank%}
	                                    </span>
	                                    <span class="status {%$statusCls[$val.change]|default:'new'%}">
	                                        <em></em>
	                                    </span>
									<span class="thumb">
										<img src="{%$val.header%}" alt="">
									</span>
									<span class="name" title="{%$val.username%}">{%$val.username%}</span>
									<span class="result 
										{%if $val.score|string_format:'%d' >= 0%}
											num 
										{%else%}
											lose
										{%/if%}">{%$val.score%}</span>
								</div>
								<div class="list-right">
									<span class="result 
										{%if $val.win_score|string_format:'%d' >= 0%}
											win 
										{%else%}
											fail
										{%/if%}
									">{%if $val.win_score|string_format:'%d' > 0%}
											+{%$val.win_score%}
										{%else%}
											{%$val.win_score%}
										{%/if%}</span>
								</div>
							</li>
						{%/foreach%}
						</ul>
					</div>
				{%else%}
					<div class="empty-tips">暂无数据</div>
				{%/if%}
			</div>
		
			<div class="month-board">
				<div class="board-title">
					<div class="tag">人品值月榜  {%$smarty.now|date_format:' %m'%}</div>
					<a href="javascript:;" class="rule">
						规则说明
						{%widget
						    name="home:widget/rule/rule.tpl"
						%}
					</a>
				</div>
				{%if !empty($month_rank_list)%}
					<div class="rpz-list">
						<ul id="J_monthList">
						{%$rankCls = ["","no1","no2","no3"]%}
	                    {%$statusCls = ["tie","up","down"]%}
						{%foreach $month_rank_list as $val%}
						<li class="{%if $val.puid == $user.puid%}current-user{%/if%}">
							<div class="list-left">
								<span class="rank {%if intval($val.rank) < 4%}{%$rankCls[$val.rank]%}{%/if%}">
	                                        {%$val.rank%}
	                                    </span>
	                                    <span class="status {%$statusCls[$val.change]|default:'new'%}">
	                                        <em></em>
	                                    </span>
								<span class="thumb">
									<img src="{%$val.header%}" alt="">
								</span>
								<span class="name" title="{%$val.username%}">{%$val.username%}</span>
								
							</div>
							<div class="list-right">
								<span class="result 
										{%if $val.score|string_format:'%d' >= 0%}
											num 
										{%else%}
											lose
										{%/if%}
									">{%$val.score%}</span>
							</div>
						</li>

						{%/foreach%}
						</ul>
					</div>
				{%else%}
					<div class="empty-tips">暂无数据</div>
				{%/if%}

		</div>
		</div>
		{%if $today_rank_list_next==0 && $month_rank_list_next==0 %}

		{%else%}
		<a href="javascript:;" class="more-btn" id="J_moreRecord">
			<div class="arrow"><span></span></div>
			<span class="txt">向下加载更多</span>
		</a>
		<div id="N_Data" class="more-end" style="display:none;">加载完毕</div>
		{%/if%}
		<div class="clearfix">
			{%$rankCls = ["","no1","no2","no3"]%}
            {%$statusCls = ["tie","up","down"]%}
			{%$val = $user_predict_info%}
			<div class="today-user {%if intval($val.day_rank)>200 || intval($val.day_rank)==0%}hidden-user{%/if%}">
				<div class="rpz-list clearfix">
					<ul>
						<li>
							<div class="list-left">
								<span class="rank {%if intval($val.day_rank) < 4%}{%$rankCls[$val.day_rank]%}{%/if%}">
		                                    {%$val.day_rank%}
		                                </span>
		                                <span class="status">
		                                    <em></em>
		                                </span>
								<span class="thumb">
									<img src="{%$user.avatar.header_small%}" alt="">
								</span>
								<span class="name"title="{%if $user.username%}{%$user.username%} {%else%}{%$user.nickname%}{%/if%}">{%if $user.username%}{%$user.username%} {%else%}{%$user.nickname%}{%/if%}</span>
								<span class="{%if $val.score>=0%}num{%elseif $val.score<0%}lose{%/if%}">{%$val.score%}</span>
							</div>
							<div class="list-right">
								<span class="result 
										{%if $val.today_win_score|string_format:'%d' >= 0%}
											win 
										{%elseif $val.today_win_score|string_format:'%d' == 0%}
											equalZero
										{%else%}
											fail
										{%/if%}
									">{%if $val.today_win_score|string_format:'%d' > 0%}
											+{%$val.today_win_score%}
										{%else%}
											{%$val.today_win_score%}
										{%/if%}</span>
							</div>
						</li>
					</ul>
				</div>
					
			</div>
			<div class="month-user {%if intval($val.month_rank)>200 || intval($val.month_rank)==0%}hidden-user{%/if%}">
				<div class="rpz-list clearfix">
					<ul>
						<li>
							<div class="list-left">
								<span class="rank {%if intval($val.month_rank) < 4%}{%$rankCls[$val.month_rank]%}{%/if%}">
		                                    {%$val.month_rank%}
		                                </span>
		                                <span class="status">
		                                    <em></em>
		                                </span>
								<span class="thumb">
									<img src="{%$user.avatar.header_small%}" alt="">
								</span>
								<span class="name" title="{%if $user.username%}{%$user.username%} {%else%}{%$user.nickname%}{%/if%}">{%if $user.username%}{%$user.username%} {%else%}{%$user.nickname%}{%/if%}</span>
							</div>
							<div class="list-right">
								<span class="result 
										{%if $val.score|string_format:'%d' >= 0%}
											num 
										{%elseif $val.score|string_format:'%d' == 0%}
											equalZero
										{%else%}
											lose
										{%/if%}
									">{%$val.score%}</span>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<script id="day-tpl" type="text/template">
	    <@ _.each(datas, function(item,index) { @>
            <li class="<@ if(item.puid==HTV.getUserId){@>current-user<@}@>">
				<div class="list-left">
					<span class="rank  
						<@ if(item.rank == 1){ @>
						    no1
						<@ }else if(item.rank == 2){ @>
						    no2
						<@ }else if(item.rank == 3){ @>
						    no3
						<@ } @>
					">
						<@=item.rank@>
					</span>
					<span class="status 
						<@ if(item.change == 0){ @>
						    tie
						<@ }else if(item.change == 1){ @>
						    up
						<@ }else if(item.change == 2){ @>
						    down
						<@ }else{ @> 
							new
						<@ } @>
					">
						<em></em>
					</span>
					<span class="thumb">
						<img src="<@=item.header@>" alt="">
					</span>
					<span class="name" title="<@=item.username@>"><@=item.username@></span>
					<span class="result <@=(+item.score>=0)?'num':'lose'@>"><@=item.score@></span>
				</div>
				<div class="list-right">
					<span class="result <@=(+item.win_score>=0)?'win':'fail'@>"><@=item.win_score@></span>
				</div>
			</li>
        <@ }); @>
	</script>

	<script id="month-tpl" type="text/template">
	    <@ _.each(datas, function(item,index) { @>
            <li  class="<@ if(item.puid==HTV.getUserId){@>current-user <@}@>">
				<div class="list-left">
					<span class="rank  
						<@ if(item.rank == 0){ @>
						    no1
						<@ }else if(item.rank == 1){ @>
						    no2
						<@ }else if(item.rank == 2){ @>
						    no3
						<@ } @>
					">
						<@=item.rank@>
					</span>
					<span class="status 
						<@ if(item.change == 0){ @>
						    tie
						<@ }else if(item.change == 1){ @>
						    up
						<@ }else if(item.change == 2){ @>
						    down
						<@ }else{ @> 
							new
						<@ } @>
					">
						<em></em>
					</span>
					<span class="thumb">
						<img src="<@=item.header@>" alt="">
					</span>
					<span class="name" title="<@=item.username@>"><@=item.username@></span>
					
				</div>
				<div class="list-right">
					<span class="result <@=(+item.score>=0)?'num':'lose'@>"><@=item.score@></span>
				</div>
			</li>
        <@ }); @>
	</script>
{%/block%}