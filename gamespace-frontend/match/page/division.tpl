{%extends file="common/page/layout.tpl"%}

{%block name="head_static"%}
  {%require name="match:static/standing/standing.css"%}
  {%require name="match:static/data/data.js"%}
{%/block%}

{%block name="content"%}
<div class="gamecenter_livestart" id="rank_js">
    <div class="bgs_png" style="display:none;"></div>
    {%widget name="common:widget/ad-980/ad-980.tpl"%}

    {%widget
        name="common:widget/page-tab/page-tab.tpl"
        title="战绩排行"
    %}

    <div class="left_box">
      {%widget
          name="match:widget/standings-nav/standings-nav.tpl"
          type="division"
      %}
      <div class="rank_data">
          <table class="players_table">
              <tbody>
                {%widget
                    name="match:widget/standings-tables/standings-tables.tpl"
                    title="大西洋赛区 - 东部"
                    data=$Atlantic
                %}
                {%widget
                    name="match:widget/standings-tables/standings-tables.tpl"
                    title="中部赛区 - 东部"
                    data=$Central
                %}
                {%widget
                    name="match:widget/standings-tables/standings-tables.tpl"
                    title="东南赛区 - 东部"
                    data=$Southeast
                %}
                {%widget
                    name="match:widget/standings-tables/standings-tables.tpl"
                    title="太平洋赛区 - 西部"
                    data=$Pacific
                %}
                {%widget
                    name="match:widget/standings-tables/standings-tables.tpl"
                    title="西北赛区 - 西部"
                    data=$Northwest
                %}
                {%widget
                    name="match:widget/standings-tables/standings-tables.tpl"
                    title="西南赛区 - 西部"
                    data=$Southwest
                %}
              </tbody>
          </table>
        </div>
    </div>
    <div class="right_box">
        <div class="rightAd">
            <div id="div-gpt-ad-1387359684902-0" style="width:250px; height:250px;">
                <script type="text/javascript">
                    googletag.cmd.push(function () {
                        googletag.display('div-gpt-ad-1387359684902-0');
                    });
                </script>
            </div>
        </div>
        {%widget name="common:widget/photo-recommend/photo-recommend.tpl"%}
        {%widget name="match:widget/standings-rules/standings-rules.tpl"%}
    </div>
</div>
{%/block%}
