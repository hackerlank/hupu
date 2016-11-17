{%extends file="app/page/layout-empty.tpl"%}

{%block name="title"%}主播公告{%/block%}

{%block name="head_static"%}
    {%require name="app:static/notice/notice.scss"%}
{%/block%}

{%block name="content"%}
<section class="content">
    <h2>主播公告</h2>
    {%if !empty($notice)%}
        <p>{%$notice|escape:none%}</p>
    {%else%}
        <p>暂无公告</p>
    {%/if%}
</section>
{%/block%}
