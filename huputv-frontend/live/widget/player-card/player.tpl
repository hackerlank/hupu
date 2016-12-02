{%if !empty($data)%}
  <div id="J_playerCardInfo"></div>

  <script id="player-card-tpl" type="javascript/template">
    <@if(datas.length){@>
      <div class="player-card-info">
        <@if(top.length){@>
          <div class="player-top-five">
            <h2 class="tag">前五</h2>
            <ul class="player-top-list">
              <@ _.each(top, function(item, index) { @>
                <li>
                  <@if(+item.lightness) {@>
                    <div class="avatar">
                      <img src="<@=item.header@>" alt="" />
                    </div>
                    <div class="name">
                      <@=sub(item.nickname, 8, '')@>
                    </div>
                  <@}else{@>
                    <div class="avatar default-avatar">
                    </div>
                  <@}@>
                </li>
                <@ }) @>
            </ul>
          </div>
        <@}@>
        <div class="player-content">
          <@ _.each(datas, function(item, index) { @>
            <div class="player-card-list">
              <div class="player-card-inner">
                <div class="avatar">
                  <img src="<@=item.header@>" alt="" />
                </div>
                <div class="name">
                  <@=sub(item.nickname, 8, '...')@>
                </div>
                <div class="weight">
                  <@=item.height@>cm | <@=item.weight@>kg
                </div>
                <div class="wins">
                  胜 <@if(!+item.total_win){@>-<@}else{@><@=item.total_win@><@}@>
                  <@if(+item.total_win){@>
                    (<@=rate(item.total_win, item.total_game)@>)
                  <@}@>
                </div>
                <@if(item.tag){@>
                  <div class="fixed-tag">
                    <@=item.tag@>
                  </div>
                <@}@>
                <div class="mark-out" <@if(+item.status == 2){@>style="display: block;"<@}@>></div>
                <div class="mark-abstain" <@if(+item.status == 3){@>style="display: block;"<@}@>></div>
              </div>
              <div class="operat-inner">
                <a href="javascript:" class="button-support J_buttonSupport" data-name="<@=item.nickname@>" data-id="<@=item.player_id@>">支持</a>
                <span class="number"><@=item.lightness@> 瓦</span>
              </div>
            </div>
          <@ }) @>
        </div>
      <@}@>
    </div>
  </script>

  {%script%}
  HTV.gameID = "{%$data.game_id%}" || 0;
  var PlayerCard = require("live:widget/player-card/player");
  PlayerCard.init();
  {%/script%}

{%/if%}
