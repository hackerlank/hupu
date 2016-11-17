{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="match:static/my-predictHistory/my-predictHistory.scss"%}
{%require name="match:static/my-predictHistory/my-predictHistory.js"%}
{%/block%}
{%block name="content"%}
{%widget
    name="common:widget/top-title/top-title.tpl"
    banner="{%$title|f_escape_xml%}"
%}
{%if !empty($teamlist)%}
<div class="my-predict-wrap" id="J_circleWrap">
{%foreach $teamlist as $key%}
<div class="predict-team {%if $key.showtype == 1%}large{%elseif $key.showtype == 2%}medium{%else%}small{%/if%}" style="border: 3px solid {%$key.color|f_escape_xml%};">
<div class="team-info" style="background-color: {%$key.color|f_escape_xml%};color:{%if $key.colortype == 1%}#fff;{%else%}#000;{%/if%}">
<h4>{%$key.tname|f_escape_xml%}</h4>
<p>预测次数：{%$key.total|f_escape_xml%}</p>
<p>命中率：{%$key.winpercent|f_escape_xml%}%</p>
</div>
</div>{%/foreach%}
</div>
{%else%}
{%if empty($havepredict)%}
<div class="empty-tip">
<p>还未参加过预测</p>
</div>
{%/if%}
<div class="bottom-tip">
<p>预测结果每24小时更新一次</p>
</div>
{%/if%}
{%require name='match:page/my-predictHistory.tpl'%}{%/block%}