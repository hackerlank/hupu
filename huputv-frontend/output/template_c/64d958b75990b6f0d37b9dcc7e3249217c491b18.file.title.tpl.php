<?php /* Smarty version Smarty-3.1.13, created on 2016-06-14 16:35:13
         compiled from "/data/www-data/hupu.com/huputv_frontend/template/home/widget/title/title.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1360384695575fc1c1603183-18483979%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '64d958b75990b6f0d37b9dcc7e3249217c491b18' => 
    array (
      0 => '/data/www-data/hupu.com/huputv_frontend/template/home/widget/title/title.tpl',
      1 => 1465893268,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1360384695575fc1c1603183-18483979',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'title' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_575fc1c160d172_05051563',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_575fc1c160d172_05051563')) {function content_575fc1c160d172_05051563($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_f_escape_xml')) include '/data/www-data/hupu.com//huputv_frontend/plugin/modifier.f_escape_xml.php';
?><div class="w-title" id="J-w-title">
<h2><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['title']->value);?>
</h2>
</div><?php }} ?>