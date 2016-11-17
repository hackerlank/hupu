<?php /* Smarty version Smarty-3.1.13, created on 2016-06-14 16:35:13
         compiled from "/data/www-data/hupu.com/huputv_frontend/template/home/widget/user-nav/user-nav.tpl" */ ?>
<?php /*%%SmartyHeaderCode:203132317575fc1c159da63-84782966%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'e4fd9b45eca5c7de87aee864635c231dd601ad2e' => 
    array (
      0 => '/data/www-data/hupu.com/huputv_frontend/template/home/widget/user-nav/user-nav.tpl',
      1 => 1465893268,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '203132317575fc1c159da63-84782966',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'index' => 0,
    'current_page' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_575fc1c15f3640_64489740',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_575fc1c15f3640_64489740')) {function content_575fc1c15f3640_64489740($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_f_escape_xml')) include '/data/www-data/hupu.com//huputv_frontend/plugin/modifier.f_escape_xml.php';
?><div class="w-user-nav">
<ul class="inner">
<li><a href="/user/wallet" class="<?php if (($_smarty_tpl->tpl_vars['index']->value==1)){?>active<?php }?>">我的钱包</a></li>
<li><a href="/user/follow-list" class="<?php if (($_smarty_tpl->tpl_vars['index']->value==2)){?>active<?php }?>">我的关注</a></li>
<li><a href="http://voice.hupu.com/other/1997628.html" target="_blank" dace-node="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['current_page']->value);?>
_roomApply" class="<?php if (($_smarty_tpl->tpl_vars['index']->value==3)){?>active<?php }?>">申请成为主播</a></li>
<li><a href="http://b.qq.com/webc.htm?new=0&sid=800021359&q=7" target="_blank" dace-node="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['current_page']->value);?>
_customService" class="<?php if (($_smarty_tpl->tpl_vars['index']->value==4)){?>active<?php }?>">客服支持</a></li>
</ul>
</div><?php }} ?>