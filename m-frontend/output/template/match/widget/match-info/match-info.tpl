<div class="match-banner" data-status="{%$gameInfo.status|f_escape_xml%}">
<p class="match-date">{%$gameInfo.year_desc|f_escape_xml%}</p>
<div class="match-title-info">
<div class="team-logo away-team-logo">
<a href="{%$gameInfo.away.link|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_team_{%$gameInfo.away.id|f_escape_xml%}">
<img src="{%$gameInfo.away.logourl|f_escape_xml%}" alt="">
</a>
</div>
<strong>
<span id="J_scoreortime">{%$gameInfo.scoreortime|f_escape_xml%}</span>
</strong>
<div class="team-logo home-team-logo">
<a href="{%$gameInfo.home.link|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_team_{%$gameInfo.home.id|f_escape_xml%}">
<img src="{%$gameInfo.home.logourl|f_escape_xml%}" alt="">
</a>
</div>
</div>
<div class="match-detail">
<div class="team-name away-team-name">
<a href="{%$gameInfo.away.link|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_team_{%$gameInfo.away.id|f_escape_xml%}">
<span>(客)</span><strong>{%$gameInfo.away.name|f_escape_xml%}</strong>
</a>
</div>
<div class="team-status" id="J_process">
{%$gameInfo.process|f_escape_xml%}
</div>
<div class="team-name home-team-name">
<a href="{%$gameInfo.home.link|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_team_{%$gameInfo.home.id|f_escape_xml%}">
<strong>{%$gameInfo.home.name|f_escape_xml%}</strong><span>(主)</span>
</a>
</div>
</div>
{%if $gameInfo.status != 1%}
<div class="balance-info" match-id="{%$gameInfo.match_id|f_escape_xml%}">
<div class="bal-btn away-btn">
<div class="btn" style="background-color:rgb({%$gameInfo.away.color|f_escape_xml%})">
<div class="load-left"><span></span></div>
<div class="load-right"><span></span></div>
{%if $gameInfo.status == 3%}
<a href="javascript:;" class="inner" dace-node="{%$id4dace|f_escape_xml%}_forecast_{%$gameInfo.away.id|f_escape_xml%}" style="color:rgb({%$gameInfo.away.color|f_escape_xml%});font-size: 16px;">胜</a>
{%else%}
<a href="javascript:;" class="inner icon-support-away" dace-node="{%$id4dace|f_escape_xml%}_for_{%$gameInfo.away.id|f_escape_xml%}"></a>
{%/if%}
</div>
</div>
<div class="balance-bar-area">
<div class="bar" style="background-color:rgb({%$gameInfo.home.color|f_escape_xml%})">
<span class="away-bar" style="width:{%$gameForcastInfo.awayWidth|f_escape_xml%};background-color:rgb({%$gameInfo.away.color|f_escape_xml%})"></span>
</div>
<div class="rate">
<span class="away-rate">{%$gameForcastInfo.awayWidth|f_escape_xml%}</span>
<span class="home-rate">{%$gameForcastInfo.homeWidth|f_escape_xml%}</span>
</div>
</div>
<div class="bal-btn home-btn">
<div class="btn" style="background-color:rgb({%$gameInfo.home.color|f_escape_xml%})">
<div class="load-right"><span></span></div>
{%if $gameInfo.status == 3%}
<a href="javascript:;" class="inner" dace-node="{%$id4dace|f_escape_xml%}_forecast_{%$gameInfo.home.id|f_escape_xml%}" style="color:rgb({%$gameInfo.home.color|f_escape_xml%});font-size: 16px;">胜</a>
{%else%}
<a href="javascript:;" class="inner icon-support" dace-node="{%$id4dace|f_escape_xml%}_for_{%$gameInfo.home.id|f_escape_xml%}"></a>
{%/if%}
</div>
</div>
</div>
{%else%}
<div class="balance-info" match-id="{%$gameInfo.match_id|f_escape_xml%}">
<div class="bal-btn away-btn">
<div class="btn-result icon-support"></div>
</div>
<div class="balance-bar-area">
<div class="bar" style="background-color:rgb({%$gameInfo.home.color|f_escape_xml%})">
<span class="away-bar" style="width:{%$gameForcastInfo.awayWidth|f_escape_xml%};background-color:rgb({%$gameInfo.away.color|f_escape_xml%})"></span>
</div>
<div class="rate">
<span class="away-rate">{%$gameForcastInfo.awayWidth|f_escape_xml%}</span>
<span class="home-rate">{%$gameForcastInfo.homeWidth|f_escape_xml%}</span>
</div>
</div>
<div class="bal-btn home-btn">
<div class="btn-result icon-support-away"></div>
</div>
</div>
{%/if%}
<div class="tips"></div>
</div>