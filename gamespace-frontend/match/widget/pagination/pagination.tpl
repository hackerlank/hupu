{%if $pageCount > 1%}
<div class="pages_box">
  <div class="post_page" >
      <div class="bg_c"></div>
      <div class="pagelist">
          {%$start =1%}
          {%if $page > 3%}
            {%$start = $page - 2%}
          {%/if%}
          {%$end = $start + 4%}
          {%if $end > $pageCount%}
            {%$end = $pageCount%}
          {%/if%}

          {%for $step=$start to $end%}
            {%if $step==$page%}
              <a>{%$page%}</a>
            {%else%}
              <a href="{%$path%}{%$step%}">{%$step%}</a>
            {%/if%}
          {%/for%}
     </div>
  </div>
  {%if $page == 1%}
    <span class="no">上一页</span>
  {%else%}
    <a href="{%$path%}{%$page-1%}">上一页</a>
  {%/if%}

  <span class="page_num">第{%$page%}页</span>

  {%if $page == $pageCount%}
    <span class="no">下一页</span>
  {%else%}
    <a href="{%$path%}{%$page+1%}">下一页</a>
  {%/if%}

</div>
{%/if%}
