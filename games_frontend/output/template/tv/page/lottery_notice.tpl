{%extends file="common/page/layout-empty.tpl"%} 
{%block name="title"%}我的彩票{%/block%}
{%block name="head_static"%}
{%require name="tv:static/lottery_notice/lottery_notice.scss"%}
{%/block%}
{%block name="content"%}
<section class="content">
<div class="lottery-title">
<h4>亲爱的虎扑彩民：</h4>
<p>彩票余额搬家啦！以后可以在”发现”-“彩票”-“我的彩票”中查询啦！具体位置请看下面的介绍：</p>
</div>
<img src="//w3.hoopchina.com.cn/hybrid/resource/events/payment/step1.png" alt="">
<img src="//w3.hoopchina.com.cn/hybrid/resource/events/payment/step2.png" alt="">
<img src="//w3.hoopchina.com.cn/hybrid/resource/events/payment/step3.png" alt="">
<img src="//w3.hoopchina.com.cn/hybrid/resource/events/payment/step4.png" alt="">
<div class="lottery-bottom">
<a href="{%$aicai_url|f_escape_xml%}">查看我的彩票余额</a>
<p>若有任何疑问，都可以找我们的客服mm咨询哦</p>
<p>请在QQ“找服务”中添加客服QQ：<span>800021359</span></p>
<p>或者在微信添加朋友中搜索：<span>hupukanqiu</span></p>
</div>
</section>
{%require name='tv:page/lottery_notice.tpl'%}{%/block%}
