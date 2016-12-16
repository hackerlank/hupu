{%extends file="app/page/layout-empty.tpl"%}

{%block name="title"%}{%$title%}{%/block%}

{%block name="head_static"%}

    {%require name="app:static/lrw_index/index.scss"%}
    {%require name="app:static/lrw_index/index.js"%}
    <script>
      window.M_LRW = {
        game_info: {%json_encode($game_info)%}||[],
        wheel_match_url: "{%$wheel_match_url%}",
        wheel_rank_url: "{%$wheel_rank_url%}",
        top8_match_url: "{%$top8_match_url%}",
        top8_rank_url: "{%$top8_rank_url%}",
        rank_url: "{%$rank_url%}"
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
{%/block%}
