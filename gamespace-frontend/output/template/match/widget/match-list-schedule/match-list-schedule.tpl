<div class="table_list" id="table_list_two">
<div class="table_list_l" date="{%$date|f_escape_xml%}"></div>
<div class="table_list_c">
<div class="table">
<ul>
{%foreach from=$weekly_count item=val key=key%}
<li {%if $date == $key%} class="on" {%/if%}>
<a href="{%$val.link|f_escape_xml%}">
<p>{%$val.week|f_escape_xml%}</p>
<div class="team">
<span class="name">{%date('m-d', strtotime($key))%}</span>
</div>
<div class="team2 border">
<span class="name">{%$val.count|f_escape_xml%}场比赛</span>
</div>
</a>
</li>
{%/foreach%}
</ul>
</div>
</div>
<div class="table_list_r2" date="{%$date|f_escape_xml%}"></div>
</div>
