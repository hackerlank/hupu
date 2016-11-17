<section class="team-rank swiper-slide swiper-no-swiping" id="J-team-rank">
	<div class="main">
	{%if !empty($rankings)%}
	{%widget
        name="match:widget/vs_nba/vs_nba.tpl"
    %}
    {%/if%}

	{%if !empty($ranking)%}
	<table class="mod-title">
		<thead>
			<tr>
				<td width="32%" class="type">东部排行</td>
				<td width="8%" align="center">胜</td>
				<td width="8%" align="center">负</td>
				<td width="18%" align="center">胜场差</td>
                <td width="10%" align="center">胜率</td>
				<td width="14%" align="center">近况</td>
			</tr>
		</thead>
	</table>
	<table class="mod-table">
		<tbody>
		{%foreach $ranking["east"] as $val%}
		<tr class="link" link="kanqiu://nba/nba/team/{%$val.tid%}">
			<td width="32%">
				{%if $val@index+1<=8%}
				<span class="red num">{%$val@index+1%}</span>
				{%else%}
				<span class="num">{%$val@index+1%}</span>
				{%/if%}<span class="logo"><img class="lazy" data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$val.tid%}_2x_alpha.png?t={%$val@index%}" width="28" /></span><span class="name">{%$val.name%}</span>
			</td>
			<td width="8%" align="center">{%$val.win%}</td>
			<td width="8%" align="center">{%$val.lost%}</td>
			<td width="18%" align="center">{%$val.gb%}</td>
            <td width="10%" align="center">{%$val.win_rate%}%</td>
			<td width="14%" align="center">{%$val.strk%}</td>
		</tr>
		{%/foreach%}
		</tbody>
	</table>
	<table class="mod-title title">
		<thead>
			<tr>
				<td width="32%" class="type">西部排行</td>
				<td width="8%" align="center">胜</td>
				<td width="8%" align="center">负</td>
				<td width="18%" align="center">胜场差</td>
                <td width="10%" align="center">胜率</td>
				<td width="14%" align="center">近况</td>
			</tr>
		</thead>
	</table>
	<table class="mod-table west-table">
		<tbody>
		{%foreach $ranking["west"] as $val%}
		<tr class="link" link="kanqiu://nba/nba/team/{%$val.tid%}">
			<td width="32%">
				{%if $val@index+1<=8 %}
				<span class="red num">{%$val@index+1%}</span>
				{%else%}
				<span class="num">{%$val@index+1%}</span>
				{%/if%}<span class="logo"><img class="lazy"  data-original="//b1.hoopchina.com.cn/games/teams/nba/1_{%$val.tid%}_2x_alpha.png?t={%$val@index%}" width="28" /><span class="name">{%$val.name%}</span>
			</td>
			<td width="8%" align="center">{%$val.win%}</td>
			<td width="8%" align="center">{%$val.lost%}</td>
			<td width="18%" align="center">{%$val.gb%}</td>
            <td width="10%" align="center">{%$val.win_rate%}%</td>
			<td width="14%" align="center">{%$val.strk%}</td>
		</tr>
		{%/foreach%}
		</tbody>
	</table>
	{%else%}
	<div class="no-data">
		暂无排行数据
	</div>
	{%/if%}
	</div>
</section>
