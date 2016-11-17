<div class="m-row m-footer-row" id="J_footer">
{%if !empty($footerType) && ($footerType == "bbsdetail")%}
{%if !empty($adInfo.m_adbanner) && $adInfo.m_adbanner.bbs_detail|count%}
<div class="m-bottom-spread">
{%foreach $adInfo.m_adbanner as $item%}
{%if !empty($item.adcode)%}
{%$item.adcode|escape:none%}
{%/if%}
{%/foreach%}
</div>
{%/if%}
{%if !empty($bottomList)%}
<div class="bottom_nav">
{%foreach $bottomList as $key => $item%}
<a href="{%$item.url|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_forumtag_{%$key|f_escape_xml%}">
{%if $item.title == '湿乎乎的话题'%}
湿乎乎{%else%}
{%$item.title|f_escape_xml%}
{%/if%}
</a>
{%/foreach%}
</div>
{%/if%}
<footer class="m-footer">
<div class="footer-note">
<div class="footer-login">
<div class="user-wrap">
{%if !empty($username) %}
<a href="/my" dace-node="{%$id4dace|f_escape_xml%}_bottom_user">{%$username|truncate:13|f_escape_xml%}</a>
{%else%}
<a href="{%$loginurl|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_bottom_login">登录</a>
{%/if%}
</div>
</div>
<div class="detail-links">
<a href="{%$baseurl|f_escape_xml%}">首页</a>
</div>
</div>
<div class="player-famous">
{%$footerword.word|f_escape_xml%}
<p>——{%$footerword.person|f_escape_xml%}</p>
</div>
<div class="sites-block">
<div class="sites">
<a href="{%$pclink|f_escape_xml%}" id="J_pc_link" dace-node="{%$id4dace|f_escape_xml%}_pc">电脑版</a>
<a href="http://mobile.hupu.com/download/games/?_r=mwap" class="download-btn">虎扑体育App<i class="icon-download"></i></a>
</div>
<p class="copyright">
&copy;{%$smarty.now|date_format:"%Y"%}&nbsp;虎扑体育 hupu.com 沪ICP备05037078号-13</p>
</div>
</footer>
{%elseif !empty($footerType) && ($footerType =="index")%}
{%if !empty($adInfo.m_adbanner) && $adInfo.m_adbanner|count%}
<div class="m-bottom-spread">
{%foreach $adInfo.m_adbanner as $item%}
{%if !empty($item.adcode)%}
{%$item.adcode|escape:none%}
{%/if%}
{%/foreach%}
</div>
{%/if%}
<footer class="m-footer">
<div class="footer-note">
<div class="footer-login">
<div class="user-wrap">
{%if !empty($username) %}
<a href="/my" dace-node="{%$id4dace|f_escape_xml%}_bottom_user">{%$username|f_escape_xml%}</a>
{%else%}
<a href="{%$loginurl|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_bottom_login">登录</a>
{%/if%}
</div>
</div>
<div class="footer-links">
<a href="{%$baseurl|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_bottom_1000" class="index-link">首页</a>
<a href="{%$baseurl|f_escape_xml%}/nba" dace-node="{%$id4dace|f_escape_xml%}_bottom_2100" class="index-link">NBA</a>
<a href="{%$baseurl|f_escape_xml%}/cba/news" dace-node="{%$id4dace|f_escape_xml%}_bottom_2200" class="index-link">CBA</a>
<a href="{%$baseurl|f_escape_xml%}/soccer" dace-node="{%$id4dace|f_escape_xml%}_bottom_3000" class="index-link">足球</a>
</div>
</div>
<div class="player-famous">
{%$footerword.word|f_escape_xml%}
<p>——{%$footerword.person|f_escape_xml%}</p>
</div>
<div class="sites-block">
<div class="sites">
<a href="{%$pclink|f_escape_xml%}" id="J_pc_link" dace-node="{%$id4dace|f_escape_xml%}_pc">电脑版</a>
<a href="http://mobile.hupu.com/download/games/?_r=mwap" dace-node="{%$id4dace|f_escape_xml%}_download_bottom">虎扑体育客户端<i class="icon-download"></i></a>
</div>
<p class="copyright">
&copy;{%$smarty.now|date_format:"%Y"%}&nbsp;虎扑体育 hupu.com 沪ICP备05037078号-13</p>
</div>
</footer>
{%elseif !empty($footerType) && ($footerType =="bbs")%}
{%if !empty($adInfo.m_adbanner) && $adInfo.m_adbanner|count%}
<div class="m-bottom-spread">
{%foreach $adInfo.m_adbanner as $item%}
{%if !empty($item.adcode)%}
{%$item.adcode|escape:none%}
{%/if%}
{%/foreach%}
</div>
{%/if%}
<footer class="m-footer">
<div class="footer-note">
<div class="footer-login">
<div class="user-wrap" dace-node="{%$id4dace|f_escape_xml%}_my">
{%if !empty($username) %}
<a href="/my">{%$username|f_escape_xml%}</a>
{%else%}
<a href="{%$loginurl|f_escape_xml%}">登录</a>
{%/if%}
</div>
</div>
<div class="footer-links">
<a href="{%$baseurl|f_escape_xml%}/bbs/allnav" dace-node="{%$id4dace|f_escape_xml%}_5052_bottom" class="bbs-link">切换版块</a>
<a href="{%$baseurl|f_escape_xml%}/bbs/searchthreads" dace-node="{%$id4dace|f_escape_xml%}_5056_bottom" class="bbs-link">论坛搜索</a>
</div>
</div>
<div class="player-famous">
{%$footerword.word|f_escape_xml%}
<p>——{%$footerword.person|f_escape_xml%}</p>
</div>
<div class="sites-block">
<div class="sites">
<a href="{%$pclink|f_escape_xml%}" id="J_pc_link" dace-node="{%$id4dace|f_escape_xml%}_pc">电脑版</a>
<a href="http://mobile.hupu.com/download/games/?_r=mwap" dace-node="{%$id4dace|f_escape_xml%}_download_bottom">虎扑体育App<i class="icon-download"></i></a>
</div>
<p class="copyright">
&copy;{%$smarty.now|date_format:"%Y"%}&nbsp;虎扑体育 hupu.com 沪ICP备05037078号-13</p>
</div>
</footer>
{%elseif !empty($footerType) && ($footerType =="home")%}
{%if !empty($adInfo.m_adbanner.m_home) && $adInfo.m_adbanner.m_home|count %}
<div class="m-bottom-spread">
{%foreach $adInfo.m_adbanner as $item%}
{%if !empty($item.adcode)%}
{%$item.adcode|escape:none%}
{%/if%}
{%/foreach%}
</div>
{%/if%}
<footer class="m-footer">
<div class="footer-note">
<div class="footer-login">
<div class="user-wrap">
{%if !empty($username) %}
<a href="/my" dace-node="{%$id4dace|f_escape_xml%}_bottom_user">{%$username|f_escape_xml%}</a>
{%else%}
<a href="{%$loginurl|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_bottom_login">登录</a>
{%/if%}
</div>
</div>
<div class="footer-links">
<a href="{%$baseurl|f_escape_xml%}/bbs/12832799.html" dace-node="{%$id4dace|f_escape_xml%}_bottom_connect" class="feedback"><i class="icon-feedback"></i>意见反馈</a>
</div>
</div>
<div class="player-famous">
{%$footerword.word|f_escape_xml%}
<p>——{%$footerword.person|f_escape_xml%}</p>
</div>
<div class="sites-block">
<div class="sites">
<a href="{%$pclink|f_escape_xml%}" id="J_pc_link" dace-node="{%$id4dace|f_escape_xml%}_pc">电脑版</a>
<a href="http://mobile.hupu.com/download/games/?_r=mwap" dace-node="{%$id4dace|f_escape_xml%}_download_bottom">虎扑体育App<i class="icon-download"></i></a>
</div>
<p class="copyright">
&copy;{%$smarty.now|date_format:"%Y"%}&nbsp;虎扑体育 hupu.com 沪ICP备05037078号-13</p>
</div>
</footer>
{%elseif !empty($footerType) && ($footerType =="newsdetail")%}
{%if !empty($adInfo.m_adbanner) && $adInfo.m_adbanner.news_detail|count%}
<div class="m-bottom-spread">
{%foreach $adInfo.m_adbanner as $item%}
{%if !empty($item.adcode)%}
{%$item.adcode|escape:none%}
{%/if%}
{%/foreach%}
</div>
{%/if%}
{%if !empty($bottomList)%}
<div class="bottom_nav">
{%foreach $bottomList as $key => $item%}
<a href="{%$item.url|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_forumtag_{%$key|f_escape_xml%}">{%$item.title|f_escape_xml%}</a>
{%/foreach%}
</div>
{%/if%}
<footer class="m-footer">
<div class="footer-note">
<div class="footer-login">
<div class="user-wrap">
{%if !empty($username) %}
<a href="/my" dace-node="{%$id4dace|f_escape_xml%}_bottom_user">{%$username|f_escape_xml%}</a>
{%else%}
<a href="{%$loginurl|f_escape_xml%}" dace-node="{%$id4dace|f_escape_xml%}_bottom_login">登录</a>
{%/if%}
</div>
</div>
<div class="detail-links">
<a href="{%$baseurl|f_escape_xml%}">首页</a>
</div>
</div>
<div class="player-famous">
{%$footerword.word|f_escape_xml%}
<p>——{%$footerword.person|f_escape_xml%}</p>
</div>
<div class="sites-block">
<div class="sites">
<a href="{%$pclink|f_escape_xml%}" id="J_pc_link" dace-node="{%$id4dace|f_escape_xml%}_pc">电脑版</a>
<a href="http://mobile.hupu.com/download/games/?_r=mwap" class="download-btn">虎扑体育App<i class="icon-download"></i></a>
</div>
<p class="copyright">
&copy;{%$smarty.now|date_format:"%Y"%}&nbsp;虎扑体育 hupu.com 沪ICP备05037078号-13</p>
</div>
</footer>
{%else%}
<footer></footer>
{%/if%}
{%if empty($smarty.cookies.__closeapp)
        && !empty($smarty.server.HTTP_USER_AGENT)
        && !$smarty.server.HTTP_USER_AGENT|strpos:"kanqiu"%}
{%if !empty($adInfo.m_adapp.hupusports.adurl)%}
<div class="m-app-info m-footer-fixed">
<div class="m-footer-fixed-close" dace-node="{%$id4dace|f_escape_xml%}_download_bottom_close"><span class="xl"></span><span class="xr"></span></div>
<div class="m-app-download">
<a dace-node="{%$id4dace|f_escape_xml%}_download_bottom" href="{%$adInfo.m_adapp.hupusports.adurl|f_escape_xml%}"><img src="{%$adInfo.m_adapp.hupusports.pic|f_escape_xml%}" alt="" /></a>
</div>
</div>
{%/if%}
{%/if%}
</div>
{%script%}
    $("#J_pc_link").on("click", function(e){
        if (document.cookie.indexOf("__nmj")  == -1) {
            var exp = new Date();
            exp.setTime(exp.getTime() + 30*24*60*60*1000);
            document.cookie = "__nmj=1; path=/;domain=.hupu.com;expires=" + exp.toGMTString();
        };
        window.location.href = '{%$pclink|f_escape_js%}';
    });

    $(".m-footer-fixed-close").on("click", function(e){
        var exp = new Date();
        exp.setTime(exp.getTime() + 2*60*60*1000);
        document.cookie = "__closeapp=1; path=/;domain=.hupu.com;expires=" + exp.toGMTString();
        $(".m-footer-fixed").remove();
        $(".m-footer").css("margin-bottom", "0");
    });

    if($(".m-footer-fixed")){
        $(".m-footer").css("margin-bottom", $(".m-footer-fixed").height());
    }

    // 用户第一次访问
    if ($('.m-footer-fixed').length && document.cookie.indexOf("__fixeduserfirst") == -1) {
        var exp = new Date();
        exp.setTime(exp.getTime() + 1*60*60*1000);
        document.cookie = "__fixeduserfirst=1; path=/;domain=.hupu.com;expires=" + exp.toGMTString();
    }
{%/script%}
