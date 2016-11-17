
{%if !empty($predict)%}
<div id="J_predGame">
<div class="pred-game" data-id="{%$predict.id|f_escape_xml%}" data-score="{%$predict.score|f_escape_xml%}" data-rate="{%$user.magnification|f_escape_xml%}">
<div class="pred-left" style="width: {%$predict.total_score_1_percente|f_escape_xml%}%">
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
{%$predict.option1|f_escape_xml%}
</div>
<div class="progress-bar">
<div class="progress-bar-bd"></div>
</div>
<div class="number">{%$predict.total_score_1|f_escape_xml%}</div>
</div>
</div>
<div class="pred-right" style="width: {%$predict.total_score_2_percente|f_escape_xml%}%">
<div class="progress-bar-inner">
<div class="team-name">
{%$predict.option2|f_escape_xml%}
</div>
<div class="progress-bar">
<div class="progress-bar-bd"></div>
</div>
<div class="number">{%$predict.total_score_2|f_escape_xml%}</div>
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
var PredGame = require("live:widget/pred-game/pred.es6");
PredGame.init();
{%/script%}
