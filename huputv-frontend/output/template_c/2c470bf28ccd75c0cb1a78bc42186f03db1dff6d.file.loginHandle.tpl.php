<?php /* Smarty version Smarty-3.1.13, created on 2016-06-14 16:35:12
         compiled from "/data/www-data/hupu.com/huputv_frontend/template/home/page/loginHandle.tpl" */ ?>
<?php /*%%SmartyHeaderCode:590162844575fc1c0b21610-82526937%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '2c470bf28ccd75c0cb1a78bc42186f03db1dff6d' => 
    array (
      0 => '/data/www-data/hupu.com/huputv_frontend/template/home/page/loginHandle.tpl',
      1 => 1465893267,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '590162844575fc1c0b21610-82526937',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_575fc1c0b2a998_72670217',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_575fc1c0b2a998_72670217')) {function content_575fc1c0b2a998_72670217($_smarty_tpl) {?>
<p style="text-align: center;">登录成功，正在跳转...</p>
<script>
        function getQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
        var jumpUrl = getQueryString('absurl');

        parent.location.href = jumpUrl;
    </script>
<?php }} ?>