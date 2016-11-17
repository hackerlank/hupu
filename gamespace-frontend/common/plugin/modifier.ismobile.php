<?php

function smarty_modifier_ismobile($params){
    $useragent=$_SERVER['HTTP_USER_AGENT'];

    return preg_match("/(android|avantgo|blackberry|bolt|boost|cricket|docomo|fone|hiptop|mini|mobi|palm|phone|pie|tablet|up\.browser|up\.link|webos|wos)/i", $useragent);

}
