{%extends file="common/page/layout-empty.tpl"%}

{%block name="head_static"%}
	{%require name="admin:static/against_pic/against_pic.scss"%}
	{%require name="admin:static/against_pic/against_pic.js"%}
	<script type="text/javascript">
        window.GM = {
            "gid": ""
        };
    </script>
{%/block%}


{%block name="content"%}
<div class="against-pic">
	<div class="againsts-nav clearfix">
		<ul>
			<li>线上违禁图片列表</li>
			<li class="active">广告图库管理</li>
			<li>其他违禁图管理</li>
		</ul>
	</div>
	<div class="pics-list">
		<div class="pic-search">
			<ul>
				<input type="text" name="" class="pic-url" placeholder="输入图片URL">
				<li>搜索当前图片1</li>
			</ul>
		</div>
		<div class="pic-table">
			<table border=1>
				<tr class="table-hd">
					<th width="25%">序号</th>
					<th width="25%">图片</th>
					<th width="25%">添加用户</th>
					<th>操作</th>
				</tr>
				<tr>
					<td>2</td>
					<td><img src="../p.png" alt=""></td>
					<td>2</td>
					<td>
						<p>从图库中删除图片</p>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="pics-list ad-list">
		<div class="pic-search">
			<ul>
				<input type="text" name="" class="pic-url" placeholder="输入图片URL">
				<li>搜索当前图片2</li>
				<li>添加到当前图库</li>
			</ul>
		</div>
		<div class="pic-table">
			<table border=1>
				<tr class="table-hd">
					<th width="25%">序号</th>
					<th width="25%">图片</th>
					<th width="25%">添加用户</th>
					<th>操作</th>
				</tr>
				<tr>
					<td>2</td>
					<td><img src="../p.png" alt=""></td>
					<td>2</td>
					<td>
						<p>从图库中删除图片</p>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="pics-list admin-list">
		<div class="pic-search">
			<ul>
				<input type="text" name="" class="pic-url" placeholder="输入图片URL">
				<li>搜索当前图片3</li>
				<li>添加到当前图库</li>
			</ul>
		</div>
		<div class="pic-table">
			<table border=1>
				<tr class="table-hd">
					<th width="25%">序号</th>
					<th width="25%">图片</th>
					<th width="25%">添加用户</th>
					<th>操作</th>
				</tr>
				<tr>
					<td>2</td>
					<td><img src="../p.png" alt=""></td>
					<td>2</td>
					<td>
						<p>从图库中删除图片</p>
					</td>
				</tr>
			</table>
		</div>
	</div>




</div>
{%/block%}
