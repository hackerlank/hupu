<?php
/**
 * @auther (FHY) yuhongfei@hupu.com
 * @date 2016-08-24
 * @desc 虎扑TV拼接m的直播间地址
 * @example
 *  {%withRommUrl roomid=$val.id inkanqiu=$in_kanqiu%}
 */

function smarty_function_withRoomUrl($params, &$smarty) {
    $roomId = $params['roomid'];
    $inKanqiu = $params['inkanqiu'];
    $client = $params['client'];

    $roomUrl = "";
    if($inKanqiu) {
        $roomUrl = 'huputiyu://huputv/room/' . $roomId . '?entrance=1';
    } else {
        $roomUrl = '/m/room/' . $roomId . '?n=0&client=' . $client;
    }
    return $roomUrl;
}
