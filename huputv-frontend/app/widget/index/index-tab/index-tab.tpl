
<nav class="ui-inner-tab" id="J_innerTab">
	<ul class="ui-inner-tab-list">
		{%foreach from=$data item=val key=keys%}
			{%$isSelected = (($val@index+1) == $selected) || ($val.name == $selected)%}
    		<li  class="J-catagory {%if $isSelected%}active{%/if%}" data-sid={%$val.sid%}>
				<a href="javascript:;">{%$val.sname%}</a>
			</li>
    {%/foreach%}
	</ul>
	<div class="login-wrap">
		{%if $login == 1%}	
			<div class="login-header-wrap">
		  		<a href="/m/my" class="login-header">
		  			<img src="{%$userInfo.avatar%}">
		  		</a>
		  	</div>
			<div class="mask"></div>
	  	{%else%}
	  		<div class="login-header-login">
	  			<a  href="javascript:;" class="lrw-login" id="J-login-btn">登录</a>
	  		</div>	
	  	{%/if%}
  	</div>
</nav>
