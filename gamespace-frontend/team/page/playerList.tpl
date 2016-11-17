{%extends file="common/page/layout.tpl"%}

{%block name="head_static"%}
  {%require name="team:static/playerList/playerList.css"%}
  {%require name="common:static/js/center.js"%}

  {%script%}
    playersList.init();//队伍列表事件
  {%/script%}
{%/block%}

{%block name="content"%}
<div class="gamecenter_livestart">
    <div class="bgs_png" style="display:none;"></div>
    {%widget name="common:widget/ad-980/ad-980.tpl"%}

    {%widget name="common:widget/page-tab/page-tab.tpl" title="球员"%}

    <div class="players_left" style="margin-bottom:10px;">
        {%widget
            name="common:widget/team-nav/team-nav.tpl"
            type="player"
        %}
    </div>
    <div class="players_right" style="margin-bottom:10px;">
        <table class="players_table" style="display:block;">
            <tbody>
                <tr class="title">
                    <td width="102"></td>
                    <td width="110">姓名</td>
                    <td width="30">号码</td>
                    <td width="40">位置</td>
                    <td width="75">身高</td>
                    <td width="70">体重</td>
                    <td width="70">生日</td>
                    <td width="105">合同</td>
                </tr>
                {%foreach $player_list as $val%}
                <tr>
                    <td class="td_padding">
                        <a href="{%$val.player_link%}" target="_blank">
                            <img src="{%$val.photo_link%}">
                        </a>
                    </td>
                    <td class="left">
                        <b><a target="_blank" href="{%$val.player_link%}">{%$val.name%}</a></b>
                        <p>(<b>{%$val.eng_name%}</b>)</p>
                    </td>
                    <td>{%$val.number%}</td>
                    <td>{%$val.position%}</td>
                    <td>{%$val.height%}</td>
                    <td>{%$val.weight%}</td>
                    <td>{%$val.birth_date%}</td>
                    <td class="left">{%$val.wage%}<br><b>本年薪金：{%$val.salary%}万美元</b></td>
                </tr>
                {%/foreach%}
            </tbody>
        </table>
    </div>
</div>
{%/block%}
