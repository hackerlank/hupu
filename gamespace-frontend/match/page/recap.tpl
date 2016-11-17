{%extends file="common/page/layout.tpl"%}

{%block name="head_static"%}
    {%require name="match:static/index/index.css"%}
    {%require name="match:static/recap/recap.css"%}
    {%require name="common:static/js/center.js"%}
{%/block%}

{%block name="content"%}
<div class="gamecenter_livestart">
    <div class="bgs_png" style="display:none;"></div>
    {%widget name="common:widget/ad-980/ad-980.tpl"%}

    {%widget name="common:widget/page-tab/page-tab.tpl"%}
    {%widget
        name="common:widget/bread-crumbs/bread-crumbs.tpl"
        title1="NBA比赛中心"
        title2="{%$match_info.away_name%}vs{%$match_info.home_name%}比赛战报"
    %}
    {%widget name="match:widget/match-list-schedule-detail/match-list-schedule-detail.tpl"%}

    <div class="gamecenter_content">

        <div class="gamecenter_content_l">
            {%widget name="match:widget/daily-tab/daily-tab.tpl" recap="on"%}

            <div class="table_list_live">
                <div class="news_box">
                    {%if !empty($article)%}
                        <h2>{%$article.title%}</h2>
                        <div class="time">最近更新：{%$article.updated_at%}</div>
                        <div class="content">
                            {%if !empty($article.img)%}
                                <div class="rightPic">
                                    <img src="{%$article.img%}">
                                </div>
                             {%/if%}
                            {%if isset($article.content)%} 
                                {%$article.content|escape:none%} 
                            {%else%}
                                <div style="margin: 80px 0px 80px; text-align: center;">
                                    暂无战报，
                                    <<a href="http://bbs.hupu.com">去论坛逛逛吧>></a>
                                </div>
                                去论坛逛逛吧>> 
                            {%/if%}
                        </div>
                    {%else%}
                    <div style="margin: 80px 0px 80px; text-align: center;">
                        暂无战报，
                        <<a href="http://bbs.hupu.com" style="color: #005EAC">去论坛逛逛吧>></a>
                    </div>
                    {%/if%}
                </div>
            </div>
        </div>


        <div class="gamecenter_content_r">
            <div id="div-gpt-ad-1387359684902-0" style="width:250px; height:250px;">
                <script type="text/javascript">
                    googletag.cmd.push(function() {
                        googletag.display('div-gpt-ad-1387359684902-0');
                    });
                </script>
            </div>
            {%widget name="match:widget/last-post/last-post.tpl" title="{%$match_info.away_name%}" logo="{%$match_info.away_logo%}"%} {%widget name="match:widget/last-post/last-post.tpl" title="{%$match_info.home_name%}" logo="{%$match_info.home_logo%}"%} {%widget
            name="match:widget/news-rank/news-rank.tpl" title="24小时新闻排行榜" news=$hot_news%}
        </div>
    </div>
</div>
</div>
{%/block%}
