{%extends file="app/page/layout.tpl"%}

{%block name="title"%}个人中心{%/block%}

{%block name="head_static"%}
    {%require name="app:static/my_info/my_info.scss"%}

    {%script%}
        window.GM = $.extend(window.GM, {
          "rpz_max": parseInt("{%$userTopicList.max%}"),
          "rpz_min": parseInt("{%$userTopicList.min%}"),
          "rpz_rank": parseInt("{%$userPredictionInfo.month_rank%}")
        });

      
        
        
    {%/script%}
{%/block%}

{%block name="content"%}
<div class="info-main" id="J-info-main">   
        <section class="info">
            <div class="play-list-item">               
                <div class="play-list-mid">
                    <div class="avatar">
                        <img src="{%$userInfo.avatar%}" alt="">
                    </div>
                    <div class="maskavatar"></div>
                    <div class="play-list-text">
                        <div class="player-nick">
                            {%$userInfo.username%}
                        </div> 
                        <div class="play-message">
                           人品值 {%$user_prediction_info.score%}
                           虎扑币 {%$balance.1%} &nbsp;&nbsp;
                           金豆数 {%$balance.6%}
                        </div>
                    </div>
                </div>                
            </div>
       
        </section>
        <section class="my-rpz">
            <a href="/m/predict/my/list?n={%$in_kanqiu%}&client={%$client%}" class="my-rpz-content">
                <div class="my-rpz-left"> 我的人品值 </div>
                <div class="my-rpz-right">
                     <em></em>
                </div>               
            </a>         
        </section>
        <section class="my-zhubo">
            <a href="/m/anchor/list?pagetab=follow&n={%$in_kanqiu%}&client={%$client%}" class="my-rpz-content">
                <div class="my-rpz-left"> 我关注的主播 </div>
                <div class="my-rpz-right">
                    {%if !empty($follow)%}
                        <h5 class="zhubo-name">{%$follow.anchor_nickname%}</h5> &nbsp;&nbsp;正在直播

                    {%/if%}
                    <em>                    
                    </em>
                </div>
               
            </a>   
        </section>
</div>  
{%/block%}
