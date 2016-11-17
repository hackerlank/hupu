{%extends file="common/page/layout.tpl"%} 
{%block name="head_static"%}
{%require name="match:static/data/data.css"%}
{%require name="match:static/data/data.js"%}
{%/block%}
{%block name="content"%}
<div class="gamecenter_livestart" id="data_js">
<div class="bgs_png" style="display:none;"></div>
{%widget name="common:widget/ad-980/ad-980.tpl"%}
{%widget name="common:widget/page-tab/page-tab.tpl" title="数据排名"%}
{%widget name="match:widget/data-nav/data-nav.tpl" type="teams"%}
<div class="table_data">
<div class="tables" style="display:block; position: relative;">
<div class="postborder" style="left: 510px; display: none;"></div>
<div class="postborder2" style="left: 650px; display: none;"></div>
<div class="postborder3" style="left: 510px; display: none;"></div>
<table class="players_table" id="data_js_sort">
<tbody>
<tr class="title">
<td colspan="2" width="135"></td>
<td colspan="3" width="175" class="jslist_a"><a href="javascript:void(0);" class="up_downs">投篮<s class="" atr="2"></s></a></td>
<td colspan="3" width="175" class="jslist_b"><a href="javascript:void(0);" class="up_downs">三分<s class="" atr="5"></s></a></td>
<td colspan="3" width="175" class="jslist_c"><a href="javascript:void(0);" class="up_downs">罚球<s class="" atr="8"></s></a></td>
<td colspan="3" width="175" class="jslist_d"><a href="javascript:void(0);" class="up_downs">篮板<s class="" atr="11"></s></a></td>
<td width="45" class="jslist_e"><a href="javascript:void(0);" class="up_downs">助攻<s class="" atr="14"></s></a></td>
<td width="45" class="jslist_f"><a href="javascript:void(0);" class="up_downs">失误<s class="" atr="15"></s></a></td>
<td width="45" class="jslist_g"><a href="javascript:void(0);" class="up_downs">抢断<s class="" atr="16"></s></a></td>
<td width="45" class="jslist_h"><a href="javascript:void(0);" class="up_downs">盖帽<s class="" atr="17"></s></a></td>
<td width="45" class="jslist_i"><a href="javascript:void(0);" class="up_downs">犯规<s class="" atr="18"></s></a></td>
<td width="45" class="jslist_j"><a href="javascript:void(0);" class="up_downs" style="color: rgb(187, 18, 21);">得分<s class="on1" atr="19"></s></a></td>
</tr>
<tr class="color_font1 bg_a">
<td>排名</td>
<td>球队</td>
<td>命中率</td>
<td>命中</td>
<td>出手</td>
<td>命中率</td>
<td>命中</td>
<td>出手</td>
<td>命中率</td>
<td>命中</td>
<td>出手</td>
<td>总篮板</td>
<td>进攻</td>
<td>防守</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
{%foreach $rank as $item%}
<tr>
<td>{%$item@index+1%}</td>
<td><a target="_blank" href="{%$item.team_link|f_escape_xml%}">{%$item.team_name|f_escape_xml%}</a></td>
<td>{%$item.fgp|f_escape_xml%}</td>
<td>{%$item.fgm|f_escape_xml%}</td>
<td>{%$item.fga|f_escape_xml%}</td>
<td>{%$item.tgp|f_escape_xml%}</td>
<td>{%$item.tgm|f_escape_xml%}</td>
<td>{%$item.tga|f_escape_xml%}</td>
<td>{%$item.ftp|f_escape_xml%}</td>
<td>{%$item.ftm|f_escape_xml%}</td>
<td>{%$item.fta|f_escape_xml%}</td>
<td>{%$item.reb|f_escape_xml%}</td>
<td>{%$item.oreb|f_escape_xml%}</td>
<td>{%$item.dreb|f_escape_xml%}</td>
<td>{%$item.ast|f_escape_xml%}</td>
<td>{%$item.fault|f_escape_xml%}</td>
<td>{%$item.st|f_escape_xml%}</td>
<td>{%$item.blk|f_escape_xml%}</td>
<td>{%$item.foul|f_escape_xml%}</td>
<td>{%$item.pts|f_escape_xml%}</td>
</tr>
{%/foreach%}
</tbody>
</table>
</div>
</div>
</div>
{%require name='match:page/data-teams.tpl'%}{%/block%}
