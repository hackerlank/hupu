{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="teams:static/players/soccer-players.css"%}
{%script%}
        var toShare = require("common:widget/ui/share/share.js");

        //全局分享事件, 每个页面单独注册.
        $(document).on("page:share", function(){
            toShare();
        });
    {%/script%}
{%/block%}
{%block name="content"%}
{%widget
        name="common:widget/inner-top-nav/nav.tpl"
    %}
<section class="m-wrap teams-data-wrap">
{%widget
            name="teams:widget/soccer-team-header/header.tpl"
        %}
{%widget
            name="common:widget/inner-tab/tab.tpl"
            tabClass="soccer-team"
            selected=4
        %}
<div class="season-content technical-content">
<div class="table-scroll">
<table class="table table-3">
<tbody>
<tr>
<td class="number-1">射门</td>
<td class="number-2">{%$statsInfo.total_scoring_att|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">射正</td>
<td class="number-2">{%$statsInfo.ontarget_scoring_att|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">角球</td>
<td class="number-2">{%$statsInfo.won_corners|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">传中</td>
<td class="number-2">{%$statsInfo.total_cross|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">控球率</td>
<td class="number-2">{%$statsInfo.possession_percentage|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">越位</td>
<td class="number-2">{%$statsInfo.total_offside|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">黄牌</td>
<td class="number-2">{%$statsInfo.total_yel_card|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">红牌</td>
<td class="number-2">{%$statsInfo.total_red_card|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">犯规</td>
<td class="number-2">{%$statsInfo.fk_foul_lost|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">点球</td>
<td class="number-2">{%$statsInfo.att_pen_goal|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">抢断</td>
<td class="number-2">{%$statsInfo.total_tackle|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">传球</td>
<td class="number-2">{%$statsInfo.total_pass|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">拦截</td>
<td class="number-2">{%$statsInfo.interception|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">扑救</td>
<td class="number-2">{%$statsInfo.saves|f_escape_xml%}</td>
</tr>
<tr>
<td class="number-1">解围数</td>
<td class="number-2">{%$statsInfo.total_clearance|f_escape_xml%}</td>
</tr>
</tbody>
</table>
</div>
</div>
</section>
{%require name='teams:page/soccer-teams-data.tpl'%}{%/block%}