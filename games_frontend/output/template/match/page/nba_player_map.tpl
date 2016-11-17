{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}{%/block%}
{%block name="head_static"%}
<script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
{%require name="common:static/js/zepto/zepto.js"%}
{%require name="match:static/nba_player_map/nba_player_map.scss"%}
{%require name="match:static/nba_player_map/nba_player_map.js"%}
{%script%}
		window.GM = {
            "client": "{%$client|f_escape_js%}" || "x",
            "islogin": !!parseInt("{%$is_login|f_escape_js%}", 10),
            "night": !!parseInt("{%$night|f_escape_js%}", 10),
            "gid": "{%$smarty.get.gid|f_escape_js%}" || 1,
            "player_id": "{%$smarty.get.player_id|f_escape_js%}" || 1
        };
    {%/script%}
{%/block%}
{%block name="content"%}
<section class="iwidth"></section>
<section class="map-wrap" id="J-map-wrap">
<i class="close" id="J-close"></i>
<a href="javascript:void(0);" class="header link" link="kanqiu://nba/nba/player/{%$player_info.player_id|f_escape_xml%}">
<div class="head">
<img src="{%$player_info.player_header|f_escape_xml%}" alt="">
{%if !empty($night)%}
<span class="mask"></span>
{%/if%}
</div>
<div class="name">{%if !empty($player_info.player_name)%}{%$player_info.player_name|f_escape_xml%}{%else%}{%$player_info.player_enname|f_escape_xml%}{%/if%}<span class="line">&rsaquo;</span></div>
</a>
<section class="tabs" id="J-tabs">
{%$loop=$sections%}
{%section name=loop loop=$loop%}
<span>
<a href="javascript:void(0);" {%if $section_status[$smarty.section.loop.index] == 0%} class="absent" {%/if%} data-section="{%$smarty.section.loop.index+1%}">
{%if $smarty.section.loop.index+1 > 4%}
加{%$smarty.section.loop.index-3%}
{%else%}
{%$smarty.section.loop.index+1%}
{%/if%}
</a>
</span>
{%/section%}
<span class="active"><a href="javascript:void(0);" data-section="0">全场</a></span>
</section>
<section id="J-datas-wrap">
<section class="all-data">
<section class="datas datas-top">
<ul>
<li>
<div class="key">时间</div>
<div class="value">{%$player_score.playerStats.ti|f_escape_xml%}</div>
</li>
<li>
<div class="key">得分</div>
<div class="value">{%$player_score.playerStats.pts|f_escape_xml%}</div>
</li>
<li>
<div class="key">篮板</div>
<div class="value">{%$player_score.playerStats.oreb+$player_score.playerStats.dreb%}</div>
</li>
<li>
<div class="key">助攻</div>
<div class="value">{%$player_score.playerStats.asts|f_escape_xml%}</div>
</li>
<li>
<div class="key">抢断</div>
<div class="value">{%$player_score.playerStats.stl|f_escape_xml%}</div>
</li>
<li>
<div class="key">盖帽</div>
<div class="value">{%$player_score.playerStats.blk|f_escape_xml%}</div>
</li>
<li>
<div class="key">+/-</div>
<div class="value">{%$player_score.playerStats.net_points|f_escape_xml%}</div>
</li>
</ul>
</section>
<section class="datas-map">
{%if !empty($night)%}
<img src="//w10.hoopchina.com.cn/hybrid/static/match/nba_player_map/img/map_bg_night_7eb2008.jpg" alt="">
{%else%}
<img src="//w10.hoopchina.com.cn/hybrid/static/match/nba_player_map/img/map_bg_d76d57c.jpg" alt="">
{%/if%}
{%if !empty($player_score.fgStats)%}
{%foreach $player_score.fgStats as $val%}
<span {%if $val.is_get == 1%} class="dot get" {%else%} class="dot notget" {%/if%} style="left: {%$val.shot_coord_x|f_escape_xml%}px; top: {%$val.shot_coord_y|f_escape_xml%}px;"></span>
{%/foreach%}
{%/if%}
</section>
<section class="datas datas-top">
<ul>
<li>
<div class="key">投篮</div>
<div class="value">{%$player_score.playerStats.fg_made|f_escape_xml%}/{%$player_score.playerStats.fg_made+$player_score.playerStats.fg_missed%}</div>
</li>
<li>
<div class="key">命中</div>
<div class="value">
{%if $player_score.playerStats.fg_missed == 0 && $player_score.playerStats.fg_made != 0%}
100{%else if $player_score.playerStats.fg_made == 0%}0{%else%}{%($player_score.playerStats.fg_made/($player_score.playerStats.fg_made+$player_score.playerStats.fg_missed)*100)|string_format:"%0.1f"%}{%/if%}%</div>
</li>
<li>
<div class="key">跳投</div>
<div class="value">{%$player_score.playerStats.jumpshot_made|f_escape_xml%}/{%$player_score.playerStats.jumpshot_made+$player_score.playerStats.jumpshot_missed%}</div>
</li>
<li>
<div class="key">扣篮</div>
<div class="value">{%$player_score.playerStats.dunk_made|f_escape_xml%}/{%$player_score.playerStats.dunk_made+$player_score.playerStats.dunk_missed%}</div>
</li>
<li>
<div class="key">上篮</div>
<div class="value">{%$player_score.playerStats.layup_made|f_escape_xml%}/{%$player_score.playerStats.layup_made+$player_score.playerStats.layup_missed%}</div>
</li>
<li>
<div class="key">补篮</div>
<div class="value">{%$player_score.playerStats.tipin_made|f_escape_xml%}/{%$player_score.playerStats.tipin_made+$player_score.playerStats.tipin_missed%}</div>
</li>
<li>
<div class="key">勾手</div>
<div class="value">{%$player_score.playerStats.hook_made|f_escape_xml%}/{%$player_score.playerStats.hook_made+$player_score.playerStats.hook_missed%}</div>
</li>
</ul>
</section>
</section>
<script type="text/template" id="J-datas-tpl">
				<section class="datas datas-top">
					<ul>
						<li>
							<div class="key">时间</div>
							<div class="value"><@=player_score.playerStats.ti@></div>
						</li>
						<li>
							<div class="key">得分</div>
							<div class="value"><@=player_score.playerStats.pts@></div>
						</li>
						<li>
							<div class="key">篮板</div>
							<div class="value"><@=player_score.playerStats.oreb + player_score.playerStats.dreb@></div>
						</li>
						<li>
							<div class="key">助攻</div>
							<div class="value"><@=player_score.playerStats.asts@></div>
						</li>
						<li>
							<div class="key">抢断</div>
							<div class="value"><@=player_score.playerStats.stl@></div>
						</li>
						<li>
							<div class="key">盖帽</div>
							<div class="value"><@=player_score.playerStats.blk@></div>
						</li>
						<li>
							<div class="key">+/-</div>
							<div class="value"><@=player_score.playerStats.net_points@></div>
						</li>
					</ul>
				</section>
				<section class="datas-map">
					<@if(GM.night){@>
					<img src="//w10.hoopchina.com.cn/hybrid/static/match/nba_player_map/img/map_bg_night_7eb2008.jpg" alt="">
					<@}else{@>
					<img src="//w10.hoopchina.com.cn/hybrid/static/match/nba_player_map/img/map_bg_d76d57c.jpg" alt="">
					<@}@>
					<@$(datas).each(function(index, item){@>
					<span <@if(item.is_get == 1){@> class="dot get" <@}else{@> class="dot notget" <@}@> style="left: <@=item.shot_coord_x@>px; top: <@=item.shot_coord_y@>px;"></span>
					<@})@>
				</section>
				<section class="datas datas-top">
					<ul>
						<li>
							<div class="key">投篮</div>
							<div class="value"><@=player_score.playerStats.fg_made@>/<@=player_score.playerStats.fg_made+player_score.playerStats.fg_missed@></div>
						</li>
						<li>
							<div class="key">命中</div>
							<div class="value">
							<@if(player_score.playerStats.fg_missed == 0 && player_score.playerStats.fg_made != 0 ){@>100<@}else if(player_score.playerStats.fg_made == 0 && player_score.playerStats.fg_made == 0){@>0<@}else{@><@=parseFloat(player_score.playerStats.fg_made/(player_score.playerStats.fg_made+player_score.playerStats.fg_missed)*100).toFixed(1) @><@}@>%
							</div>
						</li>
						<li>
							<div class="key">跳投</div>
							<div class="value"><@=player_score.playerStats.jumpshot_made@>/<@=player_score.playerStats.jumpshot_made+player_score.playerStats.jumpshot_missed@></div>
						</li>
						<li>
							<div class="key">扣篮</div>
							<div class="value"><@=player_score.playerStats.dunk_made@>/<@=player_score.playerStats.dunk_made+player_score.playerStats.dunk_missed@></div>
						</li>
						<li>
							<div class="key">上篮</div>
							<div class="value"><@=player_score.playerStats.layup_made@>/<@=player_score.playerStats.layup_made+player_score.playerStats.layup_missed@></div>
						</li>
						<li>
							<div class="key">补篮</div>
							<div class="value"><@=player_score.playerStats.tipin_made@>/<@=player_score.playerStats.tipin_made+player_score.playerStats.tipin_missed@></div>
						</li>
						<li>
							<div class="key">勾手</div>
							<div class="value"><@=player_score.playerStats.hook_made@>/<@=player_score.playerStats.hook_made+player_score.playerStats.hook_missed@></div>
						</li>
					</ul>
				</section>
			</script>
</section>
</section>
{%require name='match:page/nba_player_map.tpl'%}{%/block%}
