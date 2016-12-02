<!DOCTYPE html>
{%html framework="common:static/mod.js" class="expanded"%}
	{%head%}
	    <meta charset="utf-8"/>
        <title>{%block name="title"%}虎扑体育{%/block%}</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
        <meta name="format-detection" content="telephone=no">
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <meta name="apple-mobile-web-app-status-bar-style" content="black" />
        <link rel="dns-prefetch" href="//w10.hoopchina.com.cn" />
        <link rel="dns-prefetch" href="//w1.hoopchina.com.cn" />
        <link rel="dns-prefetch" href="//w2.hoopchina.com.cn" />
        <link rel="dns-prefetch" href="//w3.hoopchina.com.cn" />
        <link rel="dns-prefetch" href="//b3.hoopchina.com.cn" />
        {%block name="meta"%}{%/block%}
        <script id="watch_script" data-mid="4" src="//w10.hoopchina.com.cn/hybrid/common/watch.app.1.0.7.js"></script>

        <script type="text/javascript" src="//w10.hoopchina.com.cn/hybrid/common/m_dace.js?v=20160121"></script>

        {%require name="common:static/global.js"%}
        {%script%}
            var dace = require("common:widget/ui-dace/ui-dace.js");
            dace.init();
        {%/script%}
    	{%block name="head_static"%}{%/block%}
	{%/head%}
	{%body class="{%if !empty($night)%}night{%/if%}"%}
		{%block name="content"%}{%/block%}

        {%block name="footer"%}{%/block%}
	{%/body%}
{%/html%}
