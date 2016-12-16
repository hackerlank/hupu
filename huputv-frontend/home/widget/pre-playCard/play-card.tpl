
<div class="player-content"> 
{%$status = 0%}
{%foreach $data as $item%}
    {%if $item.id == $predict_data_id%}
        {%$status = 1%}
    {%/if%}
{%/foreach%}
{%if !empty($data)%}
    {%foreach $data as $item%}     
       
        <div class="player-card-list">
            <div class="player-card-inner">
                <div class="avatar">
                    <img src="{%$item.header%}" alt="" />
                    <i class="player-number">{%$item@index+1%}</i>
                    <i class="player-group">
                        {%$item.group_name%}
                    </i>
                </div>
                <div class="name">
                    {%$item.nickname%}
                </div>
                <div class="weight">
                    {%$item.height%}cm | {%$item.weight%}kg
                </div>
                <div class="wins">
                    {%if $item.total_game %} 
                        胜{%$item.total_win%}&nbsp;负{%$item.total_game-$item.total_win%}&nbsp;({%$item.rate%}%)
                    {%else%}
                        新晋球员
                    {%/if%}
                </div>                       
            </div>
            <div class="operat-inner">
                <a href="javascript:" class="
                    {%if $predict_data_id == $item.id %}
                        operat-has-support 
                    {%else if $status == 0 %}
                        button-support J_buttonSupport 
                    {%else%}
                        disable
                    {%/if%}
                    " data-name="{%$item.nickname%}" data-id="{%$item.id%}">压冠
                    <span class="number">{%$item.predict_champion_num%}</span>
                </a>        
            </div>
        </div>    
    {%/foreach%}
{%else%}    
    <div class="no-player">
       {%if $game_status == 1%}
            <p>参赛球员还在报名的路上，欢迎加入虎扑路人王官方报名QQ群：300507990</p>
        {%else if $game_status == 2%}
            <p>报名已结束，请耐心等待抽签结果...</p>
        {%else if $game_status == 4%}
            <p>抽签已结束，工作人员正在努力的确认每一个参赛者信息，即将公布名单，敬请期待...</p>        
        {%/if%}       
    </div>
{%/if%}
</div> 
