<nav class="m-top-title-nav {%if !empty($titleCenter)%}m-top-title-left{%/if%}">
    <div class="top-nav-left">
    	{%if !empty($node[0].url) %}
            <a href="{%$node[0].url|escape:none%}" class="button-returnList"></a>
    	{%else%}
    	    <a href="javascript:" onclick="history.go(-1);" class="button-returnList"></a>
    	{%/if%}
    </div>
    <div class="top-title">
        <h2>{%$banner%}</h2>
    </div>
    {%if $banner == "我的消息"%}
    <span class="ignore-all" id="J_buttonIgnoreAll">全部忽略</span>
    {%/if%}
    {%if isset($right)%}
        {%$right|escape:none%}
    {%/if%}
</nav>
