{%extends file="common/page/layout.tpl"%}

{%block name="block_head_static"%}
    {%require name="common:widget/rpz-board/rpz-board.scss"%}    
    {%require name="home:static/pre/pre.scss"%}  
    {%require name="home:static/pre/pre.js"%}
    <script src="http://b3.hoopchina.com.cn/code/zeroClipboard/1.3.5/ZeroClipboard.js"></script>

    <script>
        HTV.roomID = "{%$live.id%}" || 0;
        HTV.shareUrl = "{%$abs_url%}";
        HTV.matchID = "{%$live.match_id%}" || 0;
        HTV.token = "{%$token%}"    
        HTV.game_id = "{%$game.id%}"
       
        
        // 分享数据
        HTV.shareData = HPF.shareData = {
        {%if !empty($live.online) && $live.online < 1000%}
            title: '「{%$game.title%}」火热报名中，快来参与互动',
        {%else%}
            title: '「{%$game.title%}」火热报名中，快来参与互动',
        {%/if%}
            qqSubTitle: '「{%$game.title%}」火热报名中，快来参与互动',
            url: '{%$task_share_url%}',
            pic: '{%$live.cover%}'
        };
        // 礼物列表数据
       

    </script>
{%/block%}

{%block name="content"%}
    <div class="pre-cover">
        <img src="{%$game.division.pc_img%}">
        <div class="pre-share" id="J_uiPreShare">
            <span class="share"> 
                <i class="pre-share-icon"></i>               
                {%widget
                    name="common:widget/share/share.tpl"
                %}
            </span>
            <span class="subscribe" id="J-pre-subscribe"><i></i>&nbsp;订阅</span>
        </div>
    </div>
    <div class="pre-wrap">
        <div class="col-1">
            <div class="pre-title pre-title-head">
                <div class="board-title">
                    <div class="tag">赛事详情</div>                
                </div>
                <p class="pre-text">
                    {%$game.title%}
                </p>
            </div>
            <div class="pre-players pre-title-head">
                <div class="board-title">
                    <div class="tag">参赛球员</div>                
                </div>
                {%widget
                    name="home:widget/pre-playCard/play-card.tpl"
                    data =$player
                    predict_data_id =$predict_player_id
                %}
            </div>
            <div class="pre-discuss pre-title-head">
                <div class="board-title">
                    <div class="tag">赛前讨论</div>                
                </div>
                {%widget
                    name="home:widget/pre-discuss/discuss.tpl"
                %}
            </div>
        </div>
        <div class="col-2">
            <div class="pre-introduce pre-title-head">
                <div class="board-title">
                    <div class="tag">赛程信息</div>                
                </div>
                {%widget
                    name="home:widget/pre-introduce/introduce.tpl"
                    data= $game
                %}
            </div> 
            <div class="pre-video pre-title-head">
                <div class="board-title">
                    <div class="tag">赛后讨论</div>  
                    <a href="/predict/rank/list" target="_blank" class="more">
                        更多视频 &gt;
                    </a>              
                </div>
                {%widget
                    name="home:widget/pre-video/video.tpl"
                    data=$video_recommend
                %}
            </div>           
        </div>
    </div>
{%/block%}
