<div class="live-recommend">
{%if !empty($datas) %}
<span class="arrow left-arrow" id="J_leftArrow"></span>
<div class="channel-block recommend">
<ul>
{%foreach from=$datas item=val key=keys%}
<li>
<a href="{%$val.abs_url|f_escape_xml%}" dace-node="{%$current_page|f_escape_xml%}_roomClick">
<div class="pic">
<img src="{%$val.cover|f_escape_xml%}" alt="" />
<div class="mask"><i class="icon-hptv-play-o"></i></div>
<em class="live">Live</em>
{%if !empty($val.rp)%}
<em class="rp">RP</em>
{%/if%}
</div>
<h3>{%$val.room_name|f_escape_xml%}</h3>
<div class="info">
<div class="name">主播：{%$val.anchor_nickname|f_escape_xml%}</div>
{%if !empty($show_online)%}
<div class="audience">
<i class="icon-audience"></i>{%$val.online|f_escape_xml%}
</div>
{%/if%}
</div>
</a>
</li>
{%/foreach%}
</ul>
</div>
<span class="arrow right-arrow" id="J_rightArrow"></span>
{%/if%}
</div>
{%script%}
    require("live:widget/live-recommend/recommend");
{%/script%}
