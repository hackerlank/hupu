<!DOCTYPE html>
{%html framework="common:static/mod.js"%}
  {%head%}
    <meta charset='utf-8'>
    <meta id="viewport" name="viewport" content="initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta property="wb:webmaster" content="d8a16d6112fc138f" />
    <meta name="baidu-site-verification" content="AEcuH3GtJR" />
    <link rel="shortcut icon" href="http://b3.hoopchina.com.cn/common/favicon.ico" />
    <link rel="dns-prefetch" href="//b1.hoopchina.com.cn" />
    <link rel="dns-prefetch" href="//b2.hoopchina.com.cn" />
    <link rel="dns-prefetch" href="//b3.hoopchina.com.cn" />
    <title>
        {%block name="title"%}{%$title%}{%/block%}
    </title>
    {%block name="metaseo"%}
        <meta name="keywords" content="{%$keywords%}" />
        <meta name="description" content="{%$description%}" />
    {%/block%}
    <script>
        var __dacePageName = '{%$current_page%}';

        !function(win){
            var HTV = win.HTV = {};
            win.HPF = {};

            // 用户id
            HTV.getUserId = "{%$user.puid%}" || "";
            // 用户名称
            HTV.getUserName = "{%$user.username%}" || "";
            // 用户登陆状态
            HTV.isLogin = {%intval($login)%};

            HTV.base_url = '{%$base_url%}';
            // 跳转登录
            HTV.jumpLogin = function() {
                {%if !$login && !empty($login_url)%}
                    window.location.href = '{%$login_url%}';
                {%/if%}
            };

            HTV.loginUrl = "{%$login_url%}&display=mini&fback=true&jumpurl={%$base_url%}user/auth?absurl={%$abs_url%}";

            HTV.registerUrl = "{%$register_url%}&display=mini&fback=true&jumpurl={%$base_url%}user/auth?absurl={%$abs_url%}";
        }(window);
    </script>

    <script>
        var _hmt = _hmt || [];
        (function() {
            var hm = document.createElement("script");
            hm.src = "//hm.baidu.com/hm.js?b55ae6a6cd9b8ca6596073078419d698";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>
    <script src="http://b3.hoopchina.com.cn/web/module/dace/opdace/dace.cross.min.js"></script>
    {%require name="common:static/common.scss"%}
    {%require name="common:static/js/jquery/jquery-1.12.0.min.js"%}
    {%require name="common:static/js/global/global.js"%}
    {%require name="common:static/js/colorbox/jquery.colorbox.js"%}

    {%block name="block_head_static"%}{%/block%}
  {%/head%}

    {%body%}
        {%block name="header"%}
            {%widget name="common:widget/header/header.tpl"%}
        {%/block%}
        {%block name="content"%}

        {%/block%}
        {%block name="footer"%}
                {%widget name="common:widget/footer/footer.tpl"%}
        {%/block%}

    {%/body%}

{%/html%}
