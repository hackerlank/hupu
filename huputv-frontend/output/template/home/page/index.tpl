{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="home:static/index/index.scss"%}
{%require name="common:static/js/jquery/jquery-1.12.0.min.js"%}
{%require name="home:static/index/index.js"%}
{%require name="common:static/js/videojs/video-js.css"%}
{%require name="common:static/js/videojs/ie8/videojs-ie8.js"%}
{%require name="common:static/js/videojs/video.js"%}
{%require name="common:static/js/videojs/videojs-hls.min.js"%}
{%script%}
	// 播放器swf
	videojs.options.flash.swf = "http://b3.hoopchina.com.cn/web/tv/flash/huputv_index2.swf";

	var VideoPlay = require('home:widget/video-play/video');

	VideoPlay.init();

	// 休息中
	HTV.isLiveRest = parseInt("{%!empty($videoAnnounceError)%}");

	HTV.fullScreenVideo = VideoPlay.fullScreenVideo;
	HTV.trace = VideoPlay.trace;
	
	{%if !empty($datas) %}
		HTV.roomID = "{%$live.recommendRoomInfo[0].roomid|f_escape_js%}" || 0;
		// 视频流
		HTV.flashStreamAddress = function(){
			return {%if $live.recommendRoomInfo[0].is_live == 1 && $live.recommendRoomInfo[0].live_addr.status == 200%}{%json_encode($live.recommendRoomInfo[0].live_addr.result[1])%}{%else%}[]{%/if%}
		};
	{%/if%}

    if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/7./i)=="7.") {
        $(".J-list a").on("click", function(){
            window.location.href = $(this).attr("href");
        });
    }

	var VideoPlay = require('home:widget/video-play/video');

	$("#J-video-silde").find("li").on("click", function(){
		$(this).addClass("active").siblings().removeClass("active");
		$(this).parents(".main-wrap").find(".btn-enter").attr("href", $(this).attr("data-url"));

		VideoPlay.callFromJS({
			key: "playStream",
			data: {
		        url:  $(this).attr("data-rtmp")
		    }
		});
	});
	{%/script%}
{%/block%}
{%block name="content"%}
<div class="mod-wrap index-wrap" id="J-index-wrap">
<!--[if lte IE 8]>
<div class="IE8-tip">
由于您的浏览器版本过低，页面无法正常显示；建议您升级至最新IE版本或切换至其他浏览器进行访问。</div>
<![endif]-->
{%if $live.recommendRoomInfo|count != 0%}
<div class="main-wrap">
<div class="video">
<a href="{%$live.recommendRoomInfo[0].abs_url|f_escape_xml%}" class="btn-enter">进入直播间</a>
{%widget
	                name = "home:widget/video-play/video.tpl"
	                data = $live
	            %}
</div>
<div class="list">
<ul id="J-video-silde">
{%foreach $live.recommendRoomInfo as $val%}
{%if $val@index < 5%}
<li {%if $val@index == 0%}class="active"{%/if%} data-url="{%$val.abs_url|f_escape_xml%}" data-rtmp="{%$val.live_addr.result[1].rtmp|f_escape_xml%}">
<img src="{%$val.cover|f_escape_xml%}" title="{%$val.room_name|f_escape_xml%}" />
<p class="mod-overflow">{%$val.room_name|f_escape_xml%}</p>
</li>
{%/if%}
{%/foreach%}
</ul>
</div>
</div>
{%/if%}
<div class="channel-wrap">
{%if !empty($live.recommendRoomInfo[5])%}
<div class="channel-block recommend">
<h2 class="mod-title"><a href="#">推荐频道</a></h2>
<ul class="J-list">
{%foreach $live.recommendRoomInfo as $val%}
{%if $val@index >= 5%}
<li {%if $val@index == 9%}class="item5"{%else if $val@index == 10%}class="item6"{%/if%}>
<a href="{%$val.abs_url|f_escape_xml%}" title="{%$val.room_name|f_escape_xml%}">
{%if !empty($val.status_text)%}
<span class="tag tag-status">{%$val.status_text|f_escape_xml%}</span>
{%/if%}
{%if !empty($val.rp)%}
<span class="tag tag-rp">RP</span>
{%/if%}
<div class="pic">
<img src="{%$val.cover|f_escape_xml%}" alt="{%$val.room_name|f_escape_xml%}" />
<div class="mask"><i class="icon-hptv-play-o"></i></div>
</div>
<h3 class="mod-overflow">{%$val.room_name|f_escape_xml%}&nbsp;&nbsp;—{%$val.category|f_escape_xml%}</h3>
<div class="info">
<div class="name">主播：{%$val.anchor_nickname|f_escape_xml%}</div>
<div class="audience">
<i class="icon-audience"></i>{%$val.online_format|f_escape_xml%}
</div>
</div>
</a>
</li>
{%/if%}
{%/foreach%}
</ul>
</div>
{%/if%}
{%foreach $live.categorysInfo as $val%}
<div class="channel-block">
<h2 class="mod-title"><a href="/{%$val.sroute|f_escape_path%}">{%$val.sname|f_escape_xml%}</a><a href="/{%$val.sroute|f_escape_path%}" class="more">更多 ></a></h2>
<ul class="J-list">
{%foreach $val.list as $subVal%}
<li {%if $subVal@index == 4%}class="item5"{%else if $subVal@index == 5%}class="item6"{%/if%}>
<a href="{%$subVal.abs_url|f_escape_xml%}" title="{%$subVal.room_name|f_escape_xml%}">
{%if !empty($subVal.recommend_tag)%}
<span class="tag tag-recommend">{%$subVal.recommend_tag|f_escape_xml%}</span>
{%/if%}
{%if !empty($subVal.status_text)%}
<span class="tag tag-status">{%$subVal.status_text|f_escape_xml%}</span>
{%/if%}
{%if !empty($subVal.rp)%}
<span class="tag tag-rp">RP</span>
{%/if%}
<div class="pic">
<img src="{%$subVal.cover|f_escape_xml%}" alt="{%$subVal.room_name|f_escape_xml%}" />
<div class="mask"><i class="icon-hptv-play-o"></i></div>
</div>
<h3 class="mod-overflow">{%$subVal.room_name|f_escape_xml%}</h3>
<div class="info">
<div class="name">主播：{%$subVal.anchor_nickname|f_escape_xml%}</div>
<div class="audience">
<i class="icon-audience"></i>{%$subVal.online_format|f_escape_xml%}
</div>
</div>
</a>
</li>
{%/foreach%}
</ul>
</div>
{%/foreach%}
</div>
</div>
{%require name='home:page/index.tpl'%}{%/block%}
