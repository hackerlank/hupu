{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%if $thread.fid=='112' || $thread.fid=='195'%}
<meta name='robots' content='noindex,nofollow'/>
{%/if%}
{%require name="bbs:static/comments/comments.css"%}
{%require name="bbs:static/comments/comments.js"%}
<script>
    	HPM.pageCount = "{%$pageCount|f_escape_js%}"
    	HPM.token = "{%$token|f_escape_js%}";
    	HPM.tid = "{%$thread.tid|f_escape_js%}";
        HPM.baseUrl = "{%$baseurl|f_escape_js%}";
        HPM.type = "{%$onlyauthor|f_escape_js%}";
        HPM.fid = "{%$thread.fid|f_escape_js%}";
        HPM.csrf = "{%$no_csrf_code|f_escape_js%}";
    </script>
{%script%}
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

        var toShare = require("common:widget/ui/share/share.js");
        //全局分享事件, 每个页面单独注册.
        $(document).on("page:share", function(){
            toShare({
                url: '{%$node[0].url|f_escape_js%}'
            });
        });

        //页面分享按钮
        $("#J_buttonShare").on("click", function(){
            $(document).trigger("page:share");
        });

        // 收藏
        var Star = require("bbs:widget/star/star.js");
        Star.init();

        //底部的刷新
        var tools = require("common:widget/ui/page-tools/page-tools.js");

        tools.initTools({
            reply : true,
            replyHandler: function(){
                $(document).trigger("page:reply");
            }
        });



    {%/script%}
{%/block%}
{%block name="content"%}
{%widget
        name="common:widget/inner-top-nav/nav.tpl"
        from="comments"
    %}
{%widget
        name="bbs:widget/detail-title/title.tpl"
        from="comments"
    %}
{%if !empty($replies) %}
{%widget
            name="bbs:widget/comments/comments.tpl"
            data=$replies
        %}
<div id="J-page" class="m-page m-row"></div>
{%else%}
<div class="comment-not-tips">暂无回复</div>
{%widget
            name="bbs:widget/reply/popup-reply.tpl"
        %}
{%/if%}
{%require name='bbs:page/comments.tpl'%}{%/block%}
