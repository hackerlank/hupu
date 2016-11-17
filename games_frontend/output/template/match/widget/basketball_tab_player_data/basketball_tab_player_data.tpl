<section class="player-data mod-rank swiper-slide swiper-no-swiping" id="J-player-data">
<script id="J-player-data-tpl" type="text/template">
		<@ if(!_.isEmpty($(datas))){ @>
		<div class="nav">
			<ul>
				<@ $(datas).each(function(index,item) { @>
				<li <@ if(index==0){ @> class="active" <@ } @>><a href="javascript:void(0);"><@=item.name@></a></li>
				<@ }); @>
			</ul>
		</div>
		<ul class="main">
			<@ $(datas).each(function(index,item) { @>
			<li>
				<table class="mod-title title">
					<thead>
						<tr>
							<td width="66%" class="type"><@=item.name@>排行榜</td>
							<td width="20%" align="center">球队</td>
							<td width="14%" align="center">数据</td>
						</tr>
					</thead>
				</table>
				<table class="mod-table">
					<tbody>
						<@ $(item.data).each(function(subIndex,subItem){ @>
						<@ if(GM.match == "nba"){ @>
						<tr class="link" link="kanqiu://nba/nba/player/<@=subItem.player_id@>">
						<@ }else{ @>
							<@ if(isH5url){ @>
							<tr class="link" link="/cba/playerPage?client=<@=GM.client@>&player_id=<@=subItem.player_id@>">
							<@ }else{ @>
							<tr class="link" link="kanqiu://cba/cba/player/<@=subItem.player_id@>">
							<@ } @>
						<@ } @>
							<td width="66%">
								<@ if(subItem.rank == 1){ @>
								<span class="red num"><@=subItem.rank@></span>
								<@ }else{ @>
								<span class="num"><@=subItem.rank@></span>
								<@ } @><span class="logo"><img class="lazy" data-original="<@=subItem.player_header@>?t=<@=index@><@=subIndex@>" /><@if(GM.night){ @><span class="mask"></span><@ } @></span>
								<span class="detail">
									<span class="name"><@=subItem.player_name@></span>
									<span class="others">
										<@=subItem.pts@>分
										<@=subItem.reb@>板
										<@=subItem.asts@>助
									</span>
								</span>
							</td>
							<td width="20%" align="center"><@=subItem.team_name@></td>
							<td width="14%" align="center"><@=subItem.val@></td>
						</tr>
						<@ }); @>
						<@ if(GM.match == "nba"){ @>
							<@if(item.is_more){@>
							<tr class="last-tr">
								<td colspan="3" align="center">
									<span class="view-all link all-link" link="/nba/getDailyPlayer" data-type="<@=item.en@>">查看全部 ></span>
									<!-- <span class="rules"><i <@if(!GM.night){ @> class="day-icon" <@ }else{ @> class="night-icon" <@ } @>></i> 规则</span> -->
								</td>
							</tr>
							<@ } @>
							<@if(item.data.length == 0){@>
								<tr class="last-tr">
									<td colspan="3" align="center">
										暂无数据
									</td>
								</tr>
							<@ } @>
						<@ }else{ @>
						<tr></tr>
						<@ } @>
					</tbody>
				</table>
			</li>
			<@ }); @>
		</ul>
		<@ }else{ @>
			<div class="main">
				<div class="no-data">暂无球员数据</div>
			</div>
		<@ } @>
	</script>
</section>
