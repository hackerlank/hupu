{%if !empty($right_photos)%}
<div class="pic_ul clearfix">
    <ul>
        {%foreach $right_photos as $val%}
        <li>
            <div class="img">
                <a href="{%$val.url%}"><img src="{%$val.titlepic%}" alt="{%$val.title%}"></a>
            </div>
            <p>{%$val.title%}</p>
        </li>
        {%/foreach%}
    </ul>
</div>
{%/if%}
