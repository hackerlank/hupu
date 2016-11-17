{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}
我推荐的帖子{%/block%}
{%block name="head_static"%}
<script type="text/javascript" src="//b3.hoopchina.com.cn/games/js/hpbridge_v1.0.1.js"></script>
{%require name="common:static/js/underscore/underscore.js"%}
{%require name="common:static/js/zepto/zepto.js"%}
{%require name="user:static/recommendPost/recommendPost.scss"%}
{%require name="user:static/recommendPost/recommendPost.js"%}
<script type="text/javascript">
        window.GM = {
            "page": 2,
            "client": "{%$client|f_escape_js%}" || "x",
            "projectId":"{%$projectId|f_escape_js%}"||"null",
            "version":"{%$version|f_escape_js%}"||"7.0.10",
            "night":!!parseInt("{%$night|f_escape_js%}", 10),
            "nopic":!!parseInt("{%$nopic|f_escape_js%}", 10),
            "puid":parseInt("{%$result.author_puid|f_escape_js%}", 10),
            "nextPage": "{%$result.nextPage|f_escape_js%}" || 0
        };
    </script>
{%/block%}
{%block name="content"%}
{%if empty($list) && $result.count == 0%}
<div class="reply-empty">
{%if $result.puid == $result.author_puid%}
你{%elseif $puid == 0%}
TA{%else%}
TA{%/if%}
还没有推荐过帖子哦{%$list[0].tid|f_escape_xml%}
</div>
{%else%}
<div class="rec-list">
<ul class="items-list" id="J_content">
{%foreach from=$list item=val name=key%}
<li data-jump="kanqiu://bbs/topic/{%$val.tid|f_escape_xml%}">
<p>{%$val.title|f_escape_xml%}</p>
<div class="items-infor">
<div class="items-addr">
<a href="kanqiu://bbs/board/{%$val.forum.fid|f_escape_path%}">{%$val.forum.name|f_escape_xml%}</a>
</div>
<div class="right-info">
{%if $val.lights !== 0%}
<div class="items-lamp"><i class="icon-light"></i>{%$val.lights|f_escape_xml%}</div>
{%/if%}
<div class="items-comment"><i class="icon-comment"></i>{%$val.replies|f_escape_xml%}</div>
</div>
</div>
</li>
{%/foreach%}
</ul>{%if $result.nextPage != 'true'%}
<div class="has-more-reply"><p>由于权限限制，部分帖子可能被隐藏</p></div>
{%/if%}
<script type="text/template" id="J-post-tpl">
        <@ _.each(datas, function(item,index) { @>
        <li data-jump="kanqiu://bbs/topic/<@=item.tid@>">
            <p><@=item.title@> </p>
            <div class="items-infor">
                <div class="items-addr">
                    <a href="kanqiu://bbs/board/<@=item.forum.fid@>"><@=item.forum.name@></a>
                </div>
                <div class="right-info">
                    <@ if (item.lights != 0) { @>
                        <div class="items-lamp"> <i class="icon-light"></i><@=item.lights@></div>
                    <@ } @>
                        <div class="items-comment"> <i class="icon-comment"></i><@=item.replies@></div>
                </div>
            </div>
        </li>
        <@ }); @>
        </script>
</div>
{%/if%}
{%require name='user:page/recommendPost.tpl'%}{%/block%}
