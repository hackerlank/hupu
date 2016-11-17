{%assign var=key_en value=array("pts","fga","fgp","tpm","tpa","tpp","fta","ftm","ftp","dreb","oreb","reb","asts","stl","blk","to","pf","mins")%}

{%assign var=key_ch value=array("得分","出手数","命中率","3分得分","3分出手数","3分命中率","罚球出手数","罚球命中次数","罚球命中率","防守篮板","进攻篮板","篮板球数","助攻","抢断","盖帽","失误","犯规","时间")%}

{%assign var=key_measure value=array("分","次","%","分","次","%","次","次","%","个","个","个","次","次","次","次","次","分钟")%}

{%assign var=key_en_team value=array("pts","fga","fgp","tpm","tpa","tpp","fta","ftm","ftp","dreb","oreb","reb","asts","stl","blk","to","pf")%}

{%assign var=key_ch_team value=array("得分","出手数","命中率","3分得分","3分出手数","3分命中率","罚球出手数","罚球命中次数","罚球命中率","防守篮板","进攻篮板","篮板球数","助攻","抢断","盖帽","失误","犯规")%}

{%if $type == "cur_regular_data" || $type == "cur_playoff_data" || $type == "career_regular_data" || $type == "career_playoff_data"%}
    <div class="team_qushi">
        {%foreach from=$key_en item=val key=key%}
            <a
            {%if $val@index == 0%}
            class="on"
            {%/if%}
            href="javascript:void(0);"
            name="{%$player_info.name%}"
            arr="{%if !empty($data.data_chart[$key_en[$val@index]])%}{%$data.data_chart[$key_en[$val@index]]|array_to_string:'data'%}{%else%}0{%/if%}"
            tit="{%if $type|strpos:'cur' >= 0%}本赛季{%else%}职业生涯{%/if%}{%$key_ch[$val@index]%}变化趋势图&nbsp;&nbsp;&nbsp;&nbsp;平均{%$key_ch[$val@index]%}：
                {%if !empty($data.data_chart[$key_en[$val@index]]) %}
                    {%$data.data_chart[$key_en[$val@index]]|avg:'data'%}
                {%else%}
                    0
                {%/if%}
                {%$key_measure[$val@index]%}" pointstart="{%$data.data_chart[$key_en[$val@index]][0].date|default:0%}"
            measure="{%$key_measure[$val@index]%}" categories="{%if !empty($data.data_chart[$key_en[$val@index]])%}
                {%if $type == 'cur_regular_data' || $type == 'cur_playoff_data'%}
                    {%$data.data_chart[$key_en[$val@index]]|array_to_string:'date'%}
                {%else%}
                    {%$data.data_chart[$key_en[$val@index]]|array_to_string:'season'%}
                {%/if%}
            {%else%}
                {%date('Y-m-d',time())%}
            {%/if%}
            ">{%$key_ch[$val@index]%}</a>
        {%/foreach%}
    </div>
    <div style="height:350px; overflow:hidden;">
        <div class="team_hig_js"></div>
    </div>
{%else if $type == "team_data_avg"%}
    <div class="team_qushi">
        {%foreach from=$key_en_team item=val key=key%}
            <a
            {%if $val@index == 0%}
            class="on"
            {%/if%}
            href="javascript:void(0);"
            name="{%$base_info.name%}"
            arr="{%$team_data_avg[$key_en_team[$val@index]]|array_to_string:'score'%}"
            tit="{%if $type|strpos:'cur' >= 0%}本赛季{%else%}职业生涯{%/if%}{%$key_ch_team[$val@index]%}变化趋势图&nbsp;&nbsp;&nbsp;&nbsp;平均{%$key_ch_team[$val@index]%}：
            {%if !empty($team_data_avg[$key_en_team[$val@index]]) %}
                {%$team_data_avg[$key_en_team[$val@index]]|avg:'score'%}
            {%else%}
                0
            {%/if%}
                {%$key_measure[$val@index]%}" pointstart="{%$team_data_avg[$key_en_team[$val@index]][0].time%}"
            measure="{%$key_measure[$val@index]%}" categories="{%if !empty($team_data_avg[$key_en_team[$val@index]])%}
                {%$team_data_avg[$key_en_team[$val@index]]|array_to_string:'time'%}
            {%else%}
                {%date('Y-m-d',time())%}
            {%/if%}
                ">{%$key_ch_team[$val@index]%}</a>
        {%/foreach%}
    </div>
    <div style="height:350px; overflow:hidden;">
        <div class="team_hig_js"></div>
    </div>
{%/if%}
