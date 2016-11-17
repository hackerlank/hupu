<div class="vs-wrap {%if $leagueName == "csl_yg"%}no-background{%/if%}">
<div class="vs-con">
<section class="elimination-game above-game">
{%foreach array_slice($against_figure[8], 0, 4) as $val%}
<div class="group">
{%if !empty($val.home_tid)%}
<a class="left-logo" {%if $leagueName == "chlg"%}href="kanqiu://soccerleagues/{%$leagueName|f_escape_path%}/team/{%$val.home_tid|f_escape_path%}"{%else%}href="javascript:void(0);"{%/if%}>
<img 
						{%if $leagueName == "chlg"%} 
						data-src="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$val.home_tid|f_escape_xml%}{%if $val.win == 2%}_d{%/if%}.png?1"{%else if $leagueName == "csl_yg"%} 
						data-src="{%$val.home_logo|mb_substr:0:($val.home_logo|strlen-4)%}{%if $val.win == 2%}_d{%/if%}.png?1" 
						{%/if%} 
						alt="" class="swiper-lazy">
</a>
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
<a class="left-logo" {%if $leagueName == "chlg"%}href="kanqiu://soccerleagues/{%$leagueName|f_escape_path%}/team/{%$val.away_tid|f_escape_path%}"{%else%}href="javascript:void(0);"{%/if%}>
<img 
						{%if $leagueName == "chlg"%} 
						data-src="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$val.away_tid|f_escape_xml%}{%if $val.win == 1%}_d{%/if%}.png?2"{%else if $leagueName == "csl_yg"%} 
						data-src="{%$val.away_logo|mb_substr:0:($val.away_logo|strlen-4)%}{%if $val.win == 1%}_d{%/if%}.png?2" 
						{%/if%} 
						alt="" class="swiper-lazy">
</a>
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
{%if !empty($val.home_tid)%}
<a class="left-logo" {%if $leagueName == "chlg"%}href="kanqiu://soccerleagues/{%$leagueName|f_escape_path%}/team/{%$val.home_tid|f_escape_path%}"{%else%}href="javascript:void(0);"{%/if%}>
<img 
						{%if $leagueName == "chlg"%} 
						data-src="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$val.home_tid|f_escape_xml%}{%if $val.win == 2%}_d{%/if%}.png?3"{%else if $leagueName == "csl_yg"%} 
						data-src="{%$val.home_logo|mb_substr:0:($val.home_logo|strlen-4)%}{%if $val.win == 2%}_d{%/if%}.png?3" 
						{%/if%} 
						alt="" class="swiper-lazy">
</a>
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
<a class="left-logo" {%if $leagueName == "chlg"%}href="kanqiu://soccerleagues/{%$leagueName|f_escape_path%}/team/{%$val.away_tid|f_escape_path%}"{%else%}href="javascript:void(0);"{%/if%}>
<img 
						{%if $leagueName == "chlg"%} 
						data-src="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$val.away_tid|f_escape_xml%}{%if $val.win == 1%}_d{%/if%}.png?4"{%else if $leagueName == "csl_yg"%} 
						data-src="{%$val.away_logo|mb_substr:0:($val.away_logo|strlen-4)%}{%if $val.win == 1%}_d{%/if%}.png?4" 
						{%/if%} 
						alt="" class="swiper-lazy">
</a>
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
<a class="left-logo" {%if $leagueName == "chlg"%}href="kanqiu://soccerleagues/{%$leagueName|f_escape_path%}/team/{%$semi.home_tid|f_escape_path%}"{%else%}href="javascript:void(0);"{%/if%}>
<img 
						{%if $leagueName == "chlg"%} 
						data-src="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$semi.home_tid|f_escape_xml%}{%if $semi.win == 2%}_d{%/if%}.png?5"{%else if $leagueName == "csl_yg"%} 
						data-src="{%$semi.home_logo|mb_substr:0:($semi.home_logo|strlen-4)%}{%if $semi.win == 2%}_d{%/if%}.png?5" 
						{%/if%} 
						alt="" class="swiper-lazy">
