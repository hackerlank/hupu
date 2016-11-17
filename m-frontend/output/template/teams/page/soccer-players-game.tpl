{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="teams:static/players-game/game-data.scss"%}
{%script%}
        var toShare = require("common:widget/ui/share/share.js");

        //全局分享事件, 每个页面单独注册.
        $(document).on("page:share", function(){
            toShare();
        });
    {%/script%}
{%/block%}
{%block name="content"%}
{%widget
        name="common:widget/inner-top-nav/nav.tpl"
    %}
<section class="m-wrap playersGameData-wrap">
{%widget
            name="teams:widget/soccer-player-header/header.tpl"
        %}
{%widget
            name="common:widget/inner-tab/tab.tpl"
            tabClass="soccer-players"
            selected=2
        %}
{%$names = ["日期","主队","客队","比分","出场","出场时间"]%}
{%$pos1 = ["进球","助攻","犯规/被犯","黄牌","红牌","射门/射正","扑救","点球"]%}
{%$pos2 = ["进球","助攻","犯规/被犯","黄牌","红牌","射门/射正","越位","点球"]%}
{%$pos34 = ["进球","助攻","犯规/被犯","黄牌","红牌","射门/射正","越位","点球"]%}
{%if $playerInfo.position == 1%}
{%$names = array_merge($names, $pos1)%}
{%elseif $playerInfo.position == 2%}
{%$names = array_merge($names, $pos2)%}
{%elseif $playerInfo.position == 3 || $playerInfo.position == 4%}
{%$names = array_merge($names, $pos34)%}
{%/if%}
<div class="season-content">
<div class="table-scroll">
<table class="table table-1">
<thead>
<tr>
{%foreach $names as $item%}
<th class="number-1">{%$item|f_escape_xml%}</th>
{%/foreach%}
</tr>
</thead>
<tbody>
{%foreach $gameStats as $player%}
<tr>
<td class="number-1">{%$player.gameInfo.match_date|f_escape_xml%}</td>
<td class="number-1">{%$player.gameInfo.home_name|f_escape_xml%}</td>
<td class="number-1">{%$player.gameInfo.away_name|f_escape_xml%}</td>
<td class="number-1">{%$player.gameInfo.home_score|f_escape_xml%}:{%$player.gameInfo.away_score|f_escape_xml%}</td>
<td class="number-1">{%if $player.status == 1%}首发{%else%}替补{%/if%}</td>
<td class="number-1">{%$player.mins_played|f_escape_xml%}分钟</td>
<td class="number-1">{%$player.goals|f_escape_xml%}</td>
<td class="number-1">{%$player.goal_assist|f_escape_xml%}</td>
<td class="number-1">{%$player.fouls|f_escape_xml%}/{%$player.was_fouled|f_escape_xml%}</td>
<td class="number-1">{%$player.yellow_card|f_escape_xml%}</td>
<td class="number-1">{%$player.red_card|f_escape_xml%}</td>
<td class="number-1">{%$player.total_scoring_att|f_escape_xml%}/{%$player.ontarget_scoring_att|f_escape_xml%}</td>
<td class="number-1">{%if $playerInfo.position == 1%}{%$player.saves|f_escape_xml%}{%else%}{%$player.total_offside|f_escape_xml%}{%/if%}</td>
<td class="number-1">{%$player.att_pen_goal|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
</div>
</div>
</section>
{%require name='teams:page/soccer-players-game.tpl'%}{%/block%}