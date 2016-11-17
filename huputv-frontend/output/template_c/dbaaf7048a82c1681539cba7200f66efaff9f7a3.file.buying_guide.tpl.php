<?php /* Smarty version Smarty-3.1.13, created on 2016-06-14 16:35:12
         compiled from "/data/www-data/hupu.com/huputv_frontend/template/home/page/buying_guide.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1138494526575fc1c0954f09-01935075%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'dbaaf7048a82c1681539cba7200f66efaff9f7a3' => 
    array (
      0 => '/data/www-data/hupu.com/huputv_frontend/template/home/page/buying_guide.tpl',
      1 => 1465893266,
      2 => 'file',
    ),
    '4b636d8b8b565e67cf40427d64e6124995b765c8' => 
    array (
      0 => '/data/www-data/hupu.com/huputv_frontend/template/common/page/layout.tpl',
      1 => 1465893257,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1138494526575fc1c0954f09-01935075',
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
  'unifunc' => 'content_575fc1c0b1a0f4_81352327',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_575fc1c0b1a0f4_81352327')) {function content_575fc1c0b1a0f4_81352327($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_f_escape_xml')) include '/data/www-data/hupu.com//huputv_frontend/plugin/modifier.f_escape_xml.php';
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

<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("home:static/buying_guide/buying_guide.scss",$_smarty_tpl->smarty, false);?>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("common:static/js/jquery/jquery-1.12.0.min.js",$_smarty_tpl->smarty, false);?>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("home:static/followList/followList.js",$_smarty_tpl->smarty, false);?>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("home:static/buying_guide/buying_guide.js",$_smarty_tpl->smarty, false);?>
<script>
		var restCoin = '<?php echo smarty_modifier_f_escape_js($_smarty_tpl->tpl_vars['balance']->value["6"]);?>
',
			isEnough = '<?php echo $_smarty_tpl->tpl_vars['balance']->value["6"]>$_smarty_tpl->tpl_vars['bears_recharge_step']->value[count($_smarty_tpl->tpl_vars['bears_recharge_step']->value)-1];?>
',
			recharge_url = '<?php echo smarty_modifier_f_escape_js($_smarty_tpl->tpl_vars['recharge_url']->value);?>
',
			referer = '<?php echo smarty_modifier_f_escape_js($_smarty_tpl->tpl_vars['referer']->value);?>
';
			
	</script>

<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}echo FISResource::cssHook();?></head>
<body>

<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}$_tpl_path=FISResource::getUri("common:widget/header/header.tpl",$_smarty_tpl->smarty);if(isset($_tpl_path)){echo $_smarty_tpl->getSubTemplate($_tpl_path, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, $_smarty_tpl->caching, $_smarty_tpl->cache_lifetime, array(), Smarty::SCOPE_LOCAL);}else{trigger_error('unable to locale resource "'."common:widget/header/header.tpl".'"', E_USER_ERROR);}FISResource::load("common:widget/header/header.tpl", $_smarty_tpl->smarty);?>


<div class="myfollow-wrap" id="J-myfollow-wrap">
<div class="buying_goldbeans">
<div class="buying-guide-top">
<span class="span_3">购买金豆</span>
<div class="two-hr">
<hr class="purse-hr1">
<hr class="purse-hr2">
</div>
</div>
<div class="buying_top">
<div class="top_content">
<div class="buying_top_l">
<span class="span_1">金豆余额</span>
<span class="span_2" id="J_bean"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['balance']->value["1"]);?>
</span>
</div>
<div class="buying_top_r">
<span class="span_1">虎扑币余额</span><span class="span_2" id="J_coin"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['balance']->value["6"]);?>
</span>
</div>
</div>
<p>说明：您可以使用虎扑币购买金豆，虎扑币与金豆的购买比例为1:1，即1个虎扑币可购买1个金豆</p>
</div>
<div class="buy_choise">
<form action="" method="post" autocomplete="off">
<p>请选择需要购买的金豆数额</p>
<hr />
<div class="choise_content">
<ul id="J-get-beans">
<?php  $_smarty_tpl->tpl_vars['val'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['val']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['bears_recharge_step']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['val']->key => $_smarty_tpl->tpl_vars['val']->value){
$_smarty_tpl->tpl_vars['val']->_loop = true;
?>
<li class="<?php if (($_smarty_tpl->tpl_vars['val']->value>$_smarty_tpl->tpl_vars['balance']->value["6"])){?>disabled<?php }?>">
<label for="beans_<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value);?>
">
<input 
								name = "beans" 
								type = "radio" 
								value = "<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value);?>
" 
								class = "c_radio" 
								id = "beans_<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value);?>
" 
								data-index = "0"
								<?php if (($_smarty_tpl->tpl_vars['val']->value>$_smarty_tpl->tpl_vars['balance']->value["6"])){?>disabled<?php }?>
							/>
<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value);?>
金豆</label>
</li>
<?php } ?>
</ul>
</div>
<div class="buttons">
<button type="reset"  id="cancel">重置</button>
<button type="submit" id="confirm">确认购买</button>
<span class="error-tips">
</span>
</div>
</form>
</div></div>
</div>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load('home:page/buying_guide.tpl',$_smarty_tpl->smarty, false);?>

<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}$_tpl_path=FISResource::getUri("common:widget/footer/footer.tpl",$_smarty_tpl->smarty);if(isset($_tpl_path)){echo $_smarty_tpl->getSubTemplate($_tpl_path, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, $_smarty_tpl->caching, $_smarty_tpl->cache_lifetime, array(), Smarty::SCOPE_LOCAL);}else{trigger_error('unable to locale resource "'."common:widget/footer/footer.tpl".'"', E_USER_ERROR);}FISResource::load("common:widget/footer/footer.tpl", $_smarty_tpl->smarty);?>

<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load('common:page/layout.tpl',$_smarty_tpl->smarty, false);?></body><?php if(class_exists('FISResource', false)){echo FISResource::jsHook();}?>
<?php $_smarty_tpl->registerFilter('output', array('FISResource', 'renderResponse'));?></html><?php }} ?>