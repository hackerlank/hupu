{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="home:static/nba/index.scss"%}
{%require name="home:static/nba-tieba/nba-tieba.scss"%}
{%/block%}
{%block name="content"%}
<section class="nba-wrap">
{%if isset($customNba["home_diy"]) && !empty($customNba["home_diy"])%}
{%widget
                name="home:widget/card-1/card.tpl"
                data=$customNba["home_diy"]
                fromurl=$from
                dace="{%$id4dace|f_escape_xml%}_operate"
                isTopline = true
            %}
{%/if%}
{%if isset($customNba["home_diy"]) && !empty($customNba["home_diy"])%}
{%widget
                name="home:widget/card-1/card.tpl"
                dace="{%$id4dace|f_escape_xml%}_operate"
                data=$customNba["home_diy"]
                fromurl=$from
            %}
{%/if%}
<div class="card-4-wrap">
{%widget
                name="home:widget/card-2/card.tpl"
                banner="最热NBA新闻"
                dace="{%$id4dace|f_escape_xml%}_hotNews"
                sectionExposure="{%$id4dace|f_escape_xml%}_showhotnews"
                data=$homeData
            %}
</div>
</section>
{%/block%}
{%block name="footer"%}
{%require name='home:page/nba-tieba.tpl'%}{%/block%}