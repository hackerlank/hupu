{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}战报{%/block%}
{%block name="head_static"%}
{%require name="common:static/js/zepto/zepto.js"%}
<script type="text/javascript" src="//w1.hoopchina.com.cn/hybrid/common/hpbridge_v1.0.1.js"></script>
<script>
        window.GM = {
            "night":!!parseInt("{%$night|f_escape_js%}", 10),
            "nopic":!!parseInt("{%$nopic|f_escape_js%}", 10)
        };
    </script>
{%script%}
        var recap_data = require("match:widget/recap_v15/recap_v15.js");
        recap_data.init();
    {%/script%}
{%/block%}
{%block name="content"%}
<section class="recap-wrap">
{%widget
            name="match:widget/recap_v15/recap_v15.tpl"
            type="football"
        %}
</section>
{%require name='match:page/football_recap.tpl'%}{%/block%}
