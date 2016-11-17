<script id="J_predictNotice" type="text/template">
    <div class="prediction-tips" id="J_preTips" section-exposure="{%$id4dace|f_escape_js%}_showmsg">
        <a href="<@=url@>{%$urlParam|f_escape_js%}">您有新的预测结果，点击查看</a>
    </div>
</script>
{%script%}
    var predictionTips = require("common:widget/prediction-tips/prediction-tips.js");
    
    predictionTips.init();
{%/script%}