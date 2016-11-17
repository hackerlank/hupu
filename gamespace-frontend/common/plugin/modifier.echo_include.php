<?php

function smarty_modifier_echo_include($pos){
    if($pos == "header"){
    	echo '<!--#include virtual="/global_navigator/utf8/css.html" -->';
    }
    if($pos == "footer_level"){
    	echo '<!--#include virtual="/global_navigator/utf8/nba/level_1.html" -->';
    }
    if($pos == "footer"){
    	echo '<!--#include virtual="/global_navigator/utf8/nba/footer.html" -->';
    }
}
