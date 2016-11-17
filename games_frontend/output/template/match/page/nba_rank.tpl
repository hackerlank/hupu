{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}NBA排行数据{%/block%}
{%block name="head_static"%}
{%require name="common:static/js/zepto/zepto.js"%}
{%require name="common:static/js/swiper/js/swiper.jquery.js"%}
{%require name="common:static/js/swiper/css/swiper.css"%}
{%require name="match:static/page/nba_vs.scss"%}
{%script%}
		window.GM = {
            "client": "{%$client|f_escape_js%}" || "x",
            "islogin": !!parseInt("{%$is_login|f_escape_js%}", 10),
            "match": "nba",
            "night":!!parseInt("{%$night|f_escape_js%}", 10),
            "season": "{%$pageTab|f_escape_js%}" || "regular"
        };
        var rankList = require("match:widget/rank_list/rank_list.js");
        rankList.init();
    {%/script%}
{%/block%}
{%block name="content"%}
{%widget
        name="match:widget/rank_list/rank_list.tpl"
        type="nba"
    %}
{%require name='match:page/nba_rank.tpl'%}{%/block%}
