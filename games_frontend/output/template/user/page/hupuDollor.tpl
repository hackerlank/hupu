{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}我的虎扑币{%/block%}
{%block name="head_static"%}
<script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
{%require name="common:static/js/zepto/zepto.js"%}
{%require name="user:static/hupuDollor/hupuDollor.scss"%}
{%require name="user:static/hupuDollor/hupuDollor.js"%}
<script>
        window.GM = {
            "nid": "{%$news.nid|f_escape_js%}",
            "islogin": !!parseInt("{%$is_login|f_escape_js%}", 10),
            "client": "{%$client|f_escape_js%}" || "x",
            "projectId":"{%$projectId|f_escape_js%}"||"1",
            "version":"{%$version|f_escape_js%}"||"7.0.6",
            "night":!!parseInt("{%$night|f_escape_js%}", 10),
            "nopic":!!parseInt("{%$nopic|f_escape_js%}", 10),
            "payMonth": "{%$payThisMonth|f_escape_js%}",
            "payThreeMonth": "{%$payThreeMonth|f_escape_js%}"
        };
    </script>
{%/block%}
{%block name="content"%}
<div class="gold-hd">
<h3><span>当前{%$name|default:"虎扑币"|f_escape_xml%}:</span><b class="color2" style="">{%$balance|f_escape_xml%}</b>
{%if empty($name)%}
<i class="icon-dollor"></i>
{%else%}
<i class="icon-gold"></i>
{%/if%}
</h3>
<p class="list-title">{%$name|default:"虎扑币"|f_escape_xml%}明细 (近5个月明细)</p>
</div>
<div class="gold-list" id="wrapper">
<div id="scroller">
<ul class="items-list" id="detail-list">
</ul>
<div id="loading" style="opacity: 0;"><span class="loadingIcon"></span></div>
</div>
</div>
{%require name='user:page/hupuDollor.tpl'%}{%/block%}
