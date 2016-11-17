{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="home:static/index/index.scss"%}
{%/block%}
{%block name="content"%}
{%widget
        name="common:widget/top-nav/top-nav.tpl"
        channel="sports"
        isTwoNav=true
    %}
{%if !empty($custom["m_forcus"])%}
{%widget
            name="home:widget/card-slide/slide.tpl"
            block="page_index_top"
            data=$custom["m_forcus"]
        %}
{%/if%}
<section class="index-wrap" dace-node="{%$id4dace|f_escape_xml%}_game">
{%widget
            name="home:widget/match-board/match-board.tpl"
            data=$gameList
            from="index"
        %}
{%if !empty($custom["home_diy"])%}
<div class="home-diy {%if $isPredict%}hasPredict{%/if%}">
{%widget
            name="home:widget/card-1/card.tpl"
            data=$custom["home_diy"]
            dace="{%$id4dace|f_escape_xml%}_operate"
            isTopline=true
        %}
{%widget
            name="home:widget/card-1/card.tpl"
            data=$custom["home_diy"]
            dace="{%$id4dace|f_escape_xml%}_operate"
        %}
</div>
{%/if%}
{%widget
            name="home:widget/card-2/card.tpl"
            banner="篮球"
            dace="{%$id4dace|f_escape_xml%}_nbaHeadlines"
            sectionExposure="{%$id4dace|f_escape_xml%}_shownba"
            data=$homeData["nba"]
            link = $homeDataUrl["nba"]
        %}
{%widget
            name="common:widget/card-ad/card-ad.tpl"
            data=$adInfo.m_adword.m_home_nba
        %}
<section class="card-col-4" id="u2740429">
{%$adInfo.m_partner.m_home_soccer_upside.adcode|escape:none%}
</section>
{%widget
            name="home:widget/card-2/card.tpl"
            banner="足球"
            dace="{%$id4dace|f_escape_xml%}_soccerHeadlines"
            sectionExposure="{%$id4dace|f_escape_xml%}_showsoccer"
            data=$homeData["soccer"]
            link = $homeDataUrl["soccer"]
        %}
{%widget
            name="home:widget/card-2/card.tpl"
            banner="赛车"
            dace="{%$id4dace|f_escape_xml%}_f1Headlines"
            data=$homeData["f1"]
            link = $homeDataUrl["f1"]
        %}
{%widget
            name="home:widget/card-2/card.tpl"
            banner="网球"
            dace="{%$id4dace|f_escape_xml%}_tennisHeadlines"
            data=$homeData["tennis"]
            link = $homeDataUrl["tennis"]
        %}
{%widget
            name="common:widget/card-ad/card-ad.tpl"
            data=$adInfo.m_adword.m_home_tennis
            pos="bottom"
        %}
{%widget
            name="home:widget/card-2/card.tpl"
            banner="步行街"
            dace="{%$id4dace|f_escape_xml%}_buxingjie"
            sectionExposure="{%$id4dace|f_escape_xml%}_show34"
            data=$homeData["bxj"]
            link = $homeDataUrl["bxj"]
        %}
{%widget
            name="home:widget/card-3/card.tpl"
            banner="识货"
            dace="{%$id4dace|f_escape_xml%}_shihuoSku"
            isBigShow="true"
            data=$shihuo
        %}
{%widget
            name="home:widget/card-4/card.tpl"
            banner="卡路里运动营养"
            dace="{%$id4dace|f_escape_xml%}_kaluli"
            data=$kaluli
        %}
{%if !empty($homeGameData)%}
<section class="card-col-4" dace-node="{%$id4dace|f_escape_xml%}_game" section-exposure="{%$id4dace|f_escape_xml%}_showyouxi">
<div class="card-wrap">
<article class="title">
<h2>游戏</h2>
</article>
<article class="bd">
<ul class="card-game">
{%foreach $homeGameData as $game%}
<li><a href="{%$game.link|f_escape_xml%}" title="{%$game.name|f_escape_xml%}"><img alt="{%$game.name|f_escape_xml%}" src="{%$game.logo|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_youxi_{%$game@index|f_escape_xml%}"/></a></li>
{%/foreach%}
</ul>
</article>
</section>
{%/if%}
</section>
{%/block%}
{%block name="footer"%}
{%widget name="common:widget/footer/footer.tpl" footerType="home"%}
{%require name='home:page/index.tpl'%}{%/block%}
