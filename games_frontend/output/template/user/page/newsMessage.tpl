{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}
{%if !empty($title)%}
{%$title|f_escape_xml%}
{%else%}
我的新闻消息{%/if%}
{%/block%}
{%block name="head_static"%}
<script type="text/javascript" src="//b3.hoopchina.com.cn/games/js/hpbridge_v1.0.1.js"></script>
<script type="text/javascript">
    window.GM = {
        "page": 2,
        "msgid": "{%$result.data[count($result.data)-1].id%}" || 0,
        "client": "{%$client|f_escape_js%}" || "x",
        "projectId":"{%$projectId|f_escape_js%}"||"null",
        "version":"{%$version|f_escape_js%}"||"7.0.10",
        "title":"{%$title|f_escape_js%}",
        "night":!!parseInt("{%$night|f_escape_js%}", 10),
        "nopic":!!parseInt("{%$nopic|f_escape_js%}", 10),
        "token": "{%$token|f_escape_js%}",
        "nextPage": "{%$result.hasNextPage|f_escape_js%}" || 0
    };
    </script>
{%require name="common:static/js/underscore/underscore.js"%}
{%require name="common:static/js/zepto/zepto.js"%}
{%require name="common:static/js/fastclick/fastclick.js"%}{%require name="user:static/newsMessage/newsMessage.scss"%}
{%require name="user:static/newsMessage/newsMessage.js"%}
{%/block%}
{%block name="content"%}
{%if empty($result.data)%}
<div class="reply-empty">
您暂时还没有新闻消息</div>
{%else%}
<section class="my-reply-wrap">
<ul class="reply-inner" id="J_content">
{%foreach $result.data as $val%}
{%widget name="user:widget/newsMessage/newsMessage.tpl" val=$val key=$val@index%}
{%/foreach%}
</ul>
{%if $result.isNewMsg == true%}
{%if $result.hasNextPage == true%}
<div class="has-more-reply"><p>查看更多的消息</p></div>
{%else%}
<div class="has-more-reply-no"><p>没有更多新闻消息了</p></div>
{%/if%}
{%else%}
{%if $result.hasNextPage == true%}
<div class="has-more-reply"><p>查看更多的消息</p></div>
{%else%}
<div class="has-more-reply-no"><p>没有更多新闻消息了</p></div>
{%/if%}
{%/if%}
<script type="text/template" id="J_replyListTpl">        
        <@ _.each(datas, function($val,index) { @>
            
                {%widget name="user:widget/newsMessage/newsMessageJs.tpl"%}
            
        <@})@>
    </script>
</section>
{%/if%}
{%require name='user:page/newsMessage.tpl'%}{%/block%}
