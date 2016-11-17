<?php

function smarty_modifier_array_to_string($data, $key){
		if($data){
			return implode(',', array_column($data, $key));
		}else{
			return "0";
		}
    
}
