<table class="players_table bott" style="margin-bottom:5px; border-color:#f6f3f3">
    <tbody>
        <tr class="bottTitle">
            <td colspan="17">职业生涯{%if $type == "career_regular_data"%}常规赛{%else%}季后赛{%/if%}平均数据</td>
        </tr>
        <tr class="color_font1">
            <td>场次</td>
            <td>时间</td>
            <td>投篮</td>
            <td>命中率</td>
            <td>三分</td>
            <td>命中率</td>
            <td>罚球</td>
            <td>命中率</td>
            <td>篮板</td>
            <td>助攻</td>
            <td>抢断</td>
            <td>盖帽</td>
            <td>失误</td>
            <td>犯规</td>
            <td>得分</td>
        </tr>
        {%if !empty($data.data_avg)%}
        <tr>
            <td>{%$data.data_avg.games%}</td>
            <td>{%$data.data_avg.mins%}</td>
            <td>{%$data.data_avg.fgm%}-{%$data.data_avg.fga%}</td>
            <td>{%$data.data_avg.fgp%}</td>
            <td>{%$data.data_avg.tpm%}-{%$data.data_avg.tpa%}</td>
            <td>{%$data.data_avg.tpp%}</td>
            <td>{%$data.data_avg.ftm%}-{%$data.data_avg.fta%}</td>
            <td>{%$data.data_avg.ftp%}</td>
            <td>{%$data.data_avg.reb%}</td>
            <td>{%$data.data_avg.asts%}</td>
            <td>{%$data.data_avg.stl%}</td>
            <td>{%$data.data_avg.blk%}</td>
            <td>{%$data.data_avg.to%}</td>
            <td>{%$data.data_avg.pf%}</td>
            <td>{%$data.data_avg.pts%}</td>
        </tr>
        {%/if%}
    </tbody>
</table>
{%if !empty($data.data_normal)%}
<table class="players_table bott bgs_table">
    <tbody>
        <tr class="color_font1 borders_btm">
            <td>赛季</td>
            <td class="left">球队</td>
            <td>场次</td>
            <td>首发</td>
            <td>时间</td>
            <td>投篮</td>
            <td>命中率</td>
            <td>三分</td>
            <td>命中率</td>
            <td>罚球</td>
            <td>命中率</td>
            <td>篮板</td>
            <td>助攻</td>
            <td>抢断</td>
            <td>盖帽</td>
            <td>失误</td>
            <td>犯规</td>
            <td>得分</td>
        </tr>
        {%if !empty($data.data_normal)%}
            {%foreach $data.data_normal as $val%}
            <tr class="color_font1 borders_btm">
                <td>{%$val.season%}</td>
                <td class="left">{%$val.team_name%}</td>
                <td>{%$val.games%}</td>
                <td>{%$val.games_started%}</td>
                <td>{%$val.mins%}</td>
                <td>{%$val.fgm%}-{%$val.fga%}</td>
                <td>{%$val.fgp%}%</td>
                <td>{%$val.tpm%}-{%$val.tpa%}</td>
                <td>{%$val.tpp%}%</td>
                <td>{%$val.ftm%}-{%$val.fta%}</td>
                <td>{%$val.ftp%}%</td>
                <td>{%$val.reb%}</td>
                <td>{%$val.asts%}</td>
                <td>{%$val.stl%}</td>
                <td>{%$val.blk%}</td>
                <td>{%$val.to%}</td>
                <td>{%$val.pf%}</td>
                <td>{%$val.pts%}</td>
            </tr>
            {%/foreach%}
        {%/if%}
    </tbody>
</table>
{%/if%}
