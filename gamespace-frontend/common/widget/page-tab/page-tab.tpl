{%$pageTab = [
  [
    "link" => "{%$nav_link.home%}",
    "title" => "比赛中心"
  ],
  [
    "link" => "{%$nav_link.standing%}",
    "title" => "战绩排行"
  ],
  [
    "link" => "{%$nav_link.stats%}",
    "title" => "数据排名"
  ],
  [
    "link" => "{%$nav_link.schedule%}",
    "title" => "比赛赛程"
  ],
  [
    "link" => "{%$nav_link.team%}",
    "title" => "球队"
  ],
  [
    "link" => "{%$nav_link.player%}",
    "title" => "球员"
  ]
]%}
<div class="hp-threeNav">
    <div class="hp-threeNav-bd">
        <ul class="hp-threeNav-item">
            {%foreach $pageTab as $tab%}
              <li class="{%if $tab.title == $title|default:'比赛中心'%}on{%/if%}"><a href="{%$tab.link%}">{%$tab.title%}</a></li>
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
