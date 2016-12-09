
<nav class="ui-inner-tab" id="J_innerTab">
	<ul class="ui-inner-tab-list">
		{%foreach from=$data item=val key=keys%}
			{%$isSelected = (($val@index+1) == $selected) || ($val.name == $selected)%}
    	<li {%if $isSelected%}class="active"{%/if%} data-sid={%$val.sid%}>
				<a href="{%$val.url%}">{%$val.sname%}</a>
			</li>
    {%/foreach%}
	</ul>
  <a class="lrw-login" id="J-login-btn">登录</a>
</nav>
