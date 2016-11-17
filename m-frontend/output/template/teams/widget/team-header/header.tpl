<header class="teams-header">
<div class="teams-header-color" style="background:rgba({%$teamBgColor|f_escape_xml%},.6)">
<div class="teams-main-info">
<div class="teams-left">
<div class="teams-logo">
<img src="{%$teamInfo.logo_link|f_escape_xml%}" alt=""/>
</div>
</div>
<div class="teams-right">
<div class="teams-text">
{%$teamInfo.full_name|f_escape_xml%}<br />
<span class="font-14">{%$teamInfo.eng_full_name|f_escape_xml%}</span>
</div>
</div>
</div>
<div class="teams-other">
<div class="teams-left">
<div class="title">
进入NBA<br/>
主球场<br/>
分区<br />
主教练<br />
本赛季成绩</div>
</div>
<div class="teams-right">
<div class="main-text">
{%$teamInfo.found_year|f_escape_xml%}年<br />
{%$teamInfo.home|f_escape_xml%}<br />
{%$teamInfo.conferenceCn|f_escape_xml%}{%$teamInfo.cn_division|f_escape_xml%}<br />
{%$teamInfo.chief_coach|f_escape_xml%}<br />
{%$teamInfo.winCn|f_escape_xml%}{%$teamInfo.lostCn|f_escape_xml%}{%$teamInfo.rankCn|f_escape_xml%}
</div>
</div>
</div>
</div>
</header>
