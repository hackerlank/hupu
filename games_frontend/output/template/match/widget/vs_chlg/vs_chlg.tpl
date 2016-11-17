<div class="vs-wrap">
<div class="vs-con">
<section class="elimination-game above-game">
{%foreach array_slice($against_figure[8], 0, 4) as $val%}
<div class="group">
{%if !empty($val.home_tid)%}
{%if $val.win == 2%}
<a href="kanqiu://soccerleagues/chlg/team/{%$val.home_tid|f_escape_path%}" class="left-logo">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$val.home_tid|f_escape_xml%}_d.png?1" alt="" class="swiper-lazy">
</a>
{%else%}
<a class="left-logo" href="kanqiu://soccerleagues/chlg/team/{%$val.home_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$val.home_tid|f_escape_xml%}.png?1" alt="" class="swiper-lazy">
</a>
{%/if%}
{%else%}
<div class="left-logo">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?1" alt="" class="swiper-lazy">
</div>
{%/if%}
<div class="middle-info">
{%if $val.round_1 == '未赛'%}
<span>{%$val.round_1|f_escape_xml%}</span>
{%else%}
<span>{%$val.round_1|f_escape_xml%}</span>
<span>{%$val.round_2|f_escape_xml%}</span>
{%/if%}
{%if $val.type == 2%}
<i>点</i>
{%/if%}
</div>
{%if !empty($val.away_tid)%}
{%if $val.win == 1%}
<a class="right-logo" href="kanqiu://soccerleagues/chlg/team/{%$val.away_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$val.away_tid|f_escape_xml%}_d.png?2" alt="" class="swiper-lazy">
</a>
{%else%}
<a class="right-logo" href="kanqiu://soccerleagues/chlg/team/{%$val.away_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$val.away_tid|f_escape_xml%}.png?2" alt="" class="swiper-lazy">
</a>
{%/if%}
{%else%}
<div class="right-logo">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?2" alt="" class="swiper-lazy">
</div>
{%/if%}
</div>
{%/foreach%}
</section>
<section class="eight-game above-game">
{%foreach array_slice($against_figure[4], 0, 2) as $val%}
<div class="group">
<div class="title">8强</div>
{%if !empty($val.home_tid)%}
{%if $val.win == 2%}
<a class="left-logo" href="kanqiu://soccerleagues/chlg/team/{%$val.home_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$val.home_tid|f_escape_xml%}_d.png?3" alt="" class="swiper-lazy">
</a>
{%else%}
<a class="left-logo" href="kanqiu://soccerleagues/chlg/team/{%$val.home_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$val.home_tid|f_escape_xml%}.png?3" alt="" class="swiper-lazy">
</a>
{%/if%}
{%else%}
<div class="left-logo">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?2016020{%$val@index+1%}" alt="" class="swiper-lazy">
</div>
{%/if%}
<div class="middle-info">
{%if $val.round_1 == '未赛'%}
<span>{%$val.round_1|f_escape_xml%}</span>
{%else%}
<span>{%$val.round_1|f_escape_xml%}</span>
<span>{%$val.round_2|f_escape_xml%}</span>
{%/if%}
{%if $val.type == 2%}
<i>点</i>
{%/if%}
</div>
{%if !empty($val.away_tid)%}
{%if $val.win == 1%}
<a class="right-logo" href="kanqiu://soccerleagues/chlg/team/{%$val.away_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$val.away_tid|f_escape_xml%}_d.png?4" alt="" class="swiper-lazy">
</a>
{%else%}
<a class="right-logo" href="kanqiu://soccerleagues/chlg/team/{%$val.away_tid|f_escape_path%}" >
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$val.away_tid|f_escape_xml%}.png?4" alt="" class="swiper-lazy">
</a>
{%/if%}
{%else%}
<div class="right-logo">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?2016030{%$val@index+3%}" alt="" class="swiper-lazy">
</div>
{%/if%}
<div class="line"></div>
</div>
{%/foreach%}
</section>
<section class="semi-game above-game">
{%assign var="semi" value = $against_figure[2][0]%}
<div class="group">
<div class="title">半决赛</div>
{%if !empty($semi.home_tid)%}
{%if $semi.win == 2%}
<a class="left-logo" href="kanqiu://soccerleagues/chlg/team/{%$semi.home_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$semi.home_tid|f_escape_xml%}_d.png?5" alt="" class="swiper-lazy">
</a>
{%else%}
<a class="left-logo" href="kanqiu://soccerleagues/chlg/team/{%$semi.home_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$semi.home_tid|f_escape_xml%}.png?5" alt="" class="swiper-lazy">
</a>
{%/if%}
{%else%}
<div class="left-logo">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?{%$semi@index+1%}" alt="" class="swiper-lazy">
</div>
{%/if%}
<div class="middle-info">
{%if $semi.round_1 == '未赛'%}
<span>{%$semi.round_1|f_escape_xml%}</span>
{%else%}
<span>{%$semi.round_1|f_escape_xml%}</span>
<span>{%$semi.round_2|f_escape_xml%}</span>
{%/if%}
{%if $semi.type == 2%}
<i>点</i>
{%/if%}
</div>
{%if !empty($semi.away_tid)%}
{%if $semi.win == 1%}
<a class="right-logo" href="kanqiu://soccerleagues/chlg/team/{%$semi.away_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$semi.away_tid|f_escape_xml%}_d.png?6" alt="" class="swiper-lazy">
</a>
{%else%}
<a class="right-logo" href="kanqiu://soccerleagues/chlg/team/{%$semi.away_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$semi.away_tid|f_escape_xml%}.png?6" alt="" class="swiper-lazy">
</a>
{%/if%}
{%else%}
<div class="right-logo">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?{%$semi@index+2%}" alt="" class="swiper-lazy">
</div>
{%/if%}
<div class="line"></div>
</div>
</section>
<section class="final-game">
{%assign var="final" value = $against_figure[1][0]%}
<div class="final-group">
<div class="title">决赛</div>
{%if !empty($final.home_tid)%}
{%if $final.win == 2%}
<a class="left-logo" href="kanqiu://soccerleagues/chlg/team/{%$final.home_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$final.home_tid|f_escape_xml%}_d.png?7" alt="" class="swiper-lazy">
<span>{%$final.home_name|f_escape_xml%}</span>
</a>
{%else%}
<a class="left-logo" href="kanqiu://soccerleagues/chlg/team/{%$final.home_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$final.home_tid|f_escape_xml%}.png?7" alt="" class="swiper-lazy">
<span>{%$final.home_name|f_escape_xml%}</span>
</a>
{%/if%}
{%else%}
<div class="left-logo">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?7" alt="" class="swiper-lazy">
</div>
{%/if%}
<div class="middle-info">
<span class="score">{%$final.round_1|f_escape_xml%}</span>
{%if $final.type == 2%}
<span>
<i>点</i><em>({%$final.round_2|f_escape_xml%})</em>
</span>
{%/if%}
</div>
{%if !empty($final.away_tid)%}
{%if $final.win == 1%}
<a class="right-logo" href="kanqiu://soccerleagues/chlg/team/{%$final.away_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$final.away_tid|f_escape_xml%}_d.png?8" alt="" class="swiper-lazy">
<span>{%$final.away_name|f_escape_xml%}</span>
</a>
{%else%}
<a class="right-logo" href="kanqiu://soccerleagues/chlg/team/{%$final.away_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$final.away_tid|f_escape_xml%}.png?8" alt="" class="swiper-lazy">
<span>{%$final.away_name|f_escape_xml%}</span>
</a>
{%/if%}
{%else%}
<div class="right-logo">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?8" alt="" class="swiper-lazy">
</div>
{%/if%}
<div class="bottom-info">
@圣西罗球场 2016.5.29</div>
</div>
</section>
<section class="semi-game below-game">
{%assign var="semi" value = $against_figure[2][1]%}
<div class="group">
<div class="title">半决赛</div>
{%if !empty($semi.home_tid)%}
{%if $semi.win == 2%}
<a class="left-logo" href="kanqiu://soccerleagues/chlg/team/{%$semi.home_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$semi.home_tid|f_escape_xml%}_d.png?9" alt="" class="swiper-lazy">
</a>
{%else%}
<a class="left-logo" href="kanqiu://soccerleagues/chlg/team/{%$semi.home_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$semi.home_tid|f_escape_xml%}.png?9" alt="" class="swiper-lazy">
</a>
{%/if%}
{%else%}
<div class="left-logo">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?9" alt="" class="swiper-lazy">
</div>
{%/if%}
<div class="middle-info">
{%if $semi.round_1 == '未赛'%}
<span>{%$semi.round_1|f_escape_xml%}</span>
{%else%}
<span>{%$semi.round_1|f_escape_xml%}</span>
<span>{%$semi.round_2|f_escape_xml%}</span>
{%/if%}
{%if $semi.type == 2%}
<i>点</i>
{%/if%}
</div>
{%if !empty($semi.away_tid)%}
{%if $semi.win == 1%}
<a class="right-logo" href="kanqiu://soccerleagues/chlg/team/{%$semi.away_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$semi.away_tid|f_escape_xml%}_d.png?10" alt="" class="swiper-lazy">
</a>
{%else%}
<a class="right-logo" href="kanqiu://soccerleagues/chlg/team/{%$semi.away_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$semi.away_tid|f_escape_xml%}.png?10" alt="" class="swiper-lazy">
</a>
{%/if%}
{%else%}
<div class="right-logo">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?10" alt="" class="swiper-lazy">
</div>
{%/if%}
<div class="line"></div>
</div>
</section>
<section class="eight-game below-game">
{%foreach array_slice($against_figure[4], 2, 2) as $val%}
<div class="group">
<div class="title">8强</div>
{%if !empty($val.home_tid)%}
{%if $val.win == 2%}
<a class="left-logo" href="kanqiu://soccerleagues/chlg/team/{%$val.home_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$val.home_tid|f_escape_xml%}_d.png?11" alt="" class="swiper-lazy">
</a>
{%else%}
<a class="left-logo" href="kanqiu://soccerleagues/chlg/team/{%$val.home_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$val.home_tid|f_escape_xml%}.png?11" alt="" class="swiper-lazy">
</a>
{%/if%}
{%else%}
<div class="left-logo">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?2016050{%$val@index|f_escape_xml%}" alt="" class="swiper-lazy">
</div>
{%/if%}
<div class="middle-info">
{%if $val.round_1 == '未赛'%}
<span>{%$val.round_1|f_escape_xml%}</span>
{%else%}
<span>{%$val.round_1|f_escape_xml%}</span>
<span>{%$val.round_2|f_escape_xml%}</span>
{%/if%}
{%if $val.type == 2%}
<i>点</i>
{%/if%}
</div>
{%if !empty($val.away_tid)%}
{%if $val.win == 1%}
<a class="right-logo" href="kanqiu://soccerleagues/chlg/team/{%$val.away_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$val.away_tid|f_escape_xml%}_d.png?12" alt="" class="swiper-lazy">
</a>
{%else%}
<a class="right-logo" href="kanqiu://soccerleagues/chlg/team/{%$val.away_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$val.away_tid|f_escape_xml%}.png?12" alt="" class="swiper-lazy">
</a>
{%/if%}
{%else%}
<div class="right-logo">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?2016050{%$val@index+3%}" alt="" class="swiper-lazy">
</div>
{%/if%}
<div class="line"></div>
</div>
{%/foreach%}
</section>
<section class="elimination-game below-game">
{%foreach array_slice($against_figure[8], 4, 4) as $val%}
<div class="group">
{%if !empty($val.home_tid)%}
{%if $val.win == 2%}
<a class="left-logo" href="kanqiu://soccerleagues/chlg/team/{%$val.home_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$val.home_tid|f_escape_xml%}_d.png?13" alt="" class="swiper-lazy">
</a>
{%else%}
<a class="left-logo" href="kanqiu://soccerleagues/chlg/team/{%$val.home_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$val.home_tid|f_escape_xml%}.png?13" alt="" class="swiper-lazy">
</a>
{%/if%}
{%else%}
<div class="left-logo">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?2016070{%$val@index+3%}" alt="" class="swiper-lazy">
</div>
{%/if%}
<div class="middle-info">
{%if $val.round_1 == '未赛'%}
<span>{%$val.round_1|f_escape_xml%}</span>
{%else%}
<span>{%$val.round_1|f_escape_xml%}</span>
<span>{%$val.round_2|f_escape_xml%}</span>
{%/if%}
{%if $val.type == 2%}
<i>点</i>
{%/if%}
</div>
{%if !empty($val.home_tid)%}
{%if $val.win == 1%}
<a class="right-logo" href="kanqiu://soccerleagues/chlg/team/{%$val.away_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$val.away_tid|f_escape_xml%}_d.png?14" alt="" class="swiper-lazy">
</a>
{%else%}
<a class="right-logo" href="kanqiu://soccerleagues/chlg/team/{%$val.away_tid|f_escape_path%}">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/8_{%$val.away_tid|f_escape_xml%}.png?14" alt="" class="swiper-lazy">
</a>
{%/if%}
{%else%}
<div class="right-logo">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?14" alt="" class="swiper-lazy">
</div>
{%/if%}
</div>
{%/foreach%}
</section>
</div>
</div>