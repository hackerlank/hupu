<div class="w-user-nav">
<div class="user-info">
<div class="thumb">
<img src="{%$user.avatar.header_big|f_escape_xml%}" alt="">
</div>
{%if !empty($userPredictionInfo)%}
<div class="rpz-num {%if $userPredictionInfo.score < 0%}rpz-num-green{%/if%}">人品值&nbsp;{%$userPredictionInfo.score|f_escape_xml%}</div>
<div class="rpz-info">
<div class="rpz-detail">
连胜<span>{%$userPredictionInfo.win|f_escape_xml%}</span>场<em>(x{%$userPredictionInfo.magnification|f_escape_xml%})</em>
今日{%if $userPredictionInfo.today_win_score|string_format:'%d' >= 0%}
<span class="win">+{%$userPredictionInfo.today_win_score|f_escape_xml%}</span>
{%else%}
<span class="lose">{%$userPredictionInfo.today_win_score|f_escape_xml%}</span>
{%/if%}
</div>
{%** <div class="rpz-rank">
                    日排行{%$userPredictionInfo.day_rank|f_escape_xml%}，月排行{%$userPredictionInfo.month_rank|f_escape_xml%}
                </div> **%}
{%if $userPredictionInfo.month_rank <= 1000 && $userPredictionInfo.month_rank != 0%}
<div class="rpz-rank">你当前排名{%$userPredictionInfo.month_rank|f_escape_xml%}</div>
{%else if $userPredictionInfo.month_rank > 1000%}
<div class="rpz-rank">你已打败{%(100-$userPredictionInfo.month_rank*100/$userPredictionInfo.userCount)|string_format:"%d"%}% 的用户</div>
{%else $userPredictionInfo.month_rank == 0%}
<div class="rpz-rank">暂无排行</div>
{%/if%}
</div>
{%else%}
<div class="rpz-num {%if $user.score < 0%}rpz-num-green{%/if%}">人品值{%$user.score|f_escape_xml%}</div>
{%/if%}
</div>
<ul class="user-list">
<li class="{%if ($index == 1)%}active{%/if%}"><a href="/user/follow-list"><span>我的关注</span></a></li>
<li class="{%if ($index == 2)%}active{%/if%}"><a href="/user/wallet"><span>钱包</span></a></li>
<li class="{%if ($index == 3)%}active{%/if%}"><a href="/predict/user/info"><span>人品值</span></a></li>
</ul>
<div class="bottom-fn">
<a href="http://b.qq.com/webc.htm?new=0&sid=800021359&q=7" target="_blank" dace-node="{%$current_page|f_escape_xml%}_customService">客服支持</a>
<span>|</span>
<a href="http://voice.hupu.com/other/1997628.html" target="_blank" dace-node="{%$current_page|f_escape_xml%}_roomApply">申请成为主播</a>
</div>
</div>
