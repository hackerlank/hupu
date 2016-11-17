<div class="vs-wrap {%if $leagueName == "afccl"%}no-background{%/if%}">
<div class="vs-con">
<section class="elimination-game above-game">
{%foreach array_slice($against_figure[8], 0, 4) as $val%}
<div class="group">
{%if !empty($val.home_tid)%}
<a class="left-logo" {%if $leagueName == "chlg"%}href="kanqiu://soccerleagues/{%$leagueName|f_escape_path%}/team/{%$val.home_tid|f_escape_path%}"{%else%}href="javascript:void(0);"{%/if%}>
<img
						{%if $leagueName == "chlg"%}
						data-original="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$val.home_tid|f_escape_xml%}{%if $val.win == 2%}_d{%/if%}.png?t=121{%$val@index|f_escape_xml%}"{%else if $leagueName == "afccl"%}
						data-original="{%$val.home_logo|mb_substr:0:($val.home_logo|strlen-4)%}{%if $val.win == 2%}_d{%/if%}.png?t=122{%$val@index|f_escape_xml%}"
						{%/if%}
						alt="" class="lazy">
</a>
{%else%}
<div class="left-logo">
<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?1" alt="" class="lazy">
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
						data-original="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$val.away_tid|f_escape_xml%}{%if $val.win == 1%}_d{%/if%}.png?t=123{%$val@index|f_escape_xml%}"{%else if $leagueName == "afccl"%}
						data-original="{%$val.away_logo|mb_substr:0:($val.away_logo|strlen-4)%}{%if $val.win == 1%}_d{%/if%}.png?t=124{%$val@index|f_escape_xml%}"
						{%/if%}
						alt="" class="lazy">
</a>
{%else%}
<div class="right-logo">
<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?2" alt="" class="lazy">
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
						data-original="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$val.home_tid|f_escape_xml%}{%if $val.win == 2%}_d{%/if%}.png?t=125{%$val@index|f_escape_xml%}"{%else if $leagueName == "afccl"%}
						data-original="{%$val.home_logo|mb_substr:0:($val.home_logo|strlen-4)%}{%if $val.win == 2%}_d{%/if%}.png?t=126{%$val@index|f_escape_xml%}"
						{%/if%}
						alt="" class="lazy">
</a>
{%else%}
<div class="left-logo">
<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t={%$val@index|f_escape_xml%}" alt="" class="lazy">
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
						data-original="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$val.away_tid|f_escape_xml%}{%if $val.win == 1%}_d{%/if%}.png?t=1266{%$val@index|f_escape_xml%}"{%else if $leagueName == "afccl"%}
						data-original="{%$val.away_logo|mb_substr:0:($val.away_logo|strlen-4)%}{%if $val.win == 1%}_d{%/if%}.png?t=127{%$val@index|f_escape_xml%}"
						{%/if%}
						alt="" class="lazy">
</a>
{%else%}
<div class="right-logo">
<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t={%$val@index|f_escape_xml%}" alt="" class="lazy">
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
						data-original="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$semi.home_tid|f_escape_xml%}{%if $semi.win == 2%}_d{%/if%}.png?t=128{%$val@index|f_escape_xml%}"{%else if $leagueName == "afccl"%}
						data-original="{%$semi.home_logo|mb_substr:0:($semi.home_logo|strlen-4)%}{%if $semi.win == 2%}_d{%/if%}.png?t=129{%$val@index|f_escape_xml%}"
						{%/if%}
						alt="" class="lazy">
</a>
{%else%}
<div class="left-logo">
<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?{%$semi@index+1%}" alt="" class="lazy">
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
						data-original="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$semi.away_tid|f_escape_xml%}{%if $semi.win == 1%}_d{%/if%}.png?t=1210{%$val@index|f_escape_xml%}"{%else if $leagueName == "afccl"%}
						data-original="{%$semi.away_logo|mb_substr:0:($semi.away_logo|strlen-4)%}{%if $semi.win == 1%}_d{%/if%}.png?t=1211{%$val@index|f_escape_xml%}"
						{%/if%}
						alt="" class="lazy">
</a>
{%else%}
<div class="right-logo">
<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?{%$semi@index+2%}" alt="" class="lazy">
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
						data-original="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$final.home_tid|f_escape_xml%}{%if $final.win == 2%}_d{%/if%}.png?t=1212{%$val@index|f_escape_xml%}"{%else if $leagueName == "afccl"%}
						data-original="{%$final.home_logo|mb_substr:0:($final.home_logo|strlen-4)%}{%if $final.win == 2%}_d{%/if%}.png?t=1213{%$val@index|f_escape_xml%}"
						{%/if%}
						alt="" class="lazy">
