{%extends file="common/page/layout.tpl"%}
{%block name="block_head_static"%}
    {%script%}
        var nbaMatchList = require("common:widget/ui/nba-match-list/nba-match-list.js");
        nbaMatchList.init();

        var pageTool = require("common:widget/ui/page-tools/page-tools.js");
        pageTool.initTools({
            today: true,
            todayHandler: function(){
                var _top = $('.match-today').offset().top;
                $('html,body').scrollTop(_top);
            }
        });
    {%/script%}
{%/block%}

{%block name="content"%}
    {%widget
        name="common:widget/top-nav/top-nav.tpl"
    %}

    {%widget
        name="common:widget/ui/nba-match-list/nba-match-list.tpl"
        data=$nbaGame
    %}
{%/block%}
