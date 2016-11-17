<div class="region_box">
	<div class="title">
		<span class="title_a {%if $base_info.conference == "W"%}active{%/if%}">东部</span>
		<span class="title_b {%if $base_info.conference == "E"%}active{%/if%}">西部</span>
	</div>
	<table class="area_table east_table itinerary_table" {%if $base_info.conference == "W"%}style="display:none;"{%/if%}>
		<tr class="table_th">
			<th width="25">排名</th>
			<th width="55">球队</th>
			<th width="20">胜</th>
			<th width="25">负</th>
			<th width="25">胜差</th>
			<th>胜率</th>
		</tr>
		{%foreach from=$standing.east item=val%}
			<tr class="{%if $val.team_name == $base_info.name%}on{%/if%} {%if $val@index%2 ==0%}bg_color{%/if%}">
				<td>
					{%if $val.team_name == $base_info.name%}
					<span class="bg_box">{%$val@index+1%}</span>
					{%else%}
					{%$val@index+1%}
					{%/if%}
				</td>
				<td><a href="{%$val.team_link%}">{%$val.team_name%}</a></td>
				<td>{%$val.win%}</td>
				<td>{%$val.lost%}</td>
				<td>{%$val.diff|string_format:"%.1f"%}</td>
				<td>{%$val.win_rate|string_format:"%.1f"%}%</td>
			</tr>
		{%/foreach%}
	</table>
	<table class="area_table west_table itinerary_table" {%if $base_info.conference == "E"%}style="display:none;"{%/if%}>
		<tr class="table_th">
			<th width="25">排名</th>
			<th width="55">球队</th>
			<th width="20">胜</th>
			<th width="25">负</th>
			<th width="25">胜差</th>
			<th>胜率</th>
		</tr>
		{%foreach from=$standing.west item=val%}
			<tr class="{%if $val.team_name == $base_info.name%}on{%/if%} {%if $val@index%2 ==0%}bg_color{%/if%}">
				<td>
					{%if $val.team_name == $base_info.name%}
					<span class="bg_box">{%$val@index+1%}</span>
					{%else%}
					{%$val@index+1%}
					{%/if%}
				</td>
				<td><a href="{%$val.team_link%}">{%$val.team_name%}</a></td>
				<td>{%$val.win%}</td>
				<td>{%$val.lost%}</td>
				<td>{%$val.diff|string_format:"%.1f"%}</td>
				<td>{%$val.win_rate|string_format:"%.1f"%}%</td>
			</tr>
		{%/foreach%}
	</table>
	<table class="lastFive itinerary_table">
		<tr>
			<td width="22%"></td>
			<td width="44%"><b>未来5场</b></td>
			<td class="red_color_font"><a href="/schedule/{%$base_info.eng_name|lower%}">{%$base_info.name%}赛程</a></td>
		</tr>
		{%if !empty($next_five)%}
			{%foreach from=$next_five item=val%}
				<tr {%if $val@index%2 ==0%}class="bg_color"{%/if%}>
					<td>{%date('m-d', strtotime($val.time))%}</td>
					<td><a href="{%$val.home_link%}">{%$val.away_name%}</a>&nbsp;vs&nbsp;<a href="{%$val.away_link%}">{%$val.home_name%}</a></td>
					<td><a href="{%$val.boxscore_link%}">比赛前瞻</a></td>
				</tr>
			{%/foreach%}
		{%else%}
			<tr class="bg_color">
				<td>&nbsp;</td>
				<td>暂无比赛</td>
				<td>&nbsp;</td>
			</tr>
		{%/if%}
	</table>
	<table class="nextFive itinerary_table">
		<tr>
			<td width="22%"></td>
			<td width="44%"><b>最近5场</b></td>
			<td></td>
		</tr>
		{%if !empty($last_five)%}
			{%foreach from=$last_five item=val%}
				<tr {%if $val@index%2 ==0%}class="bg_color"{%/if%}>
					<td>{%date('m-d', strtotime($val.time))%}</td>
					<td><a href="{%$val.home_link%}">{%$val.away_name%}</a>&nbsp;vs&nbsp;<a href="{%$val.away_link%}">{%$val.home_name%}</a></td>
					<td><a href="{%$val.boxscore_link%}">数据统计</a></td>
				</tr>
			{%/foreach%}
		{%else%}
			<tr class="bg_color">
				<td>&nbsp;</td>
				<td>暂无比赛</td>
				<td>&nbsp;</td>
			</tr>
		{%/if%}
	</table>
	{%if !empty($video)%}
		<div class="video_box">
		    <div class="title">
		    		<a class="more" target="_blank" href="http://v.liangle.com/nba/tag/{%$base_info.name%}">更多</a>
		        {%$base_info.name%}视频
		    </div>
		    <ul>
		    	{%foreach from=$video item=val%}
		        <li style="background-color: rgb(255, 255, 255);">
		            <span class="a_1">
		                <a title="等等" href="{%$val.url%}" target="_blank">
		                    <img src="{%$val.img%}" />
		                </a>
		            </span>
		            <span class="a_2">
		                <p>
		                    <a href="{%$val.url%}" target="_blank">{%$val.title%}
		                    </a>
		                </p>
		                <div class="num">
		                    播放：{%$val.hits%}次
		                </div>
		            </span>
		        </li>
		  		{%/foreach%}
		    </ul>
		</div>
	{%/if%}
</div>
