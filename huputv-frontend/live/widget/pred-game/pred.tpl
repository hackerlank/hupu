
{%if !empty($predict)%}
    <div id="J_predGame">
        <div class="pred-game" data-id="{%$predict.id%}" data-score="{%$predict.score%}" data-rate="{%$user.magnification%}">
            <div class="pred-left" style="width: {%$predict.total_score_1_percente%}%">
                {%if $predict.status == 0%}
                    {%if $predict.user_option == 0%}
                        <a href="javascript:" class="button-pred J_buttonPred">攒<br />人品</a>
                    {%elseif $predict.user_option == 1%}
                        <span class="button-pred pred-selected">已选</span>
                    {%else%}
                        <span class="button-pred">攒<br />人品</span>
                    {%/if%}
                {%else%}
                    {%if $predict.user_option == 1%}
                        <span class="button-pred pred-selected">已选</span>
                    {%else%}
                        <span class="button-pred pred-disable">攒<br />人品</span>
                    {%/if%}
                {%/if%}
                <div class="progress-bar-inner">
                    <div class="team-name">
                        {%$predict.option1%}
                    </div>
                    <div class="progress-bar">
                        <div class="progress-bar-bd"></div>
                    </div>
                    <div class="number">{%$predict.total_score_1%}</div>
                </div>
            </div>
            <div class="pred-right" style="width: {%$predict.total_score_2_percente%}%">
                <div class="progress-bar-inner">
                    <div class="team-name">
                        {%$predict.option2%}
                    </div>
                    <div class="progress-bar">
                        <div class="progress-bar-bd"></div>
                    </div>
                    <div class="number">{%$predict.total_score_2%}</div>
                </div>
                {%if $predict.status == 0%}
                    {%if $predict.user_option == 0%}
                        <a href="javascript:" class="button-pred J_buttonPred">攒<br />人品</a>
                    {%elseif $predict.user_option == 2%}
                        <span class="button-pred pred-selected">已选</span>
                    {%else%}
                        <span class="button-pred">攒<br />人品</span>
                    {%/if%}
                {%else%}
                    {%if $predict.user_option == 2%}
                        <span class="button-pred pred-selected">已选</span>
                    {%else%}
                        <span class="button-pred pred-disable">攒<br />人品</span>
                    {%/if%}
                {%/if%}
            </div>
            {%if $predict.status == 0%}
                <div class="game-text-tips">进行中</div>
            {%elseif $predict.status == 1%}
                <div class="game-text-tips">待开奖</div>
            {%elseif $predict.status == 2%}
                <div class="game-text-tips">已开奖</div>
            {%else%}
                <div class="game-text-tips">已流盘</div>
            {%/if%}
        </div>
    </div>
{%else%}
    <div id="J_predGame"></div>
{%/if%}

<script id="pred-tpl" type="javascript/template">
    <div class="pred-game" data-id="<@=data.id@>" data-score="<@=data.score@>">
        <div class="pred-left" style="width: <@=data.total_score_1_percente@>%">

            <@ if (data.status == 0){ @>
                <@ if(data.user_option == 0){ @>
                    <a href="javascript:" class="button-pred J_buttonPred">攒<br />人品</a>
                <@ }else if(data.user_option == 1) { @>
                    <span class="button-pred pred-selected">已选</span>
                <@ }else{ @>
                    <@if(data.user_option == 2){@>
                        <span class="button-pred pred-disable">攒<br />人品</span>
                    <@}else{@>
                        <span class="button-pred">攒<br />人品</span>
                    <@}@>
                <@ } @>
            <@ }else{ @>
                <@ if(data.user_option == 1){ @>
                    <span class="button-pred pred-selected">已选</span>
                <@ }else{ @>
                    <span class="button-pred pred-disable">攒<br />人品</span>
                <@ } @>
            <@ } @>
            <div class="progress-bar-inner">
                <div class="team-name">
                    <@=data.option1@>
                </div>
                <div class="progress-bar">
                    <div class="progress-bar-bd"></div>
                </div>
                <div class="number"><@=data.total_score_1@></div>
            </div>
        </div>
        <div class="pred-right" style="width: <@=data.total_score_2_percente@>%">
            <div class="progress-bar-inner">
                <div class="team-name">
                    <@=data.option2@>
                </div>
                <div class="progress-bar">
                    <div class="progress-bar-bd"></div>
                </div>
                <div class="number"><@=data.total_score_2@></div>
            </div>

            <@ if (data.status == 0){ @>
                <@ if(data.user_option == 0){ @>
                    <a href="javascript:" class="button-pred J_buttonPred">攒<br />人品</a>
                <@ }else if(data.user_option == 2) { @>
                    <span class="button-pred pred-selected">已选</span>
                <@ }else{ @>
                    <@if(data.user_option == 1){@>
                        <span class="button-pred pred-disable">攒<br />人品</span>
                    <@}else{@>
                        <span class="button-pred">攒<br />人品</span>
                    <@}@>
                <@ } @>
            <@ }else{ @>
                <@ if(data.user_option == 2){ @>
                    <span class="button-pred pred-selected">已选</span>
                <@ }else{ @>
                    <span class="button-pred pred-disable">攒<br />人品</span>
                <@ } @>
            <@ } @>

        </div>
        <@ if(data.status == 0){ @>
            <div class="game-text-tips">进行中</div>
        <@ }else if(data.status == 1){ @>
            <div class="game-text-tips">待开奖</div>
        <@ }else if(data.status == 2){ @>
            <div class="game-text-tips">已开奖</div>
        <@ }else{ @>
            <div class="game-text-tips">已流盘</div>
        <@ } @>
    </div>
</script>
{%script%}
var PredGame = require("live:widget/pred-game/pred");
PredGame.init();
{%/script%}
