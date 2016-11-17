{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="bbs:static/list/list.scss"%}
<script>
        !function(win){
            // 总分页数
            HPM.pageCount = 10;
            HPM.isIndex = 1;
            HPM.hotForums = {%json_encode($hotForums)%}||[];
            HPM.collectedForums = {%json_encode($collectedForums)%}||[];
        }(window);
    </script>
{%script%}
        var board = require("bbs:widget/recommendBoard/recommendBoard.js");
        board({
            isIndex: true,
            isLogin: HPM.isLogin
        });
    {%/script%}
{%/block%}
{%block name="content"%}
{%widget
        name="common:widget/top-nav/top-nav.tpl"
        channel="bbs"
        fromPage = "index"
    %}
<section class="list-wrap">
{%widget
            name="bbs:widget/recommendBoard/recommendBoard.tpl"
        %}
{%widget
            name = "common:widget/ui/bbs-list/bbs-list.tpl"
            data = $homeData
            className = "index-list"
            from = "bbsindex"
            boardData = $recommendBoard
            curPage = $page
        %}
</section>
{%widget name="common:widget/ui/page/page.tpl" pageCount=$pageCount page=$page urlBase="/bbs-#{page}"%}
{%/block%}
{%block name="footer"%}
{%widget name="common:widget/footer/footer.tpl" footerType="bbs"%}
{%require name='bbs:page/index.tpl'%}{%/block%}
