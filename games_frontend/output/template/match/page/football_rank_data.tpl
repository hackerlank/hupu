{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}{%$league_chinese|f_escape_xml%}{%/block%}
{%block name="head_static"%}
{%require name="common:static/js/zepto/zepto.js"%}
{%require name="common:static/js/swiper/js/swiper.jquery.js"%}
{%require name="common:static/js/swiper/css/swiper.css"%}
{%require name="match:static/football_public/football_public.scss"%}
{%script%}
		window.GM = {
            "client": "{%$client|f_escape_js%}" || "x",
            "islogin": !!parseInt("{%$is_login|f_escape_js%}", 10),
            "night":!!parseInt("{%$night|f_escape_js%}", 10),
            "leagueName": "{%$league_name|f_escape_js%}",
            "pageLastTab":!!parseInt("{%$pageLastTab|f_escape_js%}", 10)
        };

		var footballRankData = require("match:widget/football_rank_data/football_rank_data.js");
		footballRankData.init();
    {%/script%}
{%/block%}
{%block name="content"%}
<section class="mod-rank-wrap" id="J-mod-rank-wrap">
{%widget
	        name="match:widget/football_tab/football_tab.tpl"
	    %}
<section class="swiper-container">
<section class="swiper-wrapper">
{%* 转会期间，五大联赛的转会球员TAB放在最前面先加载展示出来 *%}
{%if $pageLastTab == 1%}
{%widget
                        name="match:widget/football_tab_standings_rank/football_tab_standings_rank.tpl"
                    %}
{%widget
    	                name="match:widget/football_tab_player_rank/football_tab_player_rank.tpl"
    	            %}
{%if $league_name != "csl_zj"%}
{%widget
    	                name="match:widget/football_tab_team_rank/football_tab_team_rank.tpl"
    	            %}
{%/if%}
{%widget
		                name="match:widget/football_tab_transfer_player/football_tab_transfer_player.tpl"
		            %}
{%else%}
{%widget
                        name="match:widget/football_tab_standings_rank/football_tab_standings_rank.tpl"
                    %}
{%widget
                        name="match:widget/football_tab_player_rank/football_tab_player_rank.tpl"
                    %}
{%if $league_name != "csl_zj"%}
{%widget
                        name="match:widget/football_tab_team_rank/football_tab_team_rank.tpl"
                    %}
{%/if%}
{%/if%}
</section>
</section>
<div class="cover"></div>
<div class="formation m-hide">
<div class="bd"></div>
<div class="ft"><a href="javascript:void(0);" class="close">关闭</a></div>
</div>
</section>
{%require name='match:page/football_rank_data.tpl'%}{%/block%}
