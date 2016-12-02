{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
	{%require name="home:static/index/index.scss"%}
	{%require name="common:static/js/jquery/jquery-1.12.0.min.js"%}
	{%require name="home:static/index/index.js"%}

	{%require name="common:static/js/videojs/video-js.css"%}
	{%require name="common:static/js/videojs/ie8/videojs-ie8.js"%}
	{%require name="common:static/js/videojs/video.js"%}
	{%require name="common:static/js/videojs/videojs-hls.min.js"%}
{%/block%}

{%block name="content"%}
	<div class="mod-wrap index-wrap" id="J-index-wrap">
		<!--[if lte IE 8]>
		<div class="IE8-tip">
		由于您的浏览器版本过低，页面无法正常显示；建议您升级至最新IE版本或切换至其他浏览器进行访问。
		</div>
		<![endif]-->
		<!-- 推荐大视频 -->
        {%if $live.recommendRoomInfo|count != 0%}
        <div class="main-wrap">
			<div class="video">
				<a href="{%$live.recommendRoomInfo[0].abs_url%}" class="btn-enter">进入直播间</a>
				{%widget
	                name = "home:widget/video-play/video.tpl"
	                data = $live
	            %}
			</div>
			<div class="list">
				<ul id="J-video-silde">
                    {%foreach $live.recommendRoomInfo as $val%}
                    {%if $val@index < 5%}
					<li {%if $val@index == 0%}class="active"{%/if%} data-url="{%$val.abs_url%}" data-rtmp="{%$val.live_addr.result[1].rtmp%}">
						<img src="{%$val.cover%}" title="{%$val.room_name%}" />
						<p class="mod-overflow">{%$val.room_name%}</p>
					</li>
                    {%/if%}
                    {%/foreach%}
				</ul>
			</div>
		</div>
        {%/if%}
		<!-- 频道列表 -->
		<div class="channel-wrap">
            {%if !empty($live.recommendRoomInfo[5])%}
			<div class="channel-block recommend">
				<h2 class="mod-title"><a href="#">推荐频道</a></h2>
				<ul class="J-list">
                    {%foreach $live.recommendRoomInfo as $val%}
                    {%if $val@index >= 5%}
					<li {%if $val@index == 9%}class="item5"{%else if $val@index == 10%}class="item6"{%/if%}>
						<a href="{%$val.abs_url%}" title="{%$val.room_name%}">
							{%if !empty($val.status_text)%}
                            	<span class="tag tag-status">{%$val.status_text%}</span>
							{%/if%}
							{%if !empty($val.rp)%}
								<span class="tag tag-rp">RP</span>
							{%/if%}
							<div class="pic">
								<img src="{%$val.cover%}" alt="{%$val.room_name%}" />
								<div class="mask"><i class="icon-hptv-play-o"></i></div>
							</div>
							<h3 class="mod-overflow">{%$val.room_name%}&nbsp;&nbsp;—{%$val.category%}</h3>
							<div class="info">
								<div class="name">主播：{%$val.anchor_nickname%}</div>
								<div class="audience">
									<i class="icon-audience"></i>{%$val.online_format%}
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
				<h2 class="mod-title"><a href="/{%$val.sroute%}">{%$val.sname%}</a><a href="/{%$val.sroute%}" class="more">更多 ></a></h2>
				<ul class="J-list">
                    {%foreach $val.list as $subVal%}
					<li {%if $subVal@index == 4%}class="item5"{%else if $subVal@index == 5%}class="item6"{%/if%}>
						<a href="{%$subVal.abs_url%}" title="{%$subVal.room_name%}">
							{%if !empty($subVal.recommend_tag)%}
								<span class="tag tag-recommend">{%$subVal.recommend_tag%}</span>
							{%/if%}
							{%if !empty($subVal.status_text)%}
                            	<span class="tag tag-status">{%$subVal.status_text%}</span>
							{%/if%}
							{%if !empty($subVal.rp)%}
								<span class="tag tag-rp">RP</span>
							{%/if%}
							<div class="pic">
								<img src="{%$subVal.cover%}" alt="{%$subVal.room_name%}" />
								<div class="mask"><i class="icon-hptv-play-o"></i></div>
							</div>
							<h3 class="mod-overflow">{%$subVal.room_name%}</h3>
							<div class="info">
								<div class="name">主播：{%$subVal.anchor_nickname%}</div>
								<div class="audience">
									<i class="icon-audience"></i>{%$subVal.online_format%}
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
{%/block%}
