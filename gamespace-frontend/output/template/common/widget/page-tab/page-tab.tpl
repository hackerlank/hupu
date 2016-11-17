{%$pageTab = [
  [
    "link" => "{%$nav_link.home|f_escape_xml%}",
    "title" => "比赛中心"
  ],
  [
    "link" => "{%$nav_link.standing|f_escape_xml%}",
    "title" => "战绩排行"
  ],
  [
    "link" => "{%$nav_link.stats|f_escape_xml%}",
    "title" => "数据排名"
  ],
  [
    "link" => "{%$nav_link.schedule|f_escape_xml%}",
    "title" => "比赛赛程"
  ],
  [
    "link" => "{%$nav_link.team|f_escape_xml%}",
    "title" => "球队"
  ],
  [
    "link" => "{%$nav_link.player|f_escape_xml%}",
    "title" => "球员"
  ]
]%}
<div class="hp-threeNav">
<div class="hp-threeNav-bd">
<ul class="hp-threeNav-item">
{%foreach $pageTab as $tab%}
<li class="{%if $tab.title == $title|default:'比赛中心'%}on{%/if%}"><a href="{%$tab.link|f_escape_xml%}">{%$tab.title|f_escape_xml%}</a></li>
{%/foreach%}
</ul>
</div>
<div class="hp-search">
<form id="hp-form-search" method="get" enctype="multipart/form-data" action="//my.hoopchina.com/search">
<input type="text" value="搜索视频、帖子、碎碎念" class="it-search">
<input type="submit" value="搜索" class="btn-search">
</form>
<div id="hp-search-choose" class="hp-search-choose" style="display: none;"></div></div>
</div>
