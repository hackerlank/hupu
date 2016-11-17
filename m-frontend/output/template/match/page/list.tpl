{%extends file="common/page/layout.tpl"%} 
{%block name="block_head_static"%}
{%require name="match:static/list/list.scss"%}
{%require name="match:static/list/list.js"%}
{%script%}
        var pageTool = require("common:widget/ui/page-tools/page-tools.js");
        pageTool.initTools({
            today: true,
            todayHandler: function(){
                var _top = $('.match-today').offset().top;
                $('html,body').scrollTop(_top);
            }
        });
    {%/script%}
{%/block%}
{%block name="content"%}
{%widget
        name="common:widget/top-nav/top-nav.tpl"
    %}
<p class="top-tips">暂无更多赛事信息</p>
<div class="match-list-wrap" id="J_content">
{%foreach from=$nbaGame item=itemVal name=itemKey%}
{%if isset($itemVal.id)%}
<section class="match-section match-today" latestId="{%$itemVal.id|f_escape_xml%}" match-date="{%$itemVal.date|f_escape_xml%}">
{%else%}
<section class="match-section" match-date="{%$itemVal.date|f_escape_xml%}">
{%/if%}
<div class="time-label">
<span>
<strong>{%$itemVal.timestr|f_escape_xml%}</strong></span>
</div>
{%if !empty($itemVal.gameinfo)%}
{%foreach from=$itemVal.gameinfo item=infoVal name=infoKey%}
<a href="{%$infoVal.innerurl|f_escape_xml%}" class="match-wrap" dace-node="{%$id4dace|f_escape_xml%}_game">
<div class="match-info">
<div class="match-team-info">
<div class="team away-team">
<span class="team-name">{%$infoVal.away.name|f_escape_xml%}</span>
<img src="{%$infoVal.away.logourl|f_escape_xml%}" alt="">
</div>
<strong>
<span>{%$infoVal.scoreortime|f_escape_xml%}</span>
</strong>
<div class="team home-team">
<img src="{%$infoVal.home.logourl|f_escape_xml%}" alt="">
<span class="team-name">{%$infoVal.home.name|f_escape_xml%}</span>
</div>
</div>
<div class="match-status-info">
<div class="score away-score">
{%if isset($infoVal.home_win)%}
({%$infoVal.away_win|f_escape_xml%}){%/if%}
</div>
{%if isset($infoVal.isovertime)%}
{%if {%$infoVal.isover|f_escape_xml%} == 0%}
<div class="match-status-txt overtime-ing">{%$infoVal.process|f_escape_xml%}</div>
{%else%}
<div class="match-status-txt overtime">{%$infoVal.process|f_escape_xml%}</div>
{%/if%}
{%else%}
<div class="match-status-txt">{%$infoVal.process|f_escape_xml%}</div>
{%/if%}
<div class="score home-score">
{%if isset($infoVal.home_win)%}
({%$infoVal.home_win|f_escape_xml%}){%/if%}
</div>
</div>
</div>
{%if isset($infoVal.recaptext) && !empty($infoVal.recaptext)%}
<div class="match-report">
<p><img src="//b3.hoopchina.com.cn/touch/static/match/list/report_02639ab.png" alt="">{%$infoVal.recaptext|f_escape_xml%}</p>
</div>
{%/if%}
</a>
{%/foreach%}
{%/if%}
</section>
{%/foreach%}
</div>
<script id="t2" type="text/template">
        <@ _.each(datas, function(item,index) { @>
            <section class="match-section" match-date="<@=item.date@>">
                <div class="time-label">
                    <span>
                       <strong><@=item.timestr@></strong> 
                    </span>
                </div>
                <@ if ( !_.isEmpty(item.gameinfo) ){ @>
                    <@ _.each(item.gameinfo, function(item,index) { @>

                    <a href="<@=item.innerurl@>" class="match-wrap" dace-node="{%$id4dace%}_game">
                        <div class="match-info">
                            <div class="match-team-info">
                                <div class="team away-team">
                                    <span class="team-name"><@=item.away.name@></span>
                                    <img src="<@=item.away.logourl@>" alt="">
                                </div>
                                <strong>
                                    <span><@=item.scoreortime@></span>
                                </strong>
                                <div class="team home-team">
                                    <img src="<@=item.home.logourl@>" alt="">
                                    <span class="team-name"><@=item.home.name@></span>
                                </div>
                            </div>
                            <div class="match-status-info">
                                <div class="score away-score">
                                   <@ if( item.away_win == 0 ){ @>
                                        (<@=item.away_win@>)
                                    <@ }else if( !!(item.away_win) ){ @>
                                        (<@=item.away_win@>)
                                    <@ }else{ @>
                                    <@ } @>   
                                </div>
                                <@ if( !!(item.isovertime) ){@>
                                    <@ if (item.isover == 0){ @>
                                    <div class="match-status-txt overtime-ing"><@=item.process@></div>
                                    <@ }else{ @>
                                    <div class="match-status-txt overtime"><@=item.process@></div>
                                    <@ } @>
                                <@ }else{ @>
                                    <div class="match-status-txt"><@=item.process@></div>
                                <@ } @>
                                <div class="score home-score">
                                    <@ if( item.home_win == 0 ){ @>
                                        (<@=item.home_win@>)
                                    <@ }else if( !!(item.home_win) ){ @>
                                        (<@=item.home_win@>)
                                    <@ }else{ @>
                                    <@ } @>    
                                </div>
                                
                            </div>
                        </div>

                        <@ if( !!(item.recaptext) ){@>
                        <div class="match-report">
                            <p><img src="//b3.hoopchina.com.cn/touch/static/match/list/report_02639ab.png" alt=""><@=item.recaptext@></p>
                        </div>
                        <@ } @>
                    </a>

                    <@ }); @>
                <@ } @>
                
            </section>
        <@ }); @>
    </script>
{%require name='match:page/list.tpl'%}{%/block%}