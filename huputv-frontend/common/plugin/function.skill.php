<?php
/**
 * @auther (FHY) yuhongfei@hupu.com
 * @date 2016-06-07
 * @desc 超能前台技能状态和样式
 * @example
 *  {%skill total=$val.skill_totlenum used=$val.skill_usednum status=$val.skill_status%}
 */

function smarty_function_skill($params, &$smarty) {
    $total = intval($params['total']);
    $used  =  intval($params['used']);
    $status = intval($params['status']);

    $cls = "";
    //正在使用
    if(!$status){

      if($used > 0){
        // 购买已使用完
        if($total == $used){
          $cls = "shade";
        }
      } else{
        if($total == 0){
          //未购买状态
          $cls = "gray";
        }
      }
    }
    return $cls;
}
