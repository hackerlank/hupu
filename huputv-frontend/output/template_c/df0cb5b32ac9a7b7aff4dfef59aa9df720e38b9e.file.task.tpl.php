<?php /* Smarty version Smarty-3.1.13, created on 2016-06-01 10:53:34
         compiled from "/data/www-data/hupu.com/huputv_frontend/template/live/widget/task/task.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1638463423574e4e2e62ed21-17518102%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'df0cb5b32ac9a7b7aff4dfef59aa9df720e38b9e' => 
    array (
      0 => '/data/www-data/hupu.com/huputv_frontend/template/live/widget/task/task.tpl',
      1 => 1464749607,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1638463423574e4e2e62ed21-17518102',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'user' => 0,
    'task' => 0,
    'beanClass' => 0,
    'beansNum' => 0,
    'val' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_574e4e2e7b7619_74267359',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_574e4e2e7b7619_74267359')) {function content_574e4e2e7b7619_74267359($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_f_escape_xml')) include '/data/www-data/hupu.com//huputv_frontend/plugin/modifier.f_escape_xml.php';
?><div class="task-left">
<?php if (!empty($_smarty_tpl->tpl_vars['user']->value)){?>
<a href="javascript:;" class="task-btn task-item">任 务<em></em></a>
<?php if ($_smarty_tpl->tpl_vars['task']->value['online']['status']==2){?>
<a href="javascript:;" class="getbeans-btn task-item">
<span class="beans">
x<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['task']->value['online']['cur_score']);?>

</span>
<span class="text line1">领取金豆</span>
</a>
<?php }elseif($_smarty_tpl->tpl_vars['task']->value['online']['status']==1){?>
<a href="javascript:;" class="getbeans-btn task-item disabled">
<span class="beans">
x<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['task']->value['online']['cur_score']);?>

</span>
<span class="text line2">
<span class="btn-timing"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['task']->value['online']['rest_time_str']);?>
</span>
<span>领取金豆</span>
</span>
</a>
<?php }?>
<div class="mask-board">
<div class="mask-nav">
<div class="mask-tab-wrap">
<div class="mask-tab first-item J_signTab <?php if (!$_smarty_tpl->tpl_vars['task']->value['sign']['has_sign']){?>notice<?php }?>">
<span>签到领金豆</span>
<em>已连续签到<em id="J_signDays"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['task']->value['sign']['keep_days']);?>
</em>天</em>
</div>
<div class="mask-tab J_onlineTab <?php if ($_smarty_tpl->tpl_vars['task']->value['online']['status']==2){?>notice<?php }?>">
<span>在线领金豆</span>
<em class="tab-timing">
<?php if ($_smarty_tpl->tpl_vars['task']->value['online']['status']==1){?><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['task']->value['online']['rest_time_str']);?>
后可领取<?php }elseif($_smarty_tpl->tpl_vars['task']->value['online']['status']==2){?>可领取<?php }elseif($_smarty_tpl->tpl_vars['task']->value['online']['status']==3){?>
已完成<?php }?>
</em>
</div>
<div class="mask-tab J_shareTab <?php if ($_smarty_tpl->tpl_vars['task']->value['share']['status']==1){?>notice<?php }?>">
<span>分享有礼</span>
<em>还可领取<em class="J_shareTimesRest"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['task']->value['share']['rest_times']);?>
</em>次</em>
</div>
</div>
<span class="close" id="J_close"></span>
</div>
<div class="mask-con-wrap">
<div class="mask-con">
<h3>任务说明</h3>
<p>完成签到任务，每日可获得5个金豆。连续签到可在第3天、第7天分别额外获得10个金豆和30个金豆</p>
<div class="sign-info" id="J_signInfo">
<?php if ($_smarty_tpl->tpl_vars['task']->value['sign']['has_sign']){?>
<div class="sign-tip">
今日已签到，获得<span id="J_signBeans"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['task']->value['sign']['now_bean']);?>
</span>个金豆</div>
<a href="javascript:;" class="sign-btn signed" id="J_signBtn">已签到</a>
<?php }else{ ?>
<div class="sign-tip">
你已连续签到<span><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['task']->value['sign']['keep_days']);?>
</span>天</div>
<a href="javascript:;" class="sign-btn" id="J_signBtn">立即签到</a>
<?php }?>
</div>
</div>
<div class="mask-con online-con">
<h3>任务说明</h3>
<p>点击倒计时图标即可领取金豆，连续在线分别满10分钟、20分钟、30分钟、1小时、2小时，可依次免费领取5、10、15、20、30金豆。</p>
<ul class="online-list">
<?php  $_smarty_tpl->tpl_vars['val'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['val']->_loop = false;
 $_smarty_tpl->tpl_vars['keys'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['task']->value['online']['scene_list']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
 $_smarty_tpl->tpl_vars['val']->index=-1;
foreach ($_from as $_smarty_tpl->tpl_vars['val']->key => $_smarty_tpl->tpl_vars['val']->value){
$_smarty_tpl->tpl_vars['val']->_loop = true;
 $_smarty_tpl->tpl_vars['keys']->value = $_smarty_tpl->tpl_vars['val']->key;
 $_smarty_tpl->tpl_vars['val']->index++;
?>
<?php $_smarty_tpl->tpl_vars['beanClass'] = new Smarty_variable(array('beans-num1','beans-num2','beans-num2','beans-num3','beans-num3'), null, 0);?>
<?php $_smarty_tpl->tpl_vars['beansNum'] = new Smarty_variable(array(5,10,15,20,30), null, 0);?>
<li class="online-item <?php if ($_smarty_tpl->tpl_vars['val']->index==4){?>last-item<?php }?>">
<div class="beans-num <?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['beanClass']->value[$_smarty_tpl->tpl_vars['val']->index]);?>
">
<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['beansNum']->value[$_smarty_tpl->tpl_vars['val']->index]);?>

</div>
<?php if ($_smarty_tpl->tpl_vars['val']->value['status']==0){?>
<a href="javascript:;" class="online-btn wait">等待中</a>
<?php }elseif($_smarty_tpl->tpl_vars['val']->value['status']==1){?>
<a href="javascript:;" class="online-btn disable item-timing"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['task']->value['online']['rest_time_str']);?>
</a>
<?php }elseif($_smarty_tpl->tpl_vars['val']->value['status']==2){?>
<a href="javascript:;" class="online-btn able">领取</a>
<?php }else{ ?>
<a href="javascript:;" class="online-btn disable">已领取</a>
<?php }?>
</li>
<?php } ?>
</ul>
</div>
<div class="mask-con J_shareCon">
<h3>任务说明</h3>
<p>点击播放窗口右上方的分享图标，将自己喜爱的直播分享给更多人，即可领取5金豆（每分享一个直播间并有其他用户访问，即可获得金豆奖励，每天最多可分享10个不同的直播间）</p>
<div class="share-info" id="J_shareInfo">
<div class="share-tip">
你已领取<span><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['task']->value['share']['times']);?>
</span>次金豆，还可以领取<span><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['task']->value['share']['rest_times']);?>
</span>次。</div>
<?php if ($_smarty_tpl->tpl_vars['task']->value['share']['status']==0){?>
<a href="javascript:;" class="share-btn unGet" data-cls="unGet" id="J_shareBtn">未完成</a>
<?php }elseif($_smarty_tpl->tpl_vars['task']->value['share']['status']==1){?>
<a href="javascript:;" class="share-btn canGet" data-cls="canGet" id="J_shareBtn">领取金豆</a>
<?php }else{ ?><a href="javascript:;" class="share-btn fullGet" data-cls="fullGet" id="J_shareBtn">已完成</a>
<?php }?>
</div>
</div>
</div>
</div>
<?php }else{ ?>
<a href="javascript:;" class="login4task" id="J_login4task">登录领取金豆</a>
<?php }?>
</div>
<script id="sign-tpl" type="text/template">
    <@ if(datas.has_sign){ @>
        <div class="sign-tip">
           今日已签到，获得 <span id="J_signBeans"><@=datas.add_bean@></span> 个金豆
        </div>
        <a href="javascript:;" class="sign-btn signed" id="J_signBtn">已签到</a>
    <@ }else{ @>
        <div class="sign-tip">
            你已连续签到 <span><@=datas.keep_days@></span> 天
        </div>
        <a href="javascript:;" class="sign-btn" id="J_signBtn">立即签到</a>
    <@ } @>
</script>
<script id="online-tpl" type="text/template">
    <@ _.each(datas.scene_list, function(item,index) { @>
        <li class="online-item <@ if((index-1) == 4){ @>last-item<@}@>">
            <div class="beans-num <@=beanClass[index-1]@> ">
                <@=item.score@>
            </div>
            <@ if(item.status == 0){ @>
                <a href="javascript:;" class="online-btn wait">等待中</a>
            <@ }else if(item.status == 1){ @>
                <a href="javascript:;" class="online-btn disable item-timing"><@=time@></a>
            <@ }else if(item.status == 2){ @>
                <a href="javascript:;" class="online-btn able">领取</a>
            <@ }else{ @>
                <a href="javascript:;" class="online-btn disable">已领取</a>
            <@ } @>
        </li>
    <@ }); @>
</script>
<script id="share-tpl" type="text/template">
    <div class="share-tip">
        你已领取 <span><@=datas.times@></span> 次金豆，还可以领取 <span><@=datas.rest_times@></span> 次。
    </div>
    <@ if (datas.status == 0){ @>
        <a href="javascript:;" class="share-btn unGet">未完成</a>
    <@ }else if(datas.status == 1){ @>
        <a href="javascript:;" class="share-btn canGet">领取金豆</a>
    <@ }else{ @>
        <a href="javascript:;" class="share-btn fullGet">已完成</a>
    <@ } @>
</script>
<script id="btn-tpl" type="text/template">
    <@ if(datas.status != 3){ @>
        <a href="javascript:;" class="getbeans-btn task-item 
            <@ if(datas.status == 1) { @> disabled <@ } @>">
            <span class="beans">
                x<@=datas.cur_score@>
            </span>
            <@ if(datas.status == 1) { @> 
                <span class="text line2">
                    <span class="btn-timing"><@=time@></span>
                    <span>领取金豆</span>
                </span> 
            <@ }else{ @>
                <span class="text line1">领取金豆</span>
            <@ } @>
        </a>
    <@ } @>
</script>
<?php $fis_script_priority = 0;ob_start();?>
var Task = require("live:widget/task/task.es6");
Task.init();

HTV.getBeans = Task.requestOnline;

<?php $script=ob_get_clean();if($script!==false){if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}if(FISResource::$cp) {if (!in_array(FISResource::$cp, FISResource::$arrEmbeded)){FISResource::addScriptPool($script, $fis_script_priority);FISResource::$arrEmbeded[] = FISResource::$cp;}} else {FISResource::addScriptPool($script, $fis_script_priority);}}FISResource::$cp = null;?><?php }} ?>