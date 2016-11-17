{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="home:static/share/share.scss"%}
{%require name="common:static/js/jquery/jquery-1.12.0.min.js"%}
{%require name="common:static/js/videojs/video-js.css"%}
{%require name="common:static/js/videojs/video.js"%}
{%require name="common:static/js/videojs/videojs-hls.min.js"%}
{%require name="home:static/share/share.js"%}
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script>
    wx.config({
      debug: false,
      appId: '{%$weixin.appId|f_escape_js%}', // 必填，公众号的唯一标识
      timestamp: '{%$weixin.timestamp|f_escape_js%}', // 必填，生成签名的时间戳
      nonceStr: '{%$weixin.nonceStr|f_escape_js%}', // 必填，生成签名的随机串
      signature: '{%$weixin.signature|f_escape_js%}',// 必填，签名，见附录1
      jsApiList: [
        'onMenuShareTimeline',
        'onMenuShareAppMessage',
        'onMenuShareQQ',
        'onMenuShareQZone'
      ]
    });
    
    wx.ready(function(){
      var shareData = {
        {%if !empty($live.online) && $live.online < 1000%}
          title: '我正在「{%$live.anchor_nickname|f_escape_js%}」的房间「{%$live.roomname|f_escape_js%}」观看直播，快来围观吧！#亮了网#正在直播',
        {%else%}
          title: '「{%$live.online|f_escape_js%}」人正在和我一起观看「{%$live.anchor_nickname|f_escape_js%}」直播「{%$live.roomname|f_escape_js%}」，还不快来围观。#亮了网#正在直播',
        {%/if%}
        desc: '{%$title|f_escape_js%}',
        link: '{%$abs_url|f_escape_js%}',
        imgUrl: '{%$live.cover|f_escape_js%}',
        success: function () { 

        },
        cancel: function () { 

        }
      }

      wx.onMenuShareTimeline({
        title: shareData.title, // 分享标题
        link: shareData.link, // 分享链接
        imgUrl: shareData.imgUrl, // 分享图标
        success: function () {},
        cancel: function () { }
      });

      wx.onMenuShareAppMessage(shareData);
      wx.onMenuShareQQ(shareData);
      wx.onMenuShareQZone(shareData);
    });

    HTV.roomID = "{%$live.roomid|f_escape_js%}" || 0;
  </script>
{%script%}
        var PageEvent = require("common:widget/page-dace/page-dace.es6");

        /**
         * 发送百度自定义事件
         * @param {array} arr 自定内容
         */
        HTV.sendBaiduEvent = function(arr) {
            return PageEvent.sendBaiduEvent(arr);
        };
	{%/script%}
{%/block%}
{%block name="header"%}{%/block%}
{%block name="content"%}
<div class="share-wrap" id="J-share-wrap">
<div class="video-play">
{%if $live.is_live == 0 && $live.live_addr.status == 200%}
<video id="live-video" height=210 class="video-js vjs-tv-skin" controls  poster="{%$live.cover|f_escape_xml%}" style="width: 100%;">
{%if !empty($live.live_addr.result)%}
<source src="{%$live.live_addr.result[2].hls|f_escape_xml%}" type="application/x-mpegURL">
{%/if%}
</video>
{%else%}
<div class="live-video-rest">
<div class="video-mark">
{%if $live.is_live == 1 && $live.live_addr.status != 200 %}
{%$live.live_addr.result|f_escape_xml%}
{%else%}
{%$live.announce|f_escape_xml%}
{%/if%}
</div>
</div>
{%/if%}
</div>
<div class="info">
<div class="head">
<img src="{%$live.avatar.header_small|f_escape_xml%}" alt="">
</div>
<div class="text">
<div class="name">{%$live.roomname|f_escape_xml%}</div>
<div class="intro">{%$live.tips|f_escape_xml%}</div>
</div>
</div>
<div class="recommend">
<div class="title">热门推荐</div>
<ul class="list">
{%foreach $recommend as $val%}
<li>
<a href="{%$val.abs_share_url|f_escape_xml%}">
<img src="{%$val.cover|f_escape_xml%}" alt="{%$val.name|f_escape_xml%}">
<div class="text">
<h2 class="room-name mod-overflow">{%$val.name|f_escape_xml%}</h2>
<div class="name">{%$val.anchor_nickname|f_escape_xml%}</div>
</div>
</a>
</li>
{%/foreach%}
</ul>
</div>
<div class="download">
{%widget
	            name="home:widget/download/download.tpl"
	            title="下载虎扑体育App，精彩直播一手掌握"
	        %}
</div>
</div>
{%/block%}
{%block name="footer"%}{%require name='home:page/share.tpl'%}{%/block%}