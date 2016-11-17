{%extends file="common/page/layout.tpl"%} 
{%block name="head_static"%}
{%require name="match:static/schedule/schedule.css"%}
{%require name="common:static/js/datepicker/datepicker.css"%}
{%require name="common:static/js/datepicker/datepicker.js"%}
{%require name="common:static/js/eye.js"%}
{%require name="common:static/js/center.js"%}
{%require name="common:static/js/table.js"%}
{%script%}
        var base_url = '/schedule/';

        var base_date = "{%$date[0]|f_escape_js%}" || "new Date().toLocaleDateString().replace(/\//g,'-')";

        $('#date').DatePicker({
            flat: true,
            date: base_date,
            current: base_date,
            starts : 7,
            locale: {
                days: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"],
                daysShort: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
                daysMin: ["日","一", "二", "三", "四", "五", "六", "日"],
                months: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
                monthsShort: ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"]
            },
            onChange: function(){
                var url = base_url + $('#date').DatePickerGetDate('Y-m-d');
                if(window.location.href != url){
                    window.location = url;
                }

            }
        });

        playersList.init();//队伍列表事件
    {%/script%}
{%/block%}
{%block name="content"%}
<div id="allteamNba" class="gamecenter_livestart">
<div class="bgs_png" style="display:none;"></div>
{%widget name="common:widget/ad-980/ad-980.tpl"%}
{%widget name="common:widget/page-tab/page-tab.tpl" title="比赛赛程"%}
{%widget
        name="common:widget/team-nav/team-nav.tpl"
        type="schedule_all"
    %}
<div class="players_right" style="margin-bottom:10px;">
<div class="postfix_bg" style="display:none;"></div>
<div class="choosedare clearfix">
<div class="datas">{%$date[0]|date_format:'%Y'%}年</div>
<div class="a">
<b><a class="t1" href="/schedule/{%$date[0]|format_date:1:7|f_escape_path%}">前七天</a></b><span class="t2">{%$date[0]|date_format:'%m-%d'%}至{%$date[1]|date_format:'%m-%d'%}</span><b><a class="t3" href="/schedule/{%$date[1]|format_date:2:1|f_escape_path%}">后七天</a></b>
</div>
<div class="b"><img src="//w1.hoopchina.com.cn/channel/gamespace/static/match/img/schedule/date_225763e.jpg"></div>
<div id="date">
</div>
</div>
<div class="mar_height"></div>
{%if !empty($match)%}
<table class="players_table" style="display:block;">
<tbody>
<tr class="title">
<td class="left" width="165">北京时间</td>
<td width="280">客队 vs 主队</td>
<td width="150"></td>
</tr>
{%foreach from=$match item=val key=key%}
<tr class="left linglei">
<td colspan="3" class="left" width="135">{%$key|mb_substr:5:2:"utf-8"|f_escape_xml%}月{%$key|mb_substr:8:2:"utf-8"|f_escape_xml%}日&nbsp;&nbsp;{%$key|mb_substr:11:3:"utf-8"|f_escape_xml%}</td>
</tr>
{%foreach $val as $subVal%}
<tr class="left">
<td class="left" width="135">{%$subVal.time|date_format:'%H:%M'%}</td>
<td width="360">
<a href="{%$subVal.away_link|f_escape_xml%}" target="_blank">{%$subVal.away_name|f_escape_xml%}</a>&nbsp;vs&nbsp;<a href="{%$subVal.home_link|f_escape_xml%}" target="_blank">{%$subVal.home_name|f_escape_xml%}</a>
</td>
<td>
{%if $subVal.status == 1%}
<a target="_blank" href="{%$subVal.boxscore_link|f_escape_xml%}">数据统计</a>&nbsp;&nbsp;&nbsp;<a target="_blank" href="{%$subVal.video_link|f_escape_xml%}">比赛视频</a>
{%else if $subVal.status == 2%}
<a target="_blank" href="{%$subVal.boxscore_link|f_escape_xml%}">数据直播</a>&nbsp;&nbsp;&nbsp;<a target="_blank" href="http://goto.hupu.com/?a=goClick&id=3727">视频直播</a>
{%else%}
<a target="_blank" href="{%$subVal.boxscore_link|f_escape_xml%}">比赛前瞻</a>&nbsp;&nbsp;&nbsp;<a target="_blank" href="http://goto.hupu.com/?a=goClick&id=3727">视频直播</a>
{%/if%}
</td>
</tr>
{%/foreach%}
{%/foreach%}
</tbody>
</table>
{%else%}
<div style="margin: 80px 0px 80px; text-align: center;">
该时间段没有比赛，<a href="http://bbs.hupu.com/all-nba" style="color: #005EAC">去论坛逛逛吧&gt;&gt;</a>
</div>
{%/if%}
</div>
</div>
{%require name='match:page/allSchedule.tpl'%}{%/block%}
