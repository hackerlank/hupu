{%if !isset($recap_tips)%}
{%if $type == "football"%}
{%if !empty($video_url) || !empty($title) || !empty($video_cover)%}
{%if !empty($nopic) || empty($video_cover)%}
<section class="section-item hot-nopic">
<a {%if !empty($video_url)%}href="{%$video_url|f_escape_xml%}"{%else%}href="javascript:void(0);"{%/if%}>
<span>{%$title|f_escape_xml%}</span>
<i class="icon icon-arrow-right"></i>
</a>
</section>
{%else%}
<section class="section-item hot-pic">
<a {%if !empty($video_url)%}href="{%$video_url|f_escape_xml%}"{%else%}href="javascript:void(0);"{%/if%}>
<img src="{%$video_cover|f_escape_xml%}" alt="{%$title|f_escape_xml%}" />
<div class="title">
<p>{%$title|f_escape_xml%}</p>
</div>
{%if !empty($video_url)%}<i class="icon icon-play-b"></i>{%/if%}
</a>
</section>
{%/if%}
{%/if%}
{%/if%}
{%if $type == "nba"%}
{%if !empty($video_collection)%}
<section class="section-item hot-pic">
<a {%if !empty($video_collection[0].fromurl)%}href="browser://{%$video_collection[0].fromurl|escape:none%}"{%else%}href="javascript:void(0);"{%/if%}>
<img src="{%$video_collection[0].cover|f_escape_xml%}" alt="{%$video_collection[0].title|f_escape_xml%}" />
<div class="title">
<p>{%$video_collection[0].title|f_escape_xml%}</p>
</div>
{%if !empty($video_collection[0].fromurl)%}<i class="icon icon-play-b"></i>{%/if%}
</a>
</section>
{%/if%}
{%if !empty($video_collection) && $video_collection|count > 1%}
<section class="section-item collection">
<div class="hd">集锦</div>
<div class="bd">
<ul class="list">
{%foreach $video_collection as $val%}
{%if $val@index > 0%}
<li {%if $val@index > 3%}class="more-li"{%/if%}>
<a href="browser://{%$val.fromurl|escape:none%}">
<span>{%$val.title|f_escape_xml%}</span>
<i class="icon icon-arrow-right"></i>
</a>
</li>
{%/if%}
{%/foreach%}
{%if $video_collection|count > 4%}
<li>
<a href="javascript:;" id="J-more" class="more" data-more="1"><em>更多</em><i class="icon icon-arrow-down"></i></a>
</li>
{%/if%}
</ul>
</div>
</section>
{%/if%}
{%if !empty($game_video)%}
<section class="section-item video">
<div class="hd">录像</div>
<div class="bd">
<ul>
<li>
{%foreach $game_video as $val%}
{%if $val@index < 4%}
<a href="browser://{%$val.fromurl|escape:none%}">{%$val.title|f_escape_xml%}</a>
{%/if%}
{%/foreach%}
</li>
{%$game_video_left = 4-($game_video|count)%4 %}
{%if $game_video|count > 4%}
<li>
{%foreach $game_video as $val%}
{%if $val@index >= 4%}
<a href="browser://{%$val.fromurl|escape:none%}">{%$val.title|f_escape_xml%}</a>
{%/if%}
{%/foreach%}
{%section name="left" loop=$game_video_left%}
<a href="#" style="visibility:hidden;">加时n</a>
{%/section%}
</li>
{%/if%}
</ul>
</div>
</section>
{%/if%}
{%if !empty($best_players.away) || !empty($best_players.home)%}
<section class="section-item player">
<div class="hd">球员</div>
<div class="bd">
<ul>
<li>
<div class="info">
<a href="kanqiu://nba/nba/player/{%$best_players.away[0].player_id|f_escape_path%}">
<span class="head"><img src="{%$best_players.away[0].header_image|f_escape_xml%}" alt="" /></span>
<span class="name">{%$best_players.away[0].name|f_escape_xml%}</span>
</a>
</div>
<div class="data">
<div class="item">
<div class="value">{%$best_players.away[0].pts|f_escape_xml%}</div>
<div class="key">得分</div>
</div>
<div class="item">
<div class="value">{%$best_players.away[0].reb|f_escape_xml%}</div>
<div class="key">篮板</div>
</div>
<div class="item">
<div class="value">{%$best_players.away[0].asts|f_escape_xml%}</div>
<div class="key">助攻</div>
</div>
<div class="item">
<div class="value">{%$best_players.away[0].stl|f_escape_xml%}</div>
<div class="key">抢断</div>
</div>
<div class="item">
<div class="value">{%$best_players.away[0].blk|f_escape_xml%}</div>
<div class="key">盖帽</div>
</div>
</div>
</li>
<li>
<div class="info">
<a href="kanqiu://nba/nba/player/{%$best_players.home[0].player_id|f_escape_path%}">
<span class="head"><img src="{%$best_players.home[0].header_image|f_escape_xml%}" alt="" /></span>
<span class="name">{%$best_players.home[0].name|f_escape_xml%}</span>
</a>
</div>
<div class="data">
<div class="item">
<div class="value">{%$best_players.home[0].pts|f_escape_xml%}</div>
<div class="key">得分</div>
</div>
<div class="item">
<div class="value">{%$best_players.home[0].reb|f_escape_xml%}</div>
<div class="key">篮板</div>
</div>
<div class="item">
<div class="value">{%$best_players.home[0].asts|f_escape_xml%}</div>
<div class="key">助攻</div>
</div>
<div class="item">
<div class="value">{%$best_players.home[0].stl|f_escape_xml%}</div>
<div class="key">抢断</div>
</div>
<div class="item">
<div class="value">{%$best_players.home[0].blk|f_escape_xml%}</div>
<div class="key">盖帽</div>
</div>
</div>
</li>
</ul>
</div>
</section>
{%/if%}
{%/if%}
{%if $type == "football"%}
<section class="section-item match">
{%if !empty($key_event.qt)%}
<div class="normal">
<ul class="left">
{%foreach $key_event.qt[$home_tid] as $val%}
<li>
<a {%if !empty($val.event.player_id)%}href="kanqiu://soccerleagues/{%$league_name|f_escape_path%}/player/{%$val.event.player_id|f_escape_path%}"{%/if%} class="name">{%$val.event.player_name|f_escape_xml%}</a>
<span class="time">{%$val.live_time|f_escape_xml%}'</span>
<span class="icon-wrap">
{%if $val.event.id == 11%}
<span class="icon icon-goal"></span>
{%else if $val.event.id == 17%}
<span class="icon icon-point"></span>
{%else if $val.event.id == 28%}
<span class="icon icon-own"></span>
{%else if $val.event.id == 3%}
<span class="icon icon-red"></span>
{%else if $val.event.id == 18%}
<span class="icon icon-point-miss"></span>
{%/if%}
</span>
</li>
{%/foreach%}
</ul>
<ul class="right">
{%foreach $key_event.qt[$away_tid] as $val%}
<li>
<span class="icon-wrap">
{%if $val.event.id == 11%}
<span class="icon icon-goal"></span>
{%else if $val.event.id == 17%}
<span class="icon icon-point"></span>
{%else if $val.event.id == 28%}
<span class="icon icon-own"></span>
{%else if $val.event.id == 3%}
<span class="icon icon-red"></span>
{%else if $val.event.id == 18%}
<span class="icon icon-point-miss"></span>
{%/if%}
</span>
<span class="time">{%$val.live_time|f_escape_xml%}'</span>
<a {%if !empty($val.event.player_id)%}href="kanqiu://soccerleagues/{%$league_name|f_escape_path%}/player/{%$val.event.player_id|f_escape_path%}"{%/if%} class="name">{%$val.event.player_name|f_escape_xml%}</a>
</li>
{%/foreach%}
</ul>
</div>
{%/if%}
{%if !empty($key_event.dq)%}
<div class="penalty-kick">
<div class="title">点球大战</div>
<div class="inner">
<ul class="left" {%if $key_event.dq_first_tid == $away_tid%}style="margin-top:10px;"{%/if%}>
{%foreach $key_event.dq[$home_tid] as $val%}
<li>
<span class="name">{%$val.event.player_name|f_escape_xml%}</span>
<span class="time">{%$val.live_time|f_escape_xml%}'</span>
<span class="icon-wrap">
{%if $val.event.id == 17%}
<span class="icon icon-point"></span>
{%else if $val.event.id == 18%}
<span class="icon icon-point-miss"></span>
{%/if%}
</span>
</li>
{%/foreach%}
</ul>
<ul class="right" {%if $key_event.dq_first_tid == $home_tid%}style="margin-top:10px;"{%/if%}>
{%foreach $key_event.dq[$away_tid] as $val%}
<li>
<span class="icon-wrap">
{%if $val.event.id == 17%}
<span class="icon icon-point"></span>
{%else if $val.event.id == 18%}
<span class="icon icon-point-miss"></span>
{%/if%}
</span>
<span class="time">{%$val.live_time|f_escape_xml%}'</span>
<span class="name">{%$val.event.player_name|f_escape_xml%}</span>
</li>
{%/foreach%}
</ul>
</div>
</div>
{%/if%}
</section>
{%/if%}
{%if !empty($recap) || !empty($list)%}
<section class="section-item recap" id="J-main">
<div class="bd">
{%if $type == "football" && ($is_custom == "1" || !isset($is_custom))%}
<ul class="list">
{%foreach $list as $val%}
<li>
<span class="time">{%if !empty($val.match_time)%}{%$val.match_time|f_escape_xml%}'{%/if%}</span>
<p {%if empty($val.match_time)%}style="margin-left:0px;"{%/if%}>
{%$val.desc|escape:none%}
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
</p>
</li>
{%/foreach%}
</ul>
{%else%}
<div class="gdc">{%$recap|escape:none%}</div>
{%/if%}
</div>
</section>
{%/if%}
{%if !empty($light_reply)%}
<section class="section-item comments">
<div class="hd">论坛亮回帖</div>
<div class="bd">
<ul>
{%foreach $light_reply as $val%}
<li>
<p>{%$val.content|escape:none%}</p>
<div class="name">
<span class="head"><img src="{%$val.userImg|f_escape_xml%}?t={%$val@index|f_escape_path%}" alt="" /></span>
<span class="name">{%$val.userName|f_escape_xml%}</span>
</div>
</li>
{%/foreach%}
</ul>
</div>
</section>
{%/if%}
{%else%}
<section class="no-result">
{%if $type == "nba"%}
暂无战报，请先去「统计」看看吧{%else if $type == "football"%}
暂无战报，请先去「赛况」看看吧{%/if%}
</section>
{%/if%}
