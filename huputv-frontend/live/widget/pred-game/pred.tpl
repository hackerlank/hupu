
<div class="live-pred-game" id="J_predGame">
  <div class="J_content">
    <div class="not-content">
      该主播暂未开题，敬请期待
    </div>
  </div>
  <div class="button-inner">
    <a href="javascript:" class="button-confirm J_buttonSubmit">确认</a>
    <span class="text">已选中 【<span class="J_SelectText"></span>】</span>
  </div>
</div>

<script id="pred-tpl" type="javascript/template">
  <@if(datas.length){@>
    <@ _.each(datas, function(item,index) { @>
      <div class="pred-game-list J_predGameList <@if(item.status == 0){@>pred-game-list-start<@}@>" data-id="<@=item.id@>" data-score="<@=item.score@>">
        <div class="pred-title">
          <span class="status"><@=['进行中', '待开奖', '已开奖', '已流盘'][item.status]@>-</span>
          <span class="name"><@=item.title@></span>
          （RP <span class="red"><@=item.score@></span> 分）
        </div>
        <@if(!+item.status && max(item.option).total_count) {@>
          <div class="remind-option">
            <@=rate(item.option)@>的人选择 [<@=max(item.option).option@>]
          </div>
        <@}else{@>
          <div class="remind-option" style="display: none;"></div>
        <@}@>
        <div class="option-inner">
          <@if(item.option.length){@>
            <@ _.each(item.option, function(key) { @>
              <@if(item.status == 0 && item.user_option == 0){@>
                <a href="javascript:" class="button-option J_buttonOption <@=statusClass(item, key.option_id)@>" data-option-id="<@=key.option_id@>"><@=key.option@></a>
              <@}else{@>
                <span class="button-option button-disabled <@=statusClass(item, key.option_id)@>"><@=key.option@></span>
              <@}@>
            <@ }) @>
          <@}@>
        </div>
      </div>
    <@ }) @>
  <@}@>
</script>

{%script%}
var PredGame = require("live:widget/pred-game/pred");
PredGame.init();
{%/script%}
