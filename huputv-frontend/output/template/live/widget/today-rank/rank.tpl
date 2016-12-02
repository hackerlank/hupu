{%if !empty($datas)%}
<div class="day-board">
<div class="board-title">
<div class="tag">人品值排行榜</div>
<a href="/predict/rank/list" target="_blank" class="more">
更多 &gt;</a>
</div>
<div class="rpz-list">
{%$rankCls = ["","no1","no2","no3"]%}
{%$statusCls = ["tie","up","down"]%}
<ul id="J_dayList">
{%foreach $datas as $val%}
<li>
<div class="list-left">
<span class="rank {%if intval($val.rank) < 4%}{%$rankCls[$val.rank]|f_escape_xml%}{%/if%}">
{%$val.rank|f_escape_xml%}
</span>
<span class="status {%$statusCls[$val.change]|default:'new'|f_escape_xml%}">
<em></em>
</span>
<span class="thumb">
<img src="{%$val.header|f_escape_xml%}" alt="" />
</span>
<span class="name" title="{%$val.username|f_escape_xml%}">{%$val.username|f_escape_xml%}</span>
<span class="result 
                            {%if $val.score|string_format:'%d' >= 0%}
                                num 
                            {%else%}
                                lose
                            {%/if%}">{%$val.score|f_escape_xml%}</span>
</div>
<div class="list-right">
<span class="result {%if intval($val.win_score) >= 0%}win{%else%}fail{%/if%}">{%if intval($val.win_score)> 0%}
+{%$val.win_score|f_escape_xml%}
{%else%}
{%$val.win_score|f_escape_xml%}
{%/if%}</span>
</div>
</li>
{%/foreach%}
</ul>
</div>
</div>
{%/if%}