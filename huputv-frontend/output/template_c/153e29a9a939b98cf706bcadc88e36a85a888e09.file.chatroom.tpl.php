<?php /* Smarty version Smarty-3.1.13, created on 2016-06-14 16:35:12
         compiled from "/data/www-data/hupu.com/huputv_frontend/template/live/widget/chatroom/chatroom.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1496242964575fc1c0185722-37966951%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '153e29a9a939b98cf706bcadc88e36a85a888e09' => 
    array (
      0 => '/data/www-data/hupu.com/huputv_frontend/template/live/widget/chatroom/chatroom.tpl',
      1 => 1465893275,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1496242964575fc1c0185722-37966951',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'login' => 0,
    'login_url' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_575fc1c01a75a5_42631864',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_575fc1c01a75a5_42631864')) {function content_575fc1c01a75a5_42631864($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_f_escape_xml')) include '/data/www-data/hupu.com//huputv_frontend/plugin/modifier.f_escape_xml.php';
?><div class="chatroom" id="J_chatroom">
<div class="chatroom-list J_chatroomScroll">
<ul class="list J_chatroomList">
</ul>
</div>
<div class="gift-batter-tip" id="J_giftBatterTip">
</div>
<div class="send-hot-line J_sendHotline <?php if (!$_smarty_tpl->tpl_vars['login']->value){?>chatroom-notlogin<?php }?>">
<div class="textarea-inner">
<textarea name="" class="form-textarea J_formTextarea" placeholder="在这里输入弹幕文字" maxlength="60"></textarea>
<div class="chat-error J_chatError">
不能为空</div>
</div>
<div class="button-inner">
<label class="shield">
<input type="checkbox" class="J_shieldCheckbox" />
屏蔽礼物信息</label>
<div class="button-right">
<span class="text-max-count">
<span class="J_canEnterCount">0</span>/60</span>
<a class="button-send J_buttonSend" href="javascript:">发送</a>
</div>
</div>
<div class="tips-islogin">
<a href="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['login_url']->value);?>
" id="J_chatButtonLogin"><span class="red">登录</span>即可参与聊天</a>
</div>
</div>
</div>
<script id="hotline-tpl" type="text/template">
    <@ _.each(datas, function(item,index) { @>
        <@if(item.username != ""){@>
            <li>
                <@if(typeof item.gift !== "undefined"){@>
                    <span style="color: #<@=item.gift.link_color@>"><@=item.content@></span>
                <@}else if(typeof item.tv_gift !== "undefined" && typeof item.giftDetail !== "undefined"){@>
                    <span class="name <@if(item.username == username){@>self-name<@}@>"><@=item.username@></span>
                    送出
                    <@if(item.tv_gift.number < 666 || item.giftDetail.money_type == 6){@>
                        <span class="color-orange"><@=item.tv_gift.number@>个<@=item.giftDetail.name@></span>
                    <@}else{@>
                        <span class="better-count">
                            <@ _.each(item.tv_gift.number.toString().split(''), function(val) { @>
                                <i class="count-<@=val@>"></i>
                            <@ }); @>
                        </span>
                        <span class="color-orange">个<@=item.giftDetail.name@></span>
                    <@}@>
                    <i class="icons-gift" style="background-image: url(<@=item.giftDetail.effect_file_icon_url@>)"></i>
                    <@if(item.teamName){@>
                      给<span class="color-orange"><@=item.teamName@></span>
                    <@}@>
                <@}else{@>
                    <span class="name <@if(item.username == username){@>self-name<@}@>">
                        <@=item.username@>
                        <@if(typeof item.via !== "undefined" && item.via !== 5 ){@>
                            <a href="http://voice.hupu.com/other/2006264.html" target="_blank" class="icons-phone"></a>
                        <@}@>:
                    </span>
                    <@=item.content@>
                <@}@>
            </li>
        <@}@>
    <@ }); @>
</script>
<script id="chaoneng-hotline-tpl" type="text/template">
    <@ _.each(datas, function(item,index) { @>
        <@if(item.username != ""){@>
            <li>
              <@if(item.lineType == "buy"){@>
                <span class="color-team"><@=item.teamname@></span>购买了<@=item.count@>个<span class="color-skill"><@=item.name@></span>
              <@} else if(item.lineType == "use"){@>
                <span class="color-team"><@=item.teamname@></span>正在使用<span class="color-skill"><@=item.name@></span>
              <@}@>
            </li>
        <@}@>
    <@ }); @>
</script>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("common:static/js/socket/socket.io.js",$_smarty_tpl->smarty, false);?>
<?php $fis_script_priority = 0;ob_start();?>
var Chatroom = require("live:widget/chatroom/chatroom.es6");

Chatroom.init();
HTV.emitChat = Chatroom.emit;
<?php $script=ob_get_clean();if($script!==false){if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}if(FISResource::$cp) {if (!in_array(FISResource::$cp, FISResource::$arrEmbeded)){FISResource::addScriptPool($script, $fis_script_priority);FISResource::$arrEmbeded[] = FISResource::$cp;}} else {FISResource::addScriptPool($script, $fis_script_priority);}}FISResource::$cp = null;?>
<?php }} ?>