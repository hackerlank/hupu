<!DOCTYPE html>
{%html framework="common:static/mod.js" class="expanded"%}
  {%head%}
    <meta charset='utf-8'>
    <meta name="apple-itunes-app" content="app-id=906632439" />
    {%if !empty($mobile_agent_meta)%}
        {%$mobile_agent_meta|escape:none%}
    {%/if%}
    <link rel="shortcut icon" href="//b3.hoopchina.com.cn/common/favicon.ico" />
    <title>
        {%block name="title"%}{%$title|default:'虎扑体育'%}{%/block%}
    </title>
    {%block name="metaseo"%}
        <meta name="keywords" content="{%$keywords%}" />
        <meta name="description" content="{%$description%}" />
    {%/block%}
    {%$posheader="header"%}
    {%$posheader|echo_include%}
    <script src="//b3.hoopchina.com.cn/common/jquery-1.8.js"></script>
    <script>
        //baidu统计
        var _hmt = _hmt || [];
        (function() {
          var hm = document.createElement("script");
          hm.src = "//hm.baidu.com/hm.js?2eb807cf60e3295559f967a907218f33";
          var s = document.getElementsByTagName("script")[0];
          s.parentNode.insertBefore(hm, s);
        })();

        //google
        var googletag = googletag || {};
        googletag.cmd = googletag.cmd || [];
        (function() {
            var gads = document.createElement('script');
            gads.async = true;
            gads.type = 'text/javascript';
            var useSSL = 'https:' == document.location.protocol;
            gads.src = (useSSL ? 'https:' : '') +
                '//www.googletagservices.com/tag/js/gpt.js';
            var node = document.getElementsByTagName('script')[0];
            node.parentNode.insertBefore(gads, node);
        })();

        googletag.cmd.push(function() {
            googletag.defineSlot('/1016953/hc_gamespace_topright_250x250', [250, 250], 'div-gpt-ad-1387359684902-0').addService(googletag.pubads());
            googletag.defineSlot('/1016953/hoopchina-gamespace-top-banner-980-60', [980, 60], 'div-gpt-ad-1387359684902-1').addService(googletag.pubads());
            googletag.defineSlot('/1016953/g_index_1x1', [1, 1], 'div-gpt-ad-g_index_1x1').addService(googletag.pubads());
            googletag.pubads().enableSingleRequest();
            googletag.enableServices();
        });

        var hmtArray=[];
    </script>

    {%script%}
        //dace统计
        var __daceDataNameOfChannel = 'nba';

        //公共头尾
        _common.init({project:"nba"});
    {%/script%}

    {%block name="head_static"%}{%/block%}
    {%require name="common:static/common.scss"%}
    {%require name="common:static/js/global/global.js"%}
  {%/head%}

    {%body%}
        {%$posfooterlevel="footer_level"%}
        {%$posfooterlevel|echo_include%}
        {%block name="content"%}{%/block%}
        {%$posfooter="footer"%}
        {%$posfooter|echo_include%}
    {%/body%}
{%/html%}
