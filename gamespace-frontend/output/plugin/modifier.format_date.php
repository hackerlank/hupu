<?php

function smarty_modifier_format_date($date, $type, $count){
    if($type == 1){
        return date('Y-m-d', strtotime($date . '-' . $count .' day'));
    }else if($type == 2){
        return date('Y-m-d', strtotime($date . '+' . $count .' day'));
    }
}
