<header class="teams-header">
<div class="teams-header-color">
<div class="teams-main-info">
<div class="teams-left">
<div class="teams-logo">
<img src="{%$teamInfo.image_87x87_url|f_escape_xml%}" alt="{%$teamInfo.image_87x87_url|f_escape_xml%}"/>
</div>
</div>
<div class="teams-right">
<div class="teams-text">
{%$teamInfo.known_name|f_escape_xml%}<br />
<span class="font-14">{%$teamInfo.known_name_en|f_escape_xml%}</span>
</div>
</div>
</div>
<div class="teams-other">
<div class="teams-left">
<div class="title">
{%if !empty($teamInfo.founded)%}成立时间<br/>{%/if%}
{%if !empty($teamInfo.city)%}所在城市<br/>{%/if%}
现任教练</div>
</div>
<div class="teams-right">
<div class="main-text">
{%if !empty($teamInfo.founded)%}{%$teamInfo.founded|default:"--"|f_escape_xml%}年<br />{%/if%}
{%if !empty($teamInfo.city)%}{%$teamInfo.city|default:"--"|f_escape_xml%}<br />{%/if%}
<a href="{%$coach_link|f_escape_xml%}" style="color: #fff;">
{%if !empty($officialInfo.official_name)%}
{%$officialInfo.official_name|f_escape_xml%}
{%else%}
{%$officialInfo.official_name_en|default:"--"|f_escape_xml%}
{%/if%}
</a>
</div>
</div>
</div>
{%if !empty($teamInfo.recent_games)%}
<div class="teams-match">
<div class="match-title">近期战绩</div>
<div class="match-area">
<ul class="match-head">
<li>&nbsp;</li>
<li>胜</li>
<li>平</li>
<li>负</li>
<li>&nbsp;</li>
</ul>
{%foreach $teamInfo.recent_games as $matchArr%}
{%$match = $matchArr[0]%}
{%$showSelfLogo = $match.home_logo%}
{%$showSelfName = $match.home_name%}
{%$showSelfUrl = $match.home_url%}
{%$showAnthorLogo = $match.away_logo%}
{%$showAnthorName = $match.away_name%}
{%$showAnthorUrl = $match.away_url%}
{%$matchStatus = 2%}
{%if $match.home_id != $teamInfo.team_id%}
{%$showSelfLogo = $match.away_logo%}
{%$showSelfName = $match.away_name%}
{%$showSelfUrl = $match.away_url%}
{%$showAnthorLogo = $match.home_logo%}
{%$showAnthorName = $match.home_name%}
{%$showAnthorUrl = $match.home_url%}
{%/if%}
{%if $match.home_score == $match.away_score%}
{%$matchStatus = 2%}
{%else%}
{%if $match.home_id == $teamInfo.team_id%}
{%if $match.home_score > $match.away_score%}
{%$matchStatus = 3%}
{%else%}
{%$matchStatus = 1%}
{%/if%}
{%else%}
{%if $match.home_score > $match.away_score%}
{%$matchStatus = 1%}
{%else%}
{%$matchStatus = 3%}
{%/if%}
{%/if%}
{%/if%}
<ul class="match-item">
<li>{%$match.date[0]|date_format:'%m-%d'%}</li>
{%if $matchStatus == 1%}
<li class="hasbg"><a href="{%$showAnthorUrl|f_escape_xml%}"><img src="{%$showAnthorLogo|f_escape_xml%}" alt="{%$showAnthorName|f_escape_xml%}"/></a></li>
<li class="hasbg">&nbsp;</li>
<li class="hasbg"><img src="{%$showSelfLogo|f_escape_xml%}" alt="{%$showSelfName|f_escape_xml%}"/></li>
{%elseif $matchStatus == 2%}
<li class="hasbg">&nbsp;</li>
<li class="hasbg"><a href="{%$showAnthorUrl|f_escape_xml%}"><img src="{%$showAnthorLogo|f_escape_xml%}" alt="{%$showAnthorName|f_escape_xml%}"/></a></li>
<li class="hasbg">&nbsp;</li>
{%else%}<li class="hasbg"><img src="{%$showSelfLogo|f_escape_xml%}" alt="{%$showSelfName|f_escape_xml%}"/></li><li class="hasbg">&nbsp;</li>
<li class="hasbg"><a href="{%$showAnthorUrl|f_escape_xml%}"><img src="{%$showAnthorLogo|f_escape_xml%}" alt="{%$showAnthorName|f_escape_xml%}"/></a></li>
{%/if%}
<li>
{%if $match.home_score == $match.away_score%}
<span class="black">{%intval($match.home_score)%}:{%intval($match.away_score)%}</span>
{%elseif $match.home_score > $match.away_score%}
{%intval($match.home_score)%}<span class="black">:{%intval($match.away_score)%}</span>
{%else%}
<span class="black">{%intval($match.home_score)%}:</span>{%intval($match.away_score)%}
{%/if%}</li>
</ul>
{%/foreach%}
{%if $teamInfo.recent_games|count < 5%}
{%$lastCount=5-$teamInfo.recent_games|count%}
{%section name=last loop=$lastCount step=-1%}
<ul class="match-item">
<li>&nbsp;</li>
<li class="hasbg">&nbsp;</li>
<li class="hasbg">&nbsp;</li>
<li class="hasbg">&nbsp;</li>
<li>&nbsp;</li>
</ul>
{%/section%}
{%/if%}
</div>
</div>
{%/if%}
</div>
</header>
