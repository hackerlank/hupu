{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="home:static/index/index.scss"%}
{%require name="common:static/js/jquery/jquery-1.12.0.min.js"%}
{%require name="home:static/index/index.js"%}
{%script%}
    if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.match(/7./i)=="7.") {
        $("#J-list a").on("click", function(){
            window.location.href = $(this).attr("href");
        });
    }
	{%/script%}
{%/block%}
{%block name="content"%}
<div class="mod-wrap list-wrap" id="J-index-wrap">
<div class="channel-wrap">
<div class="channel-block">
<h2 class="mod-title">{%$category_name|f_escape_xml%}</h2>
{%if !empty($live)%}
<ul id="J-list">
{%foreach $live as $val%}
<li {%if $val@index == 4%}class="item5"{%else if $val@index == 5%}class="item6"{%/if%}>
<a href="{%$val.abs_url|f_escape_xml%}" title="{%$val.room_name|f_escape_xml%}">
{%if !empty($val.recommend_tag)%}
<span class="tag tag-recommend">{%$val.recommend_tag|f_escape_xml%}</span>
{%/if%}
{%if !empty($val.status_text)%}
<span class="tag tag-status">{%$val.status_text|f_escape_xml%}</span>
{%/if%}
{%if !empty($val.rp)%}
<span class="tag tag-rp">RP</span>
{%/if%}
<div class="pic">
<img src="{%$val.cover|f_escape_xml%}" alt="{%$val.room_name|f_escape_xml%}"/>
<div class="mask"><i class="icon-hptv-play-o"></i></div>
</div>
<h3 class="mod-overflow">{%$val.room_name|f_escape_xml%}</h3>
<div class="info">
<div class="name">主播：{%$val.anchor_nickname|f_escape_xml%}</div>
<div class="audience">
<i class="icon-audience"></i>{%$val.online_format|f_escape_xml%}
</div>
</div>
</a>
</li>
{%/foreach%}
</ul>
{%else%}
<div class="no-live-wrap">
<img src="http://b3.hoopchina.com.cn/web/tv/static/home/img/no_live_pic_daae0c6.png" alt="暂无直播，去别的地方逛逛吧" title="暂无直播，去别的地方逛逛吧">
</div>
{%/if%}
</div>
</div>
</div>
{%require name='home:page/list.tpl'%}{%/block%}
