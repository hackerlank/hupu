{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="match:static/match-score/match-score.scss"%}
{%script%}
        //底部的刷新
        var tools = require("common:widget/ui/page-tools/page-tools.js");
        tools.initTools({
            refresh : true
        });

        require("match:widget/match-info/match-info.js");
        require("match:widget/top-tips/top-tips.js");
    {%/script%}
{%/block%}
{%block name="content"%}
{%widget
        name="common:widget/top-nav/top-nav.tpl"
    %}
{%assign var=top value=$adInfo.m_adword.nba_game_playbyplay%}
{%widget
        name="match:widget/top-tips/top-tips.tpl"
        isOpen=$top.isopen
        content=$top.adword
        url=$top.adurl
    %}
{%widget
    	name="match:widget/match-info/match-info.tpl"
    %}
{%widget
    	name="common:widget/inner-tab/tab.tpl"
    	tabClass="match"
    	selected=2
    %}
{%assign var="matchGroup" value=[1,2,3,4,5,6]%}
<div class="table-scroll">
<table class="table">
<thead>
<tr>
<th class="number-1"></th>
{%foreach from=$matchGroup item=item name=score%}
{%if isset($stats["socre"]["home"][$item])%}
<th class="number-1 td-align">{%if $item>4%}加时{%else%}{%$item|f_escape_xml%}{%/if%}</th>
{%/if%}
{%/foreach%}
<th class="number-1 td-align">总分</th>
</tr>
</thead>
<tbody>
<tr>
<td class="number-1">{%$gameInfo["away"]["name"]|f_escape_xml%}</td>
{%foreach from=$matchGroup item=item name=score%}
{%if isset($stats["socre"]["away"][$item])%}
<td class="number-1 score td-align">{%$stats["socre"]["away"][$item]|f_escape_xml%}</td>
{%/if%}
{%/foreach%}
<td class="number-1 td-align">{%$stats["socre"]["away"]["score"]|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">{%$gameInfo["home"]["name"]|f_escape_xml%}</td>
{%foreach from=$matchGroup item=item name=score%}
{%if isset($stats["socre"]["home"][$item])%}
<td class="number-1 score td-align">{%$stats["socre"]["home"][$item]|f_escape_xml%}</td>
{%/if%}
{%/foreach%}
<td class="number-1 td-align">{%$stats["socre"]["home"]["score"]|f_escape_xml%}</td>
</tr>
</tbody>
</table>
</div>
<div class="table-col-1">
<div class="team-score away table-fixed" style="border-right-color:rgba({%$gameInfo.away.color|f_escape_xml%},1)">
<table class="table">
<thead>
<tr>
<th class="col-header" style="background-color:rgba({%$gameInfo.away.color|f_escape_xml%},1)">{%$gameInfo["away"]["name"]|f_escape_xml%}球员</th>
</tr>
</thead>
<tbody>
{%foreach from=$stats.player.away.start item=awayTeam name=infoKey%}
<tr>
<td class="col-header"><a href="{%$awayTeam.playerurl|f_escape_xml%}">{%$awayTeam.alias|cut:7|f_escape_xml%}</a></td>
</tr>
{%/foreach%}
{%foreach from=$stats.player.away.bench item=awayTeam name=infoKey%}
<tr class="bench">
<td class="col-header"><a href="{%$awayTeam.playerurl|f_escape_xml%}">{%$awayTeam.alias|cut:7|f_escape_xml%}</a></td>
</tr>
{%/foreach%}
</tbody>
</table>
</div>
<div class="table-scroll team-score away">
<table class="table">
<thead>
<tr>
<th class="number-1" style="background-color:rgba({%$gameInfo.away.color|f_escape_xml%},1)">时间</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.away.color|f_escape_xml%},1)">得分</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.away.color|f_escape_xml%},1)">篮板</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.away.color|f_escape_xml%},1)">助攻</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.away.color|f_escape_xml%},1)">投篮</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.away.color|f_escape_xml%},1)">3分</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.away.color|f_escape_xml%},1)">罚球</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.away.color|f_escape_xml%},1)">前板</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.away.color|f_escape_xml%},1)">后板</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.away.color|f_escape_xml%},1)">抢断</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.away.color|f_escape_xml%},1)">失误</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.away.color|f_escape_xml%},1)">封盖</th>
{%if $gameInfo.process == "已结束"%}
<th class="number-1" style="background-color:rgba({%$gameInfo.away.color|f_escape_xml%},1)">被盖</th>
{%/if%}
<th class="number-1" style="background-color:rgba({%$gameInfo.away.color|f_escape_xml%},1)">犯规</th>
{%if $gameInfo.process == "已结束"%}
<th class="number-1" style="background-color:rgba({%$gameInfo.away.color|f_escape_xml%},1)">被犯</th>
{%/if%}
<th class="number-1" style="background-color:rgba({%$gameInfo.away.color|f_escape_xml%},1)">+/-</th>
</tr>
</thead>
<tbody>
{%foreach from=$stats.player.away.start item=awayTeam name=infoKey%}
<tr>
<td class="number-1">{%$awayTeam.mins|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.pts|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.reb|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.asts|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.fgm|f_escape_xml%}-{%$awayTeam.fga|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.tpm|f_escape_xml%}-{%$awayTeam.tpa|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.ftm|f_escape_xml%}-{%$awayTeam.fta|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.oreb|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.dreb|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.stl|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.to|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.blk|f_escape_xml%}</td>
{%if $gameInfo.process == "已结束"%}
<td class="number-1">{%$awayTeam.blkr|f_escape_xml%}</td>
{%/if%}
<td class="number-1">{%$awayTeam.pf|f_escape_xml%}</td>
{%if $gameInfo.process == "已结束"%}
<td class="number-1">{%$awayTeam.foulr|f_escape_xml%}</td>
{%/if%}
<td class="number-1">{%if $awayTeam.net_points >= 0%}+{%/if%}{%$awayTeam.net_points|f_escape_xml%}</td>
</tr>
{%/foreach%}
{%foreach from=$stats.player.away.bench item=awayTeam name=infoKey%}
<tr class="bench">
<td class="number-1">{%$awayTeam.mins|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.pts|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.reb|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.asts|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.fgm|f_escape_xml%}-{%$awayTeam.fga|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.tpm|f_escape_xml%}-{%$awayTeam.tpa|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.ftm|f_escape_xml%}-{%$awayTeam.fta|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.oreb|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.dreb|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.stl|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.to|f_escape_xml%}</td>
<td class="number-1">{%$awayTeam.blk|f_escape_xml%}</td>
{%if $gameInfo.process == "已结束"%}
<td class="number-1">{%$awayTeam.blkr|f_escape_xml%}</td>
{%/if%}
<td class="number-1">{%$awayTeam.pf|f_escape_xml%}</td>
{%if $gameInfo.process == "已结束"%}
<td class="number-1">{%$awayTeam.foulr|f_escape_xml%}</td>
{%/if%}
<td class="number-1">{%if $awayTeam.net_points >= 0%}+{%/if%}{%$awayTeam.net_points|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
</div>
</div>
<div class="table-col-1">
<div class="team-score home table-fixed" style="border-right-color:rgba({%$gameInfo.home.color|f_escape_xml%},1)">
<table class="table">
<thead>
<tr>
<th class="col-header" style="background-color:rgba({%$gameInfo.home.color|f_escape_xml%},1)">{%$gameInfo["home"]["name"]|f_escape_xml%}球员</th>
</tr>
</thead>
<tbody>
{%foreach from=$stats.player.home.start item=homeTeam name=infoKey%}
<tr>
<td class="col-header"><a href="{%$homeTeam.playerurl|f_escape_xml%}">{%$homeTeam.alias|cut:7|f_escape_xml%}</a></td>
</tr>
{%/foreach%}
{%foreach from=$stats.player.home.bench item=homeTeam name=infoKey%}
<tr class="bench">
<td class="col-header"><a href="{%$homeTeam.playerurl|f_escape_xml%}">{%$homeTeam.alias|cut:7|f_escape_xml%}</a></td>
</tr>
{%/foreach%}
</tbody>
</table>
</div>
<div class="table-scroll team-score home">
<table class="table">
<thead>
<tr>
<th class="number-1" style="background-color:rgba({%$gameInfo.home.color|f_escape_xml%},1)">时间</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.home.color|f_escape_xml%},1)">得分</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.home.color|f_escape_xml%},1)">篮板</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.home.color|f_escape_xml%},1)">助攻</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.home.color|f_escape_xml%},1)">投篮</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.home.color|f_escape_xml%},1)">3分</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.home.color|f_escape_xml%},1)">罚球</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.home.color|f_escape_xml%},1)">前板</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.home.color|f_escape_xml%},1)">后板</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.home.color|f_escape_xml%},1)">抢断</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.home.color|f_escape_xml%},1)">失误</th>
<th class="number-1" style="background-color:rgba({%$gameInfo.home.color|f_escape_xml%},1)">封盖</th>
{%if $gameInfo.process == "已结束"%}
<th class="number-1" style="background-color:rgba({%$gameInfo.home.color|f_escape_xml%},1)">被盖</th>
{%/if%}
<th class="number-1" style="background-color:rgba({%$gameInfo.home.color|f_escape_xml%},1)">犯规</th>
{%if $gameInfo.process == "已结束"%}
<th class="number-1" style="background-color:rgba({%$gameInfo.home.color|f_escape_xml%},1)">被犯</th>
{%/if%}
<th class="number-1" style="background-color:rgba({%$gameInfo.home.color|f_escape_xml%},1)">+/-</th>
</tr>
</thead>
<tbody>
{%foreach from=$stats.player.home.start item=homeTeam name=infoKey%}
<tr>
<td class="number-1">{%$homeTeam.mins|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.pts|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.reb|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.asts|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.fgm|f_escape_xml%}-{%$homeTeam.fga|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.tpm|f_escape_xml%}-{%$homeTeam.tpa|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.ftm|f_escape_xml%}-{%$homeTeam.fta|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.oreb|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.dreb|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.stl|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.to|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.blk|f_escape_xml%}</td>
{%if $gameInfo.process == "已结束"%}
<td class="number-1">{%$homeTeam.blkr|f_escape_xml%}</td>
{%/if%}
<td class="number-1">{%$homeTeam.pf|f_escape_xml%}</td>
{%if $gameInfo.process == "已结束"%}
<td class="number-1">{%$homeTeam.foulr|f_escape_xml%}</td>
{%/if%}
<td class="number-1">{%if $homeTeam.net_points >= 0%}+{%/if%}{%$homeTeam.net_points|f_escape_xml%}</td>
</tr>
{%/foreach%}
{%foreach from=$stats.player.home.bench item=homeTeam name=infoKey%}
<tr class="bench">
<td class="number-1">{%$homeTeam.mins|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.pts|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.reb|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.asts|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.fgm|f_escape_xml%}-{%$homeTeam.fga|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.tpm|f_escape_xml%}-{%$homeTeam.tpa|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.ftm|f_escape_xml%}-{%$homeTeam.fta|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.oreb|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.dreb|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.stl|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.to|f_escape_xml%}</td>
<td class="number-1">{%$homeTeam.blk|f_escape_xml%}</td>
{%if $gameInfo.process == "已结束"%}
<td class="number-1">{%$homeTeam.blkr|f_escape_xml%}</td>
{%/if%}
<td class="number-1">{%$homeTeam.pf|f_escape_xml%}</td>
{%if $gameInfo.process == "已结束"%}
<td class="number-1">{%$homeTeam.foulr|f_escape_xml%}</td>
{%/if%}
<td class="number-1">{%if $homeTeam.net_points >= 0%}+{%/if%}{%$homeTeam.net_points|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
</div>
</div>
{%require name='match:page/match-score.tpl'%}{%/block%}
