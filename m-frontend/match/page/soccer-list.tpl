{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="match:static/soccer-list/soccer-list.scss"%}

{%/block%}

{%block name="content"%}
    {%widget
        name="common:widget/top-nav/top-nav.tpl"
    %}

    {%widget
        name="common:widget/ui/soccer-match-list/match-list.tpl"
        data=$gameList
    %}
{%/block%}   