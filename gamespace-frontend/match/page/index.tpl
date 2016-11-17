{%extends file="common/page/layout.tpl"%}

{%block name="head_static"%}
    {%require name="match:static/index/index.css"%}
    {%require name="common:static/js/center.js"%}
{%/block%}

{%block name="content"%}
<div class="gamecenter_livestart">
    <div class="bgs_png" style="display:none;"></div>
    {%widget name="common:widget/ad-980/ad-980.tpl"%}

    {%widget
        name="common:widget/page-tab/page-tab.tpl"
        title="比赛中心"
    %}
    {%widget
        name="match:widget/match-list-schedule/match-list-schedule.tpl"
        match_list=$match_list
    %}

    <div class="gamecenter_content">
        <div class="gamecenter_content_l">
            {%if !empty($match_list)%}
                {%foreach from=$match_list item=val key=key%}
                    <div class="list_box">
                        <div class="border_a">
                            <div class="team_vs">
                                <div class="team_vs_a">
                                    <div class="team_vs_a_1 clearfix">
                                        <div class="img">
                                            <a target="_blank" href="{%$val.away_link%}">
                                                <img src="{%$val.away_logo%}" height="50" width="50">
                                            </a>
                                        </div>
                                        <div class="txt">
                                            {%if $val.status != 3%}
                                            <span class="num {%if $val.status == 1 && $val.away_score > $val.home_score%}red{%/if%}">{%$val.away_score%}</span>
                                            {%/if%}
                                            <span>
                                                <a target="_blank" href="{%$val.away_link%}">{%$val.away_name%}</a>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="team_vs_a_2 clearfix">
                                        <div class="img">
                                            <a target="_blank" href="{%$val.home_link%}">
                                                <img src="{%$val.home_logo%}" height="50" width="50">
                                            </a>
                                        </div>
                                        <div class="txt">
                                            {%if $val.status != 3%}
                                            <span class="num {%if $val.status == 1 && $val.away_score < $val.home_score%}red{%/if%}">{%$val.home_score%}</span>
                                            {%/if%}
                                            <span>
                                                <a target="_blank" href="{%$val.home_link%}">{%$val.home_name%}</a>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="{%if $val.status == 2%}team_vs_c{%else%}team_vs_b{%/if%}">
                                    <span class="a"></span>
                                    <span class="b">
                                        {%if $val.status == 1%}
                                            已结束
                                        {%elseif $val.status == 2%}
                                            进行中
                                            <p>{%$val.process%}</p>
                                        {%elseif $val.status == 3%}
                                            未开始
                                            <p>{%date('H:i',strtotime($val.time))%}</p>
                                        {%elseif $val.status == 4%}
                                            已取消
                                        {%else%}
                                            未知
                                        {%/if%}
                                    </span>
                                </div>
                            </div>
                            <p class="tips">
                                <a {%if $val.status != 1%}target="_blank"{%/if%} href="{%if $val.status == 1%}{%$val.recap_link%}{%else%}https://goto.hupu.com/?a=goClick&id=2845{%/if%}">{%if $val.status == 1%}{%$val.recap_title%}{%else%}{%$val.away_name%}vs{%$val.home_name%}手机直播{%/if%}</a>
                            </p>
                            <div class="table_choose clearfix">
                                <a target="_self" href="{%$val.boxscore_link%}" class="d"><s></s>{%if $val.status == 1%}数据统计{%else if $val.status == 2%}数据直播{%else%}比赛前瞻{%/if%}</a>
                                {%if $val.status == 1 || $val.status == 2%}
                                    <a target="_self" href="{%$val.playbyplay_link%}" class="b"><s></s>{%if $val.status == 1%}文字实录{%else if  $val.status == 2%}文字直播{%/if%}</a>
                                {%else%}
                                    <span class="b_1"><s></s>文字直播</span>
                                {%/if%}
                                {%if $val.status == 1%}
                                    {%if !empty($val.video_link)%}
                                        <a target="_blank" href="{%$val.video_link%}" class="e"><s></s>比赛视频</a>
                                    {%else%}
                                        <span class="e_1"><s></s>比赛视频</span>
                                    {%/if%}
                                {%else $val.status == 2%}
                                    <a target="_blank" href="https://goto.hupu.com/?a=goClick&id=3727" class="e"><s></s>视频直播</a>
                                {%/if%}
                            </div>
                            <div class="table_data">
                                <table class="itinerary_table">
                                    <tbody>
                                        <tr class="title">
                                            <td width="50" class="left"></td>
                                            <td>一</td>
                                            <td>二</td>
                                            <td>三</td>
                                            <td>四</td>
                                            {%if isset($val.match_stats[$val.home_id].plus)%}
                                                {%foreach $val.match_stats[$val.home_id].plus as $subVal1%}
                                                    {%if $subVal1@index == 0%}
                                                    <td>加时一</td>
                                                    {%else if $subVal1@index == 1%}
                                                    <td>加时二</td>
                                                    {%else if $subVal1@index == 2%}
                                                    <td>加时三</td>
                                                    {%else if $subVal1@index == 3%}
                                                    <td>加时四</td>
                                                    {%else if $subVal1@index == 4%}
                                                    <td>加时五</td>
                                                    {%/if%}
                                                {%/foreach%}
                                            {%/if%}
                                            <td>总分</td>
                                        </tr>
                                        <tr>
                                            <th class="left">
                                                <a target="_blank" href="{%$val.away_link%}">
                                                    {%$val.away_name%}
                                                </a>
                                            </th>
                                            {%foreach $val.match_stats[$val.away_id].section as $subVal%}
                                                <td>{%$subVal%}</td>
                                            {%/foreach%}
                                            {%if isset($val.match_stats[$val.away_id].plus)%}
                                                {%foreach $val.match_stats[$val.away_id].plus as $subVal%}
                                                    <td>{%$subVal%}</td>
                                                {%/foreach%}
                                            {%/if%}
                                            <td>{%$val.match_stats[$val.away_id].total%}</td>
                                        </tr>
                                        <tr>
                                            <th class="left">
                                                <a target="_blank" href="{%$val.home_link%}">
                                                    {%$val.home_name%}
                                                </a>
                                            </th>
                                            {%foreach $val.match_stats[$val.home_id].section as $subVal%}
                                                <td>{%$subVal%}</td>
                                            {%/foreach%}
                                            {%if isset($val.match_stats[$val.home_id].plus)%}
                                                {%foreach $val.match_stats[$val.home_id].plus as $subVal%}
                                                    <td>{%$subVal%}</td>
                                                {%/foreach%}
                                            {%/if%}
                                            <td>{%$val.match_stats[$val.home_id].total%}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="table_data">
                                <table class="itinerary_table">
                                    <tbody>
                                        <tr class="title">
                                            <td width="50"></td>
                                            <td>{%$val.away_name%}</td>
                                            <td></td>
                                            <td>{%$val.home_name%}</td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td class="left"><b>得分王</b></td>
                                            <td>
                                                <a target="_blank" {%if isset($val.top_player.away.pts.link)%}href="{%$val.top_player.away.pts.link%}"{%else%}href="javascript:;" style="text-decoration:none;color:#444!important;cursor:default;"{%/if%}>
                                                    {%$val.top_player.away.pts.alias|default:"暂无"%}
                                                </a>
                                            </td>
                                            <td>{%if isset($val.top_player.away.pts.pts)%}{%$val.top_player.away.pts.pts%}{%/if%}</td>
                                            <td>
                                                <a target="_blank" {%if isset($val.top_player.home.pts.link)%}href="{%$val.top_player.home.pts.link%}"{%else%}href="javascript:;" style="text-decoration:none;color:#444!important;cursor:default;"{%/if%}>
                                                    {%$val.top_player.home.pts.alias|default:"暂无"%}
                                                </a>
                                            </td>
                                            <td>{%if isset($val.top_player.home.pts.pts)%}{%$val.top_player.home.pts.pts%}{%/if%}</td>
                                        </tr>
                                        <tr>
                                            <td class="left"><b>篮板王</b></td>
                                            <td>
                                                <a target="_blank" {%if isset($val.top_player.away.reb.link)%}href="{%$val.top_player.away.reb.link%}"{%else%}href="javascript:;" style="text-decoration:none;color:#444!important;cursor:default;"{%/if%}>
                                                    {%$val.top_player.away.reb.alias|default:"暂无"%}
                                                </a>
                                            </td>
                                            <td>{%if isset($val.top_player.away.reb.reb)%}{%$val.top_player.away.reb.reb%}{%/if%}</td>
                                            <td>
                                                <a target="_blank" {%if isset($val.top_player.home.reb.link)%}href="{%$val.top_player.home.reb.link%}"{%else%}href="javascript:;" style="text-decoration:none;color:#444!important;cursor:default;"{%/if%}>
                                                    {%$val.top_player.home.reb.alias|default:"暂无"%}
                                                </a>
                                            </td>
                                            <td>{%if isset($val.top_player.home.reb.reb)%}{%$val.top_player.home.reb.reb%}{%/if%}</td>
                                        </tr>
                                        <tr>
                                            <td class="left"><b>助攻王</b></td>
                                            <td>
                                                <a target="_blank" {%if isset($val.top_player.away.asts.link)%}href="{%$val.top_player.away.asts.link%}"{%else%}href="javascript:;" style="text-decoration:none;color:#444!important;cursor:default;"{%/if%}>
                                                    {%$val.top_player.away.asts.alias|default:"暂无"%}
                                                </a>
                                            </td>
                                            <td>{%if isset($val.top_player.away.asts.asts)%}{%$val.top_player.away.asts.asts%}{%/if%}</td>
                                            <td>
                                                <a target="_blank" {%if isset($val.top_player.home.asts.link)%}href="{%$val.top_player.home.asts.link%}"{%else%}href="javascript:;" style="text-decoration:none;color:#444!important;cursor:default;"{%/if%}>
                                                    {%$val.top_player.home.asts.alias|default:"暂无"%}
                                                </a>
                                            </td>
                                            <td>{%if isset($val.top_player.home.asts.asts)%}{%$val.top_player.home.asts.asts%}{%/if%}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    {%if $val@index%2 == 0 %}
                        <div class="margin_l"></div>
                    {%/if%}
                {%/foreach%}
            {%else%}
            <div style="margin: 80px 0px 80px; text-align: center;">
                {%date('m月d日', strtotime($date))%}没有比赛，<a style="color: #005EAC" href="http://bbs.hupu.com">去论坛逛逛吧&gt;&gt;</a>
            </div>
            {%/if%}
        </div>
        <div class="gamecenter_content_r">
            {%if !empty($mvp)%}
            <div class="bbs_a rank_box">
                <div class="title">{%date('Y年m月d日', strtotime($date))%}效率排行</div>
                {%foreach $mvp as $val%}
                <div class="list clearfix">
                    <div class="list_a">
                        <a href="{%$val.link%}" target="_blank"><img src="{%$val.img%}"></a>
                    </div>
                    <div class="list_b">
                        <h2>
                            <a target="_blank" href="{%$val.link%}">{%$val.player_name%}</a>
                        </h2>
                        <p><span>得分：{%$val.pts%}</span><span>篮板：{%$val.reb%}</span></p>
                        <p><span>助攻：{%$val.asts%}</span><span>抢断：{%$val.stl%}</span></p>
                        <p><span>封盖：{%$val.blk%}</span></p>
                    </div>
                </div>
                {%/foreach%}
            </div>
            {%/if%}
            <div class="box_a">
                <div id="div-gpt-ad-1387359684902-0" style="width:250px; height:250px;" data-google-query-id="CM_QtbHoos8CFVeDvAod3xwM_w">
                    <script type="text/javascript">
                        googletag.cmd.push(function() { googletag.display('div-gpt-ad-1387359684902-0'); });
                    </script>
                </div>
            </div>
            {%widget name="match:widget/news-rank/news-rank.tpl" title="24小时新闻排行榜" news=$news%}
        </div>
    </div>
</div>
{%/block%}
