<div class="box_a">
    <div class="top_bg"></div>
    <div class="team_vs">
        <div class="team_vs_box">
            <div class="team_a">
                <div class="img">
                    <a target="_blank" href="{%$match_info.away_link%}"> <img alt="{%$match_info.away_name%}" src="{%$match_info.away_logo%}" height="95" width="95" /></a>
                </div>
                <div class="message">
                    <h2>&nbsp;</h2>
                    <p><a href="{%$match_info.away_link%}" target="_blank">{%$match_info.away_name%}</a></p>
                    <div>
                        客队（{%$away_standing.win%}胜{%$away_standing.lost%}负）
                    </div>
                </div>
            </div>
            <div class="team_b">
                <div class="img">
                    <a target="_blank" href="{%$match_info.home_link%}"> <img alt="{%$match_info.home_name%}" src="{%$match_info.home_logo%}" height="95" width="95" /></a>
                </div>
                <div class="message">
                    <h2>&nbsp;</h2>
                    <p><a href="{%$match_info.home_link%}" target="_blank">{%$match_info.home_name%}</a></p>
                    <div>
                        主队（{%$home_standing.win%}胜{%$home_standing.lost%}负）
                    </div>
                </div>
            </div>
        </div>
        <div class="about_fonts clearfix">
            <p class="time_f">开赛：{%date('Y年m月d日 H:i', strtotime($match_info.time))%}</p>
            {%if in_array($match_info.status, [1,2])%}
                <p class="consumTime">耗时：{%$match_info.game_time|default:"暂无统计"%}</p>
                <p class="arena">球馆：{%$match_info.stadium_name|default:"暂无统计"%}</p>
                <p class="peopleNum">上座：{%$match_info.attendance|default:"暂无统计"%}人</p>
            {%else%}
                <div class="about_fonts clearfix">
                    <p class="consumTime">耗时：{%$match_info.game_time|default:"暂无统计"%}</p>
                    <p class="arena">球馆：{%$match_info.stadium_name|default:"暂无统计"%}</p>
                    <p class="peopleNum">上座：{%$match_info.attendance|default:"暂无统计"%}{%if !empty($match_info.attendance)%}人{%/if%}</p>
                </div>
            {%/if%}
        </div>
    </div>
    <div class="yuece_num">
        <div class="table_choose">
            <a target="_self" href="{%$match_info.boxscore_link%}" class="d {%if isset($boxscore)%} {%$boxscore%}{%/if%}"><s></s>比赛前瞻</a>
            <a target="_blank" href="https://goto.hupu.com/?a=goClick&id=3727" class="e"><s></s>视频直播</a>
            <a target="_blank" href="http://goto.hupu.com/?a=goClick&amp;id=2845" class="f"><s></s>手机直播</a>
            <span class="b_1"><s></s>文字直播</span>
            <span class="a_1"><s></s>比赛战报</span>
        </div>
    </div>
</div>
