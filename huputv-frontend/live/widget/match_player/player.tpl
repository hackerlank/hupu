
  {%if !empty($player) %}
    <div class="player-card-info">
      <h2>参赛球员</h2>
      <div class="player-content">
        {%foreach from=$player item=val name=key%}
          <div class="player-card-list">
            <div class="player-card-inner">
              <div class="avatar">
                <img src="{%$val.header%}" alt="" />
                <span class="num">{%$val.player_num%}</span>
                <span class="team_name">{%$val.group_name%}</span>
              </div>
              <div class="name">
                {%$val.nickname%}
              </div>
              <div class="weight">
                {%$val.height%}cm |&nbsp;{%$val.weight%}kg
              </div>
              <div class="wins">
                胜{%$val.total_win%}负{%$val.total_game-$val.total_win%}胜率{%$val.rate%}%
              </div>
              {%if !empty($val.tag)%}
                <div class="fixed-tag">
                  {%$val.tag%}
                </div>
              {%/if%}
            </div>
            <div class="operat-inner">
              <a href="javascript:" class="button-zan J_buttonSupport" data-name="{%$val.nickname%}" data-id="{%$val.id%}"><i></i><span>{%$val.top%}</span></a>
              <span class="cai" data-id="{%$val.id%}"><i></i><span>{%$val.step%}</span></span>
            </div>
          </div>
        {%/foreach%}
      </div>
    </div>
  {%/if%}



