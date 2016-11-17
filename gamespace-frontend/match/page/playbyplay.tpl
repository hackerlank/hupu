{%extends file="common/page/layout.tpl"%}

{%block name="head_static"%}
    {%require name="match:static/index/index.css"%}
    {%require name="match:static/boxscore/boxscore.css"%}
    {%require name="match:static/playbyplay/playbyplay.css"%}
    {%require name="match:static/playbyplay/playbyplay.js"%}
    {%require name="common:static/js/center.js"%}
    {%$home_id=$match_info.home_id%}

{%/block%}

{%block name="content"%}
<div class="gamecenter_livestart">
    <div class="bgs_png" style="display:none;"></div>
    {%widget name="common:widget/ad-980/ad-980.tpl"%}

    {%widget name="common:widget/page-tab/page-tab.tpl"%}
    {%widget name="common:widget/bread-crumbs/bread-crumbs.tpl" title1="NBA比赛中心" title2="{%$match_info.away_name%}vs{%$match_info.home_name%}文字实录" %}
    {%widget name="match:widget/match-list-schedule-detail/match-list-schedule-detail.tpl"%}

    <div class="gamecenter_content">

        <div class="gamecenter_content_l">
            {%widget name="match:widget/daily-tab/daily-tab.tpl" playbyplay="on"%}

            <div class="table_list_live playbyplay_td" style="margin-top:15px;">
                <table>
                    <tr class="title bg_a">
                        <td class="left" width="69">时间</td>
                        <td width="69">球队</td>
                        <td width="380">事件</td>
                        <td width="157" align="center">比分（{%$match_info.away_name%} - {%$match_info.home_name%}）</td>
                    </tr>
                </table>
            </div>
            <div class="table_list_live playbyplay_td table_overflow">
                <table>
                    {%$sequence_ids = []%}
                    {%foreach from=$text_live item=val%}
                        {%if $val.event_type == 11 || $val.event_type == 14 || $val.event_type == 15 || $val.event_type == 19%}
                            <tr id="{%$val.sequence_id%}">
                                <td colspan="4" style="font-weight:bold;" align="center">{%$val.event%}</td>
                            </tr>
                        {%else%}
                            <tr id="{%$val.sequence_id%}">
                                <td class="tdw-1 left" width="69">{%$val.left_time%}</td>
                                <td width="69">
                                    {%if $val.team == "home"%} {%$match_info.home_name%} {%else%} {%$match_info.away_name%} {%/if%}
                                </td>
                                <td width="380" {%if $val.event_type==1 || $val.event_type==3 %} style="font-weight: bold;" {%/if%}>{%$val.event%}</td>
                                {%$n=strpos($val.vs,'-')%}
                                {%$vsHome=substr($val.vs,0,$n)%}
                                {%$vsAway=substr($val.vs,$n+1)%}
                                <td width="157" align="center">{%$vsAway%}-{%$vsHome%}</td>
                            </tr>
                            <span style="display:none">{%array_unshift($sequence_ids, $val.sequence_id)%}</span>
                        {%/if%}
                    {%/foreach%}
                </table>
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
            {%widget name="match:widget/last-post/last-post.tpl" title="{%$match_info.away_name%}" logo="{%$match_info.away_logo%}" %}
            {%widget name="match:widget/last-post/last-post.tpl" title="{%$match_info.home_name%}" logo="{%$match_info.home_logo%}" %}
            {%widget name="match:widget/news-rank/news-rank.tpl" title="24小时新闻排行榜" news=$hot_news %}
        </div>
    </div>
</div>
<script type="text/javascript">
    window.GM = {
        websocket: "{%$websocket[$websocket|array_rand]%}",
        plus: "{%if isset($match_stats.$home_id.plus)%}{%$match_stats.$home_id.plus%}{%/if%}",
        match_id: "{%$match_info.match_id%}",
        away_name: "{%$match_info.away_name%}",
        home_name: "{%$match_info.home_name%}",
        sequence_ids:{%json_encode($sequence_ids)%},
        /**
         *    const STATUS_OVER = '1'; // 结束
         *    const STATUS_IN_PROGRESS = '2'; // 进行中
         *    const STATUS_NOT_STARTED = '3'; // 未开始
         *    const STATUS_CANCELLED = '4'; // 已取消
         *    const UNKNOWN     = '未知'; // 未知
         */
        is_live: parseInt("{%intval($match_info.status == 2)%}")
    };
</script>
{%/block%}
