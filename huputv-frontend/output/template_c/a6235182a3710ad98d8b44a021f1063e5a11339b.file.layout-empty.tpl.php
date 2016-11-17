<?php /* Smarty version Smarty-3.1.13, created on 2016-06-14 16:35:12
         compiled from "/data/www-data/hupu.com/huputv_frontend/template/common/page/layout-empty.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1495595339575fc1c04d8b62-74447498%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'a6235182a3710ad98d8b44a021f1063e5a11339b' => 
    array (
      0 => '/data/www-data/hupu.com/huputv_frontend/template/common/page/layout-empty.tpl',
      1 => 1456833727,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1495595339575fc1c04d8b62-74447498',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'keywords' => 0,
    'description' => 0,
    'title' => 0,
    'user' => 0,
    'login' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_575fc1c056bc46_26675439',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_575fc1c056bc46_26675439')) {function content_575fc1c056bc46_26675439($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_f_escape_xml')) include '/data/www-data/hupu.com//huputv_frontend/plugin/modifier.f_escape_xml.php';
if (!is_callable('smarty_modifier_f_escape_js')) include '/data/www-data/hupu.com//huputv_frontend/plugin/modifier.f_escape_js.php';
?><!DOCTYPE html>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::setFramework(FISResource::getUri("common:static/mod.js", $_smarty_tpl->smarty)); ?><html>
<head>
<meta charset='utf-8'>
<meta id="viewport" name="viewport" content="initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<meta name="format-detection" content="telephone=no">
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="Keywords" content="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['keywords']->value);?>
" />
<meta name="Description" content="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['description']->value);?>
" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<link rel="shortcut icon" href="http://b3.hoopchina.com.cn/common/favicon.ico" />
<title>
<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['title']->value);?>

</title>

<meta name="keywords" content="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['keywords']->value);?>
" />
<meta name="description" content="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['description']->value);?>
" />

<script>

        !function(win){
            var HTV = win.HTV = {};
            // 用户id
            HTV.getUserId = "<?php echo smarty_modifier_f_escape_js($_smarty_tpl->tpl_vars['user']->value['uid']);?>
" || "";
            // 用户名称
            HTV.getUserName = "<?php echo smarty_modifier_f_escape_js($_smarty_tpl->tpl_vars['user']->value['name']);?>
" || "";
            // 用户登陆状态
            HTV.isLogin = <?php echo intval($_smarty_tpl->tpl_vars['login']->value);?>
;
            HTV.loginUrl = '';
        }(window);
    </script>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("common:static/common.scss",$_smarty_tpl->smarty, false);?>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("common:static/js/jquery/jquery-1.12.0.min.js",$_smarty_tpl->smarty, false);?>

<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}echo FISResource::cssHook();?></head>
<body>

<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load('common:page/layout-empty.tpl',$_smarty_tpl->smarty, false);?></body><?php if(class_exists('FISResource', false)){echo FISResource::jsHook();}?>
<?php $_smarty_tpl->registerFilter('output', array('FISResource', 'renderResponse'));?></html><?php }} ?>