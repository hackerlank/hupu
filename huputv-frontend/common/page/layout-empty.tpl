<!DOCTYPE html>
{%html framework="common:static/mod.js"%}
  {%head%}
    <meta charset='utf-8'>
    <meta id="viewport" name="viewport" content="initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta property="wb:webmaster" content="d8a16d6112fc138f" />
    <meta name="baidu-site-verification" content="AEcuH3GtJR" />
    <link rel="shortcut icon" href="http://b3.hoopchina.com.cn/common/favicon.ico" />
    <title>
        {%block name="title"%}{%$title%}{%/block%}
    </title>
    
    {%require name="common:static/common.scss"%}
    {%require name="common:static/js/jquery/jquery-1.12.0.min.js"%}
    {%require name="common:static/js/global/global.js"%}
    
    {%block name="block_head_static"%}{%/block%}
  {%/head%}

    {%body%}
        {%block name="header"%}
        {%/block%}
        {%block name="content"%}{%/block%}
        {%block name="footer"%}
        {%/block%}

    {%/body%}

{%/html%}