<?php /* Smarty version Smarty-3.1.13, created on 2016-06-14 16:35:12
         compiled from "/data/www-data/hupu.com/huputv_frontend/template/live/widget/live-recommend/recommend.tpl" */ ?>
<?php /*%%SmartyHeaderCode:173542007575fc1c01ad7a0-33155838%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '30d43ef892377b9c3f002c10a44c8cf555187092' => 
    array (
      0 => '/data/www-data/hupu.com/huputv_frontend/template/live/widget/live-recommend/recommend.tpl',
      1 => 1465893275,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '173542007575fc1c01ad7a0-33155838',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'datas' => 0,
    'recommend_more' => 0,
    'keys' => 0,
    'val' => 0,
    'current_page' => 0,
    'show_online' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_575fc1c02454a6_35872107',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_575fc1c02454a6_35872107')) {function content_575fc1c02454a6_35872107($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_f_escape_xml')) include '/data/www-data/hupu.com//huputv_frontend/plugin/modifier.f_escape_xml.php';
?><div class="live-recommend">
<?php if (!empty($_smarty_tpl->tpl_vars['datas']->value)){?>
<div class="title">
<h2>热门推荐</h2>
<a href="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['recommend_more']->value);?>
" class="button-more">更多</a>
</div>
<div class="bd">
<div class="recomend-list">
<?php  $_smarty_tpl->tpl_vars['val'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['val']->_loop = false;
 $_smarty_tpl->tpl_vars['keys'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['datas']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['val']->key => $_smarty_tpl->tpl_vars['val']->value){
$_smarty_tpl->tpl_vars['val']->_loop = true;
 $_smarty_tpl->tpl_vars['keys']->value = $_smarty_tpl->tpl_vars['val']->key;
?>
<div class="list <?php if ($_smarty_tpl->tpl_vars['keys']->value>=4){?>fn-hide<?php }?>">
<dl>
<dd class="pic">
<a href="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['abs_url']);?>
" dace-node="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['current_page']->value);?>
_roomClick">
<img src="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['cover']);?>
" alt=""/>
</a>
</dd>
<dt class="title-name">
<a href="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['abs_url']);?>
" dace-node="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['current_page']->value);?>
_roomClick"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['name']);?>
</a>
</dt>
<dd class="info">
<span class="name">
<i class="icon-hptv-user"></i>
<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['anchor_nickname']);?>

</span>
<?php if (!empty($_smarty_tpl->tpl_vars['show_online']->value)){?>
<span class="people-count">
<i class="icon-hptv-people"></i>
<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['online']);?>

</span>
<?php }?>
</dd>
</dl>
</div>
<?php } ?>
</div>
</div>
<?php }?>
</div>
<?php }} ?>