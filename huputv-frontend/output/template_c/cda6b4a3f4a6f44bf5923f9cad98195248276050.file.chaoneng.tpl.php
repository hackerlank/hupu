<?php /* Smarty version Smarty-3.1.13, created on 2016-06-01 10:53:34
         compiled from "/data/www-data/hupu.com/huputv_frontend/template/live/widget/chaoneng/chaoneng.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1528954139574e4e2ea333a8-93621239%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'cda6b4a3f4a6f44bf5923f9cad98195248276050' => 
    array (
      0 => '/data/www-data/hupu.com/huputv_frontend/template/live/widget/chaoneng/chaoneng.tpl',
      1 => 1464693430,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1528954139574e4e2ea333a8-93621239',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'chaoneng_info' => 0,
    'home_power_scale' => 0,
    'val' => 0,
    'guest_power_scale' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_574e4e2eda11e4_38394028',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_574e4e2eda11e4_38394028')) {function content_574e4e2eda11e4_38394028($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_f_escape_xml')) include '/data/www-data/hupu.com//huputv_frontend/plugin/modifier.f_escape_xml.php';
?>
<div class="energy-match fr" id="J-energy-match">
<input type="hidden" id="J-home-team-id" value="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['home_team_info']['id']);?>
">
<input type="hidden" id="J-guest-team-id" value="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['guest_team_info']['id']);?>
">
<div class="inner clearfix" id="J-energy-inner">
<div class="left fl">
<div class="sub-inner fl">
<div class="progress fl">
<div class="add-energy">
<a href="javascript:void(0);" class="btn-add mod-btn-box">+能量</a>
<div class="add-energy-box mod-box">
<ul data-gameid="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['gameStatus']['id']);?>
" data-teamid="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['home_team_info']['id']);?>
" data-ischaoneng="<?php if (!empty($_smarty_tpl->tpl_vars['chaoneng_info']->value)){?>1<?php }else{ ?>0<?php }?>">
<li><a href="javascript:void(0);" data-number="1">×1</a></li>
<li><a href="javascript:void(0);" data-number="10">×10</a></li>
<li><a href="javascript:void(0);" data-number="100">×100</a></li>
<li><a href="javascript:void(0);" data-number="500">×500</a></li>
</ul>
<i class="icon-triangle"></i>
<div class="tip">每赠送一个能量值，小号一个虎扑币</div>
</div>
</div>
<div class="left-energy">剩余能量<span class="home-power-left"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['home_power']['left']);?>
</span></div>
<div class="progress-inner" style="width: <?php $_smarty_tpl->tpl_vars['home_power_scale'] = new Smarty_variable($_smarty_tpl->tpl_vars['chaoneng_info']->value['home_power']['left']/$_smarty_tpl->tpl_vars['chaoneng_info']->value['home_power']['total'], null, 0);?><?php echo $_smarty_tpl->tpl_vars['home_power_scale']->value*100;?>
%; background-color: <?php if ($_smarty_tpl->tpl_vars['home_power_scale']->value<=0.25){?>#c01e2f<?php }elseif($_smarty_tpl->tpl_vars['home_power_scale']->value>0.25&&$_smarty_tpl->tpl_vars['home_power_scale']->value<=0.5){?>#d6576d<?php }elseif($_smarty_tpl->tpl_vars['home_power_scale']->value>0.5&&$_smarty_tpl->tpl_vars['home_power_scale']->value<=0.75){?>#ec6500<?php }elseif($_smarty_tpl->tpl_vars['home_power_scale']->value>0.75){?>#ffb300;<?php }?>">
<span class="add-tip home-add-tip"></span>
</div>
<span class="energy-tip <?php if ($_smarty_tpl->tpl_vars['home_power_scale']->value>=1){?>energy-full<?php }else{ ?>energy-nofull<?php }?>"></span>
</div>
<div class="skill fl">
<a href="javascript:void(0);" class="btn-skill mod-btn-box">技能库<span style="display: none;" class="num home-skill-num">0</span></a>
<div class="skill-box mod-box">
<div class="hd clearfix">
<div class="title fl"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['home_team_info']['cn_name']);?>
技能库<i class="icon-triangle-shadow"></i></div>
<div class="summary fr">
<div class="all"><span class="st">总能量</span><span class="num home-power-total power-total"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['home_power']['total']);?>
</span></div>
<div class="left"><span class="st">剩余能量</span><span class="home-power-left power-left"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['home_power']['left']);?>
</span></div>
</div>
</div>
<div class="bd">
<div class="skill-container home-skill-swiper clearfix">
<div class="skill-btn btn-prev fl"><i></i></div>
<div class="skill-swiper fl" >
<div class="skill-inner clearfix">
<?php  $_smarty_tpl->tpl_vars['val'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['val']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['chaoneng_info']->value['home_skill']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
 $_smarty_tpl->tpl_vars['val']->index=-1;
foreach ($_from as $_smarty_tpl->tpl_vars['val']->key => $_smarty_tpl->tpl_vars['val']->value){
$_smarty_tpl->tpl_vars['val']->_loop = true;
 $_smarty_tpl->tpl_vars['val']->index++;
?>
<?php if (($_smarty_tpl->tpl_vars['val']->index+1)%8==1){?>
<div class="slide">
<ul class="clearfix">
<?php }?>
<li data-value="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['skill_info']['skill_value']);?>
" data-desc="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['skill_info']['skill_description']);?>
" data-logo="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['skill_info']['skill_logo']);?>
" data-name="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['skill_info']['skill_name']);?>
" <?php if ($_smarty_tpl->tpl_vars['val']->value['skill_totlenum']==0&&$_smarty_tpl->tpl_vars['val']->value['skill_usednum']!=0){?>class="gray"<?php }elseif($_smarty_tpl->tpl_vars['val']->value['skill_usednum']==0){?>class="shade"<?php }?> id="home_skill_<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['skill_id']);?>
">
<div class="skill-pic">
<img src="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['skill_info']['skill_logo']);?>
" alt="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['skill_info']['skill_name']);?>
" title="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['skill_info']['skill_name']);?>
">
<span class="active" style="display:<?php if ($_smarty_tpl->tpl_vars['val']->value['skill_status']==1){?>block<?php }else{ ?>none<?php }?>">已激活</span>
</div>
<div class="use-info">
<span class="sum skill-total-num"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['skill_totlenum']);?>
</span>&nbsp;|&nbsp;<span class="left skill-used-num"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['skill_usednum']);?>
</span>
</div>
</li>
<?php if (($_smarty_tpl->tpl_vars['val']->index+1)%8==0||($_smarty_tpl->tpl_vars['val']->index+1)==count($_smarty_tpl->tpl_vars['chaoneng_info']->value['home_skill'])){?>
</ul>
</div>
<?php }?>
<?php } ?>
</div>
</div>
<div class="skill-btn btn-next fl"><i></i></div>
</div>
</div>
<div class="ft">(剩余技能 | 已使用技能)</div>
<div class="skill-side-box">
<div class="hd">
<div class="pic">
<img class="skill-logo" src="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['home_skill'][0]['skill_info']['skill_logo']);?>
" alt="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['home_skill'][0]['skill_info']['skill_name']);?>
">
</div>
<div class="coin">
<i class="icon-coin"></i><span class="skill-value"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['home_skill'][0]['skill_info']['skill_value']);?>
</span>
</div>
</div>
<div class="bd skill-desc"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['home_skill'][0]['skill_info']['skill_description']);?>
</div>
<i class="icon-close"></i>
</div>
<i class="icon-triangle"></i>
</div>
</div>
</div>
</div>
<div class="center fl">
<div class="inner clearfix">
<div class="fl"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['home_team_info']['cn_name']);?>
</div>
<div class="fl score">
<div>
<span class="home-score"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['home_score']);?>
</span>&nbsp;vs&nbsp;<span class="guest-score"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['guest_score']);?>
</span>
</div>
<div class="time">
<span class="section-num">第<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['time']['section']);?>
节</span>&nbsp;<span class="section-time"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['time']['minute']);?>
:<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['time']['second']);?>
</span>
</div>
</div>
<div class="fl"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['guest_team_info']['cn_name']);?>
</div>
</div>
</div>
<div class="right fl">
<div class="sub-inner fl">
<div class="skill fl">
<a href="javascript:void(0);" class="btn-skill mod-btn-box">技能库<span style="display: none;" class="num guest-skill-num">0</span></a>
<div class="skill-box mod-box" style="display: none;">
<div class="hd clearfix">
<div class="title fl"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['guest_team_info']['cn_name']);?>
技能库<i class="icon-triangle-shadow"></i></div>
<div class="summary fr">
<div class="all"><span class="st">总能量</span><span class="num guest-power-total power-total"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['guest_power']['total']);?>
</span></div>
<div class="left"><span class="st">剩余能量</span><span class="guest-power-left power-left"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['guest_power']['left']);?>
</span></div>
</div>
</div>
<div class="bd">
<div class="skill-container guest-skill-swiper clearfix">
<div class="skill-btn btn-prev fl"><i></i></div>
<div class="skill-swiper fl" >
<div class="skill-inner clearfix">
<?php  $_smarty_tpl->tpl_vars['val'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['val']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['chaoneng_info']->value['guest_skill']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
 $_smarty_tpl->tpl_vars['val']->index=-1;
foreach ($_from as $_smarty_tpl->tpl_vars['val']->key => $_smarty_tpl->tpl_vars['val']->value){
$_smarty_tpl->tpl_vars['val']->_loop = true;
 $_smarty_tpl->tpl_vars['val']->index++;
?>
<?php if (($_smarty_tpl->tpl_vars['val']->index+1)%8==1){?>
<div class="slide">
<ul class="clearfix">
<?php }?>
<li data-value="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['skill_info']['skill_value']);?>
" data-desc="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['skill_info']['skill_description']);?>
" data-logo="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['skill_info']['skill_logo']);?>
" data-name="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['skill_info']['skill_name']);?>
" id="guest_skill_<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['skill_id']);?>
">
<div class="skill-pic">
<img src="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['skill_info']['skill_logo']);?>
" alt="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['skill_info']['skill_name']);?>
" title="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['skill_info']['skill_name']);?>
">
<span class="active" style="display:<?php if ($_smarty_tpl->tpl_vars['val']->value['skill_status']==1){?>block<?php }else{ ?>none<?php }?>">已激活</span>
</div>
<div class="use-info">
<span class="sum skill-total-num"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['skill_totlenum']);?>
</span>&nbsp;|&nbsp;<span class="left skill-used-num"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['val']->value['skill_usednum']);?>
</span>
</div>
</li>
<?php if (($_smarty_tpl->tpl_vars['val']->index+1)%8==0||($_smarty_tpl->tpl_vars['val']->index+1)==count($_smarty_tpl->tpl_vars['chaoneng_info']->value['guest_skill'])){?>
</ul>
</div>
<?php }?>
<?php } ?>
</div>
</div>
<div class="skill-btn btn-next fl"><i></i></div>
</div>
</div>
<div class="ft">(剩余技能 | 已使用技能)</div>
<div class="skill-side-box">
<div class="hd">
<div class="pic">
<img class="skill-logo" src="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['guest_skill'][0]['skill_info']['skill_logo']);?>
" alt="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['guest_skill'][0]['skill_info']['skill_name']);?>
">
</div>
<div class="coin">
<i class="icon-coin"></i><span class="skill-value"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['guest_skill'][0]['skill_info']['skill_value']);?>
</span>
</div>
</div>
<div class="bd skill-desc"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['guest_skill'][0]['skill_info']['skill_description']);?>
</div>
<i class="icon-close"></i>
</div>
<i class="icon-triangle"></i>
</div>
</div>
<div class="progress fl">
<div class="add-energy">
<a href="javascript:void(0);" class="btn-add mod-btn-box">+能量</a>
<div class="add-energy-box mod-box">
<ul data-gameid="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['gameStatus']['id']);?>
" data-teamid="<?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['guest_team_info']['id']);?>
" data-ischaoneng="<?php if (!empty($_smarty_tpl->tpl_vars['chaoneng_info']->value)){?>1<?php }else{ ?>0<?php }?>">
<li><a href="javascript:void(0);" data-number="1">×1</a></li>
<li><a href="javascript:void(0);" data-number="10">×10</a></li>
<li><a href="javascript:void(0);" data-number="100">×100</a></li>
<li><a href="javascript:void(0);" data-number="500">×500</a></li>
</ul>
<i class="icon-triangle"></i>
<div class="tip">每赠送一个能量值，小号一个虎扑币</div>
</div>
</div>
<div class="left-energy">剩余能量<span class="guest-power-left"><?php echo smarty_modifier_f_escape_xml($_smarty_tpl->tpl_vars['chaoneng_info']->value['guest_power']['left']);?>
</span></div>
<div class="progress-inner" style="width: <?php $_smarty_tpl->tpl_vars['guest_power_scale'] = new Smarty_variable($_smarty_tpl->tpl_vars['chaoneng_info']->value['guest_power']['left']/$_smarty_tpl->tpl_vars['chaoneng_info']->value['guest_power']['total'], null, 0);?><?php echo $_smarty_tpl->tpl_vars['guest_power_scale']->value*100;?>
%; background-color: <?php if ($_smarty_tpl->tpl_vars['guest_power_scale']->value<=0.25){?>#c01e2f<?php }elseif($_smarty_tpl->tpl_vars['guest_power_scale']->value>0.25&&$_smarty_tpl->tpl_vars['guest_power_scale']->value<=0.5){?>#d6576d<?php }elseif($_smarty_tpl->tpl_vars['guest_power_scale']->value>0.5&&$_smarty_tpl->tpl_vars['guest_power_scale']->value<=0.75){?>#ec6500<?php }elseif($_smarty_tpl->tpl_vars['guest_power_scale']->value>0.75){?>#ffb300;<?php }?>">
<span class="add-tip guest-add-tip"></span>
</div>
<span class="energy-tip <?php if ($_smarty_tpl->tpl_vars['guest_power_scale']->value>=1){?>energy-full<?php }else{ ?>energy-nofull<?php }?>"></span>
</div>
</div>
</div>
</div>
</div>
<?php $fis_script_priority = 0;ob_start();?>
var ChaoNeng = require("live:widget/chaoneng/chaoneng");

ChaoNeng.init();
<?php $script=ob_get_clean();if($script!==false){if(!class_exists('FISResource', false)){require_once('/data/www-data/hupu.com/huputv_frontend/plugin/FISResource.class.php');}if(FISResource::$cp) {if (!in_array(FISResource::$cp, FISResource::$arrEmbeded)){FISResource::addScriptPool($script, $fis_script_priority);FISResource::$arrEmbeded[] = FISResource::$cp;}} else {FISResource::addScriptPool($script, $fis_script_priority);}}FISResource::$cp = null;?>
<?php }} ?>