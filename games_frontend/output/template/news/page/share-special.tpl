{%extends file="common/page/layout.tpl"%} 
{%block name="meta"%}
<link rel="canonical" href="{%$webUrl|f_escape_xml%}" />
<link rel="alternate" href="{%$deepLink|f_escape_xml%}" />
{%/block%}
{%block name="title"%}{%$news.title|f_escape_xml%}{%/block%}
{%block name="head_static"%}
{%require name="news:static/share-special/share-special.scss"%}
<script src="//res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
{%script%}
        wx.config({
            debug: false,
            appId: '{%$wechat.appId|f_escape_js%}',
            timestamp: '{%$wechat.timestamp|f_escape_js%}',
            nonceStr: '{%$wechat.nonceStr|f_escape_js%}',
            signature: '{%$wechat.signature|f_escape_js%}',
            jsApiList: [
                'onMenuShareTimeline',
                'onMenuShareAppMessage',
                'onMenuShareQQ',
                'onMenuShareWeibo',
                'onMenuShareQZone'
            ]
        });

        wx.ready(function(){
            var shareData = {
                title: "{%$news.share.wechat|f_escape_js%}_虎扑体育App",
                desc: "{%$news.share.summary|f_escape_js%}",
                link: "{%$news.share.url|f_escape_js%}",
                imgUrl: "{%$news.share.img|f_escape_js%}",
                success: function(res){
                },
                cancel: function(res){
                }
            }

            wx.onMenuShareTimeline(shareData);
            wx.onMenuShareAppMessage(shareData);
            wx.onMenuShareQQ(shareData);

            wx.onMenuShareWeibo({
                title: '{%$news.share.weibo|f_escape_js%}', // 分享标题
                desc: shareData.desc, // 分享描述
                link: shareData.link, // 分享链接
                imgUrl: shareData.imgUrl, // 分享图标
                success: function () {
                // 用户确认分享后执行的回调函数
                },
                cancel: function () {
                // 用户取消分享后执行的回调函数
                }
            });

            wx.onMenuShareQZone({
                title: '{%$news.share.qzone|f_escape_js%}', // 分享标题
                desc: shareData.desc, // 分享描述
                link: shareData.link, // 分享链接
                imgUrl: shareData.imgUrl, // 分享图标
                success: function () {
                // 用户确认分享后执行的回调函数
                },
                cancel: function () {
                // 用户取消分享后执行的回调函数
                }
            });
        });

        var platform = window.navigator.platform;
        var win = platform.indexOf("Win");
        var mac = platform.indexOf("Mac");

        if(win!=-1 || mac!=-1){
            $(".artical-content img").each(function(){
                if(win!=-1 || mac!=-1){
                    $(this).css({"width":"auto","height":"auto"});
                }else{
                    $(this).css({"width":"100%"});
                }
            });
        }

        $(".main-list .item").each(function(){
            $(this).height($(this).width()*20/23);
            $(this).find("img").height($(this).width()*20/23);
        });

        $(".main-list .title").each(function(){
            if($(this).height() > 21 && $(this).next().height() > 21){
                $(this).addClass("ellipsis2");
                $(this).next().removeClass("ellipsis2").addClass("ellipsis1");
            }
        });
    {%/script%}
{%/block%}
{%block name="content"%}
<section class="special-wrap">
{%if empty($smarty.get.xfr)%}
<div class="top-down-app">
<a href="{%$top_download_url|f_escape_xml%}" dace-node="{%$top_event|f_escape_xml%}">
<div class="hupu-logo">
<img src="//i1.hoopchina.com.cn/blogfile/201512/06/BbsImg144939425562185_92*92big.png" alt=""/>
</div>
<div class="app-info">
<h4 class="name">
虎扑体育</h4>
<div class="text">
{%$top_title|f_escape_xml%}
</div>
<div class="score">
<img src="//i1.hoopchina.com.cn/blogfile/201512/06/BbsImg144939425567994_97*17big.png" alt=""/>
</div>
</div>
<div class="button-down">
免费下载</div>
</a>
</div>
{%/if%}
{%$and=''%}
{%if !empty($smarty.get.xfr)%}
{%$and=implode("", array('&xfr=',$smarty.get.xfr))%}
{%/if%}
<div class="hot" {%if !empty($news.img_m)%}style="background-image: url({%$news.img_m|f_escape_xml%});"{%/if%}>
<div class="text">
<span class="title ellipsis ellipsis2">{%$news.title|f_escape_xml%}</span>
<span class="content ellipsis ellipsis3">{%$news.summary|f_escape_xml%}</span>
</div>
</div>
<ul class="main-list">
{%foreach $news.groups as $val%}
<li>
<dl>
<dt><span class="index">{%$val.title|mb_substr:0:1:'utf-8'|f_escape_xml%}</span><span class="rest">{%$length=$val.title|strlen%}{%$val.title|mb_substr:1:$length:'utf-8'|f_escape_xml%}</span></dt>
{%foreach $val.news as $subVal%}
{%if empty($subVal.thumbs)%}
<dd>
<a {%if $subVal.type == 5%}href="{%$subVal.link|f_escape_xml%}{%$and|escape:none%}"{%else%}href="{%$subVal.url|f_escape_xml%}{%$and|escape:none%}{%/if%}">
<div class="pic" style="background-image:url({%$subVal.img|f_escape_xml%});"></div>
<div class="text">
<div class="title ellipsis ellipsis2">{%$subVal.title|f_escape_xml%}</div>
<div class="intro ellipsis ellipsis2">{%$subVal.summary|f_escape_xml%}</div>
</div>
<div class="comment"><i></i>{%$subVal.replies|f_escape_xml%}</div>
</a>
</dd>
{%else%}
<dd class="pics-pattern">
<a {%if $subVal.type == 5%}href="{%$subVal.link|f_escape_xml%}{%$and|escape:none%}"{%else%}href="{%$subVal.url|f_escape_xml%}{%$and|escape:none%}{%/if%}">
<div class="texts">{%$subVal.title|f_escape_xml%}</div>
<div class="pics">
{%foreach $subVal.thumbs as $thumbsVal%}
<div class="item"><img src="{%$thumbsVal|f_escape_xml%}"></div>
{%/foreach%}
</div>
</a>
<div class="comment"><i></i>{%$subVal.replies|f_escape_xml%}</div>
</dd>
{%/if%}
{%/foreach%}
</dl>
</li>
{%/foreach%}
</ul>
{%if empty($smarty.get.xfr)%}
<div class="down-app">
<a href="{%$bottom_url|f_escape_xml%}" class="button-down-app" dace-node="{%$bottom_event|f_escape_xml%}">{%$bottom_title|f_escape_xml%}</a>
</div>
{%/if%}
</section>
{%require name='news:page/share-special.tpl'%}{%/block%}
