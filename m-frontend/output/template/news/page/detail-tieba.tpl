{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="news:static/detail/detail.scss"%}
{%require name="news:widget/reply/reply.css"%}
{%require name="news:static/detail-tieba/detail-tieba.scss"%}
{%/block%}
{%block name="content"%}
<section class="detail-wrap">
<section class="detail-content">
{%widget
                name = "news:widget/artical/artical.tpl"
            %}
</section>
<div class="m-reply">
{%if !empty($lightComments)%}
<div class="newest-reply" data-pagecount="{%$pageCount|f_escape_xml%}">
<div class="title">
<h2>热门评论</h2>
</div>
<div class="reply-inner">
{%foreach from=$lightComments item=itemVal name=itemVal%}
{%widget
                            name="news:widget/reply/reply-list.tpl"
                            data=$itemVal
                        %}
{%/foreach%}
</div>
</div>
{%/if%}
</div>
{%widget
            name = "common:widget/relative-news/relative-news.tpl"
            dace = "{%$id4dace|f_escape_xml%}_news"
            urlfrom = "hotnews"
            sectionExposure="{%$id4dace|f_escape_xml%}_shownews"
            data = $hot
        %}
</section>
{%/block%}{%block name="footer"%}
{%require name='news:page/detail-tieba.tpl'%}{%/block%}