<?php /* Smarty version Smarty-3.1.13, created on 2016-06-14 16:35:13
         compiled from "/data/www-data/hupu.com/huputv_frontend/template/home/widget/download/download.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1648597758575fc1c158c735-23739969%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'c607f54b84bb905de082853bcdd82f5311a1e16a' => 
    array (
      0 => '/data/www-data/hupu.com/huputv_frontend/template/home/widget/download/download.tpl',
      1 => 1465893268,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1648597758575fc1c158c735-23739969',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'title' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_575fc1c1597811_20979602',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_575fc1c1597811_20979602')) {function content_575fc1c1597811_20979602($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_f_escape_xml')) include '/data/www-data/hupu.com//huputv_frontend/plugin/modifier.f_escape_xml.php';
?><div class="w-download">
<a href="http://mobile.hupu.com/?_r=shareRoom" target="_blank">
<div class="hupu-logo">
<img src="http://i1.hoopchina.com.cn/blogfile/201512/06/BbsImg144939425562185_92*92big.png" alt=""/>
</div>
<div class="app-info">
<h4 class="name">
虎扑体育</h4>
<div class="text">
<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['title']->value);?>

</div>
<div class="score">
<img src="http://i1.hoopchina.com.cn/blogfile/201512/06/BbsImg144939425567994_97*17big.png" alt=""/>
</div>
</div>
<div class="button-down">
免费下载</div>
</a>
</div><?php }} ?>