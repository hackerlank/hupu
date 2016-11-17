<?php /* Smarty version Smarty-3.1.13, created on 2016-06-14 16:35:12
         compiled from "/data/www-data/hupu.com/huputv_frontend/template/home/page/myfollow.tpl" */ ?>
<?php /*%%SmartyHeaderCode:561618773575fc1c0d37f63-24001297%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '4b819e474436460ce7cc2bee4eba27f481c7d1a4' => 
    array (
      0 => '/data/www-data/hupu.com/huputv_frontend/template/home/page/myfollow.tpl',
      1 => 1456198820,
      2 => 'file',
    ),
    '4b636d8b8b565e67cf40427d64e6124995b765c8' => 
    array (
      0 => '/data/www-data/hupu.com/huputv_frontend/template/common/page/layout.tpl',
      1 => 1465893257,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '561618773575fc1c0d37f63-24001297',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'title' => 0,
    'keywords' => 0,
    'description' => 0,
    'current_page' => 0,
    'user' => 0,
    'login' => 0,
    'base_url' => 0,
    'login_url' => 0,
    'abs_url' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_575fc1c0f00fb7_57012328',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_575fc1c0f00fb7_57012328')) {function content_575fc1c0f00fb7_57012328($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_f_escape_xml')) include '/data/www-data/hupu.com//huputv_frontend/plugin/modifier.f_escape_xml.php';
if (!is_callable('smarty_modifier_f_escape_js')) include '/data/www-data/hupu.com//huputv_frontend/plugin/modifier.f_escape_js.php';
?><!DOCTYPE html>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::setFramework(FISResource::getUri("common:static/mod.js", $_smarty_tpl->smarty)); ?><html>
<head>
<meta charset='utf-8'>
<meta id="viewport" name="viewport" content="initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<meta name="format-detection" content="telephone=no">
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta property="wb:webmaster" content="d8a16d6112fc138f" />
<meta name="baidu-site-verification" content="AEcuH3GtJR" />
<link rel="shortcut icon" href="http://b3.hoopchina.com.cn/common/favicon.ico" />
<title>
虎扑TV—体育视频直播平台
</title>

<meta name="keywords" content="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['keywords']->value);?>
" />
<meta name="description" content="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['description']->value);?>
" />

<script>
        var __dacePageName = '<?php echo smarty_modifier_f_escape_js($_smarty_tpl->tpl_vars['current_page']->value);?>
';

        !function(win){
            var HTV = win.HTV = {};
            // 用户id
            HTV.getUserId = "<?php echo smarty_modifier_f_escape_js($_smarty_tpl->tpl_vars['user']->value['puid']);?>
" || "";
            // 用户名称
            HTV.getUserName = "<?php echo smarty_modifier_f_escape_js($_smarty_tpl->tpl_vars['user']->value['username']);?>
" || "";
            // 看球名称
            HTV.getNickName = "<?php echo smarty_modifier_f_escape_js($_smarty_tpl->tpl_vars['user']->value['nickname']);?>
" || "";
            // 用户登陆状态
            HTV.isLogin = <?php echo intval($_smarty_tpl->tpl_vars['login']->value);?>
;

            HTV.base_url = '<?php echo smarty_modifier_f_escape_js($_smarty_tpl->tpl_vars['base_url']->value);?>
';
            // 跳转登录
            HTV.jumpLogin = function() {
                <?php if (!$_smarty_tpl->tpl_vars['login']->value&&!empty($_smarty_tpl->tpl_vars['login_url']->value)){?>
                    window.location.href = '<?php echo smarty_modifier_f_escape_js($_smarty_tpl->tpl_vars['login_url']->value);?>
';
                <?php }?>
            };

            HTV.loginUrl = "http://passport.videohupu.com/pc/login?project=hupuTv&from=pc&display=mini&fback=true&jumpurl=<?php echo smarty_modifier_f_escape_js($_smarty_tpl->tpl_vars['base_url']->value);?>
user/auth?absurl=<?php echo smarty_modifier_f_escape_js($_smarty_tpl->tpl_vars['abs_url']->value);?>
";

            HTV.registerUrl = "http://passport.videohupu.com/pc/register?project=hupuTv&from=pc&display=mini&fback=true&jumpurl=<?php echo smarty_modifier_f_escape_js($_smarty_tpl->tpl_vars['base_url']->value);?>
user/auth?absurl=<?php echo smarty_modifier_f_escape_js($_smarty_tpl->tpl_vars['abs_url']->value);?>
";
            
        }(window);
    </script>
<script>
        var _hmt = _hmt || [];
        (function() {
            var hm = document.createElement("script");
            hm.src = "//hm.baidu.com/hm.js?31211abefd2e8045ea07857bb7f9eae0";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>
<script src="http://b3.hoopchina.com.cn/web/module/dace/opdace/dace.cross.min.js"></script>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("common:static/common.scss",$_smarty_tpl->smarty, false);?>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("common:static/js/jquery/jquery-1.12.0.min.js",$_smarty_tpl->smarty, false);?>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("common:static/js/global/global.js",$_smarty_tpl->smarty, false);?>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("common:static/js/colorbox/jquery.colorbox.js",$_smarty_tpl->smarty, false);?>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("common:static/js/underscore/underscore.js",$_smarty_tpl->smarty, false);?>

<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("home:static/myfollow/myfollow.scss",$_smarty_tpl->smarty, false);?>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("common:static/js/jquery/jquery-1.12.0.min.js",$_smarty_tpl->smarty, false);?>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("home:static/myfollow/myfollow.js",$_smarty_tpl->smarty, false);?>
<?php $fis_script_priority = 0;ob_start();?>
	<?php $script=ob_get_clean();if($script!==false){if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}if(FISResource::$cp) {if (!in_array(FISResource::$cp, FISResource::$arrEmbeded)){FISResource::addScriptPool($script, $fis_script_priority);FISResource::$arrEmbeded[] = FISResource::$cp;}} else {FISResource::addScriptPool($script, $fis_script_priority);}}FISResource::$cp = null;?>

<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}echo FISResource::cssHook();?></head>
<body>

<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}$_tpl_path=FISResource::getUri("common:widget/header/header.tpl",$_smarty_tpl->smarty);if(isset($_tpl_path)){echo $_smarty_tpl->getSubTemplate($_tpl_path, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, $_smarty_tpl->caching, $_smarty_tpl->cache_lifetime, array(), Smarty::SCOPE_LOCAL);}else{trigger_error('unable to locale resource "'."common:widget/header/header.tpl".'"', E_USER_ERROR);}FISResource::load("common:widget/header/header.tpl", $_smarty_tpl->smarty);?>


<div class="myfollow-wrap" id="J-myfollow-wrap">
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}$_tpl_path=FISResource::getUri("home:widget/title/title.tpl",$_smarty_tpl->smarty);if(isset($_tpl_path)){echo $_smarty_tpl->getSubTemplate($_tpl_path, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, $_smarty_tpl->caching, $_smarty_tpl->cache_lifetime, array('title'=>"个人中心"), Smarty::SCOPE_LOCAL);}else{trigger_error('unable to locale resource "'."home:widget/title/title.tpl".'"', E_USER_ERROR);}FISResource::load("home:widget/title/title.tpl", $_smarty_tpl->smarty);?>
<div class="user-content">
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}$_tpl_path=FISResource::getUri("home:widget/user-nav/user-nav.tpl",$_smarty_tpl->smarty);if(isset($_tpl_path)){echo $_smarty_tpl->getSubTemplate($_tpl_path, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, $_smarty_tpl->caching, $_smarty_tpl->cache_lifetime, array(), Smarty::SCOPE_LOCAL);}else{trigger_error('unable to locale resource "'."home:widget/user-nav/user-nav.tpl".'"', E_USER_ERROR);}FISResource::load("home:widget/user-nav/user-nav.tpl", $_smarty_tpl->smarty);?>
<div class="list">
<?php if (!empty($_smarty_tpl->tpl_vars['followList']->value['list'])){?>
<ul class="inner">
<?php  $_smarty_tpl->tpl_vars['val'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['val']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['followList']->value['list']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['val']->key => $_smarty_tpl->tpl_vars['val']->value){
$_smarty_tpl->tpl_vars['val']->_loop = true;
?>
<li>
<a href="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['abs_url']);?>
" class="cover-wrap">
<div class="cover">
<img src="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['avatar_big']);?>
" alt="">
<div class="mask" <?php if ($_smarty_tpl->tpl_vars['val']->value['is_live']=="1"){?>style="display: block;"<?php }?>>
<?php if ($_smarty_tpl->tpl_vars['val']->value['is_live']=="1"){?>
<div class="rest">休息中</div>
<?php }else{ ?>
<i class="icon-hptv-play-o"></i>
<?php }?>
</div>
</div>
</a>
<div class="text">
<h3 class="room-name mod-overflow"><a href="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['abs_url']);?>
"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['title']);?>
</a></h3>
<div class="info">
<div class="user">
<i class="icon-hptv-user"></i>
<span><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['nickname']);?>
</span>
</div>
<div class="audience">
<i class="icon-hptv-people"></i>
<span><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['onlineUsers']);?>
</span>
</div>
</div>
<div class="tags mod-overflow">标签1：<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['tag']);?>
</div>
<div class="follow">
<div class="num">关注人数：<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['followers']);?>
</div>
<a href="javascript:void(0);" data-anchorId="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['anchorId']);?>
" data-type="follow" class="btn">已关注</a>
</div>
</div>
</li>
<?php } ?>
</ul>
<?php }else{ ?>
<p class="no-follow">你还没有关注主播，点击直播间右上角的“关注”按钮，可以关注你喜欢的主播</p>
<?php }?>
</div>
</div>
</div>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load('home:page/myfollow.tpl',$_smarty_tpl->smarty, false);?>

<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}$_tpl_path=FISResource::getUri("common:widget/footer/footer.tpl",$_smarty_tpl->smarty);if(isset($_tpl_path)){echo $_smarty_tpl->getSubTemplate($_tpl_path, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, $_smarty_tpl->caching, $_smarty_tpl->cache_lifetime, array(), Smarty::SCOPE_LOCAL);}else{trigger_error('unable to locale resource "'."common:widget/footer/footer.tpl".'"', E_USER_ERROR);}FISResource::load("common:widget/footer/footer.tpl", $_smarty_tpl->smarty);?>

<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load('common:page/layout.tpl',$_smarty_tpl->smarty, false);?></body><?php if(class_exists('FISResource', false)){echo FISResource::jsHook();}?>
<?php $_smarty_tpl->registerFilter('output', array('FISResource', 'renderResponse'));?></html><?php }} ?>