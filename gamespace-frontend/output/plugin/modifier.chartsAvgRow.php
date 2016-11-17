<?php

function smarty_modifier_chartsAvgRow($array, $key){
    return round(array_sum($array[$key])/count($array[$key]), 1);
}
