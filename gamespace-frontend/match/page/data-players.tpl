{%extends file="common/page/layout.tpl"%}

{%block name="head_static"%}
    {%require name="match:static/data/data.css"%}
    {%require name="match:static/data/data.js"%}
{%/block%}

{%block name="content"%}
<div class="gamecenter_livestart" id="data_js">
    <div class="bgs_png" style="display:none;"></div>
    {%widget name="common:widget/ad-980/ad-980.tpl"%}

    {%widget name="common:widget/page-tab/page-tab.tpl" title="数据排名"%}

    {%widget name="match:widget/data-nav/data-nav.tpl" type="player"%}

    <div class="table_data">
        <div class="tables" style="display:block;">
            <div class="titles_font">
                <span class="a1"><a {%if $rank_type == "pts"%}class="on"{%/if%} href="/stats/players/pts">得分</a></span>
                <span><a {%if $rank_type == "fgp"%}class="on"{%/if%} href="/stats/players/fgp">投篮</a></span>
                <span><a {%if $rank_type == "tpp"%}class="on"{%/if%} href="/stats/players/tpp">三分</a></span>
                <span><a {%if $rank_type == "ftp"%}class="on"{%/if%} href="/stats/players/ftp">罚球</a></span>
                <span><a {%if $rank_type == "reb"%}class="on"{%/if%} href="/stats/players/reb">篮板</a></span>
                <span><a {%if $rank_type == "asts"%}class="on"{%/if%} href="/stats/players/asts">助攻</a></span>
                <span><a {%if $rank_type == "blk"%}class="on"{%/if%} href="/stats/players/blk">盖帽</a></span>
                <span><a {%if $rank_type == "stl"%}class="on"{%/if%} href="/stats/players/stl">抢断</a></span>
            </div>
            <table class="players_table" style="border-top:0px;">
                <tbody>
                <tr class="color_font1 bg_a">
                    <td width="46">排名</td>
                    <td width="142" class="left">球员</td>
                    <td width="50">球队</td>
                    {%if $rank_type == "pts"%}
                    <td>得分</td>
                    <td>命中-出手</td>
                    <td>命中率</td>
                    <td>命中-三分</td>
                    <td>三分命中率</td>
                    <td>命中-罚球</td>
                    <td>罚球命中率</td>
                    {%else if $rank_type == "fgp"%}
                    <td>投篮命中率</td>
                    <td>调整命中率</td>
                    <td>命中-投篮</td>
                    <td>命中-三分</td>
                    {%else if $rank_type == "tpp"%}
                    <td>三分命中率</td>
                    <td>三分命中数</td>
                    <td>三分出手数</td>
                    <td>得分</td>
                    {%else if $rank_type == "ftp"%}
                    <td>罚球命中率</td>
                    <td>罚球命中数</td>
                    <td>罚球出手数</td>
                    <td>得分</td>
                    {%else if $rank_type == "reb"%}
                    <td>篮板数</td>
                    <td>进攻篮板</td>
                    <td>防守篮板</td>
                    {%else if $rank_type == "asts"%}
                    <td>助攻数</td>
                    <td>失误数</td>
                    <td>助攻/失误</td>
                    {%else if $rank_type == "blk"%}
                    <td>盖帽数</td>
                    <td>犯规数</td>
                    <td>盖帽/犯规</td>
                    {%else if $rank_type == "stl"%}
                    <td>抢断数</td>
                    <td>失误数</td>
                    <td>犯规数</td>
                    <td>抢断/失误</td>
                    <td>抢断/犯规</td>
                    {%/if%}
                    <td width="50">场次</td>
                    <td width="70">上场时间</td>
                </tr>
                {%foreach $rank.rank_list as $item%}
                  <tr>
                      <td width="46">{%$item.rank%}</td>
                      <td width="142" class="left"><a href="{%$item.player_link%}">{%$item.player_name%}</a></td>
                      <td width="50"><a href="{%$item.team_link%}">{%$item.team_name%}</a></td>
                      {%if $rank_type == "pts"%}
                      <td class="bg_b">{%$item.pts%}</td>
                      <td>{%$item.fgm%}-{%$item.fga%}</td>
                      <td>{%$item.fgp*100%}%</td>
                      <td>{%$item.tpm%}-{%$item.tpa%}</td>
                      <td>{%$item.tpp*100%}%</td>
                      <td>{%$item.ftm%}-{%$item.fta%}</td>
                      <td>{%$item.ftp*100%}%</td>
                      {%else if $rank_type == "fgp"%}
                      <td class="bg_b">{%$item.fgp*100%}%</td>
                      <td>{%$item.adp*100%}%</td>
                      <td>{%$item.fgm%}-{%$item.fga%}</td>
                      <td>{%$item.tpm%}-{%$item.tpa%}</td>
                      {%else if $rank_type == "tpp"%}
                      <td class="bg_b">{%$item.tpp*100%}%</td>
                      <td>{%$item.tpm%}</td>
                      <td>{%$item.tpa%}</td>
                      <td>{%$item.pts%}</td>
                      {%else if $rank_type == "ftp"%}
                      <td class="bg_b">{%$item.ftp*100%}%</td>
                      <td>{%$item.ftm%}</td>
                      <td>{%$item.fta%}</td>
                      <td>{%$item.pts%}</td>
                      {%else if $rank_type == "reb"%}
                      <td class="bg_b">{%$item.reb%}</td>
                      <td>{%$item.oreb%}</td>
                      <td>{%$item.dreb%}</td>
                      {%else if $rank_type == "asts"%}
                      <td class="bg_b">{%$item.asts%}</td>
                      <td>{%$item.to%}</td>
                      <td>{%$item.asts_to%}</td>
                      {%else if $rank_type == "blk"%}
                      <td class="bg_b">{%$item.blk%}</td>
                      <td>{%$item.pf%}</td>
                      <td>{%$item.blk_pf%}</td>
                      {%else if $rank_type == "stl"%}
                      <td class="bg_b">{%$item.stl%}</td>
                      <td>{%$item.to%}</td>
                      <td>{%$item.pf%}</td>
                      <td>{%$item.stl_to%}</td>
                      <td>{%$item.stl_pf%}</td>
                      {%/if%}
                      <td width="50">{%$item.games%}</td>
                      <td width="70">{%$item.mins%}</td>
                  </tr>
                {%/foreach%}
                </tbody>
            </table>

            {%widget
                name="match:widget/pagination/pagination.tpl"
                path="/stats/players/{%$rank_type%}/"
                page=$rank.page
                pageCount=ceil($rank.total/50)
            %}
          </div>
    </div>
</div>
{%/block%}
