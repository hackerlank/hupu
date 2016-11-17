{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}战报{%/block%}
{%block name="head_static"%}
{%require name="common:static/js/zepto/zepto.js"%}
{%require name="match:static/recap_data/recap_data.scss"%}
<script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
<script>
        window.GM = {
            "night":!!parseInt("{%$night|f_escape_js%}", 10),
            "nopic":!!parseInt("{%$nopic|f_escape_js%}", 10)
        };
    </script>
{%script%}
		var recap_data = require("match:widget/recap_data/recap_data.js");
        recap_data.init();
	{%/script%}
{%/block%}
{%block name="content"%}
{%if empty($title) && empty($video_url) && empty($video_cover) && empty($list) && empty($light_reply) && empty($key_event)%}
<script>
			var winHeight = window.innerHeight;
			var docHeight = document.body.offsetHeight;
			if(docHeight < winHeight){
				var style = document.createElement("style");
				style.innerHTML = "html,body{height:100%;}";
				document.body.appendChild(style);
			}
		</script>
<div class="no-recap">暂无战报，请先去「赛况」看看吧！</div>
{%else%}
<section class="recap-wrap">
{%if !empty($rating)%}
<section class="grade">{%$rating|escape:none%}</section>
{%else%}
<section class="grade" style="padding: 0;"></section>
{%/if%}
{%if !empty($title) || !empty($video_url) || !empty($video_cover)%}
{%if !empty($nopic) || empty($video_cover)%}
<section class="collection">
<a {%if !empty($video_url)%}href="{%$video_url|f_escape_xml%}"{%else%}href="javascript:void(0);"{%/if%} dace-node="matchvideo">
{%if !empty($video_url)%}<div class="item1"><i class="icon"></i></div>{%/if%}
<div class="ellipsis item2"{%if empty($video_url)%}style="width: 100%;"{%/if%}>{%$title|default:"视频集锦"|f_escape_xml%}</div>
</a>
</section>
{%else%}
<section class="collection-wifi">
<a {%if !empty($video_url)%}href="{%$video_url|f_escape_xml%}"{%else%}href="javascript:void(0);"{%/if%} class="inner" dace-node="matchvideo" style="background-image: url({%$video_cover|f_escape_xml%});">
<div class="title ellipsis">{%$title|default:"视频集锦"|f_escape_xml%}</div>
<div class="mask"></div>
{%if !empty($video_url)%}<i class="icon"></i>{%/if%}
</a>
</section>
{%/if%}
{%/if%}
{%if !empty($key_event[$home_tid]) || !empty($key_event[$away_tid])%}
<section class="detail">
<div class="teams clearfix">
<div class="left fl">
<span class="logo"><img src="{%$home_logo|f_escape_xml%}?t=1"></span>
<span class="name">{%$home_name|f_escape_xml%}</span>
</div>
<div class="right fr">
<span class="name">{%$away_name|f_escape_xml%}</span>
<span class="logo"><img src="{%$away_logo|f_escape_xml%}?t=2"></span>
</div>
</div>
<div class="tables">
<div class="left">
<table>
{%foreach $key_event[$home_tid] as $val%}
<tr>
<td class="icon">
{%if $val.event.id == 11%}
<span class="goal"></span>
{%else if $val.event.id == 17%}
<span class="point"></span>
{%else if $val.event.id == 28%}
<span class="own-goal"></span>
{%else if $val.event.id == 3%}
<span class="red"></span>
{%else if $val.event.id == 18%}
<span class="point-miss"></span>
{%/if%}
</td>
<td class="content {%if !empty($val.event.player_id)%}link{%/if%}" {%if !empty($val.event.player_id)%}link="kanqiu://soccerleagues/{%$league_name|f_escape_xml%}/player/{%$val.event.player_id|f_escape_xml%}"{%/if%}>{%$val.live_time|f_escape_xml%}'&nbsp;&nbsp;{%$val.event.player_name|f_escape_xml%}</td>
</tr>
{%/foreach%}
{%if $key_event[$home_tid]|count <  $key_event[$away_tid]|count%}
{%$loop = $key_event[$away_tid]|count-$key_event[$home_tid]|count%}
{%section name=loop loop=$loop%}
<tr>
<td>&nbsp;&nbsp;</td>
<td>&nbsp;&nbsp;</td>
</tr>
{%/section%}
{%/if%}
</table>
</div>
<div class="right">
<table>
{%foreach $key_event[$away_tid] as $val%}
<tr>
<td class="content {%if !empty($val.event.player_id)%}link{%/if%}" {%if !empty($val.event.player_id)%}link="kanqiu://soccerleagues/{%$league_name|f_escape_xml%}/player/{%$val.event.player_id|f_escape_xml%}"{%/if%}>{%$val.live_time|f_escape_xml%}'&nbsp;&nbsp;{%$val.event.player_name|f_escape_xml%}</td>
<td class="icon">
{%if $val.event.id == 11%}
<span class="goal"></span>
{%else if $val.event.id == 17%}
<span class="point"></span>
{%else if $val.event.id == 28%}
<span class="own-goal"></span>
{%else if $val.event.id == 3%}
<span class="red"></span>
{%else if $val.event.id == 18%}
<span class="point-miss"></span>
{%/if%}
</td>
</tr>
{%/foreach%}
{%if $key_event[$away_tid]|count <  $key_event[$home_tid]|count%}
{%$loop = $key_event[$home_tid]|count-$key_event[$away_tid]|count%}
{%section name=loop loop=$loop%}
<tr>
<td>&nbsp;&nbsp;</td>
<td>&nbsp;&nbsp;</td>
</tr>
{%/section%}
{%/if%}
</table>
</div>
</div>
</section>
{%/if%}
<section class="main" id="J-main">
<ul class="list">
{%foreach $list as $val%}
<li>
<div class="left">
<span class="icon">{%if !empty($val.match_time)%}{%$val.match_time|f_escape_xml%}'{%else%}综述{%/if%}</span>
</div>
<div class="right">
<p>{%$val.desc|escape:none%}</p>
{%if $val.img_url%}
{%if $nopic%}
{%$defaultPic="//b3.hoopchina.com.cn/games/images/news_nopic_day@2x.png?t={%$val@index%}"%}
{%if $night%}
{%$defaultPic="//w3.hoopchina.com.cn/games/images/bbs-night-nopic.png?t={%$val@index%}"%}
{%/if%}
{%if $val.img_url_src%}
<img src="{%$defaultPic|f_escape_xml%}" data-src="{%$val.img_url_src|f_escape_xml%}" data-gif="{%$val.img_url|f_escape_xml%}" alt="GIF {%$val.img_size|f_escape_xml%}MB"/>
{%else%}
<img src="{%$defaultPic|f_escape_xml%}" data-src="{%$val.img_url|f_escape_xml%}"/>
{%/if%}
{%else%}
{%if $val.img_url_src%}
<img src="{%$val.img_url_src|f_escape_xml%}" data-gif="{%$val.img_url|f_escape_xml%}" alt="GIF {%$val.img_size|f_escape_xml%}MB"/>
{%else%}
<img src="{%$val.img_url|f_escape_xml%}"/>
{%/if%}
{%/if%}
{%/if%}
</div>
</li>
{%/foreach%}
{%if !empty($light_reply)%}
{%$all_hidden = false%}
{%foreach $light_reply as $val%}
{%if !$val.is_hidden%}
{%$all_hidden = true%}
{%/if%}
{%/foreach%}
{%if $all_hidden%}
<li>
<div class="comments">
<span class="icon">评论</span>
<ul class="c-list">
{%$trueIndex=0%}
{%foreach $light_reply as $val%}
<li>
<div class="user">@{%$val.userName|f_escape_xml%}</div>
<p>{%$val.content|escape:none%}</p>
</li>
{%/foreach%}
</ul>
</div>
</li>
{%/if%}
{%/if%}
</ul>
</section>
</section>
{%/if%}
{%require name='match:page/recap_data.tpl'%}{%/block%}
