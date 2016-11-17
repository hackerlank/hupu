{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="news:static/detail/detail.scss"%}
{%require name="news:static/detail/detail.js"%}
<script>
        HPM.pageCount = "{%$pageCount|f_escape_js%}";
        HPM.curUrl = "{%if !empty($newspageurl)%}{%$newspageurl|f_escape_js%}{%else%}{%/if%}";
        HPM.tid = "{%$id|f_escape_js%}";
    </script>
{%script%}

        //底部的刷新
        var tools = require("common:widget/ui/page-tools/page-tools.js");
        tools.initTools({
            reply : true,
            replyHandler: function(){
                $(document).trigger("page:reply");
            }
        });

        // 微信图片切换
        var WeixinTool = require("common:widget/ui/weixin-tool/weixin-tool.js");
        WeixinTool.init('.article-content');
    {%/script%}
{%/block%}
{%block name="content"%}
{%widget
        name="common:widget/inner-top-nav/nav.tpl"
    %}
{%if !empty($custom["m_top"])%}
{%widget name="common:widget/live-text/live.tpl" data=$custom["m_top"]%}
{%/if%}
{%widget
        name="common:widget/prediction-tips/prediction-tips.tpl"
        urlParam="?dace_from=bbs#today"
    %}
<section class="detail-wrap">
<section class="detail-content">
{%widget
                name = "news:widget/artical/artical.tpl"
            %}
<div class="down-kanApp">
<a href="http://mobile.hupu.com/download/games/?_r=mxinwenneiye" class="down-link" dace-node="{%$id4dace|f_escape_xml%}_download_news">下载虎扑体育App，看更多相关内容</a>
</div>
<div class="choice" news-id="{%$detail.id|f_escape_xml%}">
<div class="choice-item support">
<i></i><strong>支持</strong>
{%if $detail.support>0%}
<span>({%$detail.support|f_escape_xml%})</span>
{%else%}
<span></span>
{%/if%}
</div>
<div class="choice-item against">
<i></i><strong>反对</strong>
{%if $detail.against>0%}
<span>({%$detail.against|f_escape_xml%})</span>
{%else%}
<span></span>
{%/if%}
</div>
</div>
{%if !empty($detail.tags)%}
<div class="swiper-container hot-tags">
<div class="swiper-wrapper">
<div class="swiper-slide tag-title">新闻热搜</div>
{%foreach from=$detail.tags item=hotItem name=hotItem%}
<div class="swiper-slide" dace-node="{%$id4dace|f_escape_xml%}_tag_{%$hotItem@index+1%}"><a href="{%$hotItem.url|f_escape_xml%}">{%$hotItem.tag_name|f_escape_xml%}</a></div>
{%/foreach%}
</div>
</div>
{%/if%}
</section>
{%widget
            name="news:widget/reply/reply.tpl"
        %}
<div id="J_replyDownKanApp" class="down-kanApp fn-hide">
<a href="http://mobile.hupu.com/download/games/?_r=mxinwenpinglun" class="down-link" dace-node="{%$id4dace|f_escape_xml%}_download-comment">下载虎扑体育App查看全部回复</a>
</div>
{%if isset($hotThread) && !empty($hotThread) %}
<div class="guess-like">
<div class="title">
<h2>其他人正在看</h2>
</div>
<div class="bd">
<ul class="list">
{%if !empty($kaluli) && isset($kaluli)%}
{%foreach from=$kaluli item=val name=key%}
<li>
<a href="{%$val.detail_url|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_bbs">
<h4 class="name">{%$val.title|escape:none%}</h4>
<div class="status-bar">
<div class="news-info">
<span class="news-source">
{%$val.come|f_escape_xml%}
</span>
<span class="news-time">
{%$val.time|f_escape_xml%}
</span>
</div>
{%if !empty($val.replies)%}
<div class="news-comment">
<i class="icon-comment"></i><span class="comment-number">{%$val.replies|f_escape_xml%}</span>
</div>
{%/if%}
</div>
</a>
</li>
{%/foreach%}
{%/if%}
{%foreach from=$hotThread item=hotItem name=hotItem%}
<li>
<a href="{%$hotItem.mobileurl|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_bbs">
<h4 class="name">{%$hotItem.subject|escape:none%}</h4>
<div class="status-bar">
<div class="news-info">
<span class="news-source">
{%$hotItem.forumname|f_escape_xml%}
</span>
<span class="news-time">
{%$hotItem.posttime|f_escape_xml%}
</span>
</div>
{%if !empty($hotItem.replies)%}
<div class="news-comment">
<i class="icon-comment"></i><span class="comment-number">{%$hotItem.replies|f_escape_xml%}</span>
</div>
{%/if%}
</div>
</a>
</li>
{%/foreach%}
</ul>
</div>
</div>
{%/if%}
{%widget
            name = "common:widget/relative-news/relative-news.tpl"
            dace = "{%$id4dace|f_escape_xml%}_news"
            urlfrom = "hotnews"
            sectionExposure="{%$id4dace|f_escape_xml%}_shownews"
            data = $hot
        %}
</section>
{%if $is_show_taobao|default:false%}
<script src="//st1.shihuo.cn/alibtn.js" data-unit="px" data-style="right:-8" data-size="60" data-type="fixed" data-url="http://www.shihuo.cn/shihuo_activity_tmall_page.html"></script>
{%/if%}
<span style="display:none"></span>
{%/block%}
{%block name="footer"%}
{%widget name="common:widget/footer/footer.tpl" footerType="newsdetail"%}
{%require name='news:page/detail.tpl'%}{%/block%}
