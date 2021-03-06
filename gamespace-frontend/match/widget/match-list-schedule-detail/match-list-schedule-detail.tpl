<div class="table_list">
    <div class="table_list_l"></div>
    <div class="table_list_c">
        <div class="table">
            <ul>
            {%foreach from=$daily_match_list item=val%}
                <li {%if $match_info.match_id == $val.match_id%} class="on" {%/if%}>
                    <a href="{%$val.link%}">
                    <p>{%$val.status_txt%}</p>
                    <div class="
                        {%if $val.status == 1%}
                            {%if $val.away_score > $val.home_score%}
                            team2
                            {%else%}
                            team
                            {%/if%}
                        {%else if $val.status == 2%}
                            {%if $val.away_score > $val.home_score%}
                            bg_img_j
                            {%/if%} team
                        {%else%}
                            team
                        {%/if%}">
                        <span class="name">{%$val.away_name%}</span>
                        {%if $val.status == 1 || $val.status == 2%}
                            {%$val.away_score%}
                        {%else%}
                            {%$val.time%}
                        {%/if%}
                    </div>
                    <div class="
                        {%if $val.status == 1%}
                            {%if $val.away_score < $val.home_score%}
                            team2
                            {%else%}
                            team
                            {%/if%}
                        {%else if $val.status == 2%}
                            {%if $val.away_score < $val.home_score%}
                            bg_img_j
                            {%/if%} team
                        {%else%}
                            team
                        {%/if%}
                        border">
                        <span class="name">{%$val.home_name%}</span>
                        {%if $val.status == 1 || $val.status == 2%}
                            {%$val.home_score%}
                        {%/if%}
                    </div>
                    </a>
                </li>
            {%/foreach%}
            </ul>
        </div>
    </div>
    <div class="table_list_r2"></div>
</div>
