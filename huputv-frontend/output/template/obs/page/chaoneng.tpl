{%extends file="common/page/layout-empty.tpl"%} 
{%block name="block_head_static"%}
{%require name="obs:static/chaoneng/chaoneng.scss"%}
{%require name="obs:static/chaoneng/chaoneng.js"%}
{%/block%}
{%block name="title"%}
超能{%/block%}
{%block name="header"%}
{%/block%}
{%block name="content"%}
<div class="chaoneng-wrap" id="J_chaonengWrap">
<div class="game-info J_gameInfo"></div>
<div class="skill-info">
<div class="team-skill team-skill-left">
<ul class="skill-pic-list J_skillList">
</ul>
<div class="skill-detail J_skillDetail">
</div>
</div><div class="team-skill team-skill-right">
<ul class="skill-pic-list J_skillList">
</ul>
<div class="skill-detail J_skillDetail">
</div>
</div></div></div><script id="chaoneng-game-tpl" type="text/template">
  <div class="team-name team-name-left">
    <@=home_team_info.cn_name@>
  </div>
  <div class="score-number score-number-left">
    <@=home_score@>
  </div>
  <div class="game-pos">
    <@=gameTime.minute@>:<@=gameTime.second@><br />
    <@=gameTime.section@>
    <@ if(gameTime.section=="1") {@>st
    <@ }else if(gameTime.section=="2"){@>nd
    <@ }else if(gameTime.section=="3"){@>rd
    <@ }else if(gameTime.section=="4"){@>th 
    <@ }@>
  </div>
  <div class="score-number score-number-right">
    <@=guest_score@>
  </div>
  <div class="team-name team-name-right">
    <@=guest_team_info.cn_name@>
  </div>
</script><script id="skill-list-tpl" type="text/template">
  <@ _.each(datas, function(item,index) { @>
    <@if(typeof item.is_show !== "undefined" ){@>
      <li class="J_skillLi_<@=item.id@>">
        <img src="<@=item.skill_info.skill_logo@>" alt="<@=item.skill_info.skill_name@>">
      </li>
    <@}@>
  <@ }) @>
</script>{%require name='obs:page/chaoneng.tpl'%}{%/block%}
