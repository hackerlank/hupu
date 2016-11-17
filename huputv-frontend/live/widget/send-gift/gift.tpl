{%if !empty($datas)%}
    <div class="send-gift J_sendGift">
        <ul class="gift-list" id="J_sendGiftList" data-beans="{%$balance[1]%}" data-gold="{%$balance[6]%}">
            {%foreach from=$datas item=val key=keys%}
                <li data-id="{%$val.id%}">
                    <div class="gift-pic {%if empty($val.multi_send)%}J_giftButton{%/if%}">
                        <img src="{%$val.cover_url%}" alt=""/>
                    </div>
                    <div class="gift-tips {%if !empty($val.multi_send) && $val.multi_send == 1%}send-gift-tips{%/if%}">
                        <div class="pic">
                            {%if !empty($val.money_type) && $val.money_type == "1"%}
                                <div class="gift-icon-bg" style="background-image: url({%$val.effect_file_icon_url%})"></div>
                            {%else%}
                                <img src="{%$val.effect_file_gif_url%}" alt="{%$val.name%}"/>
                            {%/if%}
                        </div>
                        <dl class="list">
                            <dd class="name">
                                {%$val.name%}
                            </dd>
                            <dd class="money">
                                {%if !empty($val.money_type) && $val.money_type == "1"%}
                                    <i class="icons icons-1"></i><span class="J_giftPrice" data-price="{%$val.price%}">{%$val.price%}</span>
                                    金豆
                                {%else%}
                                    <i class="icons icons-2"></i><span class="J_giftPrice" data-price="{%$val.price%}">{%$val.price%}</span>
                                    虎扑币
                                {%/if%}
                            </dd>
                            <dt class="about">{%$val.description%}</dt>
                        </dl>
                        {%if !empty($val.multi_send) && $val.multi_send == 1 && $gift.multi|@count > 1%}
                            <div class="batch-send-gift J_batchSendGift">
                                {%foreach from=$gift.multi item=val1 key=keys1%}
                                    <a href="javascript:">x{%$val1%}</a>
                                {%/foreach%}
                            </div>
                        {%/if%}
                    </div>
                </li>
            {%/foreach%}
        </ul>
        <div class="ui-success-toast" id="J_uiSuccessToast"></div>
    </div>
{%/if%}

{%script%}
var SendGift = require("live:widget/send-gift/gift");
SendGift.init();
{%/script%}