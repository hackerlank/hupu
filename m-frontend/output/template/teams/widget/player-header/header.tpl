<header class="players-header">
<div class="players-header-color" style="background:rgba({%$teamBgColor|f_escape_xml%},.6)">
<div class="players-basic">
<dl>
<dd class="avatar">
<img src="{%$playerBasic.photo_link|f_escape_xml%}" alt=""/>
</dd>
<dt class="name">{%$playerBasic.name|f_escape_xml%}</dt>
<dd class="en-name">{%$playerBasic.eng_name|f_escape_xml%}</dd>
<dd class="other-info">
<span>{%$playerBasic.number|f_escape_xml%}号</span>
<span>{%$playerBasic.position|f_escape_xml%}</span>
<span>{%$playerBasic.teamName|f_escape_xml%}</span>
</dd>
</dl>
</div>
<div class="other-data-table">
<table class="table">
<tr>
<td class="number-1">身高</td>
<td class="number-2">{%$playerBasic.height_fix|f_escape_xml%}米 /{%$playerBasic.height_fix2|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">体重</td>
<td class="number-2">{%$playerBasic.weight_fix|f_escape_xml%}公斤 /{%$playerBasic.weight|f_escape_xml%}磅</td>
</tr>
<tr>
<td class="number-1">生日</td>
<td class="number-2">{%$playerBasic.birth_date_fix2|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">选秀</td>
<td class="number-2">
{%if isset($playerBasic.draft_year) && !empty($playerBasic.draft_year)%}
{%$playerBasic.draft_year|f_escape_xml%}年第{%$playerBasic.draft_round|f_escape_xml%}轮第{%$playerBasic.draft_pick|f_escape_xml%}顺位{%else%}
--{%/if%}
</td>
</tr>
<tr>
<td class="number-1">出生地</td>
<td class="number-2">{%$playerBasic.country|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">本赛季薪金</td>
<td class="number-2">
{%if isset($playerBasic.salary) && !empty($playerBasic.salary)%}
{%$playerBasic.salary|f_escape_xml%}万美元{%else%}
--{%/if%}
</td>
</tr>
<tr>
<td class="number-1">合同</td>
<td class="number-2">
{%if isset($playerBasic.wage) && !empty($playerBasic.wage)%}
{%$playerBasic.wage|f_escape_xml%}
{%else%}
--{%/if%}
</td>
</tr>
</table>
</div>
</div>
</header>