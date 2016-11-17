{%extends file="common/page/layout.tpl"%} 
{%block name="meta"%}
<link rel="canonical" href="{%$webUrl|f_escape_xml%}" />
<link rel="alternate" href="{%$deepLink|f_escape_xml%}" />
{%/block%}
{%block name="title"%}{%$news.title|f_escape_xml%}{%/block%}
{%block name="head_static"%}
{%require name="news:static/comment/comment.scss"%}
{%require name="common:static/js/zepto/zepto.js"%}
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

        $(".artical-content img").each(function() {
          if (win != -1 || mac != -1) {
            $(this).css({
              "width": "auto",
              "height": "auto"
            });
          } else {
            $(this).css({
              "width": "100%",
              "height": "auto"
            });
          }
        });

        //展示投票
        var voteRender = require("common:widget/ui-vote-onlyshow/ui-vote-onlyshow.js");
        $(".artical-content span._vote").each(function(idx, elem){
           voteRender("news", elem);
        });
    {%/script%}
{%/block%}
{%block name="content"%}
{%if !empty($news.img)%}
<div style="width:0px; height:0px; overflow:hidden"><img src="{%$news['img']|f_escape_xml%}" /></div>
{%/if%}
<section class="detail-wrap">
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
{%widget
        name="news:widget/artical-title/title.tpl"
        tplType= "php"
    %}
<article class="artical-content">
{%if !empty($news.img_m)%}
<div class="artical-main-pic">
<img src="{%$news.img_m|f_escape_xml%}" alt=""/>
</div>
{%/if%}
{%$news.content|escape:none%}
</article>
{%if !empty($news.tags)%}
<section class="news-tags">
<span class="tag-title">
标签:</span>
<div class="tags-list">
{%foreach $news.tags as $item%}
<a href="{%$item.url|f_escape_xml%}" class="button-link" dace-node="news_tags_share">{%$item.name|f_escape_xml%}</a>
{%/foreach%}
</div>
</section>
{%/if%}
{%widget
        name="news:widget/reply/reply.tpl"
        replyType="shareComment"
    %}
{%if empty($smarty.get.xfr)%}
<div class="down-app">
<a href="{%$bottom_url|f_escape_xml%}" class="button-down-app" dace-node="{%$bottom_event|f_escape_xml%}">{%$bottom_title|f_escape_xml%}</a>
</div>
{%/if%}
</section>
{%require name='news:page/share-comment.tpl'%}{%/block%}