</a>
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
<a class="left-logo" {%if $leagueName == "chlg"%}href="kanqiu://soccerleagues/{%$leagueName|f_escape_path%}/team/{%$semi.away_tid|f_escape_path%}"{%else%}href="javascript:void(0);"{%/if%}>
<img 
						{%if $leagueName == "chlg"%} 
						data-src="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$semi.away_tid|f_escape_xml%}{%if $semi.win == 1%}_d{%/if%}.png?6"{%else if $leagueName == "csl_yg"%} 
						data-src="{%$semi.away_logo|mb_substr:0:($semi.away_logo|strlen-4)%}{%if $semi.win == 1%}_d{%/if%}.png?6" 
						{%/if%} 
						alt="" class="swiper-lazy">
</a>
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
<a class="left-logo" {%if $leagueName == "chlg"%}href="kanqiu://soccerleagues/{%$leagueName|f_escape_path%}/team/{%$final.home_tid|f_escape_path%}"{%else%}href="javascript:void(0);"{%/if%}>
<img 
						{%if $leagueName == "chlg"%} 
						data-src="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$final.home_tid|f_escape_xml%}{%if $final.win == 2%}_d{%/if%}.png?7"{%else if $leagueName == "csl_yg"%} 
						data-src="{%$final.home_logo|mb_substr:0:($final.home_logo|strlen-4)%}{%if $final.win == 2%}_d{%/if%}.png?7" 
						{%/if%} 
						alt="" class="swiper-lazy">
<span>{%$final.home_name|f_escape_xml%}</span>
</a>
{%else%}
<div class="left-logo">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?7" alt="" class="swiper-lazy">
</div>
{%/if%}
<div class="middle-info">
{%if $final.round_1 == '未赛'%}
<span class="score">{%$final.round_1|f_escape_xml%}</span>
{%else%}
<span>{%$final.round_1|f_escape_xml%}</span>
<span>{%$final.round_2|f_escape_xml%}</span>
{%/if%}
{%if $final.type == 2%}
<i>点</i>
{%/if%}
</div>
{%if !empty($final.away_tid)%}
<a class="left-logo" {%if $leagueName == "chlg"%}href="kanqiu://soccerleagues/{%$leagueName|f_escape_path%}/team/{%$final.away_tid|f_escape_path%}"{%else%}href="javascript:void(0);"{%/if%}>
<img 
						{%if $leagueName == "chlg"%} 
						data-src="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$final.away_tid|f_escape_xml%}{%if $final.win == 1%}_d{%/if%}.png?8"{%else if $leagueName == "csl_yg"%} 
						data-src="{%$final.away_logo|mb_substr:0:($final.away_logo|strlen-4)%}{%if $final.win == 1%}_d{%/if%}.png?8" 
						{%/if%} 
						alt="" class="swiper-lazy">
<span>{%$final.away_name|f_escape_xml%}</span>
</a>
{%else%}
<div class="right-logo">
<img data-src="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?8" alt="" class="swiper-lazy">
</div>
{%/if%}
{%if $leagueName == "chlg"%}
<div class="bottom-info">
@圣西罗球场 2016.5.29</div>
{%/if%}
</div>
</section>
<section class="semi-game below-game">
{%assign var="semi" value = $against_figure[2][1]%}
<div class="group">
<div class="title">半决赛</div>
{%if !empty($semi.home_tid)%}
<a class="left-logo" {%if $leagueName == "chlg"%}href="kanqiu://soccerleagues/{%$leagueName|f_escape_path%}/team/{%$semi.home_tid|f_escape_path%}"{%else%}href="javascript:void(0);"{%/if%}>
<img 
						{%if $leagueName == "chlg"%} 
						data-src="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$semi.home_tid|f_escape_xml%}{%if $semi.win == 2%}_d{%/if%}.png?9"{%else if $leagueName == "csl_yg"%} 
						data-src="{%$semi.home_logo|mb_substr:0:($semi.home_logo|strlen-4)%}{%if $semi.win == 2%}_d{%/if%}.png?9" 
						{%/if%} 
						alt="" class="swiper-lazy">
