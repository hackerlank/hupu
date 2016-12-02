<script id="J_lrwTop8Tpl" type="text/template">
  <@ if(datas.length){@>
    <div class="match-anainst">
      <@ _.each(datas, function(item, index){@>
        <@ if(+item.right_puid || +item.left_puid){ @>
          <div class="match-anainst-item <@ if(item.status == 0){@>semifinal-item-notstart<@}@>">
            <div class="col-left <@ if(item.status == 2){@>match-fail<@}@>">
              <@ if(item.left){ @>
                <div class="avatar-inner">
                  <span class="number"><@=item.left.player_num@></span>
                  <div class="avatar">
                    <img src="<@=item.left.header@>" />
                    <div class="maskavatar"></div>
                  </div>
                </div>
                <h4 class="title"><@=subBtyesString(item.left.nickname)@></h4>
                <div class="info">
                  胜<@=item.left.total_win@> (<@=item.left.rate@>%)
                </div>
              <@}else{@>
                <span class="unknown-person"><@=matchText[item.num].left@></span>
              <@}@>
            </div>
            <div class="col-center">
              <div class="match-score">
                <div class="course-number">第<@=item.num@>场</div>
                <div class="score">
                  <@ if(item.status == 0){ @>
                    未开始
                  <@ }else{@>
                    <@=item.left_score@>-<@=item.right_score@>
                  <@ } @>
                </div>
              </div>
            </div>
            <div class="col-right <@ if(item.status == 1){@>match-fail<@}@>">
              <@ if(item.right){ @>
                <div class="avatar-inner">
                  <span class="number"><@=item.right.player_num@></span>
                  <div class="avatar">
                    <img src="<@=item.right.header@>" />
                    <div class="maskavatar"></div>
                  </div>
                </div>
                <h4 class="title"><@=subBtyesString(item.right.nickname)@></h4>
                <div class="info">
                  胜<@=item.right.total_win@> (<@=item.right.rate@>%)
                </div>
              <@}else{@>
                <span class="unknown-person"><@=matchText[item.num].right@></span>
              <@}@>
            </div>
          </div>
        <@}@>
      <@});@>
    </div>
  <@ }@>
</script>
