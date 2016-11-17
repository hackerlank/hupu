{%* 8强去除线框 *%}
{%if $leagueName == "americacup"%}
<style>
	.eight-game .group:before { height: 0;}
</style>
{%/if%}
{%* 欧洲杯美洲杯对阵图 （类似于NBA对阵图结构，支持自适应， 且支持8强、16强结构） *%}
<div class="vs-wrap {%if $leagueName == "eurocup"%}euro-bg{%else%}america-bg{%/if%}">
{%* 欧洲杯16强且有季军赛   美洲杯只有8强且有季军赛 *%}
{%if $leagueName == "eurocup"%}
<section class="elimination-game above-game">
{%foreach array_slice($AgainstInfo[8], 0, 4) as $val%}
<div class="elimination-group">
<div class="left">
<a href="javascript:void(0);" class="logo">
{%if $val.home_tid%}
<img src="{%$val.hlogo|f_escape_xml%}?201601{%$val@index|f_escape_path%}" class="swiper-lazy">
{%else%}
<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?201601{%$val@index|f_escape_path%}" class="swiper-lazy">
{%/if%}
</a>
<div class="name">{%$val.home_name|f_escape_xml%}</div>
</div>
<div class="right">
<a href="javascript:void(0);" class="logo">
{%if $val.away_tid%}
<img src="{%$val.alogo|f_escape_xml%}?201601{%$val@index|f_escape_path%}" class="swiper-lazy">
{%else%}
<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?201602{%$val@index|f_escape_path%}" class="swiper-lazy">
{%/if%}
</a>
<div class="name">{%$val.away_name|f_escape_xml%}</div>
</div>
<div class="soccer">
{%if $val.round_1 == '未赛'%}
{%$val.round_1|f_escape_xml%}
{%else%}
{%$val.round_1|f_escape_xml%}
{%if $val.type == 2%}
<i class="point"></i>
{%/if%}
{%/if%}
</div>
</div>
{%/foreach%}
</section>
{%/if%}
<section class="eight-game above-game">
{%foreach array_slice($AgainstInfo[4], 0, 2) as $val%}
<div class="group eight-group">
<div class="inner">
<div class="left">
<a href="javascript:void(0);" class="logo">
{%if $val.home_tid%}
<img src="{%$val.hlogo|f_escape_xml%}?201602{%$val@index|f_escape_path%}" class="swiper-lazy">
{%else%}
<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?201603{%$val@index|f_escape_path%}" class="swiper-lazy">
{%/if%}
</a>
<div class="name">{%$val.home_name|f_escape_xml%}</div>
</div>
<div class="right">
<a href="javascript:void(0);" class="logo">
{%if $val.away_tid%}
<img src="{%$val.alogo|f_escape_xml%}?201602{%$val@index|f_escape_path%}" class="swiper-lazy">
{%else%}
<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?201604{%$val@index|f_escape_path%}" class="swiper-lazy">
{%/if%}
</a>
<div class="name">{%$val.away_name|f_escape_xml%}</div>
</div>
<div class="soccer">
{%if $val.round_1 == '未赛'%}
{%$val.round_1|f_escape_xml%}
{%else%}
{%$val.round_1|f_escape_xml%}
{%if $val.type == 2%}
<i class="point"></i>
{%/if%}
{%/if%}
</div>
</div>
</div>
{%/foreach%}
</section>
<section class="semi-game above-game">
{%foreach array_slice($AgainstInfo[2], 0, 1) as $val%}
<div class="group semi-group">
<div class="inner">
<div class="left">
<a href="javascript:void(0);" class="logo">
{%if $val.home_tid%}
<img src="{%$val.hlogo|f_escape_xml%}?201603{%$val@index|f_escape_path%}" class="swiper-lazy">
{%else%}
<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?201605{%$val@index|f_escape_path%}" class="swiper-lazy">
{%/if%}
</a>
<div class="name">{%$val.home_name|f_escape_xml%}</div>
</div>
<div class="right">
<a href="javascript:void(0);" class="logo">
{%if $val.away_tid%}
<img src="{%$val.alogo|f_escape_xml%}?201603{%$val@index|f_escape_path%}" class="swiper-lazy">
{%else%}
<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?201606{%$val@index|f_escape_path%}" class="swiper-lazy">
{%/if%}
</a>
<div class="name">{%$val.away_name|f_escape_xml%}</div>
</div>
<div class="soccer">
{%if $val.round_1 == '未赛'%}
{%$val.round_1|f_escape_xml%}
{%else%}
{%$val.round_1|f_escape_xml%}
{%if $val.type == 2%}
<i class="point"></i>
{%/if%}
{%/if%}
</div>
</div>
</div>
{%/foreach%}
</section>
<section class="final-game">
{%foreach array_slice($AgainstInfo[1], 0, 2) as $val%}
<div class="group {%if $val@index == 0%}final-group{%else%}third-place-group{%/if%}">
<div class="inner">
<div class="left">
<a href="javascript:void(0);" class="logo">
{%if $val.home_tid%}
<img src="{%$val.hlogo|f_escape_xml%}?201604{%$val@index|f_escape_path%}" class="swiper-lazy">
{%else%}
<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?201607{%$val@index|f_escape_path%}" class="swiper-lazy">
{%/if%}
</a>
<div class="name">{%$val.home_name|f_escape_xml%}</div>
</div>
<div class="right">
<a href="javascript:void(0);" class="logo">
{%if $val.away_tid%}
<img src="{%$val.alogo|f_escape_xml%}?201604{%$val@index|f_escape_path%}" class="swiper-lazy">
{%else%}
<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?201608{%$val@index|f_escape_path%}" class="swiper-lazy">
{%/if%}
</a>
<div class="name">{%$val.away_name|f_escape_xml%}</div>
</div>
<div class="title">{%if $val@index == 0%}决赛{%else%}3-4名决赛{%/if%}</div>
<div class="soccer" {%if $val.round_1 == '未赛'%}style="top: 42%;"{%/if%}>
{%if $val.round_1 == '未赛'%}
{%$val.round_1|f_escape_xml%}
{%else%}
<div class="normal-soccer">{%$val.round_1|f_escape_xml%}</div>
{%if $val.type == 2%}
<div class="total-soccer">({%$val.round_2|f_escape_xml%})</div>
<i class="point"></i>
{%/if%}
{%/if%}
</div>
</div>
</div>
{%/foreach%}
</section>
<section class="semi-game below-game">
{%foreach array_slice($AgainstInfo[2], 1, 2) as $val%}
<div class="group semi-group">
<div class="inner">
<div class="left">
<a href="javascript:void(0);" class="logo">
{%if $val.home_tid%}
<img src="{%$val.hlogo|f_escape_xml%}?201605{%$val@index|f_escape_path%}" class="swiper-lazy">
{%else%}
<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?201609{%$val@index|f_escape_path%}" class="swiper-lazy">
{%/if%}
</a>
<div class="name">{%$val.home_name|f_escape_xml%}</div>
</div>
<div class="right">
<a href="javascript:void(0);" class="logo">
{%if $val.away_tid%}
<img src="{%$val.alogo|f_escape_xml%}?201605{%$val@index|f_escape_path%}" class="swiper-lazy">
{%else%}
<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?201610{%$val@index|f_escape_path%}" class="swiper-lazy">
{%/if%}
</a>
<div class="name">{%$val.away_name|f_escape_xml%}</div>
</div>
<div class="soccer">
{%if $val.round_1 == '未赛'%}
{%$val.round_1|f_escape_xml%}
{%else%}
{%$val.round_1|f_escape_xml%}
{%if $val.type == 2%}
<i class="point"></i>
{%/if%}
{%/if%}
</div>
</div>
</div>
{%/foreach%}
</section>
<section class="eight-game below-game">
{%foreach array_slice($AgainstInfo[4], 2, 4) as $val%}
<div class="group eight-group">
<div class="inner">
<div class="left">
<a href="javascript:void(0);" class="logo">
{%if $val.home_tid%}
<img src="{%$val.hlogo|f_escape_xml%}?201606{%$val@index|f_escape_path%}" class="swiper-lazy">
{%else%}
<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?201611{%$val@index|f_escape_path%}" class="swiper-lazy">
{%/if%}
</a>
<div class="name">{%$val.home_name|f_escape_xml%}</div>
</div>
<div class="right">
<a href="javascript:void(0);" class="logo">
{%if $val.away_tid%}
<img src="{%$val.alogo|f_escape_xml%}?201606{%$val@index|f_escape_path%}" class="swiper-lazy">
{%else%}
<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?201612{%$val@index|f_escape_path%}" class="swiper-lazy">
{%/if%}
</a>
<div class="name">{%$val.away_name|f_escape_xml%}</div>
</div>
<div class="soccer">
{%if $val.round_1 == '未赛'%}
{%$val.round_1|f_escape_xml%}
{%else%}
{%$val.round_1|f_escape_xml%}
{%if $val.type == 2%}
<i class="point"></i>
{%/if%}
{%/if%}
</div>
</div>
</div>
{%/foreach%}
</section>
{%if $leagueName == "eurocup"%}
<section class="elimination-game below-game">
{%foreach array_slice($AgainstInfo[8], 4, 8) as $val%}
<div class="elimination-group">
<div class="left">
<a href="javascript:void(0);" class="logo">
{%if $val.home_tid%}
<img src="{%$val.hlogo|f_escape_xml%}?201607{%$val@index|f_escape_path%}" class="swiper-lazy">
{%else%}
<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?201613{%$val@index|f_escape_path%}" class="swiper-lazy">
{%/if%}
</a>
<div class="name">{%$val.home_name|f_escape_xml%}</div>
</div>
<div class="right">
<a href="javascript:void(0);" class="logo">
{%if $val.away_tid%}
<img src="{%$val.alogo|f_escape_xml%}?201607{%$val@index|f_escape_path%}" class="swiper-lazy">
{%else%}
<img src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?201614{%$val@index|f_escape_path%}" class="swiper-lazy">
{%/if%}
</a>
<div class="name">{%$val.away_name|f_escape_xml%}</div>
</div>
<div class="soccer">
{%if $val.round_1 == '未赛'%}
{%$val.round_1|f_escape_xml%}
{%else%}
{%$val.round_1|f_escape_xml%}
{%if $val.type == 2%}
<i class="point"></i>
{%/if%}
{%/if%}
</div>
</div>
{%/foreach%}
</section>
{%/if%}
</div>