</a>
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
<a class="left-logo" {%if $leagueName == "chlg"%}href="kanqiu://soccerleagues/{%$leagueName|f_escape_path%}/team/{%$semi.away_tid|f_escape_path%}"{%else%}href="javascript:void(0);"{%/if%}>
<img 
						{%if $leagueName == "chlg"%} 
						data-src="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$semi.away_tid|f_escape_xml%}{%if $semi.win == 1%}_d{%/if%}.png?10"{%else if $leagueName == "csl_yg"%} 
						data-src="{%$semi.away_logo|mb_substr:0:($semi.away_logo|strlen-4)%}{%if $semi.win == 1%}_d{%/if%}.png?10" 
						{%/if%} 
						alt="" class="swiper-lazy">
</a>
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
{%if !empty($val.home_tid)%}
<a class="left-logo" {%if $leagueName == "chlg"%}href="kanqiu://soccerleagues/{%$leagueName|f_escape_path%}/team/{%$val.home_tid|f_escape_path%}"{%else%}href="javascript:void(0);"{%/if%}>
<img 
						{%if $leagueName == "chlg"%} 
						data-src="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$val.home_tid|f_escape_xml%}{%if $val.win == 2%}_d{%/if%}.png?11"{%else if $leagueName == "csl_yg"%} 
						data-src="{%$val.home_logo|mb_substr:0:($val.home_logo|strlen-4)%}{%if $val.win == 2%}_d{%/if%}.png?11" 
						{%/if%} 
						alt="" class="swiper-lazy">
</a>
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
<a class="left-logo" {%if $leagueName == "chlg"%}href="kanqiu://soccerleagues/{%$leagueName|f_escape_path%}/team/{%$val.away_tid|f_escape_path%}"{%else%}href="javascript:void(0);"{%/if%}>
<img 
						{%if $leagueName == "chlg"%} 
						data-src="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$val.away_tid|f_escape_xml%}{%if $val.win == 1%}_d{%/if%}.png?12"{%else if $leagueName == "csl_yg"%} 
						data-src="{%$val.away_logo|mb_substr:0:($val.away_logo|strlen-4)%}{%if $val.win == 1%}_d{%/if%}.png?12" 
						{%/if%} 
						alt="" class="swiper-lazy">
</a>
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
<a class="left-logo" {%if $leagueName == "chlg"%}href="kanqiu://soccerleagues/{%$leagueName|f_escape_path%}/team/{%$val.home_tid|f_escape_path%}"{%else%}href="javascript:void(0);"{%/if%}>
<img 
						{%if $leagueName == "chlg"%} 
						data-src="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$val.home_tid|f_escape_xml%}{%if $val.win == 2%}_d{%/if%}.png?13"{%else if $leagueName == "csl_yg"%} 
						data-src="{%$val.home_logo|mb_substr:0:($val.home_logo|strlen-4)%}{%if $val.win == 2%}_d{%/if%}.png?13" 
						{%/if%} 
						alt="" class="swiper-lazy">
</a>
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
<a class="left-logo" {%if $leagueName == "chlg"%}href="kanqiu://soccerleagues/{%$leagueName|f_escape_path%}/team/{%$val.away_tid|f_escape_path%}"{%else%}href="javascript:void(0);"{%/if%}>
<img 
						{%if $leagueName == "chlg"%} 
						data-src="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$val.away_tid|f_escape_xml%}{%if $val.win == 1%}_d{%/if%}.png?14"{%else if $leagueName == "csl_yg"%} 
						data-src="{%$val.away_logo|mb_substr:0:($val.away_logo|strlen-4)%}{%if $val.win == 1%}_d{%/if%}.png?14" 
						{%/if%} 
						alt="" class="swiper-lazy">
</a>
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