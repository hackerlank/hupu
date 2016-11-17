<?php

function smarty_modifier_avg($array, $key="pts"){
    return round(array_sum(array_column($array, $key))/count(array_column($array, $key)), 1);
}
