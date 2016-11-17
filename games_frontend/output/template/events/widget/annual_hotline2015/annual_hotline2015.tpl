<section class="hotline-wrap">
<div class="bd-content" id="J-bd-container">
<div class="bd" id="J-pager-hotline">
<ul class="list" id="J-hotline-container">
<script type="text/template" id="J-hotline-tpl">
                    <@if(msg_type && msg_type === 1){@>
                		<li class="clearfix">
                			<div class="fl">
                				<div class="dot"></div>
                				<div class="time"><@=date@></div>
                			</div>
                			<div class="fr">
                				<div class="name">-<@=username@></div>
                				<div class="content"><@=content@></div>
                			</div>
                		</li>
                    <@}@>
                    <@if(msg_type && msg_type === 2 && gift && gift.link_color){@>
                        <li class="clearfix gift" style="color:#<@=gift.link_color@>">
                            <div class="fl">
                                <div class="dot"></div>
                                <div class="time" style="border:1px solid #<@=gift.link_color@>"><@=date@></div>
                            </div>
                            <div class="fr">
                                <span><@=content@></span>
                            </div>
                        </li>
                    <@}@>
                </script>
</ul>
</div>
</div>
<div class="guess" id="J-gift-container">
<script type="text/template" id="J-gift-guess-tpl">
    	<div class="yes">
    		<div class="num"><@=top.count@></div>
    		<div class="text"><@=top.gift_name@></div>
    	</div>
    	<div class="no">
    		<div class="num"><@=bottom.count@></div>
    		<div class="text"><@=bottom.gift_name@></div>
    	</div>
        </script>
</div>
</section>
{%script%}
    var hotline = require("events:widget/annual_hotline2015/annual_hotline2015.js");
    hotline.init();
{%/script%}