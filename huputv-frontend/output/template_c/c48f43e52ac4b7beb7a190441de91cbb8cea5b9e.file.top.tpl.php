<?php /* Smarty version Smarty-3.1.13, created on 2016-06-14 16:35:11
         compiled from "/data/www-data/hupu.com/huputv_frontend/template/live/widget/gift-top/top.tpl" */ ?>
<?php /*%%SmartyHeaderCode:156394878575fc1bfedd840-32519002%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'c48f43e52ac4b7beb7a190441de91cbb8cea5b9e' => 
    array (
      0 => '/data/www-data/hupu.com/huputv_frontend/template/live/widget/gift-top/top.tpl',
      1 => 1465893275,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '156394878575fc1bfedd840-32519002',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_575fc1bfee52a2_46407918',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_575fc1bfee52a2_46407918')) {function content_575fc1bfee52a2_46407918($_smarty_tpl) {?><div class="gift-top" id="J_giftTop">
<div class="gift-top-inner">
<div class="gift-top-tab">
<ul class="tab-list J_tabList">
<li class="active">
<a href="javascript:">本场排行</a>
</li>
<li>
<a href="javascript:">总排行</a>
</li>
</ul>
</div>
<div class="content J_content"></div>
</div>
</div>
<script id="gift-top-tpl" type="text/template">
    <div class="content-list J_contentList <@if(typeof active !== "undefined"){@>active<@}@>">
        <@if(datas.length >= 1){@>
            <ul class="gift-list gift-top-list">
                <@ _.each(datas, function(item,index) { @>
                    <li class="top-<@=index + 1@>">
                        <i class="count"><@=index + 1@></i>
                        <span class="name"><@=item.nickname@></span>
                        <span class="gift-count">
                            <i class="icon-beans"></i>
                            <@=item.total@>
                        </span>
                    </li>
                <@ }); @>
            </ul>
            <@if(isLogin){@>
                <@if(self.length != 0){@>
                    <ul class="gift-list self-gift-top" <@if(datas.length <= 2){@>style="display: block;"<@}@>>
                        <li>
                            <i class="count"><@=self.rank@></i>
                            <span class="name"><@=self.nickname@></span>
                            <span class="gift-count">
                                <i class="icon-beans"></i>
                                <@=self.total@>
                            </span>
                        </li>
                    </ul>
                <@}else{@>
                    <div class="self-gift-top self-not-gift" <@if(datas.length <= 2){@>style="display: block;"<@}@>>你还未参与过送礼，暂无排名</div>
                <@}@>
            <@}@>
        <@}else{@>
            <div class="not-gift">
                该主播还未收到礼物，快去打赏一下吧
            </div>
        <@}@>
    </div>
</script>
<?php $fis_script_priority = 0;ob_start();?>
var GiftTop = require("live:widget/gift-top/top.es6");
GiftTop.init();
<?php $script=ob_get_clean();if($script!==false){if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}if(FISResource::$cp) {if (!in_array(FISResource::$cp, FISResource::$arrEmbeded)){FISResource::addScriptPool($script, $fis_script_priority);FISResource::$arrEmbeded[] = FISResource::$cp;}} else {FISResource::addScriptPool($script, $fis_script_priority);}}FISResource::$cp = null;?><?php }} ?>