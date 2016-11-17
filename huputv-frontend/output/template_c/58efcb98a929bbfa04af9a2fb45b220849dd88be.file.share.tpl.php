<?php /* Smarty version Smarty-3.1.13, created on 2016-06-14 16:35:12
         compiled from "/data/www-data/hupu.com/huputv_frontend/template/common/widget/share/share.tpl" */ ?>
<?php /*%%SmartyHeaderCode:130763429575fc1c08307d9-36859971%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '58efcb98a929bbfa04af9a2fb45b220849dd88be' => 
    array (
      0 => '/data/www-data/hupu.com/huputv_frontend/template/common/widget/share/share.tpl',
      1 => 1465893261,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '130763429575fc1c08307d9-36859971',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_575fc1c0832d25_26786143',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_575fc1c0832d25_26786143')) {function content_575fc1c0832d25_26786143($_smarty_tpl) {?><div class="ui-share" id="J_share">
<span class="lable-title">
分享：</span>
<a href="javascript:" class="icon icon-copy" id="J_zeroClipboard" data-type="copy" title="复制链接"></a>
<a href="javascript:" class="icon icon-weixin" data-type="weixins" title="分享微信"></a>
<a href="javascript:" class="icon icon-qq" data-type="qq" title="分享QQ"></a>
<a href="javascript:" class="icon icon-qzone" data-type="qzone" title="QQ分享"></a>
<a href="javascript:" class="icon icon-weibo" data-type="weibo" title="新浪微博"></a>
<div class="share-copy-tips" id="J_shareCopyTips">
已复制到您的剪切板</div>
<div class="share-tips" id="J_shareWeixinTips">
<div class="tips-title">
<i class="icon-hptv-phone"></i>
<span class="text">微信扫一扫</span>
</div>
<div class="bd" id="J_shareQrcode">
</div>
</div>
</div>
<?php }} ?>