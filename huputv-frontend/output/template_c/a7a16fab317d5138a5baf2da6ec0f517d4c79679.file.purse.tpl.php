<?php /* Smarty version Smarty-3.1.13, created on 2016-06-14 16:35:13
         compiled from "/data/www-data/hupu.com/huputv_frontend/template/home/page/purse.tpl" */ ?>
<?php /*%%SmartyHeaderCode:153002419575fc1c1429a88-45778608%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'a7a16fab317d5138a5baf2da6ec0f517d4c79679' => 
    array (
      0 => '/data/www-data/hupu.com/huputv_frontend/template/home/page/purse.tpl',
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
  'nocache_hash' => '153002419575fc1c1429a88-45778608',
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
  'unifunc' => 'content_575fc1c1583e60_35690955',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_575fc1c1583e60_35690955')) {function content_575fc1c1583e60_35690955($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_f_escape_xml')) include '/data/www-data/hupu.com//huputv_frontend/plugin/modifier.f_escape_xml.php';
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

<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("home:static/purse/purse.scss",$_smarty_tpl->smarty, false);?>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("common:static/js/jquery/jquery-1.12.0.min.js",$_smarty_tpl->smarty, false);?>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load("home:static/purse/purse.js",$_smarty_tpl->smarty, false);?>
<?php $fis_script_priority = 0;ob_start();?>
	<?php $script=ob_get_clean();if($script!==false){if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}if(FISResource::$cp) {if (!in_array(FISResource::$cp, FISResource::$arrEmbeded)){FISResource::addScriptPool($script, $fis_script_priority);FISResource::$arrEmbeded[] = FISResource::$cp;}} else {FISResource::addScriptPool($script, $fis_script_priority);}}FISResource::$cp = null;?>

<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}echo FISResource::cssHook();?></head>
<body>

<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}$_tpl_path=FISResource::getUri("common:widget/header/header.tpl",$_smarty_tpl->smarty);if(isset($_tpl_path)){echo $_smarty_tpl->getSubTemplate($_tpl_path, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, $_smarty_tpl->caching, $_smarty_tpl->cache_lifetime, array(), Smarty::SCOPE_LOCAL);}else{trigger_error('unable to locale resource "'."common:widget/header/header.tpl".'"', E_USER_ERROR);}FISResource::load("common:widget/header/header.tpl", $_smarty_tpl->smarty);?>


<div class="myfollow-wrap" id="J-myfollow-wrap">
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}$_tpl_path=FISResource::getUri("home:widget/title/title.tpl",$_smarty_tpl->smarty);if(isset($_tpl_path)){echo $_smarty_tpl->getSubTemplate($_tpl_path, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, $_smarty_tpl->caching, $_smarty_tpl->cache_lifetime, array('title'=>"个人中心"), Smarty::SCOPE_LOCAL);}else{trigger_error('unable to locale resource "'."home:widget/title/title.tpl".'"', E_USER_ERROR);}FISResource::load("home:widget/title/title.tpl", $_smarty_tpl->smarty);?>
<div class="user-content">
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}$_tpl_path=FISResource::getUri("home:widget/user-nav/user-nav.tpl",$_smarty_tpl->smarty);if(isset($_tpl_path)){echo $_smarty_tpl->getSubTemplate($_tpl_path, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, $_smarty_tpl->caching, $_smarty_tpl->cache_lifetime, array('index'=>1), Smarty::SCOPE_LOCAL);}else{trigger_error('unable to locale resource "'."home:widget/user-nav/user-nav.tpl".'"', E_USER_ERROR);}FISResource::load("home:widget/user-nav/user-nav.tpl", $_smarty_tpl->smarty);?>
<div class="purse-main">
<div class="top-content">
<div class="hupu-coin">
<div class="top-inner">
<div class="clearfix">
<div class="fl">
<span class="span_1">虎扑币余额</span><span class="span_2"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['balance']->value["6"]);?>
</span></div>
<a href="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['recharge_url']->value);?>
" id="rechange">充值</a>
</div>
<p class="text">虎扑币可用于购买不同价值的礼物赠送给喜欢的主播以及购买金豆。</p></div>
</div>
<div class="goldbean">
<div class="top-inner">
<div class="clearfix">
<div class="fl">
<span class="span_1">金豆余额</span><span class="span_2"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['balance']->value["1"]);?>
</span></div>
<a href="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['beans_recharge_url']->value);?>
" id="buy">购买</a>
</div>
<p class="text">金豆可用于赠送给喜欢的主播，提升主播的经验等级以及参与直播间的互动竞猜。</p><p>金豆可由虎扑币购买，购买比率为1:1。</p>
</div>
</div>
</div>
<div class="tradingrecord">
<div class="trading-top">
<span class="span_3">交易记录</span><span class="span_4">可查询最近5个月的交易记录</span>
<div class="two-hr">
<hr class="purse-hr1">
<hr class="purse-hr2">
</div>
</div>
<div class="records-table"><div class="tab-con" id="J_tab">
<span class="tab coin-tab active" id="J_coinTab">虎扑币</span>
<span class="sep"></span>
<span class="tab bean-tab" id="J_beanTab">金豆</span>
</div>
<div class="table-wrap">
<div class="table-con coin-tablecon" id="J_coinWrap">
<table class="coin-table" id="J_coinTable">
</table>
<div class="table-footer">
<a href="javascript:;" class="disabled" id="J_coinPrev">上一页</a>
<select name="" id="J_coinSelect">
<option value="1">第1页</option>
</select>
<a href="javascript:;" id="J_coinNext">下一页</a>
</div>
</div>
<div class="table-con bean-tablecon" id="J_beanWrap">
<table class="bean-table" id="J_beanTable">
</table>
<div class="table-footer">
<a href="javascript:;" class="disabled" id="J_beanPrev">上一页</a>
<select name="" id="J_beanSelect">
<option value="1">第1页</option>
</select>
<a href="javascript:;" id="J_beanNext">下一页</a>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<script id="recordTpl" type="text/template">
		<@ _.each(datas, function(item,index) { @>
			<tr>
				<td class="td-time"><@=item.timestr@></td>
				<td class="td-title">
					<@ if(item.type == 30) { @>
						<@=item.comment@>
					<@ }else{ @>
						<@=item.title@>
					<@ } @>
				</td>
				<td class="td-result <@ if(item.direction == 1){ @>plus<@ }else{@>minus<@ }@>">
					<@=item.record@>
				</td>
			</tr>
		<@ }); @>
	</script>
<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load('home:page/purse.tpl',$_smarty_tpl->smarty, false);?>

<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}$_tpl_path=FISResource::getUri("common:widget/footer/footer.tpl",$_smarty_tpl->smarty);if(isset($_tpl_path)){echo $_smarty_tpl->getSubTemplate($_tpl_path, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, $_smarty_tpl->caching, $_smarty_tpl->cache_lifetime, array(), Smarty::SCOPE_LOCAL);}else{trigger_error('unable to locale resource "'."common:widget/footer/footer.tpl".'"', E_USER_ERROR);}FISResource::load("common:widget/footer/footer.tpl", $_smarty_tpl->smarty);?>

<?php if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}FISResource::load('common:page/layout.tpl',$_smarty_tpl->smarty, false);?></body><?php if(class_exists('FISResource', false)){echo FISResource::jsHook();}?>
<?php $_smarty_tpl->registerFilter('output', array('FISResource', 'renderResponse'));?></html><?php }} ?>