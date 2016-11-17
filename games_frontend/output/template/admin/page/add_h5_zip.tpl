{%extends file="common/page/layout-admin.tpl"%} 
{%block name="head_static"%}
<script src="http://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
{%script%}
        {%require name="admin:static/add_h5_zip/webuploader.js"%}
        {%require name="admin:static/add_h5_zip/add_h5_zip.js"%}
        {%require name="admin:static/add_h5_zip/webuploader.css"%}
	{%/script%}
{%/block%}
{%block name="content"%}
<h5><span class="add-on"><i class="icon-circle-arrow-right"></i>离线包管理</span></h5>
<div id="uploader" class="wu-example">
<h5>
上传离线包&nbsp;&nbsp;&nbsp;&nbsp;<br>
</h5>
<div id="thelist" class="uploader-list"></div>
<div class="btns">
<div id="picker">选择文件</div>
<button id="ctlBtn" class="btn btn-default">开始上传</button>
</div>
<br>
<form name="form" action="updateOfflinePackage" method="post">
链&nbsp;&nbsp;&nbsp;&nbsp;接：<input type="text" id="url" name="url" readOnly="true" /><br>
文件数：<input type="text" id="filecount" name="filecount" readOnly="true" /><br>
版&nbsp;&nbsp;&nbsp;&nbsp;本：<input type="text" id="ver" name="version" placeholder="请输入整数版本号" /><br>
描&nbsp;&nbsp;&nbsp;&nbsp;述：<input type="text" id="desc" name="desc" placeholder="请输入版本描述" /><br>
<input type="submit" name="submit" value="提交" class="btn btn-default">
</form>
</div>
<div class="table-responsive">
<table class="table">
<tr>
<th width="5%">#</th>
<th width="10%">版本号</th>
<th width="20%">地址</th>
<th width="10%">文件数</th>
<th width="20%">描述</th>
<th width="25%">操作</th>
<th width="10%">状态</th>
</tr>
{%foreach $list as $val%}
<tr>
<td width="5%">{%$val@index+1%}</td>
<td width="10%">{%$val.version|f_escape_xml%}</td>
<td width="20%" style="word-break:break-all;">{%$val.url|f_escape_xml%}</td>
<td width="10%">{%$val.filecount|f_escape_xml%}</td>
<td width="20%">{%$val.desc|f_escape_xml%}</td>
<td width="25%">
<button type="button" class="btn btn-warning btn-sm btn-status" data-status="0" data-id="{%$val.id|f_escape_xml%}" data-version="{%$val.version|f_escape_xml%}">禁用</button>
<button type="button" class="btn btn-primary btn-sm btn-status" data-status="1" data-id="{%$val.id|f_escape_xml%}" data-version="{%$val.version|f_escape_xml%}">内测</button>
<button type="button" class="btn btn-danger btn-sm btn-status" data-status="2" data-id="{%$val.id|f_escape_xml%}" data-version="{%$val.version|f_escape_xml%}" data-toggle="modal" data-target="#myModal">开放</button>
<button type="button" class="btn btn-danger btn-sm btn-status" data-status="3" data-id="{%$val.id|f_escape_xml%}" data-version="{%$val.version|f_escape_xml%}" data-toggle="modal" data-target="#myModal">降级</button>
</td>
<td width="10%">
{%if $val.status == 0%}
<code>禁用</code>
{%else if $val.status == 1%}
<code>内测</code>
{%else if $val.status == 2%}
<code>开放</code>
{%else%}
<code>降级</code>
{%/if%}
</td>
</tr>
{%/foreach%}
</table>
</div>
<div class="modal fade" id="myModal">
<div class="modal-dialog">
<div class="modal-content">
<div class="modal-header">
<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
<h4 class="modal-title">注意！！！</h4>
</div>
<div class="modal-body">
<p>开放和降级操作，会对线上用户产生影响，真的确定这样做吗？</p>
</div>
<div class="modal-footer">
<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
<button type="button" class="btn btn-primary btn-ok" data-ok="0">确认</button>
</div>
</div>
</div>
</div>
{%require name='admin:page/add_h5_zip.tpl'%}{%/block%}
