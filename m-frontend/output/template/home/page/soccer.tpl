{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="home:static/nba/index.scss"%}
{%/block%}
{%block name="content"%}
{%widget
        name="common:widget/top-nav/top-nav.tpl"
        channel="soccer"
        isTwoNav=true
    %}
{%widget
            name="home:widget/match-board/match-board.tpl"
            data=$gamelist
            from="index"
        %}
<section class="nba-wrap">
{%widget
            name="home:widget/card-1/card.tpl"
            data=$customSoccer["home_diy"]
            dace="{%$id4dace|f_escape_xml%}_operate"
            isTopline = true
        %}
{%widget
            name="home:widget/card-1/card.tpl"
            data=$customSoccer["home_diy"]
            dace="{%$id4dace|f_escape_xml%}_operate"
        %}
{%widget
            name="home:widget/card-2/card.tpl"
            dace="{%$id4dace|f_escape_xml%}_soccerHeadlines"
            data=$homeData["soccer"]
        %}
{%widget
            name="common:widget/card-ad/card-ad.tpl"
            data=$adInfo.m_adword.soccer_home_top
        %}
{%widget
            name="home:widget/card-2/card.tpl"
            dace="{%$id4dace|f_escape_xml%}_hupuProduct"
            data=$homeData["zhizao"]
            type="soccer"
        %}
{%**widget
            name="home:widget/card-2/card.tpl"
            banner="中超头条"
            dace="{%$id4dace|f_escape_xml%}_china"
            data=$homeData["china"]
        **%}
{%widget
            name="home:widget/card-2/card.tpl"
            banner="足球话题区"
            hideForm=true
            dace="{%$id4dace|f_escape_xml%}_bbs"
            sectionExposure="{%$id4dace|f_escape_xml%}_show1389"
            data=$homeData["huati"]
        %}
<section class="card-col-4" id="u2740431">
{%$adInfo.m_partner.m_soccer_home_epl_upside.adcode|escape:none%}
</section>
{%widget
            name="home:widget/card-2/card.tpl"
            banner="英超"
            hideForm=true
            dace="{%$id4dace|f_escape_xml%}_eng"
            data=$homeData["eng"]
        %}
{%widget
            name="home:widget/card-2/card.tpl"
            banner="西甲"
            hideForm=true
            dace="{%$id4dace|f_escape_xml%}_esp"
            data=$homeData["esp"]
        %}
{%widget
            name="common:widget/card-ad/card-ad.tpl"
            data=$adInfo.m_adword.soccer_home_laliga
            pos="bottom"
        %}
{%widget
            name="home:widget/card-2/card.tpl"
            banner="意甲"
            hideForm=true
            dace="{%$id4dace|f_escape_xml%}_itl"
            data=$homeData["itl"]
        %}
{%widget
            name="home:widget/card-2/card.tpl"
            banner="最热足球新闻"
            dace="{%$id4dace|f_escape_xml%}_hotNews"
            sectionExposure="{%$id4dace|f_escape_xml%}_showhotnews"
            data=$homeData["hotnews"]
        %}
</section>
{%/block%}
{%block name="footer"%}
{%widget name="common:widget/footer/footer.tpl" footerType="index"%}
{%require name='home:page/soccer.tpl'%}{%/block%}
