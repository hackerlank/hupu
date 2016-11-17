<div class="mod-zan" id="J-zan-container">
{%if $type != "bbs" || count($users) >= 1%}
<div class="zan-author">
<a href="kanqiu://people/{%$author.uid|f_escape_path%}" dace-node="reward_writer">
<img src="{%$author.header|default:'//b1.hoopchina.com.cn/games/images/man.jpg'|f_escape_xml%}" class="user-icon J-user-avatar-img" />{%$author.nickname|default:'神秘球迷'|f_escape_xml%}
<span class="mod-mask mask"></span>
</a>
<span class="zan-tag">{%$callname|f_escape_xml%}</span>
</div>
{%/if%}
<span class="zan-btn J-zan" dace-node="reward_pay">赞赏{%$callname|f_escape_xml%}</span>
{%if !empty($users)%}
<br />
<div class="zan-list J-zanlist" dace-node="reward_people">
{%foreach $users as $index => $user%}
{%if $index < 3%}
<span class="zan-userimg">
<img src="{%$user.header|default:'//b1.hoopchina.com.cn/games/images/man.jpg'|f_escape_xml%}?{%$index|f_escape_path%}" alt="{%$user.nickname|f_escape_xml%}" class="user-icon J-user-avatar-img" />
<span class="mod-mask mask"></span>
</span>
{%/if%}
{%/foreach%}
<span class="J-zan-detail">已有<span class="zan-count">{%$userCount|f_escape_xml%}</span>个JRs赞赏了{%$goldCount|f_escape_xml%}虎扑币 &gt;</span>
</div>
{%/if%}
</div>
{%script%}
require("common:widget/mod-zan/mod-zan.js").init(
{
  type: "{%$type|f_escape_js%}",
  tips: "{%$tips|f_escape_js%}",
  nickname: "{%$author.nickname|f_escape_js%}",
  typeid: "{%$typeid|f_escape_js%}",
  fid: "{%$fid|f_escape_js%}",
  userCount: Math.max({%count($users)%}, parseInt("{%$userCount|f_escape_js%}", 10) || 0),
  goldCount: parseInt("{%$goldCount|f_escape_js%}", 10) || 0,
}, {%intval((count($users) >= 1))%});
{%/script%}
