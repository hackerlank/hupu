{%extends file="common/page/layout-empty.tpl"%} 
{%block name="block_head_static"%}
{%require name="live:static/stats/stats.scss"%}
{%/block%}
{%block name="content"%}
<div class="stats-wrap">
</div><div class="stats-not-list">
暂无统计数据</div>{%require name='live:page/kanqiu-chaoneng-stats.tpl'%}{%/block%}