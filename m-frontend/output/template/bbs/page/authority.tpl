{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="bbs:static/authority/authority.scss"%}
{%require name="bbs:static/authority/authority.js"%}
{%/block%}
{%block name="content"%}
<form action="{%$formUrl|f_escape_xml%}" name="checkpassword" method="post">
<input id="fid" type="hidden" value="{%$fid|f_escape_xml%}" name="fid">
<input id="fid" type="hidden" value="{%$backUrl|f_escape_xml%}" name="backUrl">
<p>该版块设置了访问权限，请输入密码</p>
<div class="input-item">
<span class="pwd-ipt"><input id="password" type="password" name="password"></span>
<span class="pwd-control"></span>
</div>
<div class="btn-item">
<input type="button" value="取消" class="cancel-btn" data-link="{%$backUrl|f_escape_xml%}">
<input type="submit" value="提交" class="submit-btn" name="submit">
</div>
</form>{%require name='bbs:page/authority.tpl'%}{%/block%}