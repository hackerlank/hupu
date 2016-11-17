{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="home:static/nba/index.scss"%}
{%/block%}
{%block name="content"%}
{%widget
        name="common:widget/top-nav/top-nav.tpl"
        channel="nba"
        isTwoNav=true
    %}
<section class="nba-wrap">
{%if isset($customNba["home_diy"]) && !empty($customNba["home_diy"])%}
{%widget
                name="home:widget/card-1/card.tpl"
                data=$customNba["home_diy"]
                dace="{%$id4dace|f_escape_xml%}_operate"
                isTopline = true
            %}
{%/if%}
{%widget
                name="home:widget/match-board/match-board.tpl"
                data=$gameList
            %}
{%if isset($customNba["home_diy"]) && !empty($customNba["home_diy"])%}
{%widget
                name="home:widget/card-1/card.tpl"
                dace="{%$id4dace|f_escape_xml%}_operate"
                data=$customNba["home_diy"]
            %}
{%/if%}
<div class="card-4-wrap">
{%widget
            name="home:widget/card-2/card.tpl"
            dace="{%$id4dace|f_escape_xml%}_nbaHeadlines"
            data=$homeData["nba"]
        %}
{%widget
            name="common:widget/card-ad/card-ad.tpl"
            data=$adInfo.m_adword.nba_home_top
        %}
{%widget
            name="home:widget/card-2/card.tpl"
            dace="{%$id4dace|f_escape_xml%}_hupuProduct"
            data=$homeData["zhizao"]
        %}
{%widget
            name="home:widget/card-2/card.tpl"
            banner="湿乎乎话题区"
            showFrom=true
            dace="{%$id4dace|f_escape_xml%}_bbs"
            sectionExposure="{%$id4dace|f_escape_xml%}_show1048"
            data=$homeData["topic"]
        %}
{%foreach from=$homeData.teams item=val key=keys %}
{%if $val[0]["boardname"] == "火箭专区"%}
<section class="card-col-4" id="u2740416">
{%$adInfo.m_partner.m_nba_home_rockets_upside.adcode|escape:none%}
</section>
{%/if%}
{%widget
                name="home:widget/card-2/card.tpl"
                banner="{%$val[0]["boardname"]|f_escape_xml%}"
                showFrom=true
                dace="{%$id4dace|f_escape_xml%}_nbaPlate"
                data=$val
            %}
{%/foreach%}
{%widget
            name="common:widget/card-ad/card-ad.tpl"
            data=$adInfo.m_adword.nba_home_lakers
            pos="bottom"
        %}
{%widget
            name="home:widget/card-2/card.tpl"
            banner="最热NBA新闻"
            dace="{%$id4dace|f_escape_xml%}_hotNews"
            sectionExposure="{%$id4dace|f_escape_xml%}_showhotnews"
            data=$homeData["hotnews"]
        %}
</div>
</section>
{%/block%}
{%block name="footer"%}
{%widget name="common:widget/footer/footer.tpl" footerType="index"%}
{%require name='home:page/nba.tpl'%}{%/block%}
