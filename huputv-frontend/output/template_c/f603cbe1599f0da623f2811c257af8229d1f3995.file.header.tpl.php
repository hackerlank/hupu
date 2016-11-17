<?php /* Smarty version Smarty-3.1.13, created on 2016-06-14 16:35:12
         compiled from "/data/www-data/hupu.com/huputv_frontend/template/common/widget/header/header.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1859270585575fc1c0675354-06642765%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'f603cbe1599f0da623f2811c257af8229d1f3995' => 
    array (
      0 => '/data/www-data/hupu.com/huputv_frontend/template/common/widget/header/header.tpl',
      1 => 1465893257,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1859270585575fc1c0675354-06642765',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'category' => 0,
    'val' => 0,
    'category_id' => 0,
    'current_page' => 0,
    'user' => 0,
    'open_soon' => 0,
    'show_online' => 0,
    'logout_url' => 0,
    'base_url' => 0,
    'abs_url' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_575fc1c0828f85_36685894',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_575fc1c0828f85_36685894')) {function content_575fc1c0828f85_36685894($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_f_escape_xml')) include '/data/www-data/hupu.com//huputv_frontend/plugin/modifier.f_escape_xml.php';
if (!is_callable('smarty_modifier_ismobile')) include '/data/www-data/hupu.com//huputv_frontend/plugin/modifier.ismobile.php';
if (!is_callable('smarty_modifier_f_escape_path')) include '/data/www-data/hupu.com//huputv_frontend/plugin/modifier.f_escape_path.php';
?><div class="w-header clearfix" id="J-w-header">
<div class="inner">
<h1 class="logo">
<a href="/" title="虎扑TV">虎扑TV</a>
</h1>
<div class="nav">
<?php if (!empty($_smarty_tpl->tpl_vars['category']->value)){?>
<ul>
<?php  $_smarty_tpl->tpl_vars['val'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['val']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['category']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
 $_smarty_tpl->tpl_vars['val']->index=-1;
foreach ($_from as $_smarty_tpl->tpl_vars['val']->key => $_smarty_tpl->tpl_vars['val']->value){
$_smarty_tpl->tpl_vars['val']->_loop = true;
 $_smarty_tpl->tpl_vars['val']->index++;
?>
<?php if (!empty($_smarty_tpl->tpl_vars['val']->value['display'])){?>
<?php $_smarty_tpl->createLocalArrayVariable('category_arr', null, 0);
$_smarty_tpl->tpl_vars['category_arr']->value[$_smarty_tpl->tpl_vars['val']->index] = $_smarty_tpl->tpl_vars['val']->value['sid'];?>
<?php }?>
<?php } ?>
<?php  $_smarty_tpl->tpl_vars['val'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['val']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['category']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
 $_smarty_tpl->tpl_vars['val']->index=-1;
foreach ($_from as $_smarty_tpl->tpl_vars['val']->key => $_smarty_tpl->tpl_vars['val']->value){
$_smarty_tpl->tpl_vars['val']->_loop = true;
 $_smarty_tpl->tpl_vars['val']->index++;
?>
<?php if (!empty($_smarty_tpl->tpl_vars['val']->value['display'])){?>
<li><a href="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['abs_url']);?>
" dace-node="nav_channelClick" <?php if (isset($_smarty_tpl->tpl_vars['category_id']->value)&&$_smarty_tpl->tpl_vars['category_id']->value==$_smarty_tpl->tpl_vars['val']->value['sid']&&$_smarty_tpl->tpl_vars['current_page']->value!="center"){?>class="active"<?php }?>><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['sname']);?>
</a></li>
<?php }?>
<?php } ?>
</ul>
<?php }?>
</div>
<div class="right">
<?php if (!empty($_smarty_tpl->tpl_vars['user']->value)){?>
<div class="login">
<span class="app"><i class="icon icon-hptv-phone"></i><a <?php if (smarty_modifier_ismobile($_SERVER['HTTP_USER_AGENT'])){?>href="http://mobile.hupu.com/?_r=shareRoom"<?php }else{ ?>href="http://voice.hupu.com/other/2006264.html"<?php }?> target="_blank" dace-node="nav_appDownloadClick">手机客户端</a></span>
<span class="myfollow">
<?php if (!empty($_smarty_tpl->tpl_vars['open_soon']->value['new'])){?>
<span class="num"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['open_soon']->value['new']);?>
</span>
<?php }?>
<a class="link-myfollow" href="/user/follow-list"><i class="icon icon-hptv-love"></i>我的关注</a>
<div class="myfollow-list">
<?php if (!empty($_smarty_tpl->tpl_vars['open_soon']->value['list'])){?>
<dl class="inner">
<?php if (sizeof($_smarty_tpl->tpl_vars['open_soon']->value['list'])!=1){?>
<dt>你关注的主播有<span><?php echo sizeof($_smarty_tpl->tpl_vars['open_soon']->value['list']);?>
</span>个已开播</dt>
<?php }else{ ?>
<dt><span><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['open_soon']->value['list'][0]['anchor_nickname']);?>
</span>&nbsp;已开播</dt>
<?php }?>
<?php  $_smarty_tpl->tpl_vars['val'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['val']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['open_soon']->value['list']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
 $_smarty_tpl->tpl_vars['val']->index=-1;
foreach ($_from as $_smarty_tpl->tpl_vars['val']->key => $_smarty_tpl->tpl_vars['val']->value){
$_smarty_tpl->tpl_vars['val']->_loop = true;
 $_smarty_tpl->tpl_vars['val']->index++;
?>
<dd <?php if ($_smarty_tpl->tpl_vars['val']->index==sizeof($_smarty_tpl->tpl_vars['open_soon']->value)-1){?>class="last-item"<?php }?>>
<a href="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['abs_url']);?>
" title="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['name']);?>
" dace-node="nav_myfollowRoomClick">
<div class="cover">
<img src="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['cover']);?>
" width="78" height="45" alt="">
</div>
<div class="text">
<h3 class="room-name mod-overflow"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['name']);?>
</h3>
<div class="info">
<div class="user fl">
<i class="icon-hptv-user"></i>
<span><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['anchor_nickname']);?>
</span>
</div>
<?php if (!empty($_smarty_tpl->tpl_vars['show_online']->value)){?>
<div class="audience fr">
<i class="icon-hptv-people"></i>
<span><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['online']);?>
</span>
</div>
<?php }?>
</div>
</div>
</a>
</dd>
<?php } ?>
</dl>
<div class="bottom-inner">
<a href="/user/follow-list" class="button-all-follow">全部关注</a>
</div>
<?php }else{ ?>
<p class="no-live">暂无关注主播开播。</p>
<?php }?>
</div>
</span>
<span class="user">
<div class="inner">
<a href="/user/follow-list">
<img src="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['user']->value['avatar']['header_small']);?>
" alt="">
<span class="name mod-overflow"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['user']->value['nickname']);?>
</span>
</a>
</div>
<ul class="user-list">
<li><a href="/user/wallet" dace-node="nav_myfollowClick">我的钱包</a></li>
<li><a href="http://voice.hupu.com/other/1997628.html" target="_blank" dace-node="nav_roomApply">申请成为主播</a></li>
<li><a href="http://b.qq.com/webc.htm?new=0&sid=800021359&o=hupu.tv&q=7" target="_blank" dace-node="nav_customService">客服支持</a></li>
<li class="last-item"><a href="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['logout_url']->value);?>
">退出登录</a></li>
</ul>
</span>
</div>
<?php }else{ ?>
<div class="unlogin">
<span class="app"><i class="icon icon-hptv-phone"></i><a <?php if (smarty_modifier_ismobile($_SERVER['HTTP_USER_AGENT'])){?>href="http://mobile.hupu.com/?_r=shareRoom"<?php }else{ ?>href="http://voice.hupu.com/other/2006264.html"<?php }?> target="_blank" dace-node="nav_appDownloadClick">手机客户端</a></span>
<span class="logreg">
<i class="icon icon-hptv-user"></i>
<a href="http://passport.videohupu.com/pc/login?project=hupuTv&from=pc&display=mini&fback=true&jumpurl=<?php echo smarty_modifier_f_escape_path($_smarty_tpl->tpl_vars['base_url']->value);?>
user/auth?absurl=<?php echo smarty_modifier_f_escape_path($_smarty_tpl->tpl_vars['abs_url']->value);?>
" id="J_loginUrl">登录</a>
<i class="line">|</i>
<a href="http://passport.videohupu.com/pc/register?project=hupuTv&from=pc&display=mini&fback=true&jumpurl=<?php echo smarty_modifier_f_escape_path($_smarty_tpl->tpl_vars['base_url']->value);?>
user/auth?absurl=<?php echo smarty_modifier_f_escape_path($_smarty_tpl->tpl_vars['abs_url']->value);?>
" id="J_registerUrl">注册</a></span>
</div>
<?php }?>
</div>
</div>
</div>
<?php $fis_script_priority = 0;ob_start();?>
	var header = require("common:widget/header/header");
    header.init();

    

<?php $script=ob_get_clean();if($script!==false){if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}if(FISResource::$cp) {if (!in_array(FISResource::$cp, FISResource::$arrEmbeded)){FISResource::addScriptPool($script, $fis_script_priority);FISResource::$arrEmbeded[] = FISResource::$cp;}} else {FISResource::addScriptPool($script, $fis_script_priority);}}FISResource::$cp = null;?>
<?php }} ?>