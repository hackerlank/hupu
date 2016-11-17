{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="teams:static/players/players.scss"%}
{%script%}
    var toShare = require("common:widget/ui/share/share.js");

        //全局分享事件, 每个页面单独注册.
        $(document).on("page:share", function(){
        toShare();
        });
    {%/script%}
{%/block%}
{%block name="content"%}
{%widget
        name="common:widget/inner-top-nav/nav.tpl"
    %}
<section class="m-wrap players-wrap">
{%widget
            name="teams:widget/team-header/header.tpl"
        %}
{%widget
            name="common:widget/inner-tab/tab.tpl"
            tabClass="team"
            selected=2
        %}
<div class="main-content">
<div class="players-list">
<ul class="list">
{%foreach from=$players item=val name=key%}
<li>
<a href="{%$val.player_link|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_player">
<dl>
<dd class="avatar">
<img src="{%$val.photo_link|f_escape_xml%}" alt=""/>
</dd>
<dt class="name">
{%$val.alias|f_escape_xml%}
</dt>
<dd class="age">
{%$val.number|f_escape_xml%}{%$val.positionZhName|f_escape_xml%}
</dd>
<dd class="annual-salary">
{%$val.final_field|f_escape_xml%}
</dd>
</dl>
</a>
</li>
{%/foreach%}
</ul>
</div>
</div>
</section>
{%require name='teams:page/players.tpl'%}{%/block%}