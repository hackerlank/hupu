{%extends file="app/page/layout.tpl"%} 
{%block name="title"%}{%$game_info.title|f_escape_xml%}{%/block%}
{%block name="head_static"%}
{%require name="app:static/lrw_index/index.scss"%}
{%require name="app:static/js/videojs/video-js.css"%}
{%require name="app:static/js/videojs/video.js"%}
{%require name="app:static/js/videojs/videojs-hls.min.js"%}
{%require name="app:static/lrw_index/index.js"%}
<script>
      window.M_LRW = {
        game_info: {%json_encode($game_info)%}||[],
        wheel_match_url: "{%$wheel_match_url|f_escape_js%}",
        wheel_rank_url: "{%$wheel_rank_url|f_escape_js%}",
        top8_match_url: "{%$top8_match_url|f_escape_js%}",
        top8_rank_url: "{%$top8_rank_url|f_escape_js%}",
        rank_url: "{%$rank_url|f_escape_js%}"
      };
    </script>
{%/block%}
{%block name="content"%}
<section class="lrw-wrap" id="J_lrwWrap">
{%widget
      name = "app:widget/inner-tab/tab.tpl"
      channel = "lrw"
      selected = "1"
    %}
<div id="J_lrwContent"></div>
{%widget
      name = "app:widget/lrw/inner-title/title.tpl"
    %}
{%widget
      name="app:widget/lrw/play-list/play-list.tpl"
    %}
{%widget
      name = "app:widget/lrw/against-list/list.tpl"
    %}
</section>
{%require name='app:page/lrw_index.tpl'%}{%/block%}
