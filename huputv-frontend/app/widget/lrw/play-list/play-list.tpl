<script id="J_lrwListTpl" type="text/template">
	<@ _.each(datas,function(item,index){@>
		<div class="play-list-item <@ if(+item.status == 3){@> list-out<@}@>">
			<div class="play-list-left"><@=item.player_num@></div>
			<div class="play-list-mid">
				<div class="avatar">
					<img src="<@=item.header@>" alt="">
				</div>
				<div class="maskavatar"></div>
				<div class="play-list-text">
					<div class="player-nick"><@=item.nickname@></div>
					<@ if(+item.lightness){@>
					<span class="play-energy"><@=item.lightness@>瓦</span>
					<@}@>
					<div class="play-message">
						<@=item.height@>cm | <@=item.weight@>kg
						<@if (+item.total_win){@>
						 | 胜<@=item.total_win@>(<@=item.rate@>%)
						<@}@>
					</div>
				</div>
			</div>
			<div class="play-list-right">
				<@if (item.status == 3){@>
					<div class="list-giveup">
						已弃权
					</div>
				<@}else if(typeof type !== "undefined" && type == "top"){@>
					<@if (item.rank){@>
						<span class="rank-item play-list-number-<@=item.rank@>"><@=item.rank@></span>
					<@}else{@>
						<span class="rank-item play-list-number-<@=index + 1@>"><@=index + 1@></span>
					<@}@>
				<@}@>
			</div>
		</div>
	<@});@>
</script>
