<table class="players_table bott" style="margin-bottom:5px; border-color:#f6f3f3">
    <tbody>
        <tr class="bottTitle">
            <td colspan="17">本赛季{%if $type == "cur_regular_data"%}常规赛{%else%}季后赛{%/if%}平均数据</td>
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
{%foreach from=$data.data_normal item=val key=key%}
<table class="players_table bott bgs_table">
    <tbody>
        <tr>
            <td colspan="17" class="left td_a"><s></s><b>{%$key|mb_substr:4:2:'utf-8'%}月</b> 数据</td>
        </tr>
        <tr class="color_font1 borders_btm">
            <td>日期</td>
            <td class="left" width="8%">对手</td>
            <td class="left">比分</td>
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
            {%foreach $val as $subVal%}
            <tr class="color_font1 borders_btm">
                <td>{%$subVal.china_time%}</td>
                <td class="left" width="8%">{%$subVal.opponents%}</td>
                <td class="left">{%$subVal.away_score%}-{%$subVal.home_score%}({%$subVal.status%})</td>
                <td>{%$subVal.mins%}</td>
                <td>{%$subVal.fgm%}-{%$subVal.fga%}</td>
                <td>{%$subVal.fgp%}%</td>
                <td>{%$subVal.tpm%}-{%$subVal.tpa%}</td>
                <td>{%$subVal.tpp%}%</td>
                <td>{%$subVal.ftm%}-{%$subVal.fta%}</td>
                <td>{%$subVal.ftp%}%</td>
                <td>{%$subVal.reb%}</td>
                <td>{%$subVal.asts%}</td>
                <td>{%$subVal.stl%}</td>
                <td>{%$subVal.blk%}</td>
                <td>{%$subVal.to%}</td>
                <td>{%$subVal.pf%}</td>
                <td>{%$subVal.pts%}</td>
            </tr>
            {%/foreach%}
        {%/if%}
    </tbody>
</table>
{%/foreach%}
