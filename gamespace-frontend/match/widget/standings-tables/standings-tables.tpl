<tr class="linglei">
  <td colspan="14" class="left">{%$title%}</td>
</tr>
<tr class="color_font1 bg_a">
    <td width="60">排名</td>
    <td width="292" class="left">队名</td>
    <td width="40">胜</td>
    <td width="40">负</td>
    <td width="40">胜率</td>
    <td width="100">胜场差</td>
    <td width="60">主场</td>
    <td width="60">客场</td>
    <td width="60">赛区</td>
    <td width="60">东部</td>
    <td width="60">得分</td>
    <td width="60">失分</td>
    <td width="40">净胜</td>
    <td width="100">连胜/负</td>
</tr>
{%foreach $data as $item%}
  <tr>
      <td>{%if $item@index < 8 && $hasBg|default:false%}<span class="{%if $title == "东部"%}rank_bg{%else%}rank_bg2{%/if%}">{%$item@index+1%}</span>{%else%}{%$item@index+1%}{%/if%}</td>
      <td class="left"><a target="_blank" href="{%$item.team_link%}">{%$item.team_name%}</a></td>
      <td>{%$item.win%}</td>
      <td>{%$item.lost%}</td>
      <td>{%$item.win_rate%}%</td>
      <td>{%$item.gb%}</td>
      <td>{%$item.home%}</td>
      <td>{%$item.road%}</td>
      <td>{%$item.div%}</td>
      <td>{%$item.conf%}</td>
      <td>{%$item.pf%}</td>
      <td>{%$item.pa%}</td>
      <td>{%$item.diff%}</td>
      <td>{%$item.strk%}</td>
  </tr>
{%/foreach%}
