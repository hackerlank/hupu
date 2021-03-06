{%if $type == "nba"%}
<header class="w-player-header nba-header">
<div class="head" style="background-image: url({%$playerBasic.photo_link|f_escape_xml%});background-size: cover;">
</div>
<ul class="info">
<li class="name">
{%if !empty($playerBasic.name)%}
<span>{%$playerBasic.name|f_escape_xml%}</span>
{%else%}
<span>{%$playerBasic.eng_name|f_escape_xml%}</span>
{%/if%}
{%if !empty($playerBasic.country)%}
{%foreach $playerBasic.country as $val%}
<span class="country">
<img src="//b3.hoopchina.com.cn/images/country/{%$val|f_escape_path%}.jpg" alt="">
</span>
{%/foreach%}
{%/if%}
</li>
{%if !empty($playerBasic.eng_name) && !empty($playerBasic.name)%}<li class="en-name">{%$playerBasic.eng_name|f_escape_xml%}</li>{%/if%}
<li class="player-info">
{%if !empty($playerBasic.number) || $playerBasic.number === 0%}<span class="num">{%$playerBasic.number|f_escape_xml%}号</span>{%/if%}
<span class="position">{%$playerBasic.position_zh_name|f_escape_xml%}</span>
<span class="team">{%$playerBasic.team_name|f_escape_xml%}</span>
</li>
</ul>
</header>
{%else%}
<header class="w-player-header soccer-header" >
<div class="head" style="background-image: url({%$playerInfo.image_86x120_url|f_escape_xml%});background-size: cover;">
</div>
<ul class="info">
<li class="name">
{%if !empty($playerInfo.name)%}
<span>{%$playerInfo.name|f_escape_xml%}</span>
{%else%}
<span>{%$playerInfo.name_en|f_escape_xml%}</span>
{%/if%}
{%if !empty($playerInfo.country)%}{%foreach $playerInfo.country as $val%}
<span class="country">
<img src="//b3.hoopchina.com.cn/images/country/{%$val|f_escape_path%}.jpg" alt="">
</span>
{%/foreach%}
{%/if%}
</li>
{%if !empty($playerInfo.name_en) && !empty($playerInfo.name)%}<li class="en-name">{%$playerInfo.name_en|f_escape_xml%}</li>{%/if%}
<li class="player-info">
{%if !empty($playerInfo.jersey_num) || $playerInfo.jersey_num === 0%}<span class="num">{%$playerInfo.jersey_num|f_escape_xml%}号</span>{%/if%}
<span class="position">{%$playerInfo.position|f_escape_xml%}</span>
<span class="team">{%$playerInfo.team_name|f_escape_xml%}</span>
</li>
</ul>
</header>
{%/if%}