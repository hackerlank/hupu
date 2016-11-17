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
            <a href="{%$item.url%}" dace-node="{%$id4dace%}_forumtag_{%$key%}">
                {%if $item.title == '湿乎乎的话题'%}
                    湿乎乎
                {%else%}
                    {%$item.title%}
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
                            <a href="/my" dace-node="{%$id4dace%}_bottom_user">{%$username|truncate:13%}</a>
                        {%else%}
                            <a href="{%$loginurl%}" dace-node="{%$id4dace%}_bottom_login">登录</a>
                        {%/if%}
                    </div>
                </div>
                <div class="detail-links">
                    <a href="{%$baseurl%}">首页</a>
                </div>
            </div>
            <div class="player-famous">
                {%$footerword.word%}
                <p>——{%$footerword.person%}</p>
            </div>
            <div class="sites-block">
                <div class="sites">
                    <a href="{%$pclink%}" id="J_pc_link" dace-node="{%$id4dace%}_pc">电脑版</a>
                    <a href="http://mobile.hupu.com/download/games/?_r=mwap" class="download-btn">虎扑体育App<i class="icon-download"></i></a>
                </div>
                <p class="copyright">
                    &copy; {%$smarty.now|date_format:"%Y"%}&nbsp;虎扑体育 hupu.com 沪ICP备05037078号-13
                </p>
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
                            <a href="/my" dace-node="{%$id4dace%}_bottom_user">{%$username%}</a>
                        {%else%}
                            <a href="{%$loginurl%}" dace-node="{%$id4dace%}_bottom_login">登录</a>
                        {%/if%}
                    </div>
                </div>
                <div class="footer-links">
                    <a href="{%$baseurl%}" dace-node="{%$id4dace%}_bottom_1000" class="index-link">首页</a>
                    <a href="{%$baseurl%}/nba" dace-node="{%$id4dace%}_bottom_2100" class="index-link">NBA</a>
                    <a href="{%$baseurl%}/cba/news" dace-node="{%$id4dace%}_bottom_2200" class="index-link">CBA</a>
                    <a href="{%$baseurl%}/soccer" dace-node="{%$id4dace%}_bottom_3000" class="index-link">足球</a>
                </div>
            </div>
            <div class="player-famous">
                {%$footerword.word%}
                <p>——{%$footerword.person%}</p>
            </div>
            <div class="sites-block">
                <div class="sites">
                    <a href="{%$pclink%}" id="J_pc_link" dace-node="{%$id4dace%}_pc">电脑版</a>
                    <a href="http://mobile.hupu.com/download/games/?_r=mwap" dace-node="{%$id4dace%}_download_bottom">虎扑体育客户端<i class="icon-download"></i></a>
                </div>
                <p class="copyright">
                    &copy; {%$smarty.now|date_format:"%Y"%}&nbsp;虎扑体育 hupu.com 沪ICP备05037078号-13
                </p>
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
                    <div class="user-wrap" dace-node="{%$id4dace%}_my">
                        {%if !empty($username) %}
                            <a href="/my">{%$username%}</a>
                        {%else%}
                            <a href="{%$loginurl%}">登录</a>
                        {%/if%}
                    </div>
                </div>
                <div class="footer-links">
                    <a href="{%$baseurl%}/bbs/allnav" dace-node="{%$id4dace%}_5052_bottom" class="bbs-link">切换版块</a>
                    <a href="{%$baseurl%}/bbs/searchthreads" dace-node="{%$id4dace%}_5056_bottom" class="bbs-link">论坛搜索</a>
                </div>
            </div>
            <div class="player-famous">
                {%$footerword.word%}
                <p>——{%$footerword.person%}</p>
            </div>
            <div class="sites-block">
                <div class="sites">
                    <a href="{%$pclink%}" id="J_pc_link" dace-node="{%$id4dace%}_pc">电脑版</a>
                    <a href="http://mobile.hupu.com/download/games/?_r=mwap" dace-node="{%$id4dace%}_download_bottom">虎扑体育App<i class="icon-download"></i></a>
                </div>
                <p class="copyright">
                    &copy; {%$smarty.now|date_format:"%Y"%}&nbsp;虎扑体育 hupu.com 沪ICP备05037078号-13
                </p>
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
                            <a href="/my" dace-node="{%$id4dace%}_bottom_user">{%$username%}</a>
                        {%else%}
                            <a href="{%$loginurl%}" dace-node="{%$id4dace%}_bottom_login">登录</a>
                        {%/if%}
                    </div>
                </div>
                <div class="footer-links">
                    <a href="{%$baseurl%}/bbs/12832799.html" dace-node="{%$id4dace%}_bottom_connect" class="feedback"><i class="icon-feedback"></i>意见反馈</a>
                </div>
            </div>
            <div class="player-famous">
                {%$footerword.word%}
                <p>——{%$footerword.person%}</p>
            </div>
            <div class="sites-block">
                <div class="sites">
                    <a href="{%$pclink%}" id="J_pc_link" dace-node="{%$id4dace%}_pc">电脑版</a>
                    <a href="http://mobile.hupu.com/download/games/?_r=mwap" dace-node="{%$id4dace%}_download_bottom">虎扑体育App<i class="icon-download"></i></a>
                </div>
                <p class="copyright">
                    &copy; {%$smarty.now|date_format:"%Y"%}&nbsp;虎扑体育 hupu.com 沪ICP备05037078号-13
                </p>
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
            <a href="{%$item.url%}" dace-node="{%$id4dace%}_forumtag_{%$key%}">{%$item.title%}</a>
            {%/foreach%}
        </div>
        {%/if%}
        <footer class="m-footer">
            <div class="footer-note">
                <div class="footer-login">
                    <div class="user-wrap">
                        {%if !empty($username) %}
                            <a href="/my" dace-node="{%$id4dace%}_bottom_user">{%$username%}</a>
                        {%else%}
                            <a href="{%$loginurl%}" dace-node="{%$id4dace%}_bottom_login">登录</a>
                        {%/if%}
                    </div>
                </div>
                <div class="detail-links">
                    <a href="{%$baseurl%}">首页</a>
                </div>
            </div>
            <div class="player-famous">
                {%$footerword.word%}
                <p>——{%$footerword.person%}</p>
            </div>
            <div class="sites-block">
                <div class="sites">
                    <a href="{%$pclink%}" id="J_pc_link" dace-node="{%$id4dace%}_pc">电脑版</a>
                    <a href="http://mobile.hupu.com/download/games/?_r=mwap" class="download-btn">虎扑体育App<i class="icon-download"></i></a>
                </div>
                <p class="copyright">
                    &copy; {%$smarty.now|date_format:"%Y"%}&nbsp;虎扑体育 hupu.com 沪ICP备05037078号-13
                </p>

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
            <div class="m-footer-fixed-close" dace-node="{%$id4dace%}_download_bottom_close">×</div>
            <div class="m-app-download">
                <a dace-node="{%$id4dace%}_download_bottom" href="{%$adInfo.m_adapp.hupusports.adurl%}"><img src="{%$adInfo.m_adapp.hupusports.pic%}" alt="" /></a>
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
        window.location.href = '{%$pclink%}';
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