<span>{%$final.home_name|f_escape_xml%}</span>
</a>
{%else%}
<div class="left-logo">
<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?7" alt="" class="lazy">
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
						data-original="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$final.away_tid|f_escape_xml%}{%if $final.win == 1%}_d{%/if%}.png?t=1214{%$val@index|f_escape_xml%}"{%else if $leagueName == "afccl"%}
						data-original="{%$final.away_logo|mb_substr:0:($final.away_logo|strlen-4)%}{%if $final.win == 1%}_d{%/if%}.png?t=1215{%$val@index|f_escape_xml%}"
						{%/if%}
						alt="" class="lazy">
<span>{%$final.away_name|f_escape_xml%}</span>
</a>
{%else%}
<div class="right-logo">
<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?8" alt="" class="lazy">
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
						data-original="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$semi.home_tid|f_escape_xml%}{%if $semi.win == 2%}_d{%/if%}.png?t=1216{%$val@index|f_escape_xml%}"{%else if $leagueName == "afccl"%}
						data-original="{%$semi.home_logo|mb_substr:0:($semi.home_logo|strlen-4)%}{%if $semi.win == 2%}_d{%/if%}.png?t=1217{%$val@index|f_escape_xml%}"
						{%/if%}
						alt="" class="lazy">
</a>
{%else%}
<div class="left-logo">
<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?9" alt="" class="lazy">
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
						data-original="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$semi.away_tid|f_escape_xml%}{%if $semi.win == 1%}_d{%/if%}.png?t=1218{%$val@index|f_escape_xml%}"{%else if $leagueName == "afccl"%}
						data-original="{%$semi.away_logo|mb_substr:0:($semi.away_logo|strlen-4)%}{%if $semi.win == 1%}_d{%/if%}.png?t=1219{%$val@index|f_escape_xml%}"
						{%/if%}
						alt="" class="lazy">
</a>
{%else%}
<div class="right-logo">
<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?10" alt="" class="lazy">
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
						data-original="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$val.home_tid|f_escape_xml%}{%if $val.win == 2%}_d{%/if%}.png?t=1220{%$val@index|f_escape_xml%}"{%else if $leagueName == "afccl"%}
						data-original="{%$val.home_logo|mb_substr:0:($val.home_logo|strlen-4)%}{%if $val.win == 2%}_d{%/if%}.png?t=1221{%$val@index|f_escape_xml%}"
						{%/if%}
						alt="" class="lazy">
</a>
{%else%}
<div class="left-logo">
<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t={%$val@index|f_escape_xml%}50{%$val@index|f_escape_xml%}" alt="" class="lazy">
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
						data-original="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$val.away_tid|f_escape_xml%}{%if $val.win == 1%}_d{%/if%}.png?t=1222{%$val@index|f_escape_xml%}"{%else if $leagueName == "afccl"%}
						data-original="{%$val.away_logo|mb_substr:0:($val.away_logo|strlen-4)%}{%if $val.win == 1%}_d{%/if%}.png?t=1223{%$val@index|f_escape_xml%}"
						{%/if%}
						alt="" class="lazy">
</a>
{%else%}
<div class="right-logo">
<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t={%$val@index|f_escape_xml%}" alt="" class="lazy">
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
						data-original="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$val.home_tid|f_escape_xml%}{%if $val.win == 2%}_d{%/if%}.png?t=1224{%$val@index|f_escape_xml%}"{%else if $leagueName == "afccl"%}
						data-original="{%$val.home_logo|mb_substr:0:($val.home_logo|strlen-4)%}{%if $val.win == 2%}_d{%/if%}.png?t=1225{%$val@index|f_escape_xml%}"
						{%/if%}
						alt="" class="lazy">
</a>
{%else%}
<div class="left-logo">
<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?t={%$val@index|f_escape_xml%}" alt="" class="lazy">
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
						data-original="//b1.hoopchina.com.cn/games/teams/{%$leagueName|f_escape_xml%}/8_{%$val.away_tid|f_escape_xml%}{%if $val.win == 1%}_d{%/if%}.png?t=1226{%$val@index|f_escape_xml%}"{%else if $leagueName == "afccl"%}
						data-original="{%$val.away_logo|mb_substr:0:($val.away_logo|strlen-4)%}{%if $val.win == 1%}_d{%/if%}.png?t=1227{%$val@index|f_escape_xml%}"
						{%/if%}
						alt="" class="lazy">
</a>
{%else%}
<div class="right-logo">
<img data-original="//b1.hoopchina.com.cn/games/teams/chlg/no_pic.png?14" alt="" class="lazy">
</div>
{%/if%}
</div>
{%/foreach%}
</section>
</div>
</div>
