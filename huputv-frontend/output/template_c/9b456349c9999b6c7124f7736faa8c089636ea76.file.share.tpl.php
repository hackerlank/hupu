<?php /* Smarty version Smarty-3.1.13, created on 2016-06-14 16:35:13
         compiled from "/data/www-data/hupu.com/huputv_frontend/template/home/page/share.tpl" */ ?>
<?php /*%%SmartyHeaderCode:891168056575fc1c1201036-81921252%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '9b456349c9999b6c7124f7736faa8c089636ea76' => 
    array (
      0 => '/data/www-data/hupu.com/huputv_frontend/template/home/page/share.tpl',
      1 => 1465893267,
      2 => 'file',
    ),
    '4b636d8b8b565e67cf40427d64e6124995b765c8' => 
    array (
      0 => '/data/www-data/hupu.com/huputv_frontend/template/common/page/layout.tpl',
      1 => 1465893257,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '891168056575fc1c1201036-81921252',
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
  'unifunc' => 'content_575fc1c1421da1_07580040',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_575fc1c1421da1_07580040')) {function content_575fc1c1421da1_07580040($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_f_escape_xml')) include '/data/www-data/hupu.com//huputv_frontend/plugin/modifier.f_escape_xml.php';
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
<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['title']->value);?>

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

<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("home:static/share/share.scss",$_smarty_tpl->smarty, false);?>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("common:static/js/jquery/jquery-1.12.0.min.js",$_smarty_tpl->smarty, false);?>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("common:static/js/videojs/video-js.css",$_smarty_tpl->smarty, false);?>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("common:static/js/videojs/video.js",$_smarty_tpl->smarty, false);?>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("common:static/js/videojs/videojs-hls.min.js",$_smarty_tpl->smarty, false);?>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("home:static/share/share.js",$_smarty_tpl->smarty, false);?>
<script>
        HTV.roomID = "<?php echo smarty_modifier_f_escape_js($_smarty_tpl->tpl_vars['live']->value['roomid']);?>
" || 0;
    </script>
<?php $fis_script_priority = 0;ob_start();?>
        var PageEvent = require("common:widget/page-dace/page-dace.es6");

        /**
         * 发送百度自定义事件
         * @param {array} arr 自定内容
         */
        HTV.sendBaiduEvent = function(arr) {
            return PageEvent.sendBaiduEvent(arr);
        };
	<?php $script=ob_get_clean();if($script!==false){if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}if(FISResource::$cp) {if (!in_array(FISResource::$cp, FISResource::$arrEmbeded)){FISResource::addScriptPool($script, $fis_script_priority);FISResource::$arrEmbeded[] = FISResource::$cp;}} else {FISResource::addScriptPool($script, $fis_script_priority);}}FISResource::$cp = null;?>

<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}echo FISResource::cssHook();?></head>
<body>


<div class="share-wrap" id="J-share-wrap">
<div class="video-play">
<?php if ($_smarty_tpl->tpl_vars['live']->value['is_live']==0&&$_smarty_tpl->tpl_vars['live']->value['live_addr']['status']==200){?>
<video id="live-video" height=210 class="video-js vjs-tv-skin" controls  poster="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['live']->value['cover']);?>
" style="width: 100%;">
<?php if (!empty($_smarty_tpl->tpl_vars['live']->value['live_addr']['result'])){?>
<source src="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['live']->value['live_addr']['result'][2]['hls']);?>
" type="application/x-mpegURL">
<?php }?>
</video>
<?php }else{ ?>
<div class="live-video-rest">
<div class="video-mark">
<?php if ($_smarty_tpl->tpl_vars['live']->value['is_live']==0&&$_smarty_tpl->tpl_vars['live']->value['live_addr']['status']!=200){?>
<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['live']->value['live_addr']['result']);?>

<?php }else{ ?>
<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['live']->value['announce']);?>

<?php }?>
</div>
</div>
<?php }?>
</div>
<div class="info">
<div class="head">
<img src="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['live']->value['avatar']['header_small']);?>
" alt="">
</div>
<div class="text">
<div class="name"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['live']->value['roomname']);?>
</div>
<div class="intro"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['live']->value['tips']);?>
</div>
</div>
</div>
<div class="recommend">
<div class="title">热门推荐</div>
<ul class="list">
<?php  $_smarty_tpl->tpl_vars['val'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['val']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['recommend']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['val']->key => $_smarty_tpl->tpl_vars['val']->value){
$_smarty_tpl->tpl_vars['val']->_loop = true;
?>
<li>
<a href="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['abs_share_url']);?>
">
<img src="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['cover']);?>
" alt="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['name']);?>
">
<div class="text">
<h2 class="room-name mod-overflow"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['name']);?>
</h2>
<div class="name"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['anchor_nickname']);?>
</div>
</div>
</a>
</li>
<?php } ?>
</ul>
</div>
<br><br>
<div class="download">
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}$_tpl_path=FISResource::getUri("home:widget/download/download.tpl",$_smarty_tpl->smarty);if(isset($_tpl_path)){echo $_smarty_tpl->getSubTemplate($_tpl_path, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, $_smarty_tpl->caching, $_smarty_tpl->cache_lifetime, array('title'=>"下载虎扑体育App，精彩直播一手掌握"), Smarty::SCOPE_LOCAL);}else{trigger_error('unable to locale resource "'."home:widget/download/download.tpl".'"', E_USER_ERROR);}FISResource::load("home:widget/download/download.tpl", $_smarty_tpl->smarty);?>
</div>
</div>

<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load('home:page/share.tpl',$_smarty_tpl->smarty, false);?>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load('common:page/layout.tpl',$_smarty_tpl->smarty, false);?></body><?php if(class_exists('FISResource', false)){echo FISResource::jsHook();}?>
<?php $_smarty_tpl->registerFilter('output', array('FISResource', 'renderResponse'));?></html><?php }} ?>