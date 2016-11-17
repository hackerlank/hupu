{%extends file="common/page/layout.tpl"%} 
{%block name="title"%}2015足球最佳阵型{%/block%}
{%block name="head_static"%}
{%script%}
    	var page = require("events:widget/footbollbest2015/footbollbest2015.js");
    	page.init();
    {%/script%}
{%/block%}
{%block name="content"%}
<section class="content" id="container">
<script type="text/template" id="J-index-tpl">
 	 	
        <a href="#step2">step2</a>
 	 </script>
<script type="text/template" id="J-step1-tpl">
 	 	<a href="#index">index</a>
        <a href="#step2">step2</a>
 	 </script>
<script type="text/template" id="J-step2-tpl">
 	 	<a href="#index">index</a>
        <a href="#step1">step1</a>
 	 </script>
</section>
{%require name='events:page/footbollbest2015.tpl'%}{%/block%}