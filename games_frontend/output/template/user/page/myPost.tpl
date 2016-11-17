{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}
{%if $result.puid == $result.author_puid%}我的{%/if%}论坛发帖{%/block%}
{%block name="head_static"%}
<script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
<script type="text/javascript">
        window.GM = {
            "page": 2,
            "client": "{%$client|f_escape_js%}" || "x",
            "projectId":"{%$projectId|f_escape_js%}"||"null",
            "version":"{%$version|f_escape_js%}"||"7.0.5.0",
            "night":!!parseInt("{%$night|f_escape_js%}", 10),
            "nopic":!!parseInt("{%$nopic|f_escape_js%}", 10),
            "puid":parseInt("{%$result.author_puid|f_escape_js%}", 10),
            "nextPage": "{%$result.nextPage|f_escape_js%}" || 0
        };
    </script>
{%require name="common:static/js/underscore/underscore.js"%}
{%require name="common:static/js/zepto/zepto.js"%}
{%require name="user:static/myPost/myPost.scss"%}
{%require name="common:static/js/fastclick/fastclick.js"%}
{%require name="user:static/myPost/myPost.js"%}
{%/block%}
{%block name="content"%}
{%if empty($result.list) && $result.all_count == 0%}
<div class="reply-empty">
{%if $result.puid == $result.author_puid%}
你{%elseif $result.puid == 0%}
TA{%else%}
TA{%/if%}
还没有发表过帖子哦</div>
{%else%}
<section class="my-post-wrap">
<ul class="post-inner" id="J_content">
{%foreach from=$result.list item=val name=key%}
<li class="post-list" data-jump="kanqiu://bbs/topic/{%$val.tid|f_escape_xml%}">
<h3>{%$val.title|f_escape_xml%}</h3>
<div class="post-info">
<div class="left-info">
<div class="post-time">{%$val.time|f_escape_xml%}</div>
<div class="thread-board">
<a href="kanqiu://bbs/board/{%$val.forum.fid|f_escape_path%}">{%$val.forum.name|f_escape_xml%}</a>
</div>
</div>
<div class="right-info">
{%if $val.lights !== 0%}
<div class="thread-lights">
<i class="icon-light"></i>
{%$val.lights|f_escape_xml%}
</div>
{%/if%}
<div class="thread-comment">
<i class="icon-comment"></i>
{%$val.replies|f_escape_xml%}
</div>
</div>
</div>
</li>
{%/foreach%}
</ul>
{%if $result.nextPage != 'true'%}
<div class="has-more-reply"><p>由于权限限制，部分帖子可能被隐藏</p></div>
{%/if%}
<script type="text/template" id="J-post-tpl">
            <@ _.each(datas, function(item,index) { @>
            <li class="post-list" data-jump="kanqiu://bbs/topic/<@=item.tid@>">
                <h3><@=item.title@></h3>
                <div class="post-info">
                    <div class="left-info">
                        <div class="post-time"><@=item.time@></div>
                        <div class="thread-board">
                            <a href="kanqiu://bbs/board/{%$val.forum.fid|f_escape_js%}"><@=item.forum.name@></a>
                        </div>
                    </div>
                    <div class="right-info">
                        <@ if (item.lights != 0) { @>
                            <div class="thread-lights">
                                <i class="icon-light"></i>
                                <@=item.lights@>
                            </div>
                        <@ } @>
                        <div class="thread-comment">
                            <i class="icon-comment"></i>
                            <@=item.replies@>
                        </div>
                    </div>
                </div>
            </li>
            <@ }); @>
        </script>
</section>
{%/if%}
{%require name='user:page/myPost.tpl'%}{%/block%}
