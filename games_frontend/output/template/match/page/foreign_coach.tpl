{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}{%$profile.coach_full_name|f_escape_xml%}{%/block%}
{%block name="head_static"%}
{%require name="common:static/js/zepto/zepto.js"%}
{%require name="match:static/foreign_coach/foreign_coach.scss"%}
<script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
{%script%}
		window.GM = {
            "client": "{%$client|f_escape_js%}" || "x",
            "islogin": !!parseInt("{%$is_login|f_escape_js%}", 10),
            "night":!!parseInt("{%$night|f_escape_js%}", 10),
            "version":"{%$version|f_escape_js%}"||"7.0.7",
            "player_name": "{%$profile.coach_full_name|f_escape_js%}",
            "player_enname": "{%$profile.coach_enname|f_escape_js%}",
            "isBirth": !!parseInt("{%$profile.is_birthday|f_escape_js%}", 10)
        };

    {%/script%}
{%require name="match:static/foreign_coach/foreign_coach.js"%}
{%/block%}
{%block name="content"%}
<section class="foreign-coach-wrap">
<section class="info">
<div class="head">
<img src="{%$profile.coach_header|f_escape_xml%}">
{%if !empty($night)%}<div class="mask"></div>{%/if%}
</div>
<ul class="detail">
<li>
<span>{%$profile.team_name|f_escape_xml%}</span>
<i class="separator">|</i>
<span>{%$profile.country|f_escape_xml%}</span>
<input type="hidden" class="coachid" value="{%$profile.coach_id|f_escape_xml%}">
</li>
<li>
<span>{%$profile.role|f_escape_xml%}</span>
</li>
<li>
<span>
<span class="birth-status">
<img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/2x/1f382.png?t=1" width="15" height="15">
</span>
{%$profile.age|f_escape_xml%}
<span class="birth-status">
<img src="//w1.hoopchina.com.cn/hybrid/resource/emoji/1f382.png" width="15" height="15">
</span>
</span>
{%if !empty($profile.age) && !empty($profile.birth_date)%}
<i class="separator">|</i>
<span id="J-birth-date">{%$profile.birth_date|f_escape_xml%}</span>
{%/if%}
</li>
</ul>
</section>
<section class="other-info">
<div class="info-item">
<div class="info-label">
加入球队</div>
<div class="info-con">
{%$profile.join_date|f_escape_xml%}
</div>
</div>
{%if !empty($profile.season_record)%}
<div class="info-item">
<div class="info-label">
联赛成绩</div>
<div class="info-con">
<span>共{%$profile.win+$profile.draw+$profile.lose%}场</span><span>{%$profile.season_record|f_escape_xml%}</span><span>胜率{%$profile.win_per|f_escape_xml%}</span>
</div>
</div>
{%/if%}
<div class="info-item">
<div class="info-label">
偏好阵型</div>
<div class="info-con">
{%if !empty($profile.prefer_tactic)%}
<div class="tactic">
<span>{%$profile.prefer_tactic|f_escape_xml%}</span>
<em class="notice"></em>
</div>
{%else%}
不详{%/if%}
</div>
</div>
</section>
{%if !empty($profile.intro)%}
<section class="intro">
{%if !empty($profile.intro)%}
<h2>教练简介</h2>
<p class="intro-con">{%$profile.intro|f_escape_xml%}</p>
{%/if%}
</section>
{%/if%}
{%if !empty($profile.official_record)%}
<section class="career">
<div class="summary">
<h2>执教生涯</h2>
</div>
<div class="list">
<table>
<tr>
<th>时间</th>
<th>球队</th>
<th>比赛数</th>
<th>胜率</th>
</tr>
{%foreach $profile.official_record as $val%}
<tr>
<td>{%$val.appointed_date|f_escape_xml%}-{%$val.until_date|f_escape_xml%}</td>
<td>{%$val.team_name|f_escape_xml%}</td>
<td><span class="match">{%$val.matches|f_escape_xml%}</span></td>
<td><span class="rate">{%$val.rate|f_escape_xml%}</span></td>
</tr>
{%/foreach%}
</table>
</div>
</section>
{%/if%}
<div class="source">
<div>数据支持：</div>
</div>
{%if !empty($profile.official_tactic)%}
<div class="cover"></div>
<div class="formation m-hide">
<div class="bd">
<div class="title">
最近{%$profile.total_tactic|f_escape_xml%}场比赛所使用的首发阵型统计：</div>
<div class="sum-wrap">
{%foreach $profile.official_tactic as $val%}
<div class="sum-item">
<span class="tactic-name">{%$val.tactic_name|f_escape_xml%}</span>
<span>{%$val.used_times|f_escape_xml%}</span>
</div>
{%/foreach%}
</div>
</div>
<div class="close">
关闭</div>
</div>
{%/if%}
</section>
{%require name='match:page/foreign_coach.tpl'%}{%/block%}
