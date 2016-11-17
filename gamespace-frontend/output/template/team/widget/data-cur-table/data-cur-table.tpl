<table class="players_table bott" style="margin-bottom:5px; border-color:#f6f3f3">
<tbody>
<tr class="bottTitle">
<td colspan="17">本赛季{%if $type == "cur_regular_data"%}常规赛{%else%}季后赛{%/if%}平均数据</td>
</tr>
<tr class="color_font1">
<td>场次</td>
<td>时间</td>
<td>投篮</td>
<td>命中率</td>
<td>三分</td>
<td>命中率</td>
<td>罚球</td>
<td>命中率</td>
<td>篮板</td>
<td>助攻</td>
<td>抢断</td>
<td>盖帽</td>
<td>失误</td>
<td>犯规</td>
<td>得分</td>
</tr>
<tr>
<td>{%$data.data_avg.games|f_escape_xml%}</td>
<td>{%$data.data_avg.mins|f_escape_xml%}</td>
<td>{%$data.data_avg.fgm|f_escape_xml%}-{%$data.data_avg.fga|f_escape_xml%}</td>
<td>{%$data.data_avg.fgp|f_escape_xml%}</td>
<td>{%$data.data_avg.tpm|f_escape_xml%}-{%$data.data_avg.tpa|f_escape_xml%}</td>
<td>{%$data.data_avg.tpp|f_escape_xml%}</td>
<td>{%$data.data_avg.ftm|f_escape_xml%}-{%$data.data_avg.fta|f_escape_xml%}</td>
<td>{%$data.data_avg.ftp|f_escape_xml%}</td>
<td>{%$data.data_avg.reb|f_escape_xml%}</td>
<td>{%$data.data_avg.asts|f_escape_xml%}</td>
<td>{%$data.data_avg.stl|f_escape_xml%}</td>
<td>{%$data.data_avg.blk|f_escape_xml%}</td>
<td>{%$data.data_avg.to|f_escape_xml%}</td>
<td>{%$data.data_avg.pf|f_escape_xml%}</td>
<td>{%$data.data_avg.pts|f_escape_xml%}</td>
</tr>
</tbody>
</table>
{%foreach from=$data.data_normal item=val key=key%}
<table class="players_table bott bgs_table">
<tbody>
<tr>
<td colspan="17" class="left td_a"><s></s><b>{%$key|mb_substr:4:2:'utf-8'|f_escape_xml%}月</b>数据</td>
</tr>
<tr class="color_font1 borders_btm">
<td>日期</td>
<td class="left" width="8%">对手</td>
<td class="left">比分</td>
<td>时间</td>
<td>投篮</td>
<td>命中率</td>
<td>三分</td>
<td>命中率</td>
<td>罚球</td>
<td>命中率</td>
<td>篮板</td>
<td>助攻</td>
<td>抢断</td>
<td>盖帽</td>
<td>失误</td>
<td>犯规</td>
<td>得分</td>
</tr>
{%foreach $val as $subVal%}
<tr class="color_font1 borders_btm">
<td>{%$subVal.china_time|f_escape_xml%}</td>
<td class="left" width="8%">{%$subVal.opponents|f_escape_xml%}</td>
<td class="left">{%$subVal.away_score|f_escape_xml%}-{%$subVal.home_score|f_escape_xml%}</td>
<td>{%$subVal.mins|f_escape_xml%}</td>
<td>{%$subVal.fgm|f_escape_xml%}-{%$subVal.fga|f_escape_xml%}</td>
<td>{%$subVal.fgp|f_escape_xml%}%</td>
<td>{%$subVal.tpm|f_escape_xml%}-{%$subVal.tpa|f_escape_xml%}</td>
<td>{%$subVal.tpp|f_escape_xml%}%</td>
<td>{%$subVal.ftm|f_escape_xml%}-{%$subVal.fta|f_escape_xml%}</td>
<td>{%$subVal.ftp|f_escape_xml%}%</td>
<td>{%$subVal.reb|f_escape_xml%}</td>
<td>{%$subVal.asts|f_escape_xml%}</td>
<td>{%$subVal.stl|f_escape_xml%}</td>
<td>{%$subVal.blk|f_escape_xml%}</td>
<td>{%$subVal.to|f_escape_xml%}</td>
<td>{%$subVal.pf|f_escape_xml%}</td>
<td>{%$subVal.pts|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
{%/foreach%}
