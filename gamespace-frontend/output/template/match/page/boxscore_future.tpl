{%extends file="common/page/layout.tpl"%} 
{%block name="head_static"%}
{%require name="match:static/index/index.css"%}
{%require name="match:static/boxscore/boxscore.css"%}
{%require name="match:static/boxscore_future/boxscore_future.scss"%}
{%require name="common:static/js/highcharts/highcharts.js"%}
{%require name="common:static/js/highcharts/highcharts-more.js"%}
{%require name="match:static/boxscore_future/boxscore_future.js"%}
{%require name="common:static/js/player.js"%}
{%require name="common:static/js/center.js"%}
<script type="text/javascript">
        window.GM = {
            "away_name": "{%$match_info.away_name|f_escape_js%}",
            "home_name": "{%$match_info.home_name|f_escape_js%}",
            "away_team_rank_info": {%json_encode($away_avg_score)%},
            "home_team_rank_info": {%json_encode($home_avg_score)%},
            "away_latest_five": {%json_encode($away_latest_five)%}
        };
    </script>
{%/block%}
{%block name="content"%}
<div class="gamecenter_livestart">
<div class="bgs_png" style="display:none;"></div>
{%widget name="common:widget/ad-980/ad-980.tpl"%}
{%widget name="common:widget/page-tab/page-tab.tpl"%}
{%widget
        name="common:widget/bread-crumbs/bread-crumbs.tpl"
        title1="NBA比赛中心"
        title2="{%$match_info.away_name|f_escape_xml%}vs{%$match_info.home_name|f_escape_xml%}比赛前瞻"
    %}
{%widget name="match:widget/match-list-schedule-detail/match-list-schedule-detail.tpl"%}
<div class="gamecenter_content">
<div class="gamecenter_content_l">
{%widget name="match:widget/daily-tab/daily-tab-future.tpl" boxscore="on"%}
<div class="title_tip">
<div class="border"></div>
<span class="title_border">
<span class="title_font">两队基本数据对比</span>
</span>
</div>
<div class="box_b" id="box_b" style="width: 600px; height: 350px; margin:0 auto;">
</div>
<div class="team_hig">
<div class="title_style">
<div class="boreder"></div>
<span class="title_border">
<span class="title_font">{%$match_info.name|f_escape_xml%}本赛季表现</span>
</span>
</div>
<div class="Js_show_line" style="display: block;">
{%widget name="match:widget/data-chart/data-chart.tpl" type="team_data_avg" %}
</div>
</div>
<div class="table_choose">
<a target="_self" href="{%$match_info.boxscore_link|f_escape_xml%}" class="d on"><s></s>比赛前瞻</a>
<a target="_blank" href="https://goto.hupu.com/?a=goClick&id=3727" class="e"><s></s>视频直播</a>
<a target="_blank" href="http://goto.hupu.com/?a=goClick&amp;id=2845" class="f"><s></s>手机直播</a>
<span class="b_1"><s></s>文字实录</span>
<span class="a_1"><s></s>比赛战报</span>
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
{%widget
                name="match:widget/last-post/last-post.tpl"
                title="{%$match_info.away_name|f_escape_xml%}"
                logo="{%$match_info.away_logo|f_escape_xml%}"
            %}
{%widget
                name="match:widget/last-post/last-post.tpl"
                title="{%$match_info.home_name|f_escape_xml%}"
                logo="{%$match_info.home_logo|f_escape_xml%}"
            %}
{%widget
                name="match:widget/news-rank/news-rank.tpl"
                title="24小时新闻排行榜"
                news=$hot_news
            %}
</div>
</div>
</div>
</div>
{%require name='match:page/boxscore_future.tpl'%}{%/block%}
