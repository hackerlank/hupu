{%extends file="app/page/layout.tpl"%} 
{%block name="title"%}8强{%/block%}
{%block name="head_static"%}
{%require name="app:static/lrw_index/index.scss"%}
{%require name="app:static/js/videojs/video-js.css"%}
{%require name="app:static/js/videojs/video.js"%}
{%require name="app:static/js/videojs/videojs-hls.min.js"%}
{%/block%}
{%block name="content"%}
<section class="lrw-wrap">
{%widget
      name = "app:widget/video/video.tpl"
      data = $live
    %}
{%widget
      name = "app:widget/inner-tab/tab.tpl"
      channel = "lrw"
      selected = "2"
    %}
{%widget
      name = "app:widget/lrw/against-list/list.tpl"
    %}
</section>
{%require name='app:page/lrw_8match.tpl'%}{%/block%}
