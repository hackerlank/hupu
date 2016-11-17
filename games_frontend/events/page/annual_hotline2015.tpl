{%extends file="common/page/layout.tpl"%}

{%block name="title"%}2015虎扑年会热线{%/block%}

{%block name="head_static"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="common:static/js/underscore/underscore.js"%}
    {%require name="events:static/annual2016/annual2016.scss"%}
    <script src="//b3.hoopchina.com.cn/code/socketio/socket.io.js"></script>
	{%script%}
		window.GM = {
            "hgid": "{%$smarty.get.hgid%}" || "10001607",
            "hroom": "{%$smarty.get.hroom%}" || "CHAT",
            "htype": "{%$smarty.get.htype%}" || "other",
            "hroomid": "{%$smarty.get.hroomid%}"
		};
    {%/script%}
{%/block%}

{%block name="content"%}
    <div class="container">
    <h2 class="title">{%if !empty($smarty.get.title)%}{%$smarty.get.title%}{%else%}虎扑年会{%/if%}</h2>
    	{%widget
            name="events:widget/annual_hotline2015/annual_hotline2015.tpl"
        %}
    </div>
{%/block%}
