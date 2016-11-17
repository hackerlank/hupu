{%extends file="common/page/layout.tpl"%}

{%block name="title"%}2015虎扑年会竞猜{%/block%}

{%block name="head_static"%}
    {%require name="common:static/js/zepto/zepto.js"%}
    {%require name="common:static/js/underscore/underscore.js"%}
    {%require name="events:static/annual2016/annual2016.scss"%}
    <script src="//b3.hoopchina.com.cn/code/socketio/socket.io.js"></script>
	{%script%}
		window.GM = {
            "glid": "{%$smarty.get.glid%}" || 1,
            "ggid": "{%$smarty.get.ggid%}" || "",
			"hgid": "{%$smarty.get.hgid%}",
            "hroom": "{%$smarty.get.hroom%}" || "CHAT",
            "htype": "{%$smarty.get.htype%}" || "other",
            "hroomid": "{%$smarty.get.hroomid%}"
		};
    {%/script%}
{%/block%}

{%block name="content"%}
    <div class="container clearfix">
        <h2 class="title">{%if !empty($smarty.get.title)%}{%$smarty.get.title%}{%else%}虎扑年会{%/if%}</h2>
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
{%/block%}