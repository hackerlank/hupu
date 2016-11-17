<?php /* Smarty version Smarty-3.1.13, created on 2016-06-14 16:35:12
         compiled from "/data/www-data/hupu.com/huputv_frontend/template/live/widget/send-gift/gift.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1229426494575fc1c0056496-07391033%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'e591cbdeb815cbab95dcd35492d3dc835d685912' => 
    array (
      0 => '/data/www-data/hupu.com/huputv_frontend/template/live/widget/send-gift/gift.tpl',
      1 => 1465893275,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1229426494575fc1c0056496-07391033',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'datas' => 0,
    'balance' => 0,
    'val' => 0,
    'gift' => 0,
    'val1' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_575fc1c017e688_96160334',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_575fc1c017e688_96160334')) {function content_575fc1c017e688_96160334($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_f_escape_xml')) include '/data/www-data/hupu.com//huputv_frontend/plugin/modifier.f_escape_xml.php';
?><?php if (!empty($_smarty_tpl->tpl_vars['datas']->value)){?>
<div class="send-gift J_sendGift">
<ul class="gift-list" id="J_sendGiftList" data-beans="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['balance']->value[1]);?>
" data-gold="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['balance']->value[6]);?>
">
<?php  $_smarty_tpl->tpl_vars['val'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['val']->_loop = false;
 $_smarty_tpl->tpl_vars['keys'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['datas']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['val']->key => $_smarty_tpl->tpl_vars['val']->value){
$_smarty_tpl->tpl_vars['val']->_loop = true;
 $_smarty_tpl->tpl_vars['keys']->value = $_smarty_tpl->tpl_vars['val']->key;
?>
<li data-id="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['id']);?>
">
<div class="gift-pic <?php if (empty($_smarty_tpl->tpl_vars['val']->value['multi_send'])){?>J_giftButton<?php }?>">
<img src="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['cover_url']);?>
" alt=""/>
</div>
<div class="gift-tips <?php if (!empty($_smarty_tpl->tpl_vars['val']->value['multi_send'])&&$_smarty_tpl->tpl_vars['val']->value['multi_send']==1){?>send-gift-tips<?php }?>">
<div class="pic">
<?php if (!empty($_smarty_tpl->tpl_vars['val']->value['money_type'])&&$_smarty_tpl->tpl_vars['val']->value['money_type']=="1"){?>
<div class="gift-icon-bg" style="background-image: url(<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['effect_file_icon_url']);?>
)"></div>
<?php }else{ ?>
<img src="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['effect_file_gif_url']);?>
" alt="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['name']);?>
"/>
<?php }?>
</div>
<dl class="list">
<dd class="name">
<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['name']);?>

</dd>
<dd class="money">
<?php if (!empty($_smarty_tpl->tpl_vars['val']->value['money_type'])&&$_smarty_tpl->tpl_vars['val']->value['money_type']=="1"){?>
<i class="icons icons-1"></i><span class="J_giftPrice" data-price="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['price']);?>
"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['price']);?>
</span>
金豆<?php }else{ ?>
<i class="icons icons-2"></i><span class="J_giftPrice" data-price="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['price']);?>
"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['price']);?>
</span>
虎扑币<?php }?>
</dd>
<dt class="about"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['description']);?>
</dt>
</dl>
<?php if (!empty($_smarty_tpl->tpl_vars['val']->value['multi_send'])&&$_smarty_tpl->tpl_vars['val']->value['multi_send']==1&&count($_smarty_tpl->tpl_vars['gift']->value['multi'])>1){?>
<div class="batch-send-gift J_batchSendGift">
<?php  $_smarty_tpl->tpl_vars['val1'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['val1']->_loop = false;
 $_smarty_tpl->tpl_vars['keys1'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['gift']->value['multi']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['val1']->key => $_smarty_tpl->tpl_vars['val1']->value){
$_smarty_tpl->tpl_vars['val1']->_loop = true;
 $_smarty_tpl->tpl_vars['keys1']->value = $_smarty_tpl->tpl_vars['val1']->key;
?>
<a href="javascript:">x<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val1']->value);?>
</a>
<?php } ?>
</div>
<?php }?>
</div>
</li>
<?php } ?>
</ul>
<div class="ui-success-toast" id="J_uiSuccessToast"></div>
</div>
<?php }?>
<?php $fis_script_priority = 0;ob_start();?>
var SendGift = require("live:widget/send-gift/gift.es6");
SendGift.init();
<?php $script=ob_get_clean();if($script!==false){if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}if(FISResource::$cp) {if (!in_array(FISResource::$cp, FISResource::$arrEmbeded)){FISResource::addScriptPool($script, $fis_script_priority);FISResource::$arrEmbeded[] = FISResource::$cp;}} else {FISResource::addScriptPool($script, $fis_script_priority);}}FISResource::$cp = null;?><?php }} ?>