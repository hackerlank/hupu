{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="home:static/nba/index.scss"%}
{%/block%}
{%block name="content"%}
{%widget
        name="common:widget/top-nav/top-nav.tpl"
        channel="soccer-channel"
        isTwoNav=true
    %}
<section class="nba-wrap">
{%if !empty($customSoccer["home_diy"])%}
{%widget
                name="home:widget/card-1/card.tpl"
                data=$customSoccer["home_diy"]
                dace="{%$id4dace|f_escape_xml%}_operate"
                isTopline = true
            %}
{%/if%}
{%widget 
                name="home:widget/match-board/match-board.tpl"
                data=$gameList
            %}{%if !empty($customSoccer["home_diy"])%}
{%widget
                name="home:widget/card-1/card.tpl"
                data=$customSoccer["home_diy"]
                dace="{%$id4dace|f_escape_xml%}_operate"
            %}
{%/if%}
{%widget
            name="home:widget/card-2/card.tpl"
            dace="{%$id4dace|f_escape_xml%}_hupuProduct"
            data=$homeData["news"]
        %}
{%widget
            name="home:widget/card-2/card.tpl"
            banner=$homeData["bbs"]["name"]
            dace="{%$id4dace|f_escape_xml%}_soccerHeadlines"
            data=$homeData["bbs"]["data"]
            link=$homeData["bbs"]["url"]
            type="soccer"
        %}
{%if !empty($homeData["teamBbs"]) %}
{%foreach $homeData["teamBbs"] as $item%}
{%widget
                name="home:widget/card-2/card.tpl"
                banner=$item["name"]
                dace="{%$id4dace|f_escape_xml%}_{%$item.fid|f_escape_xml%}"
                data=$item["data"]
                link=$item["url"]
                type="soccer"
            %}
{%/foreach%}
{%/if%}
</section>
{%/block%}
{%block name="footer"%}
{%widget name="common:widget/footer/footer.tpl" footerType="index"%}
{%require name='home:page/soccer-channel.tpl'%}{%/block%}