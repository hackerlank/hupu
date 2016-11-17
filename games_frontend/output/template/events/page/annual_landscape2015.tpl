{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}2015虎扑年会竞猜{%/block%}
{%block name="head_static"%}
{%require name="common:static/js/zepto/zepto.js"%}
{%require name="common:static/js/underscore/underscore.js"%}
{%require name="events:static/annual2016/annual2016.scss"%}
<script src="//b3.hoopchina.com.cn/code/socketio/socket.io.js"></script>
{%script%}
		window.GM = {
            "glid": "{%$smarty.get.glid|f_escape_js%}" || 1,
            "ggid": "{%$smarty.get.ggid|f_escape_js%}" || "",
			"hgid": "{%$smarty.get.hgid|f_escape_js%}",
            "hroom": "{%$smarty.get.hroom|f_escape_js%}" || "CHAT",
            "htype": "{%$smarty.get.htype|f_escape_js%}" || "other",
            "hroomid": "{%$smarty.get.hroomid|f_escape_js%}"
		};
    {%/script%}
{%/block%}
{%block name="content"%}
<div class="container clearfix">
<h2 class="title">{%if !empty($smarty.get.title)%}{%$smarty.get.title|f_escape_xml%}{%else%}虎扑年会{%/if%}</h2>
<div class="fl flex1">
{%widget
        name="events:widget/annual_guess2015/annual_guess2015.tpl"
    %}
</div>
<div class="fr flex1">
{%widget
        name="events:widget/annual_hotline2015/annual_hotline2015.tpl"
    %}
</div>
</div>
{%require name='events:page/annual_landscape2015.tpl'%}{%/block%}