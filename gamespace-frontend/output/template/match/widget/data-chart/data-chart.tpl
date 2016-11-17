{%assign var=key_en value=array("pts","fga","fgm","tgp","tpa","tpp","fta","ftm","ftp","dreb","oreb","reb","asts","st","blk","to","pf")%}
{%assign var=key_ch value=array("得分","出手数","命中率","3分得分","3分出手数","3分命中率","罚球出手数","罚球命中次数","罚球命中率","防守篮板","进攻篮板","篮板球数","助攻","抢断","盖帽","失误","犯规")%}
{%assign var=key_measure value=array("分","次","%","分","次","%","次","次","%","个","个","个","次","次","次","次","次","分钟")%}
{%if !empty($away_latest_five)%}
<div class="team_qushi">
{%foreach from=$key_en item=val key=key%}
{%if !empty($away_latest_five)%}
<a
                {%if $val@index == 0%}
                class="on"
                {%/if%}
                href="javascript:void(0);"
                name="{%$match_info.away_name|f_escape_xml%}/{%$match_info.home_name|f_escape_xml%}"
                {%if !empty($away_latest_five[$val]) %}
                    arr="{%$away_latest_five[$val]|implode:','|f_escape_xml%}/{%$home_latest_five[$val]|implode:','|f_escape_xml%}"
                {%else%}
                    arr="0/0" 
                {%/if%}

                tit="{%$match_info.away_name%}平均{%$key_ch[$val@index]|f_escape_xml%}:
                {%if !empty($away_latest_five[$val]) %}
                    {%$away_latest_five|chartsAvgRow:$val%}
                {%else%}
                    0
                {%/if%}
                {%$key_measure[$val@index]%}&nbsp;&nbsp;&nbsp;&nbsp;{%$match_info.home_name%}平均{%$key_ch[$val@index]%}:
                {%if !empty($home_latest_five[$val]) %}
                    {%$home_latest_five|chartsAvgRow:$val%}
                {%else%}
                    0
                {%/if%}
                {%$key_measure[$val@index]%}" pointstart="1"
                measure="{%$key_measure[$val@index]|f_escape_xml%}" categories="1,2,3,4,5">{%$key_ch[$val@index]%}</a>
{%/if%}
{%/foreach%}
</div>
<div style="height:350px; overflow:hidden;">
<div class="team_hig_js"></div>
</div>
{%else%}
<div style="text-align:center; padding:30px;">暂无图表模式</div>
{%/if%}
