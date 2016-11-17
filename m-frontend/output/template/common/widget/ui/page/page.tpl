{%if !empty($pageCount) && $pageCount > 1%}
{%if $page > 2%}
{%$prev=$page - 1%}
{%else%}
{%$prev=1%}
{%/if%}
{%if $page < $pageCount%}
{%$next=$page + 1%}
{%else%}
{%$next=$pageCount%}
{%/if%}
<div class="m-page" id="J_page">
<a dace-node="{%$id4dace|f_escape_xml%}_homepage" class="{%if $page == 1%}disabled{%/if%}" href="{%$urlBase|urlformat:1|f_escape_xml%}">首页</a>
<a dace-node="{%$id4dace|f_escape_xml%}_previouspage" class="{%if $page <  2%}disabled{%/if%}" href="{%$urlBase|urlformat:$prev|f_escape_xml%}">上页</a>
<div class="pager_btn">
<span class="page_num">{%$page|f_escape_xml%}/{%$pageCount|f_escape_xml%}</span>
<select id="J_selectcontainer"></select>
</div>
<a dace-node="{%$id4dace|f_escape_xml%}_nextpage" class="{%if $page > $pageCount - 1%}disabled{%/if%}" href="{%$urlBase|urlformat:$next|f_escape_xml%}">下页</a>
<a dace-node="{%$id4dace|f_escape_xml%}_lastpage" class="{%if $page == $pageCount%}disabled{%/if%}" href="{%$urlBase|urlformat:$pageCount|f_escape_xml%}">末页</a>
</div>
{%script%}
		var pager = require("common:widget/ui/page/page.js");
		pager({
			isAjax : false,
			currntPage : "{%$page|f_escape_js%}",
			pageCount: "{%$pageCount|f_escape_js%}",
			urlFormat: "{%$urlBase|f_escape_js%}"
		});
	{%/script%}
{%/if%}