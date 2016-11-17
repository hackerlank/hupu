{%extends file="common/page/layout.tpl"%}

{%block name="head_static"%}
    {%require name="match:static/index/index.css"%}
    {%require name="match:static/boxscore/boxscore.css"%}
    {%require name="common:static/js/underscore/underscore.js"%}
    {%require name="match:static/boxscore/boxscore.js"%}
    {%require name="common:static/js/center.js"%}
    {%$home_id=$match_info.home_id%}
     <script type="text/javascript">
        window.GM = {
            websocket: "{%$websocket[$websocket|array_rand]%}",
            match_id: "{%$match_info.match_id%}",
            away_name: "{%$match_info.away_name%}",
            home_name: "{%$match_info.home_name%}",
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
{%block name="content"%}
<div class="gamecenter_livestart">
    <div class="bgs_png" style="display:none;"></div>
    {%widget name="common:widget/ad-980/ad-980.tpl"%}

    {%widget name="common:widget/page-tab/page-tab.tpl"%}
    {%widget
        name="common:widget/bread-crumbs/bread-crumbs.tpl"
        title1="NBA比赛中心"
        title2="{%$match_info.away_name%}vs{%$match_info.home_name%}数据统计"
    %}
    {%widget name="match:widget/match-list-schedule-detail/match-list-schedule-detail.tpl"%}

    <div class="gamecenter_content boxscore_td">

        <div class="gamecenter_content_l">
            {%widget name="match:widget/daily-tab/daily-tab.tpl" boxscore="on"%}
            <div class="table_list_live">
                <div class="clearfix">
                    <h2>{%$match_info.away_name%}（客队）</h2>
                    <div class="tips_layes" style="color: rgb(153, 153, 153);">
                        ?
                        <div class="tips_tems">
                            <div class="post_tips">
                            </div>
                            <div class="fonts">
                                +/- ：指球员在场上时球队的净胜分
                                <br /> PG ：控球后卫
                                <br /> SG ：得分后卫
                                <br /> G ：后卫
                                <br /> SF ：小前锋
                                <br /> PF ：大前锋
                                <br /> F ：前锋
                                <br /> G/F ：后卫/前锋
                                <br /> C ：中锋
                                <br /> F/C ：前锋/中锋
                                <br />
                            </div>
                        </div>
                    </div>
                </div>
                <table id="J_away_content">
                    <tbody>
                        <tr class="title bg_a" style="background-color: rgb(251, 251, 251);">
                            <td class="left" width="150"><b>首发</b></td>
                            <td width="23"></td>
                            <td>时间</td>
                            <td>投篮</td>
                            <td>3分</td>
                            <td>罚球</td>
                            <td>前场</td>
                            <td>后场</td>
                            <td>篮板</td>
                            <td>助攻</td>
                            <td>犯规</td>
                            <td>抢断</td>
                            <td>失误</td>
                            <td>封盖</td>
                            <td>得分</td>
                            <td>+/-</td>
                        </tr>
                        {%foreach from=$player_stats.away_start item=val name=key%}
                            <tr style="background-color: rgb(255, 255, 255);">
                                <td class="tdw-1 left"> <a href="{%$val.player_link%}" target="_blank"> {%$val.name%}</a> </td>
                                <td>{%$val.position%}</td>
                                <td>{%$val.mins%}</td>
                                <td>{%$val.fgm%}-{%$val.fga%}</td>
                                <td>{%$val.tpm%}-{%$val.tpa%}</td>
                                <td>{%$val.ftm%}-{%$val.fta%}</td>
                                <td>{%$val.oreb%}</td>
                                <td>{%$val.dreb%}</td>
                                <td>
                                    {%if $val.reb == $player_stats.away_max_data.reb && $val.reb != 0%}
                                    <span class="high">{%$val.reb%}</span> {%else%} {%$val.reb%} {%/if%}
                                </td>
                                <td>
                                    {%if $val.asts == $player_stats.away_max_data.asts && $val.asts != 0%}
                                    <span class="high">{%$val.asts%}</span> {%else%} {%$val.asts%} {%/if%}
                                </td>
                                <td>{%$val.pf%}</td>
                                <td>{%$val.stl%}</td>
                                <td>{%$val.to%}</td>
                                <td>{%$val.blk%}</td>
                                <td>
                                    {%if $val.pts == $player_stats.away_max_data.pts%}
                                    <span class="high">{%$val.pts%}</span> {%else%} {%$val.pts%} {%/if%}
                                </td>
                                <td>
                                    {%if $val.net_points == $player_stats.away_max_data.net_points && $val.net_points != 0%}
                                        <span class="high">{%if $val.net_points > 0 %}+{%/if%}{%$val.net_points%}</span>
                                    {%else%}
                                        {%if $val.net_points > 0 %}+{%/if%}{%$val.net_points%}
                                    {%/if%}
                                </td>
                            </tr>
                        {%/foreach%}
                        <tr class="title bg_a" style="background-color: rgb(251, 251, 251);">
                            <td class="left" width="150"><b>替补</b></td>
                            <td width="23"></td>
                            <td>时间</td>
                            <td>投篮</td>
                            <td>3分</td>
                            <td>罚球</td>
                            <td>前场</td>
                            <td>后场</td>
                            <td>篮板</td>
                            <td>助攻</td>
                            <td>犯规</td>
                            <td>抢断</td>
                            <td>失误</td>
                            <td>封盖</td>
                            <td>得分</td>
                            <td>+/-</td>
                        </tr>
                        {%foreach from=$player_stats.away_reserve item=val name=key%}
                            <tr style="background-color: rgb(255, 255, 255);">
                                <td class="tdw-1 left"> <a href="{%$val.player_link%}" target="_blank"> {%$val.name%}</a> </td>
                                <td>{%$val.position%}</td>
                                <td>{%$val.mins%}</td>
                                <td>{%$val.fgm%}-{%$val.fga%}</td>
                                <td>{%$val.tpm%}-{%$val.tpa%}</td>
                                <td>{%$val.ftm%}-{%$val.fta%}</td>
                                <td>{%$val.oreb%}</td>
                                <td>{%$val.dreb%}</td>
                                <td>
                                    {%if $val.reb == $player_stats.away_max_data.reb && $val.reb != 0%}
                                    <span class="high">{%$val.reb%}</span> {%else%} {%$val.reb%} {%/if%}
                                </td>
                                <td>
                                    {%if $val.asts == $player_stats.away_max_data.asts && $val.asts != 0%}
                                    <span class="high">{%$val.asts%}</span> {%else%} {%$val.asts%} {%/if%}
                                </td>
                                <td>{%$val.pf%}</td>
                                <td>{%$val.stl%}</td>
                                <td>{%$val.to%}</td>
                                <td>{%$val.blk%}</td>
                                <td>
                                    {%if $val.pts == $player_stats.away_max_data.pts && $val.pts != 0%}
                                    <span class="high">{%$val.pts%}</span> {%else%} {%$val.pts%} {%/if%}
                                </td>
                                <td>
                                    {%if $val.net_points == $player_stats.away_max_data.net_points && $val.net_points != 0%}
                                    <span class="high">{%if $val.net_points > 0 %}+{%/if%}{%$val.net_points%}</span> {%else%}{%if $val.net_points > 0 %}+{%/if%} {%$val.net_points%} {%/if%}
                                </td>
                            </tr>
                        {%/foreach%}
                        <tr class="title bg_a" style="background-color: rgb(251, 251, 251);">
                            <td width="150" class="left">统计</td>
                            <td>&nbsp;</td>
                            <td></td>
                            <td>
                                {%$awaySTfgm=0%} {%$awayREfgm=0%} {%foreach from=$player_stats.away_start item=val name=key%} {%$awaySTfgm=$awaySTfgm+$val.fgm%} {%/foreach%} {%foreach from=$player_stats.away_reserve item=val name=key%} {%$awayREfgm=$awayREfgm+$val.fgm%} {%/foreach%}
                                {%$awaySTfga=0%} {%$awayREfga=0%} {%foreach from=$player_stats.away_start item=val name=key%} {%$awaySTfga=$awaySTfga+$val.fga%} {%/foreach%} {%foreach from=$player_stats.away_reserve item=val name=key%} {%$awayREfga=$awayREfga+$val.fga%}
                                {%/foreach%} {%$awaySTfgm+$awayREfgm%}-{%$awaySTfga+$awayREfga%}
                            </td>
                            <td>
                                {%$awaySTtpm=0%} {%$awayREtpm=0%} {%foreach from=$player_stats.away_start item=val name=key%} {%$awaySTtpm=$awaySTtpm+$val.tpm%} {%/foreach%} {%foreach from=$player_stats.away_reserve item=val name=key%} {%$awayREtpm=$awayREtpm+$val.tpm%} {%/foreach%}
                                {%$awaySTtpa=0%} {%$awayREtpa=0%} {%foreach from=$player_stats.away_start item=val name=key%} {%$awaySTtpa=$awaySTtpa+$val.tpa%} {%/foreach%} {%foreach from=$player_stats.away_reserve item=val name=key%} {%$awayREtpa=$awayREtpa+$val.tpa%}
                                {%/foreach%} {%$awaySTtpm+$awayREtpm%}-{%$awaySTtpa+$awayREtpa%}
                            </td>
                            <td>
                                {%$awaySTftm=0%} {%$awayREftm=0%} {%foreach from=$player_stats.away_start item=val name=key%} {%$awaySTftm=$awaySTftm+$val.ftm%} {%/foreach%} {%foreach from=$player_stats.away_reserve item=val name=key%} {%$awayREftm=$awayREftm+$val.ftm%} {%/foreach%}
                                {%$awaySTfta=0%} {%$awayREfta=0%} {%foreach from=$player_stats.away_start item=val name=key%} {%$awaySTfta=$awaySTfta+$val.fta%} {%/foreach%} {%foreach from=$player_stats.away_reserve item=val name=key%} {%$awayREfta=$awayREfta+$val.fta%}
                                {%/foreach%} {%$awaySTftm+$awayREftm%}-{%$awaySTfta+$awayREfta%}
                            </td>
                            <td>
                                {%$awaySToreb=0%} {%$awayREoreb=0%} {%foreach from=$player_stats.away_start item=val name=key%} {%$awaySToreb=$awaySToreb+$val.oreb%} {%/foreach%} {%foreach from=$player_stats.away_reserve item=val name=key%} {%$awayREoreb=$awayREoreb+$val.oreb%} {%/foreach%}
                                {%$awaySToreb+$awayREoreb%}
                            </td>
                            <td>
                                {%$awaySTdreb=0%} {%$awayREdreb=0%} {%foreach from=$player_stats.away_start item=val name=key%} {%$awaySTdreb=$awaySTdreb+$val.dreb%} {%/foreach%} {%foreach from=$player_stats.away_reserve item=val name=key%} {%$awayREdreb=$awayREdreb+$val.dreb%} {%/foreach%}
                                {%$awaySTdreb+$awayREdreb%}
                            </td>
                            <td>
                                {%$awaySTreb=0%} {%$awayREreb=0%} {%foreach from=$player_stats.away_start item=val name=key%} {%$awaySTreb=$awaySTreb+$val.reb%} {%/foreach%} {%foreach from=$player_stats.away_reserve item=val name=key%} {%$awayREreb=$awayREreb+$val.reb%} {%/foreach%}
                                {%$awaySTreb+$awayREreb%}
                            </td>
                            <td>
                                {%$awaySTasts=0%} {%$awayREasts=0%} {%foreach from=$player_stats.away_start item=val name=key%} {%$awaySTasts=$awaySTasts+$val.asts%} {%/foreach%} {%foreach from=$player_stats.away_reserve item=val name=key%} {%$awayREasts=$awayREasts+$val.asts%} {%/foreach%}
                                {%$awaySTasts+$awayREasts%}
                            </td>
                            <td>
                                {%$awaySTpf=0%} {%$awayREpf=0%} {%foreach from=$player_stats.away_start item=val name=key%} {%$awaySTpf=$awaySTpf+$val.pf%} {%/foreach%} {%foreach from=$player_stats.away_reserve item=val name=key%} {%$awayREpf=$awayREpf+$val.pf%} {%/foreach%} {%$awaySTpf+$awayREpf%}
                            </td>
                            <td>
                                {%$awaySTstl=0%} {%$awayREstl=0%} {%foreach from=$player_stats.away_start item=val name=key%} {%$awaySTstl=$awaySTstl+$val.stl%} {%/foreach%} {%foreach from=$player_stats.away_reserve item=val name=key%} {%$awayREstl=$awayREstl+$val.stl%} {%/foreach%}
                                {%$awaySTstl+$awayREstl%}
                            </td>
                            <td>
                                {%$awaySTto=0%} {%$awayREto=0%} {%foreach from=$player_stats.away_start item=val name=key%} {%$awaySTto=$awaySTto+$val.to%} {%/foreach%} {%foreach from=$player_stats.away_reserve item=val name=key%} {%$awayREto=$awayREto+$val.to%} {%/foreach%} {%$awaySTto+$awayREto%}
                            </td>
                            <td>
                                {%$awaySTblk=0%} {%$awayREblk=0%} {%foreach from=$player_stats.away_start item=val name=key%} {%$awaySTblk=$awaySTblk+$val.blk%} {%/foreach%} {%foreach from=$player_stats.away_reserve item=val name=key%} {%$awayREblk=$awayREblk+$val.blk%} {%/foreach%}
                                {%$awaySTblk+$awayREblk%}
                            </td>
                            <td>
                                {%$awaySTpts=0%} {%$awayREpts=0%} {%foreach from=$player_stats.away_start item=val name=key%} {%$awaySTpts=$awaySTpts+$val.pts%} {%/foreach%} {%foreach from=$player_stats.away_reserve item=val name=key%} {%$awayREpts=$awayREpts+$val.pts%} {%/foreach%}
                                {%$awaySTpts+$awayREpts%}
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr class="title bg_a" style="background-color: rgb(251, 251, 251);">
                            <td width="150" class="left">命中率</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>
                                {%if $awaySTfga+$awayREfga != 0 %}
                                    {%(($awaySTfgm+$awayREfgm)*100/($awaySTfga+$awayREfga))|string_format:"%.1f"%}%
                                {%else%}
                                    0%
                                {%/if%}
                            </td>
                            <td>
                                {%if $awaySTfga+$awayREtpa != 0 %}
                                    {%(($awaySTtpm+$awayREtpm)*100/($awaySTtpa+$awayREtpa))|string_format:"%.1f" %}%
                                {%else%}
                                    0%
                                {%/if%}
                            </td>
                            <td>
                                {%if $awaySTfga+$awayREfta != 0 %}
                                    {%(($awaySTftm+$awayREftm)*100/($awaySTfta+$awayREfta))|string_format:"%.1f"%}%
                                {%else%}
                                    0%
                                {%/if%}
                            </td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="table_list_live">
                <div class="clearfix">
                    <h2>{%$match_info.home_name%}（主队）</h2>
                    <div class="tips_layes" style="color: rgb(153, 153, 153);">
                        ?
                        <div class="tips_tems" style="display: none;">
                            <div class="post_tips">
                            </div>
                            <div class="fonts">
                                +/- ：指球员在场上时球队的净胜分
                                <br /> PG ：控球后卫
                                <br /> SG ：得分后卫
                                <br /> G ：后卫
                                <br /> SF ：小前锋
                                <br /> PF ：大前锋
                                <br /> F ：前锋
                                <br /> G/F ：后卫/前锋
                                <br /> C ：中锋
                                <br /> F/C ：前锋/中锋
                                <br />
                            </div>
                        </div>
                    </div>
                </div>
                <table id="J_home_content">
                    <tbody>
                        <tr class="title bg_a">
                            <td class="left" width="150"><b>首发</b></td>
                            <td width="23"></td>
                            <td>时间</td>
                            <td>投篮</td>
                            <td>3分</td>
                            <td>罚球</td>
                            <td>前场</td>
                            <td>后场</td>
                            <td>篮板</td>
                            <td>助攻</td>
                            <td>犯规</td>
                            <td>抢断</td>
                            <td>失误</td>
                            <td>封盖</td>
                            <td>得分</td>
                            <td>+/-</td>
                        </tr>
                        {%foreach from=$player_stats.home_start item=val name=key%}
                            <tr style="background-color: rgb(255, 255, 255);">
                                <td class="tdw-1 left"> <a href="{%$val.player_link%}" target="_blank"> {%$val.name%}</a> </td>
                                <td>{%$val.position%}</td>
                                <td>{%$val.mins%}</td>
                                <td>{%$val.fgm%}-{%$val.fga%}</td>
                                <td>{%$val.tpm%}-{%$val.tpa%}</td>
                                <td>{%$val.ftm%}-{%$val.fta%}</td>
                                <td>{%$val.oreb%}</td>
                                <td>{%$val.dreb%}</td>
                                <td>
                                    {%if $val.reb == $player_stats.home_max_data.reb && $val.reb != 0%}
                                    <span class="high">{%$val.reb%}</span> {%else%} {%$val.reb%} {%/if%}
                                </td>
                                <td>
                                    {%if $val.asts == $player_stats.home_max_data.asts && $val.asts != 0%}
                                    <span class="high">{%$val.asts%}</span> {%else%} {%$val.asts%} {%/if%}
                                </td>
                                <td>{%$val.pf%}</td>
                                <td>{%$val.stl%}</td>
                                <td>{%$val.to%}</td>
                                <td>{%$val.blk%}</td>
                                <td>
                                    {%if $val.pts == $player_stats.home_max_data.pts && $val.pts != 0%}
                                    <span class="high">{%$val.pts%}</span> {%else%} {%$val.pts%} {%/if%}
                                </td>
                                <td>
                                    {%if $val.net_points == $player_stats.home_max_data.net_points && $val.net_points != 0%}
                                    <span class="high">{%if $val.net_points > 0 %}+{%/if%}{%$val.net_points%}</span> {%else%}{%if $val.net_points > 0 %}+{%/if%} {%$val.net_points%} {%/if%}
                                </td>
                            </tr>
                        {%/foreach%}
                        <tr class="title bg_a">
                            <td class="left" width="150"><b>替补</b></td>
                            <td width="23"></td>
                            <td>时间</td>
                            <td>投篮</td>
                            <td>3分</td>
                            <td>罚球</td>
                            <td>前场</td>
                            <td>后场</td>
                            <td>篮板</td>
                            <td>助攻</td>
                            <td>犯规</td>
                            <td>抢断</td>
                            <td>失误</td>
                            <td>封盖</td>
                            <td>得分</td>
                            <td>+/-</td>
                        </tr>
                        {%foreach from=$player_stats.home_reserve item=val name=key%}
                            <tr style="background-color: rgb(255, 255, 255);">
                                <td class="tdw-1 left"> <a href="{%$val.player_link%}" target="_blank"> {%$val.name%}</a> </td>
                                <td>{%$val.position%}</td>
                                <td>{%$val.mins%}</td>
                                <td>{%$val.fgm%}-{%$val.fga%}</td>
                                <td>{%$val.tpm%}-{%$val.tpa%}</td>
                                <td>{%$val.ftm%}-{%$val.fta%}</td>
                                <td>{%$val.oreb%}</td>
                                <td>{%$val.dreb%}</td>
                                <td>
                                    {%if $val.reb == $player_stats.home_max_data.reb && $val.reb != 0%}
                                    <span class="high">{%$val.reb%}</span> {%else%} {%$val.reb%} {%/if%}
                                </td>
                                <td>
                                    {%if $val.asts == $player_stats.home_max_data.asts && $val.asts != 0%}
                                    <span class="high">{%$val.asts%}</span> {%else%} {%$val.asts%} {%/if%}
                                </td>
                                <td>{%$val.pf%}</td>
                                <td>{%$val.stl%}</td>
                                <td>{%$val.to%}</td>
                                <td>{%$val.blk%}</td>
                                <td>
                                    {%if $val.pts == $player_stats.home_max_data.pts && $val.pts != 0%}
                                    <span class="high">{%$val.pts%}</span> {%else%} {%$val.pts%} {%/if%}
                                </td>
                                <td>
                                    {%if $val.net_points == $player_stats.home_max_data.net_points && $val.net_points != 0%}
                                    <span class="high">{%if $val.net_points > 0 %}+{%/if%}{%$val.net_points%}</span> {%else%}{%if $val.net_points > 0 %}+{%/if%} {%$val.net_points%} {%/if%}
                                </td>
                            </tr>
                        {%/foreach%}
                        <tr class="title bg_a">
                            <td width="150" class="left">统计</td>
                            <td>&nbsp;</td>
                            <td></td>
                            <td>
                                {%$homeSTfgm=0%} {%$homeREfgm=0%} {%foreach from=$player_stats.home_start item=val name=key%} {%$homeSTfgm=$homeSTfgm+$val.fgm%} {%/foreach%} {%foreach from=$player_stats.home_reserve item=val name=key%} {%$homeREfgm=$homeREfgm+$val.fgm%} {%/foreach%}
                                {%$homeSTfga=0%} {%$homeREfga=0%} {%foreach from=$player_stats.home_start item=val name=key%} {%$homeSTfga=$homeSTfga+$val.fga%} {%/foreach%} {%foreach from=$player_stats.home_reserve item=val name=key%} {%$homeREfga=$homeREfga+$val.fga%}
                                {%/foreach%} {%$homeSTfgm+$homeREfgm%}-{%$homeSTfga+$homeREfga%}
                            </td>
                            <td>
                                {%$homeSTtpm=0%} {%$homeREtpm=0%} {%foreach from=$player_stats.home_start item=val name=key%} {%$homeSTtpm=$homeSTtpm+$val.tpm%} {%/foreach%} {%foreach from=$player_stats.home_reserve item=val name=key%} {%$homeREtpm=$homeREtpm+$val.tpm%} {%/foreach%}
                                {%$homeSTtpa=0%} {%$homeREtpa=0%} {%foreach from=$player_stats.home_start item=val name=key%} {%$homeSTtpa=$homeSTtpa+$val.tpa%} {%/foreach%} {%foreach from=$player_stats.home_reserve item=val name=key%} {%$homeREtpa=$homeREtpa+$val.tpa%}
                                {%/foreach%} {%$homeSTtpm+$homeREtpm%}-{%$homeSTtpa+$homeREtpa%}
                            </td>
                            <td>
                                {%$homeSTftm=0%} {%$homeREftm=0%} {%foreach from=$player_stats.home_start item=val name=key%} {%$homeSTftm=$homeSTftm+$val.ftm%} {%/foreach%} {%foreach from=$player_stats.home_reserve item=val name=key%} {%$homeREftm=$homeREftm+$val.ftm%} {%/foreach%}
                                {%$homeSTfta=0%} {%$homeREfta=0%} {%foreach from=$player_stats.home_start item=val name=key%} {%$homeSTfta=$homeSTfta+$val.fta%} {%/foreach%} {%foreach from=$player_stats.home_reserve item=val name=key%} {%$homeREfta=$homeREfta+$val.fta%}
                                {%/foreach%} {%$homeSTftm+$homeREftm%}-{%$homeSTfta+$homeREfta%}
                            </td>
                            <td>
                                {%$homeSToreb=0%} {%$homeREoreb=0%} {%foreach from=$player_stats.home_start item=val name=key%} {%$homeSToreb=$homeSToreb+$val.oreb%} {%/foreach%} {%foreach from=$player_stats.home_reserve item=val name=key%} {%$homeREoreb=$homeREoreb+$val.oreb%} {%/foreach%}
                                {%$homeSToreb+$homeREoreb%}
                            </td>
                            <td>
                                {%$homeSTdreb=0%} {%$homeREdreb=0%} {%foreach from=$player_stats.home_start item=val name=key%} {%$homeSTdreb=$homeSTdreb+$val.dreb%} {%/foreach%} {%foreach from=$player_stats.home_reserve item=val name=key%} {%$homeREdreb=$homeREdreb+$val.dreb%} {%/foreach%}
                                {%$homeSTdreb+$homeREdreb%}
                            </td>
                            <td>
                                {%$homeSTreb=0%} {%$homeREreb=0%} {%foreach from=$player_stats.home_start item=val name=key%} {%$homeSTreb=$homeSTreb+$val.reb%} {%/foreach%} {%foreach from=$player_stats.home_reserve item=val name=key%} {%$homeREreb=$homeREreb+$val.reb%} {%/foreach%}
                                {%$homeSTreb+$homeREreb%}
                            </td>
                            <td>
                                {%$homeSTasts=0%} {%$homeREasts=0%} {%foreach from=$player_stats.home_start item=val name=key%} {%$homeSTasts=$homeSTasts+$val.asts%} {%/foreach%} {%foreach from=$player_stats.home_reserve item=val name=key%} {%$homeREasts=$homeREasts+$val.asts%} {%/foreach%}
                                {%$homeSTasts+$homeREasts%}
                            </td>
                            <td>
                                {%$homeSTpf=0%} {%$homeREpf=0%} {%foreach from=$player_stats.home_start item=val name=key%} {%$homeSTpf=$homeSTpf+$val.pf%} {%/foreach%} {%foreach from=$player_stats.home_reserve item=val name=key%} {%$homeREpf=$homeREpf+$val.pf%} {%/foreach%} {%$homeSTpf+$homeREpf%}
                            </td>
                            <td>
                                {%$homeSTstl=0%} {%$homeREstl=0%} {%foreach from=$player_stats.home_start item=val name=key%} {%$homeSTstl=$homeSTstl+$val.stl%} {%/foreach%} {%foreach from=$player_stats.home_reserve item=val name=key%} {%$homeREstl=$homeREstl+$val.stl%} {%/foreach%}
                                {%$homeSTstl+$homeREstl%}
                            </td>
                            <td>
                                {%$homeSTto=0%} {%$homeREto=0%} {%foreach from=$player_stats.home_start item=val name=key%} {%$homeSTto=$homeSTto+$val.to%} {%/foreach%} {%foreach from=$player_stats.home_reserve item=val name=key%} {%$homeREto=$homeREto+$val.to%} {%/foreach%} {%$homeSTto+$homeREto%}
                            </td>
                            <td>
                                {%$homeSTblk=0%} {%$homeREblk=0%} {%foreach from=$player_stats.home_start item=val name=key%} {%$homeSTblk=$homeSTblk+$val.blk%} {%/foreach%} {%foreach from=$player_stats.home_reserve item=val name=key%} {%$homeREblk=$homeREblk+$val.blk%} {%/foreach%}
                                {%$homeSTblk+$homeREblk%}
                            </td>
                            <td>
                                {%$homeSTpts=0%} {%$homeREpts=0%} {%foreach from=$player_stats.home_start item=val name=key%} {%$homeSTpts=$homeSTpts+$val.pts%} {%/foreach%} {%foreach from=$player_stats.home_reserve item=val name=key%} {%$homeREpts=$homeREpts+$val.pts%} {%/foreach%}
                                {%$homeSTpts+$homeREpts%}
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr class="title bg_a">
                            <td width="150" class="left">命中率</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>
                                {%if $awaySTfga+$homeREfga != 0 %}
                                    {%(($homeSTfgm+$homeREfgm)*100/($homeSTfga+$homeREfga))|string_format:"%.1f"%}%
                                {%else%}
                                    0%
                                {%/if%}
                            </td>
                            <td>
                                {%if $awaySTfga+$homeREtpa != 0 %}
                                    {%(($homeSTtpm+$homeREtpm)*100/($homeSTtpa+$homeREtpa))|string_format:"%.1f" %}%
                                {%else%}
                                    0%
                                {%/if%}
                            </td>
                            <td>
                                {%if $awaySTfga+$homeREfta != 0 %}
                                    {%(($homeSTftm+$homeREftm)*100/($homeSTfta+$homeREfta))|string_format:"%.1f"%}%
                                {%else%}
                                    0%
                                {%/if%}
                            </td>

                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="table_choose">
                <a target="_self" href="{%$match_info.boxscore_link%}" class="d on"><s></s>{%if $match_info.status == 1%}数据统计{%else if  $match_info.status == 2%}数据直播{%/if%}</a>
                {%if $match_info.status == 1%}
                    {%if !empty($match_info.video_link)%}
                        <a target="_blank" href="{%$match_info.video_link%}" class="e"><s></s>比赛视频</a>
                    {%else%}
                        <span class="e_1"><s></s>比赛视频</span>
                    {%/if%}
                {%else $match_info.status == 2%}
                    <a target="_blank" href="https://goto.hupu.com/?a=goClick&id=3727" class="e"><s></s>视频直播</a>
                {%/if%}
                <a target="_blank" href="http://goto.hupu.com/?a=goClick&amp;id=2845" class="f"><s></s>手机直播</a>
                <a target="_self" href="{%$match_info.textlive_link%}" class="b"><s></s>{%if $match_info.status == 1%}文字实录{%else if  $match_info.status == 2%}文字直播{%/if%}</a>
                {%if $match_info.status == 1%}
                <a target="_self" href="{%$match_info.recap_link%}" class="a"><s></s>比赛战报</a>
                {%else if $match_info.status == 2%}
                <span class="a_1"><s></s>比赛战报</span>
                {%/if%}
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
    <script type="text/template" id="J_awayTpl">
        <tbody>
            <tr class="title bg_a" style="background-color: rgb(251, 251, 251);">
                <td class="left" width="150"><b>首发</b></td>
                <td width="23"></td>
                <td>时间</td>
                <td>投篮</td>
                <td>3分</td>
                <td>罚球</td>
                <td>前场</td>
                <td>后场</td>
                <td>篮板</td>
                <td>助攻</td>
                <td>犯规</td>
                <td>抢断</td>
                <td>失误</td>
                <td>封盖</td>
                <td>得分</td>
                <td>+/-</td>
            </tr>
            <@ _.each(away_start, function(item,index) { @>
                <tr style="background-color: rgb(255, 255, 255);">
                    <td class="tdw-1 left"> <a href="<@=item.player_link@>" target="_blank"> <@=item.name@></a> </td>
                    <td><@=item.position@></td>
                    <td><@=item.mins@></td>
                    <td><@=item.fgm@>-<@=item.fga@></td>
                    <td><@=item.tpm@>-<@=item.tpa@></td>
                    <td><@=item.ftm@>-<@=item.fta@></td>
                    <td><@=item.oreb@></td>
                    <td><@=item.dreb@></td>
                    <td>
                        <@if (item.reb == away_max_data.reb && item.reb != 0){@>
                            <span class="high"><@=item.reb@></span>
                        <@}else{@>
                            <@=item.reb@>
                        <@}@>
                    </td>
                    <td>
                        <@if (item.asts == away_max_data.asts && item.asts != 0){@>
                        <span class="high"><@=item.asts@></span> <@}else{@> <@=item.asts@> <@}@>
                    </td>
                    <td><@=item.pf@></td>
                    <td><@=item.stl@></td>
                    <td><@=item.to@></td>
                    <td><@=item.blk@></td>
                    <td>
                        <@if (item.pts == away_max_data.pts && item.pts != 0){@>
                        <span class="high"><@=item.pts@></span> <@}else{@> <@=item.pts@> <@}@>
                    </td>
                    <td>
                        <@if (item.net_points == away_max_data.net_points && item.net_points != 0){@>
                        <span class="high">
                            <@if (item.net_points > 0){ @>+<@}@>
                            <@=item.net_points@>
                        </span> <@}else{@>
                            <@if (item.net_points > 0){ @>+<@}@>
                        <@=item.net_points@>
                        <@}@>
                    </td>
                </tr>
            <@})@>
            <tr class="title bg_a" style="background-color: rgb(251, 251, 251);">
                <td class="left" width="150"><b>替补</b></td>
                <td width="23"></td>
                <td>时间</td>
                <td>投篮</td>
                <td>3分</td>
                <td>罚球</td>
                <td>前场</td>
                <td>后场</td>
                <td>篮板</td>
                <td>助攻</td>
                <td>犯规</td>
                <td>抢断</td>
                <td>失误</td>
                <td>封盖</td>
                <td>得分</td>
                <td>+/-</td>
            </tr>
            <@ _.each(away_reserve, function(item,index) { @>
                <tr style="background-color: rgb(255, 255, 255);">
                    <td class="tdw-1 left"> <a href="<@=item.player_link@>" target="_blank"> <@=item.name@></a> </td>
                    <td><@=item.position@></td>
                    <td><@=item.mins@></td>
                    <td><@=item.fgm@>-<@=item.fga@></td>
                    <td><@=item.tpm@>-<@=item.tpa@></td>
                    <td><@=item.ftm@>-<@=item.fta@></td>
                    <td><@=item.oreb@></td>
                    <td><@=item.dreb@></td>
                    <td>
                        <@if (item.reb == away_max_data.reb && item.reb != 0){@>
                        <span class="high"><@=item.reb@></span> <@}else{@> <@=item.reb@> <@}@>
                    </td>
                    <td>
                        <@if (item.asts == away_max_data.asts && item.asts != 0){@>
                        <span class="high"><@=item.asts@></span> <@}else{@> <@=item.asts@> <@}@>
                    </td>
                    <td><@=item.pf@></td>
                    <td><@=item.stl@></td>
                    <td><@=item.to@></td>
                    <td><@=item.blk@></td>
                    <td>
                        <@if (item.pts == away_max_data.pts && item.pts != 0){@>
                        <span class="high"><@=item.pts@></span> <@}else{@> <@=item.pts@> <@}@>
                    </td>
                    <td>
                        <@if (item.net_points == away_max_data.net_points && item.net_points != 0){@>
                            <span class="high">
                                <@if (item.net_points > 0){ @>+<@}@>
                                <@=item.net_points@>
                            </span>
                        <@}else{@>
                            <@if (item.net_points > 0){ @>+<@}@>
                            <@=item.net_points@>
                        <@}@>
                    </td>
                </tr>
            <@})@>
            <tr class="title bg_a" style="background-color: rgb(251, 251, 251);">
                <td width="150" class="left">统计</td>
                <td>&nbsp;</td>
                <td></td>
                <td>
                    <@var awaySTfgm = 0 @> <@var awayREfgm = 0 @>
                        <@ _.each(away_start, function(item) { @>
                            <@ awaySTfgm = awaySTfgm+ parseInt(item.fgm)@>
                        <@})@>
                        <@ _.each(away_reserve, function(item,index) { @>
                            <@ awayREfgm=awayREfgm + parseInt(item.fgm)@>
                        <@})@>
                    <@var awaySTfga = 0@> <@var awayREfga = 0@>
                    <@ _.each(away_start, function(item) { @>
                        <@ awaySTfga=awaySTfga+parseInt(item.fga)@> <@})@>
                    <@ _.each(away_reserve, function(item,index) { @>
                        <@ awayREfga=awayREfga + parseInt(item.fga)@>
                    <@})@>
                    <@=awaySTfgm+awayREfgm@>-<@=awaySTfga+awayREfga@>
                </td>
                <td>
                    <@var awaySTtpm=0@> <@var awayREtpm=0@>
                        <@ _.each(away_start, function(item) { @>
                            <@ awaySTtpm= awaySTtpm+parseInt(item.tpm)@>
                         <@})@>
                        <@ _.each(away_reserve, function(item) { @>
                            <@awayREtpm= awayREtpm+parseInt(item.tpm)@>
                        <@})@>
                    <@var awaySTtpa=0@> <@var awayREtpa=0@>
                        <@ _.each(away_start, function(item) { @>
                         <@ awaySTtpa=awaySTtpa+parseInt(item.tpa)@>
                        <@})@>
                        <@ _.each(away_reserve, function(item) { @>
                            <@awayREtpa=awayREtpa+parseInt(item.tpa)@>
                        <@})@>
                        <@=awaySTtpm+awayREtpm@>-<@=awaySTtpa+awayREtpa@>
                </td>
                <td>
                    <@var awaySTftm=0@> <@var awayREftm=0@> <@ _.each(away_start, function(item) { @> <@awaySTftm=awaySTftm+parseInt(item.ftm)@> <@})@> <@ _.each(away_reserve, function(item) { @> <@awayREftm=awayREftm+parseInt(item.ftm)@> <@})@>
                    <@var awaySTfta=0@> <@var awayREfta=0@> <@ _.each(away_start, function(item) { @> <@awaySTfta=awaySTfta+parseInt(item.fta)@> <@})@> <@ _.each(away_reserve, function(item) { @> <@awayREfta=awayREfta+parseInt(item.fta)@>
                    <@})@> <@=awaySTftm+awayREftm@>-<@=awaySTfta+awayREfta@>
                </td>
                <td>
                    <@var awaySToreb=0@> <@var awayREoreb=0@> <@ _.each(away_start, function(item) { @> <@awaySToreb=awaySToreb+parseInt(item.oreb)@> <@})@> <@ _.each(away_reserve, function(item) { @> <@awayREoreb=awayREoreb+parseInt(item.oreb)@> <@})@>
                    <@=awaySToreb+awayREoreb@>
                </td>
                <td>
                    <@var awaySTdreb=0@> <@var awayREdreb=0@> <@ _.each(away_start, function(item) { @> <@awaySTdreb=awaySTdreb+parseInt(item.dreb)@> <@})@> <@ _.each(away_reserve, function(item) { @> <@awayREdreb=awayREdreb+parseInt(item.dreb)@> <@})@>
                    <@=awaySTdreb+awayREdreb@>
                </td>
                <td>
                    <@var awaySTreb=0@> <@var awayREreb=0@> <@ _.each(away_start, function(item) { @> <@awaySTreb=awaySTreb+parseInt(item.reb)@> <@})@> <@ _.each(away_reserve, function(item) { @> <@awayREreb=awayREreb+parseInt(item.reb)@> <@})@>
                    <@=awaySTreb+awayREreb@>
                </td>
                <td>
                    <@var awaySTasts=0@> <@var awayREasts=0@> <@ _.each(away_start, function(item) { @> <@awaySTasts=awaySTasts+parseInt(item.asts)@> <@})@> <@ _.each(away_reserve, function(item) { @> <@awayREasts=awayREasts+parseInt(item.asts)@> <@})@>
                    <@=awaySTasts+awayREasts@>
                </td>
                <td>
                    <@var awaySTpf=0@> <@var awayREpf=0@> <@ _.each(away_start, function(item) { @> <@awaySTpf=awaySTpf+parseInt(item.pf)@> <@})@> <@ _.each(away_reserve, function(item) { @> <@awayREpf=awayREpf+parseInt(item.pf)@> <@})@> <@=awaySTpf+awayREpf@>
                </td>
                <td>
                    <@var awaySTstl=0@> <@var awayREstl=0@> <@ _.each(away_start, function(item) { @> <@awaySTstl=awaySTstl+parseInt(item.stl)@> <@})@> <@ _.each(away_reserve, function(item) { @> <@awayREstl=awayREstl+parseInt(item.stl)@> <@})@>
                    <@=awaySTstl+awayREstl@>
                </td>
                <td>
                    <@var awaySTto=0@> <@var awayREto=0@> <@ _.each(away_start, function(item) { @> <@awaySTto=awaySTto+parseInt(item.to)@> <@})@> <@ _.each(away_reserve, function(item) { @> <@awayREto=awayREto+parseInt(item.to)@> <@})@> <@=awaySTto+awayREto@>
                </td>
                <td>
                    <@var awaySTblk=0@> <@var awayREblk=0@> <@ _.each(away_start, function(item) { @> <@awaySTblk=awaySTblk+parseInt(item.blk)@> <@})@> <@ _.each(away_reserve, function(item) { @> <@awayREblk=awayREblk+parseInt(item.blk)@> <@})@>
                    <@=awaySTblk+awayREblk@>
                </td>
                <td>
                    <@var awaySTpts=0@> <@var awayREpts=0@> <@ _.each(away_start, function(item) { @> <@awaySTpts=awaySTpts+parseInt(item.pts)@> <@})@> <@ _.each(away_reserve, function(item) { @> <@awayREpts=awayREpts+parseInt(item.pts)@> <@})@>
                    <@=awaySTpts+awayREpts@>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr class="title bg_a" style="background-color: rgb(251, 251, 251);">
                <td width="150" class="left">命中率</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>
                    <@ if ((awaySTfga+awayREfga) != 0) {@>
                        <@=((awaySTfgm+awayREfgm)*100/(awaySTfga+awayREfga)).toFixed(1)@>   
                    <@}else{@>
                        0
                    <@}@>
                    %
                </td>
                <td>
                    <@ if ((awaySTtpa+awayREtpa) != 0) {@>
                        <@=((awaySTtpm+awayREtpm)*100/(awaySTtpa+awayREtpa)).toFixed(1)@>  
                    <@}else{@>
                        0
                    <@}@>
                    %
                </td>
                <td>
                    <@ if ((awaySTfta+awayREfta) != 0) {@>
                        <@=((awaySTftm+awayREftm)*100/(awaySTfta+awayREfta)).toFixed(1)@> 
                    <@}else{@>
                        0
                    <@}@>
                    %
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </tbody>
    </script>
    <script type="text/template" id="J_homeTpl">
        <tbody>
            <tr class="title bg_a" style="background-color: rgb(251, 251, 251);">
                <td class="left" width="150"><b>首发</b></td>
                <td width="23"></td>
                <td>时间</td>
                <td>投篮</td>
                <td>3分</td>
                <td>罚球</td>
                <td>前场</td>
                <td>后场</td>
                <td>篮板</td>
                <td>助攻</td>
                <td>犯规</td>
                <td>抢断</td>
                <td>失误</td>
                <td>封盖</td>
                <td>得分</td>
                <td>+/-</td>
            </tr>
            <@ _.each(home_start, function(item,index) { @>
                <tr style="background-color: rgb(255, 255, 255);">
                    <td class="tdw-1 left"> <a href="<@=item.player_link@>" target="_blank"> <@=item.name@></a> </td>
                    <td><@=item.position@></td>
                    <td><@=item.mins@></td>
                    <td><@=item.fgm@>-<@=item.fga@></td>
                    <td><@=item.tpm@>-<@=item.tpa@></td>
                    <td><@=item.ftm@>-<@=item.fta@></td>
                    <td><@=item.oreb@></td>
                    <td><@=item.dreb@></td>
                    <td>
                        <@if (item.reb == home_max_data.reb && item.reb != 0){@>
                            <span class="high"><@=item.reb@></span>
                        <@}else{@>
                            <@=item.reb@>
                        <@}@>
                    </td>
                    <td>
                        <@if (item.asts == home_max_data.asts && item.asts != 0){@>
                        <span class="high"><@=item.asts@></span> <@}else{@> <@=item.asts@> <@}@>
                    </td>
                    <td><@=item.pf@></td>
                    <td><@=item.stl@></td>
                    <td><@=item.to@></td>
                    <td><@=item.blk@></td>
                    <td>
                        <@if (item.pts == home_max_data.pts && item.pts != 0){@>
                        <span class="high"><@=item.pts@></span> <@}else{@> <@=item.pts@> <@}@>
                    </td>
                    <td>
                        <@if (item.net_points == home_max_data.net_points && item.net_points != 0){@>
                            <span class="high">
                                <@if (item.net_points > 0){ @>+<@}@>
                                <@=item.net_points@>
                            </span>
                        <@}else{@>
                            <@if (item.net_points > 0){ @>+<@}@>
                            <@=item.net_points@>
                         <@}@>
                    </td>
                </tr>
            <@})@>
            <tr class="title bg_a" style="background-color: rgb(251, 251, 251);">
                <td class="left" width="150"><b>替补</b></td>
                <td width="23"></td>
                <td>时间</td>
                <td>投篮</td>
                <td>3分</td>
                <td>罚球</td>
                <td>前场</td>
                <td>后场</td>
                <td>篮板</td>
                <td>助攻</td>
                <td>犯规</td>
                <td>抢断</td>
                <td>失误</td>
                <td>封盖</td>
                <td>得分</td>
                <td>+/-</td>
            </tr>
            <@ _.each(home_reserve, function(item,index) { @>
                <tr style="background-color: rgb(255, 255, 255);">
                    <td class="tdw-1 left"> <a href="<@=item.player_link@>" target="_blank"> <@=item.name@></a> </td>
                    <td><@=item.position@></td>
                    <td><@=item.mins@></td>
                    <td><@=item.fgm@>-<@=item.fga@></td>
                    <td><@=item.tpm@>-<@=item.tpa@></td>
                    <td><@=item.ftm@>-<@=item.fta@></td>
                    <td><@=item.oreb@></td>
                    <td><@=item.dreb@></td>
                    <td>
                        <@if (item.reb == home_max_data.reb && item.reb != 0){@>
                        <span class="high"><@=item.reb@></span> <@}else{@> <@=item.reb@> <@}@>
                    </td>
                    <td>
                        <@if (item.asts == home_max_data.asts && item.asts != 0){@>
                        <span class="high"><@=item.asts@></span> <@}else{@> <@=item.asts@> <@}@>
                    </td>
                    <td><@=item.pf@></td>
                    <td><@=item.stl@></td>
                    <td><@=item.to@></td>
                    <td><@=item.blk@></td>
                    <td>
                        <@if (item.pts == home_max_data.pts && item.pts != 0){@>
                        <span class="high"><@=item.pts@></span> <@}else{@> <@=item.pts@> <@}@>
                    </td>
                    <td>
                        <@if (item.net_points == home_max_data.net_points && item.net_points != 0){@>
                            <span class="high">
                                <@if (item.net_points > 0){ @>+<@}@>
                                <@=item.net_points@>
                            </span>
                        <@}else{@>
                            <@if (item.net_points > 0){ @>+<@}@>
                            <@=item.net_points@>
                        <@}@>
                    </td>
                </tr>
            <@})@>
            <tr class="title bg_a" style="background-color: rgb(251, 251, 251);">
                <td width="150" class="left">统计</td>
                <td>&nbsp;</td>
                <td></td>
                <td>
                    <@var homeSTfgm = 0 @> <@var homeREfgm = 0 @>
                        <@ _.each(home_start, function(item) { @>
                            <@ homeSTfgm = homeSTfgm+ parseInt(item.fgm)@>
                        <@})@>
                        <@ _.each(home_reserve, function(item,index) { @>
                            <@ homeREfgm=homeREfgm + parseInt(item.fgm)@>
                        <@})@>
                    <@var homeSTfga = 0@> <@var homeREfga = 0@>
                    <@ _.each(home_start, function(item) { @>
                        <@ homeSTfga=homeSTfga+parseInt(item.fga)@> <@})@>
                    <@ _.each(home_reserve, function(item,index) { @>
                        <@ homeREfga=homeREfga + parseInt(item.fga)@>
                    <@})@>
                    <@=homeSTfgm+homeREfgm@>-<@=homeSTfga+homeREfga@>
                </td>
                <td>
                    <@var homeSTtpm=0@> <@var homeREtpm=0@>
                        <@ _.each(home_start, function(item) { @>
                            <@ homeSTtpm= homeSTtpm+parseInt(item.tpm)@>
                         <@})@>
                        <@ _.each(home_reserve, function(item) { @>
                            <@homeREtpm= homeREtpm+parseInt(item.tpm)@>
                        <@})@>
                    <@var homeSTtpa=0@> <@var homeREtpa=0@>
                        <@ _.each(home_start, function(item) { @>
                         <@ homeSTtpa=homeSTtpa+parseInt(item.tpa)@>
                        <@})@>
                        <@ _.each(home_reserve, function(item) { @>
                            <@homeREtpa=homeREtpa+parseInt(item.tpa)@>
                        <@})@>
                        <@=homeSTtpm+homeREtpm@>-<@=homeSTtpa+homeREtpa@>
                </td>
                <td>
                    <@var homeSTftm=0@> <@var homeREftm=0@> <@ _.each(home_start, function(item) { @> <@homeSTftm=homeSTftm+parseInt(item.ftm)@> <@})@> <@ _.each(home_reserve, function(item) { @> <@homeREftm=homeREftm+parseInt(item.ftm)@> <@})@>
                    <@var homeSTfta=0@> <@var homeREfta=0@> <@ _.each(home_start, function(item) { @> <@homeSTfta=homeSTfta+parseInt(item.fta)@> <@})@> <@ _.each(home_reserve, function(item) { @> <@homeREfta=homeREfta+parseInt(item.fta)@>
                    <@})@> <@=homeSTftm+homeREftm@>-<@=homeSTfta+homeREfta@>
                </td>
                <td>
                    <@var homeSToreb=0@> <@var homeREoreb=0@> <@ _.each(home_start, function(item) { @> <@homeSToreb=homeSToreb+parseInt(item.oreb)@> <@})@> <@ _.each(home_reserve, function(item) { @> <@homeREoreb=homeREoreb+parseInt(item.oreb)@> <@})@>
                    <@=homeSToreb+homeREoreb@>
                </td>
                <td>
                    <@var homeSTdreb=0@> <@var homeREdreb=0@> <@ _.each(home_start, function(item) { @> <@homeSTdreb=homeSTdreb+parseInt(item.dreb)@> <@})@> <@ _.each(home_reserve, function(item) { @> <@homeREdreb=homeREdreb+parseInt(item.dreb)@> <@})@>
                    <@=homeSTdreb+homeREdreb@>
                </td>
                <td>
                    <@var homeSTreb=0@> <@var homeREreb=0@> <@ _.each(home_start, function(item) { @> <@homeSTreb=homeSTreb+parseInt(item.reb)@> <@})@> <@ _.each(home_reserve, function(item) { @> <@homeREreb=homeREreb+parseInt(item.reb)@> <@})@>
                    <@=homeSTreb+homeREreb@>
                </td>
                <td>
                    <@var homeSTasts=0@> <@var homeREasts=0@> <@ _.each(home_start, function(item) { @> <@homeSTasts=homeSTasts+parseInt(item.asts)@> <@})@> <@ _.each(home_reserve, function(item) { @> <@homeREasts=homeREasts+parseInt(item.asts)@> <@})@>
                    <@=homeSTasts+homeREasts@>
                </td>
                <td>
                    <@var homeSTpf=0@> <@var homeREpf=0@> <@ _.each(home_start, function(item) { @> <@homeSTpf=homeSTpf+parseInt(item.pf)@> <@})@> <@ _.each(home_reserve, function(item) { @> <@homeREpf=homeREpf+parseInt(item.pf)@> <@})@> <@=homeSTpf+homeREpf@>
                </td>
                <td>
                    <@var homeSTstl=0@> <@var homeREstl=0@> <@ _.each(home_start, function(item) { @> <@homeSTstl=homeSTstl+parseInt(item.stl)@> <@})@> <@ _.each(home_reserve, function(item) { @> <@homeREstl=homeREstl+parseInt(item.stl)@> <@})@>
                    <@=homeSTstl+homeREstl@>
                </td>
                <td>
                    <@var homeSTto=0@> <@var homeREto=0@> <@ _.each(home_start, function(item) { @> <@homeSTto=homeSTto+parseInt(item.to)@> <@})@> <@ _.each(home_reserve, function(item) { @> <@homeREto=homeREto+parseInt(item.to)@> <@})@> <@=homeSTto+homeREto@>
                </td>
                <td>
                    <@var homeSTblk=0@> <@var homeREblk=0@> <@ _.each(home_start, function(item) { @> <@homeSTblk=homeSTblk+parseInt(item.blk)@> <@})@> <@ _.each(home_reserve, function(item) { @> <@homeREblk=homeREblk+parseInt(item.blk)@> <@})@>
                    <@=homeSTblk+homeREblk@>
                </td>
                <td>
                    <@var homeSTpts=0@> <@var homeREpts=0@> <@ _.each(home_start, function(item) { @> <@homeSTpts=homeSTpts+parseInt(item.pts)@> <@})@> <@ _.each(home_reserve, function(item) { @> <@homeREpts=homeREpts+parseInt(item.pts)@> <@})@>
                    <@=homeSTpts+homeREpts@>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr class="title bg_a" style="background-color: rgb(251, 251, 251);">
                <td width="150" class="left">命中率</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>
                    <@ if (homeSTfga+homeREfga != 0) {@>
                        <@=((homeSTfgm+homeREfgm)*100/(homeSTfga+homeREfga)).toFixed(1)@>  
                    <@}else{@>
                        0
                    <@}@>
                    %
                </td>
                <td>
                    <@ if (homeSTtpa+homeREtpa != 0) {@>
                         <@=((homeSTtpm+homeREtpm)*100/(homeSTtpa+homeREtpa)).toFixed(1)@>  
                    <@}else{@>
                        0
                    <@}@>
                    %
                </td>
                <td>
                    <@ if (homeSTfta+homeREfta != 0) {@>
                        <@=((homeSTftm+homeREftm)*100/(homeSTfta+homeREfta)).toFixed(1)@>  
                    <@}else{@>
                        0
                    <@}@>
                    %
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </tbody>
    </script>
</div>
{%/block%}
