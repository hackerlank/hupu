
<div class="energy-match fr" id="J-energy-match">
<div class="inner clearfix" id="J-energy-inner">
<div class="left fl">
<div class="sub-inner fl">
<div class="progress fl">
<div class="add-energy">
<a href="javascript:void(0);" class="btn-add mod-btn-box">+能量</a>
<div class="add-energy-box mod-box">
<ul data-gameid="{%$chaoneng_info.gameStatus.id|f_escape_xml%}" data-teamid="{%$chaoneng_info.home_team_info.id|f_escape_xml%}" data-ischaoneng="{%if !empty($chaoneng_info)%}1{%else%}0{%/if%}">
<li><a href="javascript:void(0);" data-number="1">×1</a></li>
<li><a href="javascript:void(0);" data-number="10">×10</a></li>
<li><a href="javascript:void(0);" data-number="100">×100</a></li>
<li><a href="javascript:void(0);" data-number="500">×500</a></li>
</ul>
<i class="icon-triangle"></i>
<div class="tip">每赠送一个能量值，消耗一个虎扑币</div>
</div>
</div>
<div class="left-energy">剩余&nbsp;<span class="home-power-left">{%$chaoneng_info.home_power.left|f_escape_xml%}</span></div>
{%$home_power_scale=intval($chaoneng_info.home_power.left)/$chaoneng_info.home_power.show%}
{%if $home_power_scale > 1%}{%$home_power_scale=1%}{%/if%}
<div class="progress-inner" style="width: {%$home_power_scale*100%}%; background-color: {%if $home_power_scale<=0.25%}#c01e2f{%else if $home_power_scale>0.25&&$home_power_scale<=0.5%}#d6576d{%else if $home_power_scale>0.5&&$home_power_scale<=0.75%}#ec6500{%else if $home_power_scale>0.75%}#ffb300;{%/if%}">
<span class="add-tip home-add-tip"></span>
</div>
<span class="energy-tip {%if $home_power_scale>=1%}energy-full{%else%}energy-nofull{%/if%}"></span>
</div>
<div class="skill fl">
{%$allLastSkillCount=0%}
{%foreach $chaoneng_info.home_skill as $val%}
{%$allLastSkillCount= $allLastSkillCount + (intval($val.skill_totlenum) - intval($val.skill_usednum))%}
{%/foreach%}
<a href="javascript:void(0);" class="btn-skill mod-btn-box">技能库<span {%if $allLastSkillCount == 0%}style="display: none;"{%/if%} class="num home-skill-num">{%$allLastSkillCount|f_escape_xml%}</span></a>
<div class="skill-box mod-box">
<div class="hd clearfix">
<div class="title fl">{%$chaoneng_info.home_team_info.cn_name|f_escape_xml%}技能库<i class="icon-triangle-shadow"></i></div>
<div class="summary fr">
<div class="all"><span class="st">总能量</span><span class="sum home-power-total power-total" data-total="{%$chaoneng_info.home_power.show|f_escape_xml%}">{%$chaoneng_info.home_power.total|f_escape_xml%}</span></div>
<div class="left"><span class="st">剩余能量</span><span class="home-power-left power-left">{%$chaoneng_info.home_power.left|f_escape_xml%}</span></div>
</div>
</div>
<div class="bd">
<div class="skill-container home-skill-swiper clearfix">
<div class="skill-btn btn-prev"><i></i></div>
<div class="skill-swiper" >
<div class="skill-inner clearfix">
{%foreach $chaoneng_info.home_skill as $val%}
{%if ($val@index+1)%8 == 1%}
<div class="slide">
<ul class="clearfix">
{%/if%}
<li data-value="{%$val.skill_info.skill_value|f_escape_xml%}" data-desc="{%$val.skill_info.skill_description|f_escape_xml%}" data-logo="{%$val.skill_info.skill_logo|f_escape_xml%}" data-name="{%$val.skill_info.skill_name|f_escape_xml%}" class="{%skill total=$val.skill_totlenum used=$val.skill_usednum status=$val.skill_status%}" id="home_skill_{%$val.skill_id|f_escape_xml%}">
<div class="skill-pic">
<img src="{%$val.skill_info.skill_logo|f_escape_xml%}" alt="{%$val.skill_info.skill_name|f_escape_xml%}" title="{%$val.skill_info.skill_name|f_escape_xml%}">
<span class="active" style="display:{%if $val.skill_status == 1%}block{%else%}none{%/if%}">已激活</span>
</div>
<div class="use-info">
<span class="left skill-total-num">{%intval($val.skill_totlenum)-intval($val.skill_usednum)%}</span>&nbsp;|&nbsp;<span class="skill-used-num">{%$val.skill_usednum|f_escape_xml%}</span>
</div>
</li>
{%if ($val@index+1)%8 == 0 || ($val@index+1) == $chaoneng_info.home_skill|count%}
</ul>
</div>
{%/if%}
{%/foreach%}
</div>
</div>
<div class="skill-btn btn-next"><i></i></div>
</div>
</div>
<div class="ft">(剩余技能 | 已使用技能)</div>
<div class="skill-side-box">
<div class="hd">
<div class="pic">
<img class="skill-logo" src="{%$chaoneng_info.home_skill[0].skill_info.skill_logo|f_escape_xml%}" alt="{%$chaoneng_info.home_skill[0].skill_info.skill_name|f_escape_xml%}">
</div>
<div class="coin">
<i class="icon-coin"></i><span class="skill-value">{%$chaoneng_info.home_skill[0].skill_info.skill_value|f_escape_xml%}</span>
<p class="skill-name">{%$chaoneng_info.home_skill[0].skill_info.skill_name|f_escape_xml%}</p>
</div>
</div>
<div class="bd skill-desc">{%$chaoneng_info.home_skill[0].skill_info.skill_description|f_escape_xml%}</div>
<i class="icon-close"></i>
</div>
<i class="icon-triangle"></i>
</div>
</div>
</div>
</div>
<div class="center fl">
<div class="inner clearfix">
<div class="fl">{%$chaoneng_info.home_team_info.cn_name|f_escape_xml%}</div>
<div class="fl show-vs">
VS</div>
<div class="fl">{%$chaoneng_info.guest_team_info.cn_name|f_escape_xml%}</div>
</div>
</div>
<div class="right fl">
<div class="sub-inner fl">
<div class="skill fl">
{%$allLastSkillCount = 0%}
{%foreach $chaoneng_info.guest_skill as $val%}
{%$allLastSkillCount = $allLastSkillCount + intval($val.skill_totlenum) - intval($val.skill_usednum)%}
{%/foreach%}
<a href="javascript:void(0);" class="btn-skill mod-btn-box">技能库<span {%if $allLastSkillCount == 0%}style="display: none;"{%/if%} class="num guest-skill-num">{%$allLastSkillCount|f_escape_xml%}</span></a>
<div class="skill-box mod-box">
<div class="hd clearfix">
<div class="title fl">{%$chaoneng_info.guest_team_info.cn_name|f_escape_xml%}技能库<i class="icon-triangle-shadow"></i></div>
<div class="summary fr">
<div class="all"><span class="st">总能量</span><span class="sum guest-power-total power-total" data-total="{%$chaoneng_info.guest_power.show|f_escape_xml%}">{%$chaoneng_info.guest_power.total|f_escape_xml%}</span></div>
<div class="left"><span class="st">剩余能量</span><span class="guest-power-left power-left">{%$chaoneng_info.guest_power.left|f_escape_xml%}</span></div>
</div>
</div>
<div class="bd">
<div class="skill-container guest-skill-swiper clearfix">
<div class="skill-btn btn-prev"><i></i></div>
<div class="skill-swiper" >
<div class="skill-inner clearfix">
{%foreach $chaoneng_info.guest_skill as $val%}
{%if ($val@index+1)%8 == 1%}
<div class="slide">
<ul class="clearfix">
{%/if%}
<li data-value="{%$val.skill_info.skill_value|f_escape_xml%}" data-desc="{%$val.skill_info.skill_description|f_escape_xml%}" data-logo="{%$val.skill_info.skill_logo|f_escape_xml%}" data-name="{%$val.skill_info.skill_name|f_escape_xml%}" class="{%skill total=$val.skill_totlenum used=$val.skill_usednum status=$val.skill_status%}" id="guest_skill_{%$val.skill_id|f_escape_xml%}">
<div class="skill-pic">
<img src="{%$val.skill_info.skill_logo|f_escape_xml%}" alt="{%$val.skill_info.skill_name|f_escape_xml%}" title="{%$val.skill_info.skill_name|f_escape_xml%}">
<span class="active" style="display:{%if $val.skill_status == 1%}block{%else%}none{%/if%}">已激活</span>
</div>
<div class="use-info">
<span class="left skill-total-num">{%intval($val.skill_totlenum)-intval($val.skill_usednum)%}</span>&nbsp;|&nbsp;<span class="skill-used-num">{%$val.skill_usednum|f_escape_xml%}</span>
</div>
</li>
{%if ($val@index+1)%8 == 0 || ($val@index+1) == $chaoneng_info.guest_skill|count%}
</ul>
</div>
{%/if%}
{%/foreach%}
</div>
</div>
<div class="skill-btn btn-next"><i></i></div>
</div>
</div>
<div class="ft">(剩余技能 | 已使用技能)</div>
<div class="skill-side-box">
<div class="hd">
<div class="pic">
<img class="skill-logo" src="{%$chaoneng_info.guest_skill[0].skill_info.skill_logo|f_escape_xml%}" alt="{%$chaoneng_info.guest_skill[0].skill_info.skill_name|f_escape_xml%}">
</div>
<div class="coin">
<i class="icon-coin"></i><span class="skill-value">{%$chaoneng_info.guest_skill[0].skill_info.skill_value|f_escape_xml%}</span>
<p class="skill-name">{%$chaoneng_info.guest_skill[0].skill_info.skill_name|f_escape_xml%}</p>
</div>
</div>
<div class="bd skill-desc">{%$chaoneng_info.guest_skill[0].skill_info.skill_description|f_escape_xml%}</div>
<i class="icon-close"></i>
</div>
<i class="icon-triangle"></i>
</div>
</div>
<div class="progress fl">
<div class="add-energy">
<a href="javascript:void(0);" class="btn-add mod-btn-box">+能量</a>
<div class="add-energy-box mod-box">
<ul data-gameid="{%$chaoneng_info.gameStatus.id|f_escape_xml%}" data-teamid="{%$chaoneng_info.guest_team_info.id|f_escape_xml%}" data-ischaoneng="{%if !empty($chaoneng_info)%}1{%else%}0{%/if%}">
<li><a href="javascript:void(0);" data-number="1">×1</a></li>
<li><a href="javascript:void(0);" data-number="10">×10</a></li>
<li><a href="javascript:void(0);" data-number="100">×100</a></li>
<li><a href="javascript:void(0);" data-number="500">×500</a></li>
</ul>
<i class="icon-triangle"></i>
<div class="tip">每赠送一个能量值，消耗一个虎扑币</div>
</div>
</div>
<div class="left-energy">剩余&nbsp;<span class="guest-power-left">{%$chaoneng_info.guest_power.left|f_escape_xml%}</span></div>
{%$guest_power_scale=intval($chaoneng_info.guest_power.left)/$chaoneng_info.guest_power.show%}
{%if $guest_power_scale > 1%}{%$guest_power_scale=1%}{%/if%}
<div class="progress-inner" style="width: {%$guest_power_scale*100%}%; background-color: {%if $guest_power_scale<=0.25%}#c01e2f{%else if $guest_power_scale>0.25&&$guest_power_scale<=0.5%}#d6576d{%else if $guest_power_scale>0.5&&$guest_power_scale<=0.75%}#ec6500{%else if $guest_power_scale>0.75%}#ffb300;{%/if%}">
<span class="add-tip guest-add-tip"></span>
</div>
<span class="energy-tip {%if $guest_power_scale>=1%}energy-full{%else%}energy-nofull{%/if%}"></span>
</div>
</div>
</div>
</div>
</div>
{%script%}
var ChaoNeng = require("live:widget/chaoneng/chaoneng.es6");

ChaoNeng.init();
{%/script%}
