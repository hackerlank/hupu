{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="bbs:static/detail/detail.scss"%}
<link rel="canonical" href="{%$url|f_escape_xml%}" />
<script>
        // 当前板块名称
        HPM.boardName = '{%$thread.boardname|f_escape_js%}' || '';
        // 当前板块ID 做链接用
        HPM.fid = '{%$thread.fid|f_escape_js%}' || '';
        // 当前板块链接
        HPM.boardLink = '/bbs/{%$thread.fid|f_escape_js%}';
        // token
        HPM.token = '{%$token|f_escape_js%}';
        // csrf
        HPM.csrf = '{%$no_csrf_code|f_escape_js%}';
        // 帖子ID
        HPM.tid = '{%$thread.tid|f_escape_js%}';
    </script>
{%script%}
        var toShare = require("common:widget/ui/share/share.js");
            //全局分享事件, 每个页面单独注册.
        $(document).on("page:share", function(){
            toShare();
        });

        //页面分享按钮
        $("#J_buttonShare").on("click", function(){
            $(document).trigger("page:share");
        });

        //底部的刷新
        var tools = require("common:widget/ui/page-tools/page-tools.js");
            tools.initTools({
            reply : true,
            replyHandler: function(){
                $(document).trigger("page:reply");
            }
        });

        // 收藏
        var Star = require("bbs:widget/star/star.js");
        Star.init();

        //微信中屏蔽该请求
        {%if $smarty.server.HTTP_USER_AGENT|strpos:'MicroMessenger' == false%}
          //模拟PC统计请求
          var oImg = new Image();
          oImg.onload = oImg.onerror = function(){
            oImg.onload = oImg.onerror = null;
            oImg = null;
          }

          //延迟发送.
          setTimeout(function(){
            oImg.src = "//msa.hupu.com/thread_hit?tid=" + HPM.tid;
          }, 800);
        {%/if%}

        // 微信图片切换
        // var WeixinTool = require("common:widget/ui/weixin-tool/weixin-tool.js");
        // WeixinTool.init('.article-content');

        // 投票
        var voteRender = require("common:widget/ui-vote/ui-vote.js");
        $(".article-content span._vote").each(function(idx, elem){
           voteRender(elem);
        });

        //2016-11-08 add newreply by 洪源
        $.ajax({
          url: '//msa.hupu.com/check_newreply?tid='+ HPM.tid,
          type: "GET",
          dataType : 'jsonp',
          success: function(){},
          error: function(){}
        });
    {%/script%}
{%/block%}
{%block name="content"%}
{%widget
        name="common:widget/top-nav/top-nav.tpl"
        channel="bbsdetail"
    %}
{%if !empty($smarty.get.p)%}
{%widget name="bbs:widget/merge-info/merge-info.tpl" data=base64_decode(str_replace(' ', '+', $smarty.get.p))%}
{%/if%}
{%widget name="bbs:widget/detail-title/title.tpl"%}
{%if !empty($custom["m_top"])%}
{%widget name="common:widget/live-text/live.tpl" data=$custom["m_top"]%}
{%/if%}
{%widget
        name="common:widget/prediction-tips/prediction-tips.tpl"
        urlParam="?dace_from=bbs#today"
    %}
<section class="detail-wrap">
<section class="detail-content m-card-split-line">
<article class="article-content">
{%$thread.content|escape:none%}
</article>
{%if !empty($searchData)%}
<div class="rel-info" dace-node="{%$id4dace|f_escape_xml%}_5056" section-exposure="{%$id4dace|f_escape_xml%}_5056_show">
<a href="{%$searchData.url|f_escape_xml%}?search=1&fid={%$searchData.fid|f_escape_path%}&fromBBS={%$searchData.fid|f_escape_path%}&keyword={%$searchData.keyword|f_escape_path%}" class="rel-link"><span>更多关于“{%$searchData.keyword|f_escape_xml%}”的帖子请点击</span><em></em></a>
</div>
{%/if%}
{%if !empty($thread.viainfo)%}
<div class="article-form">
{%$thread.viainfo|escape:none%}
</div>
{%/if%}
</section>
{%widget
            name="bbs:widget/reply/reply.tpl"
        %}
{%if isset($relevantthreads) && !empty($relevantthreads)%}
<div class="guess-like m-card-split-line" section-exposure="{%$id4dace|f_escape_xml%}_showbbs">
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
{%foreach from=$relevantthreads item=val name=key%}
<li>
<a href="{%$val.mobileurl|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_bbs">
<h4 class="name">{%$val.subject|escape:none%}</h4>
<div class="status-bar">
<div class="news-info">
<span class="news-source">
{%$val.forumname|f_escape_xml%}
</span>
<span class="news-time">
{%$val.posttime|f_escape_xml%}
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
</ul>
</div>
</div>
{%/if%}
{%widget
            name = "common:widget/relative-news/relative-news.tpl"
            data = $relevantnews
            dace = "{%$id4dace|f_escape_xml%}_news"
            urlfrom = "bbshotnews"
            sectionExposure="{%$id4dace|f_escape_xml%}_shownews"
        %}
{%** 推荐热点模块不上线先注释
            {%widget
                name = "common:widget/hot-spot/hot-spot.tpl"
                data = $hotSpots
                dace = "{%$id4dace|f_escape_xml%}_hot"
                urlfrom = "bbshotnews"
                sectionExposure="{%$id4dace|f_escape_xml%}_showhot"
            %}
        **%}
</section>
{%if $is_show_taobao|default:false%}
<script src="//st1.shihuo.cn/alibtn.js" data-unit="px" data-style="right:-8" data-size="60" data-type="fixed" data-url="http://www.shihuo.cn/shihuo_activity_tmall_page.html"></script>
{%/if%}
{%/block%}
{%block name="footer"%}
{%widget name="common:widget/footer/footer.tpl" footerType="bbsdetail"%}
{%require name='bbs:page/detail.tpl'%}{%/block%}
