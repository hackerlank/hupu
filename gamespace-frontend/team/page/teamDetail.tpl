{%extends file="common/page/layout.tpl"%}

{%block name="head_static"%}
    <link rel="canonical" href="{%$base_info.link%}" />
    {%require name="team:static/teamDetail/teamDetail.css"%}
    {%require name="team:widget/team-area/east-west.scss"%}
    {%require name="common:static/js/center.js"%}
    {%require name="common:static/js/highcharts/highcharts.js"%}
    {%require name="common:static/js/highcharts/highcharts-more.js"%}
    {%require name="team:static/teamDetail/teamDetail.js"%}
    {%require name="team:static/playerDetail/player.js"%}
    {%require name="common:static/js/center.js"%}
    <script type="text/javascript">
        window.GM = {
            "name": "{%$base_info.name%}",
            "team_rank_info": {%json_encode($team_rank_info)%}
        };
    </script>
{%/block%}

{%block name="content"%}
<div class="gamecenter_livestart">
    <div class="bgs_png" style="display:none;"></div>
    {%widget name="common:widget/ad-980/ad-980.tpl"%}

    {%widget
        name="common:widget/page-tab/page-tab.tpl"
        title="球队"
    %}
    {%widget
        name="common:widget/bread-crumbs/bread-crumbs.tpl"
        title1="NBA比赛中心"
        title2="NBA球队"
        title3="{%$base_info.full_name%}&nbsp;({%$base_info.eng_full_name%})"
        link2="{%$nav_link.team%}"
    %}
    <div class="gamecenter_content">
        <div class="gamecenter_content_l">
            <div class="team_data">
                <h2>
                    <span class="title-text">{%$base_info.full_name%}（{%$base_info.eng_full_name%}）</span>
                    <span class="crumbs-link"> <a href="{%$urls.match%}" target="_blank">赛程</a>&nbsp;|&nbsp;
                        <a href="{%$urls.player%}" target="_blank">球员</a>&nbsp;|&nbsp;
                        <a href="{%$urls.video%}" target="_blank">视频</a>&nbsp;|&nbsp;
                        <a href="{%$urls.bbs%}" target="_blank">论坛</a>&nbsp;|&nbsp;
                        <a href="{%$urls.news%}" target="_blank">新闻</a>
                    </span>
                </h2>
                <div class="content">
                    <div class="content_a">
                        <div class="clearfix">
                            <div class="img">
                                <img src="{%$base_info.logo_link%}">
                            </div>
                            <div class="font">
                                <p>进入NBA：{%$base_info.found_year%}年</p>
                                <p>主场：{%$base_info.home%}&nbsp;分区：{%$base_info.cn_division%}</p>
                                <p>官网：<a target="_blank" href="{%$base_info.homepage_link%}">{%$base_info.homepage_link%}</a></p>
                                <p>主教练：{%$base_info.chief_coach%}</p>
                            </div>
                        </div>
                        <div class="txt">
                            {%$base_info.intro%}
                        </div>
                        <div class="table_team_box">
                            <div class="list">
                                <div class="border">
                                    <span class="a">技术统计</span>
                                    <span class="b">数值</span>
                                    <span class="c">联盟排名</span>
                                </div>
                                {%foreach from=$team_rank_info item=val key=key %}
                                    <div class="border">
                                        <span class="a">
                                            {%if $key == "pts"%}
                                                场均得分
                                            {%elseif $key == "ast"%}
                                                场均助攻
                                            {%elseif $key == "reb"%}
                                                场均篮板
                                            {%elseif $key == "lts"%}
                                                场均失分
                                            {%elseif $key == "to"%}
                                                场均失误
                                            {%/if%}
                                        </span>
                                        <span class="b">
                                            <b>{%$val.score|default:"-"
                                                %}</b>
                                        </span>
                                        <b>
                                            <span class="c">{%$val.rank|default:"-"%}</span>
                                        </b>
                                    </div>
                                {%/foreach%}
                            </div>
                        </div>
                    </div>
                    <div class="content_b" data-highcharts-chart="0">
                        <div class="highcharts-container" id="highcharts_0" style="width: 332px; height: 332px; text-align: left;"></div>
                    </div>
                </div>
            </div>

            <div class="team_hig">
                <div class="title_style">
                    <div class="boreder"></div>
                    <span class="title_border">
                            <span class="title_font">{%$base_info.name%}本赛季表现</span>
                    </span>
                </div>
                <div class="Js_show_line" style="display: block;">
                {%widget
                    name="team:widget/data-chart/data-chart.tpl"
                    type="team_data_avg"
                %}
                </div>
            </div>

            <div class="team_news">
                <div class="team_news_a">
                    <div class="title">
                        <a target="_blank" title="更多{%$base_info.name%}新闻" href="{%$urls.news%}" class="more">更多{%$base_info.name%}新闻</a><span class="font">{%$base_info.name%}新闻</span>
                    </div>
                    <ul>
                        {%foreach from=$news item=val %}
                            <li class="bg_color"><a target="_blank" title="{%$val.title%}" href="{%$val.url%}">{%$val.title%}</a></li>
                        {%/foreach%}
                    </ul>
                </div>
                <div class="team_news_b">
                    <div class="title">
                        <a target="_blank" title="更多{%$base_info.name%}帖子" href="{%$urls.bbs%}" class="more">更多{%$base_info.name%}帖子</a><span class="font">{%$base_info.name%}论坛</span>
                    </div>
                    <ul>
                        {%foreach from=$bbs item=val %}
                            <li class="bg_color"><a target="_blank" title="{%$val.title%}" href="{%$val.url%}">{%$val.title%}</a></li>
                        {%/foreach%}
                    </ul>
                </div>
            </div>
            <div class="team_list_data">
                <div class="title">
                    <span class="font">{%$base_info.name%}阵容与数据</span>
                </div>
                <div class="jiben_title">
                    <span>基本数据</span>
                    <!--
                    <s></s>
                    -->
                    <span att="more" class="on">比赛数据</span>
                </div>
                <div class="jiben_title_table">
                    <div class="a">
                        <div class="x_title">
                            <span class="c1">号码</span><span class="c2">球员</span>
                        </div>
                        {%foreach from=$players item=val %}
                            <div class="x_list">
                                <span class="c1">{%$val.number%}</span>
                                <span class="c2">
                                    <a target="_blank" title="{%$val.name%}" href="{%$val.player_link%}">
                                    {%if !empty($val.name)%}
                                        {%$val.name%}
                                    {%else%}
                                        {%$val.eng_name%}
                                    {%/if%}
                                    </a>
                                </span>
                            </div>
                        {%/foreach%}
                    </div>
                    <div class="b">
                        <div class="post_click_a"></div>
                        <div class="post_click_b"></div>
                        <div class="box_post" id="table_post" style="display: none;">
                            <div class="x_title">
                                <span class="c4">位置</span>
                                <span class="c4">年龄</span>
                                <span class="c4">球龄</span>
                                <span class="c3">身高</span>
                                <span class="c3">体重</span>
                                <span class="c4">薪金</span>
                            </div>
                            {%foreach from=$players item=val %}
                                <div class="x_list">
                                    <span class="c4">{%$val.position|default:"0"%}</span>
                                    <span class="c4">{%$val.age|default:"0"%}</span>
                                    <span class="c4">{%$val.play_year|default:"0"%}</span>
                                    <span class="c3">{%$val.height|default:"0"%}</span>
                                    <span class="c3">{%$val.weight|default:"0"%}</span>
                                    <span class="c4">{%$val.salary|default:"0"%}万</span>
                                </div>
                            {%/foreach%}
                        </div>

                        <div class="box_post" id="table_post2" style="width: 2000px;">
                            <div class="x_title">
                                <span class="c5">场数</span>
                                <span class="c5">首发数</span>
                                <span class="c5">时间</span>
                                <span class="c5">得分</span>
                                <span class="c5">助攻</span>
                                <span class="c5">出手数</span>
                                <span class="c5">命中率</span>
                                <span class="c5">3分得分</span>
                                <span class="c5">3分出手</span>
                                <span class="c5">3分命中率</span>
                                <span class="c5">罚球命中数</span>
                                <span class="c5">罚球出手数</span>
                                <span class="c5">罚球命中率</span>
                                <span class="c5">进攻篮板</span>
                                <span class="c5">防守篮板</span>
                                <span class="c5">总篮板</span>
                                <span class="c5">抢断</span>
                                <span class="c5">盖帽</span>
                                <span class="c5">失误 </span>
                                <span class="c5">犯规</span>
                            </div>
                            {%foreach from=$players item=val %}
                                <div class="x_list">
                                    <span class="c5">{%$val.data.games|default:"0"%}</span>
                                    <span class="c5">{%$val.data.games_started|default:"0"%}</span>
                                    <span class="c5">{%$val.data.mins|default:"0"%}</span>
                                    <span class="c5">{%$val.data.pts|default:"0"%}</span>
                                    <span class="c5">{%$val.data.asts|default:"0"%}</span>
                                    <span class="c5">{%$val.data.fga|default:"0"%}</span>
                                    <span class="c5">{%$val.data.fgp|default:"0"%}</span>
                                    <span class="c5">{%$val.data.tpt|default:"0"%}</span>
                                    <span class="c5">{%$val.data.tpa|default:"0"%}</span>
                                    <span class="c5">{%$val.data.tpp|default:"0"%}</span>
                                    <span class="c5">{%$val.data.ftm|default:"0"%}</span>
                                    <span class="c5">{%$val.data.fta|default:"0"%}</span>
                                    <span class="c5">{%$val.data.ftp|default:"0"%}</span>
                                    <span class="c5">{%$val.data.oreb|default:"0"%}</span>
                                    <span class="c5">{%$val.data.dreb|default:"0"%}</span>
                                    <span class="c5">{%$val.data.reb|default:"0"%}</span>
                                    <span class="c5">{%$val.data.stl|default:"0"%}</span>
                                    <span class="c5">{%$val.data.blk|default:"0"%}</span>
                                    <span class="c5">{%$val.data.to|default:"0"%} </span>
                                    <span class="c5">{%$val.data.foul|default:"0"%}</span>
                                </div>
                            {%/foreach%}
                        </div>
                    </div>
                    <div class="c" style="display: block;"></div>
                </div>
            </div>
        </div>

        <div class="gamecenter_content_r">
            {%widget name="team:widget/team-area/east-west.tpl"%}
        </div>
    </div>
</div>
{%/block%}
