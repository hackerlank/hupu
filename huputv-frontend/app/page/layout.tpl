<!DOCTYPE html>
{%html framework="app:static/mod.js" class="expanded"%}
	{%head%}
	    <meta charset="utf-8"/>
        <title>{%block name="title"%}亮了网{%/block%}</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
        <meta name="format-detection" content="telephone=no">
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <meta name="apple-mobile-web-app-status-bar-style" content="black" />
				<link rel="dns-prefetch" href="//b1.hoopchina.com.cn" />
        <link rel="dns-prefetch" href="//b2.hoopchina.com.cn" />
        <link rel="dns-prefetch" href="//b3.hoopchina.com.cn" />
        {%block name="meta"%}{%/block%}
				<script type="text/javascript" src="//b3.hoopchina.com.cn/games/js/hpbridge_v1.0.1.js"></script>
				<script src="//b3.hoopchina.com.cn/web/module/dace/opdace/dace.cross.min.js"></script>
		{%require name="app:static/js/zepto/zepto.js"%}
		{%require name="app:static/js/underscore/underscore.js"%}
        {%require name="app:static/global.js"%}
        {%script%}
			window.GM = {
				login_url: "{%$login_url%}",
				logout_url: "{%$logout_url%}",
				register_url: "{%$register_url%}",
        isInApp : parseInt("{%$in_kanqiu%}", 10) || 0,
        puid: "{%if !empty($userInfo.uid)%}{%$userInfo.uid%}{%/if%}"|| 0,
        night: !!parseInt("{%$night%}", 10),
				islogin: !!parseInt("{%$is_login%}", 10),
				client:'{%$client%}',
				platform:'{%$platform%}',
				n: "{%$smarty.get.n%}" || 0
		    };
            var dace = require("app:widget/ui-dace/ui-dace.js");
            dace.init();
        {%/script%}
    	{%block name="head_static"%}{%/block%}
	{%/head%}
	{%body class="{%if !empty($night)%}night{%/if%}"%}
		{%block name="content"%}{%/block%}

        {%block name="footer"%}{%/block%}
	{%/body%}
{%/html%}
