<div class="match-index" id="J_matchIndex">
</div>
<script id="J_lrwListTpl" type="text/template">
<@ _.each(datas,function(item,index){@>
	<div class="play-list-item <@ if(item.status != 1){@> list-out<@}@>">
		<div class="play-list-left"><@=item.player_id@></div>
		<div class="play-list-mid">
			<div class="avatar">
				<img src="<@=item.header@>" alt="">
			</div>
			<div class="play-list-text">
				<div class="player-nick"><@=item.nickname@></div>
				<@ if(item.energy){@>
				<span class="play-energy"><@=item.energy@>瓦</span>
				<@}@>
				<div class="play-message">
					<@=item.height@>cm|<@=item.weight@>kg|胜<@=item.total_win@>(<@=item.rate@>)
				</div>
			</div>
		</div>
		<div class="play-list-right">
			<@if (typeof type !== "undefined" && type == "top"){@>
				<span class="rank-item play-list-number-<@=index + 1@>"><@=index + 1@></span>
			<@}@>
		</div>
		<!--
	    <@if (item.statu==0 || item.status==2){@>
			<div class="play-list-right">
				<span class="rank-item
				<@if(item.rank==1){@>
					play-list-number-1
				<@}else if(item.rank==2){@>
					play-list-number-2
				<@}else if(item.rank==3){@>
					play-list-number-3
				<@}@>"
				><@=item.rank@></span>
			</div>
		<@}else if(item.status==3){@>
			<div class="play-list-right list-giveup">
				已弃权
			</div>
		<@}else if(item.status==4){@>
			<div class="play-list-right list-follow J-play-list-follow">
				订阅
			</div>
		<@}@>
	-->
	</div>
<@});@>
</script>
