
<div class="player-content"> 
{%$status = 0%}
{%foreach $data as $item%}
    {%if $item.id == $predict_data_id%}
        {%$status = 1%}
    {%/if%}
{%/foreach%}
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
                {%$item.name%}
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
                " data-name="<@=item.nickname@>" data-id="<@=item.id@>">压冠
                <span class="number">{%$item.predict_champion_num%}</span>
            </a>        
        </div>
    </div>    
{%/foreach%}    
</div> 
