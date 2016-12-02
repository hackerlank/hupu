{%extends file="app/page/layout.tpl"%} 
{%block name="title"%}{%$live.room_name|f_escape_xml%}{%/block%}
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
      selected = "3"
    %}
{%widget
      name="app:widget/lrw/inner-title/title.tpl"
      title="本轮比赛战绩表"
      position="center"
    %}
{%widget
      name="app:widget/lrw/play-list/play-list.tpl"
    %}
</section>
{%require name='app:page/lrw_rank.tpl'%}{%/block%}
