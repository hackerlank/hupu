<?php

function smarty_modifier_chartsAvgRow($array, $key){
		$newArray = [];
		foreach($array[$key] as $item=>$val) {
			if($val != "0") {
				array_push($newArray,$val);
			}
		}
    return round(array_sum($newArray)/count($newArray), 1);
}
