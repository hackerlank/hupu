<?php /* Smarty version Smarty-3.1.13, created on 2016-06-14 16:35:11
         compiled from "/data/www-data/hupu.com/huputv_frontend/template/live/widget/video-play/video.tpl" */ ?>
<?php /*%%SmartyHeaderCode:420630017575fc1bfeedab7-24531193%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'c0b8b7f0241e52eb3e87e08de3f42b32f2fc8c5e' => 
    array (
      0 => '/data/www-data/hupu.com/huputv_frontend/template/live/widget/video-play/video.tpl',
      1 => 1465893275,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '420630017575fc1bfeedab7-24531193',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'data' => 0,
    'liveError' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_575fc1c0050506_51940923',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_575fc1c0050506_51940923')) {function content_575fc1c0050506_51940923($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_ismobile')) include '/data/www-data/hupu.com//huputv_frontend/plugin/modifier.ismobile.php';
if (!is_callable('smarty_modifier_f_escape_xml')) include '/data/www-data/hupu.com//huputv_frontend/plugin/modifier.f_escape_xml.php';
?><div class="live-play">
<?php if ($_smarty_tpl->tpl_vars['data']->value['is_live']==0&&$_smarty_tpl->tpl_vars['data']->value['live_addr']['status']==200){?>
<?php if (smarty_modifier_ismobile($_SERVER['HTTP_USER_AGENT'])){?>
<video id="mobile-live-video" style="width: 100%;height: 180px;" class="video-js vjs-tv-skin">
<?php if (!empty($_smarty_tpl->tpl_vars['data']->value['live_addr']['result'])){?>
<source src="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['data']->value['live_addr']['result'][1]['hls']);?>
" type="application/x-mpegURL">
<?php }?>
</video>
<?php }else{ ?>
<video id="live-video" width=725 height=602 style="width: 100%" class="video-js vjs-tv-skin">
<?php if (!empty($_smarty_tpl->tpl_vars['data']->value['live_addr']['result'])){?>
<source src="" type="rtmp/mp4">
<?php }?>
</video>
<?php }?>
<?php }else{ ?>
<?php $_smarty_tpl->tpl_vars["liveError"] = new Smarty_variable("1", null, 0);?>
<?php }?>
<div id="J_liveVideoRest" class="live-video-rest" <?php if (!empty($_smarty_tpl->tpl_vars['liveError']->value)){?>style="display: block;"<?php }?>>
<div class="video-mark">
<?php if ($_smarty_tpl->tpl_vars['data']->value['is_live']==0&&$_smarty_tpl->tpl_vars['data']->value['live_addr']['status']!=200){?>
<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['data']->value['live_addr']['result']);?>

<?php }else{ ?>
<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['data']->value['announce']);?>

<?php }?>
</div>
</div>
<img src="http://b1.hoopchina.com.cn/web/tv/static/live/widget/video-play/huputv_e9a7534.swf" id="J_flashPlayUrl" style="display: none"/>
</div>
<?php $fis_script_priority = 0;ob_start();?>
// 播放器swf
videojs.options.flash.swf = $('#J_flashPlayUrl').attr('src');

var VideoPlay = require('live:widget/video-play/video');

VideoPlay.init();

HTV.fullScreenVideo = VideoPlay.fullScreenVideo;
HTV.trace = VideoPlay.trace;
<?php $script=ob_get_clean();if($script!==false){if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}if(FISResource::$cp) {if (!in_array(FISResource::$cp, FISResource::$arrEmbeded)){FISResource::addScriptPool($script, $fis_script_priority);FISResource::$arrEmbeded[] = FISResource::$cp;}} else {FISResource::addScriptPool($script, $fis_script_priority);}}FISResource::$cp = null;?><?php }} ?>