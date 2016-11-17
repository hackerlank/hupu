<table class="players_table bott" style="margin-bottom:5px; border-color:#f6f3f3">
<tbody>
<tr class="bottTitle">
<td colspan="17">职业生涯{%if $type == "career_regular_data"%}常规赛{%else%}季后赛{%/if%}平均数据</td>
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
{%if !empty($data.data_normal)%}
<table class="players_table bott bgs_table">
<tbody>
<tr class="color_font1 borders_btm">
<td>赛季</td>
<td class="left">球队</td>
<td>场次</td>
<td>首发</td>
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
{%foreach $data.data_normal as $val%}
<tr class="color_font1 borders_btm">
<td>{%$val.season|f_escape_xml%}</td>
<td class="left">{%$val.team_name|f_escape_xml%}</td>
<td>{%$val.games|f_escape_xml%}</td>
<td>{%$val.games_started|f_escape_xml%}</td>
<td>{%$val.mins|f_escape_xml%}</td>
<td>{%$val.fgm|f_escape_xml%}-{%$val.fga|f_escape_xml%}</td>
<td>{%$val.fgp|f_escape_xml%}%</td>
<td>{%$val.tpm|f_escape_xml%}-{%$val.tpa|f_escape_xml%}</td>
<td>{%$val.tpp|f_escape_xml%}%</td>
<td>{%$val.ftm|f_escape_xml%}-{%$val.fta|f_escape_xml%}</td>
<td>{%$val.ftp|f_escape_xml%}%</td>
<td>{%$val.reb|f_escape_xml%}</td>
<td>{%$val.asts|f_escape_xml%}</td>
<td>{%$val.stl|f_escape_xml%}</td>
<td>{%$val.blk|f_escape_xml%}</td>
<td>{%$val.to|f_escape_xml%}</td>
<td>{%$val.pf|f_escape_xml%}</td>
<td>{%$val.pts|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
{%/if%}
