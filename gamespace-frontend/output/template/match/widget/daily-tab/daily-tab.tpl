<div class="box_a">
<div class="top_bg"></div>
<div class="team_vs">
<div class="team_vs_box">
<div class="team_a">
<div class="img">
<a target="_blank" href="{%$match_info.away_link|f_escape_xml%}"><img alt="{%$match_info.away_name|f_escape_xml%}" src="{%$match_info.away_logo|f_escape_xml%}" height="95" width="95" /></a>
</div>
<div class="message">
<h2>{%$match_info.away_score|f_escape_xml%}</h2>
<p><a href="{%$match_info.away_link|f_escape_xml%}" target="_blank">{%$match_info.away_name|f_escape_xml%}</a></p>
<div>
客队（{%$away_standing.won|f_escape_xml%}胜{%$away_standing.lost|f_escape_xml%}负）</div>
</div>
</div>
{%if $match_info.status == 2%}
<div class="team_num">{%$match_info.process|f_escape_xml%}</div>
{%/if%}
<div class="team_b">
<div class="img">
<a target="_blank" href="{%$match_info.home_link|f_escape_xml%}"><img alt="{%$match_info.home_name|f_escape_xml%}" src="{%$match_info.home_logo|f_escape_xml%}" height="95" width="95" /></a>
</div>
<div class="message">
<h2>{%$match_info.home_score|f_escape_xml%}</h2>
<p><a href="{%$match_info.home_link|f_escape_xml%}" target="_blank">{%$match_info.home_name|f_escape_xml%}</a></p>
<div>
主队（{%$home_standing.won|f_escape_xml%}胜{%$home_standing.lost|f_escape_xml%}负）</div>
</div>
</div>
</div>
<div class="about_fonts clearfix">
<p class="time_f">开赛：{%date('Y年m月d日 H:i', strtotime($match_info.time))%}</p>
<p class="consumTime">耗时：{%$match_info.game_time|default:"暂无统计"|f_escape_xml%}</p>
<p class="arena">球馆：{%$match_info.stadium_name|default:"暂无统计"|f_escape_xml%}</p>
<p class="peopleNum">上座：{%$match_info.attendance|default:"暂无统计"|f_escape_xml%}{%if !empty($match_info.attendance) || $match_info.attendance == "0"%}人{%/if%}</p>
</div>
</div>
<div class="yuece_num">
<div class="yuece_num_a">
<table class="itinerary_table">
{%$away_id=$match_info.away_id%}{%$home_id=$match_info.home_id%}
<tbody>
<tr class="title">
<td></td>
<td>一</td>
<td>二</td>
<td>三</td>
<td>四</td>
{%if !empty($match_stats.$away_id.plus) || !empty($match_stats.$home_id.plus)%}{%foreach from=$match_stats.$away_id.plus item=val%}{%if $val@index == 0%}{%$index = "一"%}{%elseif $val@index == 1%}{%$index = "二"%}{%elseif $val@index == 2%}{%$index
                        = "三"%}{%elseif $val@index == 3%}{%$index = "四"%}{%elseif $val@index == 4%}{%$index = "五"%}{%else $val@index > 4%}{%$index = ""%}{%/if%}
<td class="addtime">加时{%$index|f_escape_xml%}</td>
{%/foreach%}{%/if%}
<td class="total">总分</td>
</tr>
<tr class="away_score">
<td>{%$match_info.away_name|f_escape_xml%}</td>
{%foreach from=$match_stats.$away_id.section item=val%}
<td class="item-away-{%$val@index|f_escape_xml%}">
{%if $match_info.status == "2"%}
{%$val|f_escape_xml%}
{%else%}
{%if $val != "0"%}
{%$val|f_escape_xml%}
{%/if%}
{%/if%}
</td>
{%/foreach%}
{%if !empty($match_stats.$away_id.plus)%}
{%foreach from=$match_stats.$away_id.plus item=val%}
<td class="away-plus-{%$val@index|f_escape_xml%}">
{%if $match_info.status == "2"%}
{%$val|f_escape_xml%}
{%else%}
{%if $val != "0"%}
{%$val|f_escape_xml%}
{%/if%}
{%/if%}
</td>
{%/foreach%}
{%/if%}
<td class="item-away-total">
{%if $match_stats.$away_id.total  != "0" %}
{%$match_stats.$away_id.total|f_escape_xml%}
{%/if%}
</td>
</tr>
<tr class="home_score">
<td>{%$match_info.home_name|f_escape_xml%}</td>
{%foreach from=$match_stats.$home_id.section item=val%}
<td class="item-home-{%$val@index|f_escape_xml%}">
{%if $match_info.status == "2"%}
{%$val|f_escape_xml%}
{%else%}
{%if $val != "0"%}
{%$val|f_escape_xml%}
{%/if%}
{%/if%}
</td>
{%/foreach%}
{%if !empty($match_stats.$away_id.plus) || !empty($match_stats.$home_id.plus)%}
{%foreach from=$match_stats.$home_id.plus item=val%}
<td class="home-plus-{%$val@index|f_escape_xml%}">
{%if $match_info.status == "2"%}
{%$val|f_escape_xml%}
{%else%}
{%if $val != "0"%}
{%$val|f_escape_xml%}
{%/if%}
{%/if%}
</td>
{%/foreach%}
{%/if%}
<td class="item-home-total">
{%if $match_stats.$home_id.total != "0" %}
{%$match_stats.$home_id.total|f_escape_xml%}
{%/if%}
</td>
</tr>
</tbody>
</table>
</div>
<div class="yuece_num_b">
<a target="_self" href="{%$match_info.boxscore_link|f_escape_xml%}" class="d {%$boxscore|f_escape_xml%}"><s></s>{%if $match_info.status == 1%}数据统计{%else if  $match_info.status == 2%}数据直播{%/if%}</a>
{%if $match_info.status == 1%}
{%if !empty($match_info.video_link)%}
<a target="_blank" href="{%$match_info.video_link|f_escape_xml%}" class="e"><s></s>比赛视频</a>
{%else%}
<span class="e_1"><s></s>比赛视频</span>
{%/if%}
{%else $match_info.status == 2%}
<a target="_blank" href="https://goto.hupu.com/?a=goClick&id=3727" class="e"><s></s>视频直播</a>
{%/if%}
<a target="_blank" href="http://goto.hupu.com/?a=goClick&amp;id=2845" class="f"><s></s>手机直播</a>
<a target="_self" href="{%$match_info.textlive_link|f_escape_xml%}" class="b {%$playbyplay|f_escape_xml%}"><s></s>{%if $match_info.status == 1%}文字实录{%else if  $match_info.status == 2%}文字直播{%/if%}</a>
{%if $match_info.status == 1%}
<a target="_self" href="{%$match_info.recap_link|f_escape_xml%}" class="a {%$recap|f_escape_xml%}"><s></s>比赛战报</a>
{%else if $match_info.status == 2%}
<span class="a_1"><s></s>比赛战报</span>
{%/if%}
</div>
</div>
</div>
