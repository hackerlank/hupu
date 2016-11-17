{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="teams:static/teams-schedule/teams-schedule.scss"%}
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
<section class="m-wrap teams-data-wrap">
{%widget
            name="teams:widget/team-header/header.tpl"
        %}
{%widget
            name="common:widget/inner-tab/tab.tpl"
            tabClass="team"
            selected=1
        %}
<div class="match-list-wrap" id="J_content">
{%foreach from=$nbaGame item=itemVal name=itemKey%}
{%if isset($itemVal.id)%}
<section class="match-section match-today" latestId="{%$itemVal.id|f_escape_xml%}" match-date="{%$itemVal.date|f_escape_xml%}">
{%else%}
<section class="match-section" match-date="{%$itemVal.date|f_escape_xml%}">
{%/if%}
<div class="time-label">
<span>
<strong>{%$itemVal.timestr|f_escape_xml%}</strong></span>
</div>
{%if !empty($itemVal.gameinfo)%}
{%foreach from=$itemVal.gameinfo item=infoVal name=infoKey%}
<a href="{%$infoVal.innerurl|f_escape_xml%}" class="match-wrap" dace-node="{%$id4dace|f_escape_xml%}_game">
<div class="match-info">
<div class="match-team-info">
<div class="team home-team">
<span class="team-name">{%$infoVal.home.name|f_escape_xml%}</span>
</div>
<strong>
<span>{%$infoVal.scoreortime|f_escape_xml%}</span>
</strong>
<div class="team away-team">
<span class="team-name">{%$infoVal.away.name|f_escape_xml%}</span>
</div>
</div>
<div class="match-status-info">
<div class="score home-score">
{%if isset($infoVal.home_win)%}
({%$infoVal.home_win|f_escape_xml%}){%/if%}
</div>
{%if isset($infoVal.isovertime)%}
{%if {%$infoVal.isover|f_escape_xml%} == 0%}
<div class="match-status-txt overtime-ing">{%$infoVal.process|f_escape_xml%}</div>
{%else%}
<div class="match-status-txt overtime">{%$infoVal.process|f_escape_xml%}</div>
{%/if%}
{%else%}
<div class="match-status-txt">{%$infoVal.process|f_escape_xml%}</div>
{%/if%}
<div class="score away-score">
{%if isset($infoVal.home_win)%}
({%$infoVal.away_win|f_escape_xml%}){%/if%}
</div>
</div>
</div>
</a>
{%/foreach%}
{%/if%}
</section>
{%/foreach%}
</div>
</section>
{%require name='teams:page/teams-schedule.tpl'%}{%/block%}