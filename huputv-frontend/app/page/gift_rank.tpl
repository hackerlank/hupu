{%extends file="app/page/layout.tpl"%}

{%block name="title"%}礼物排行{%/block%}

{%block name="head_static"%}
    {%require name="app:static/live/live.scss"%}
    {%script%}
        window.GM = $.extend(window.GM, {
          room_id: location.pathname.split("/").pop()
        });

        initBridge(function(){
           HupuBridge.send("hupu.ui.header", {
                title: "礼物排行",
                subtitle: ""
           }, function(){
           });
        });

        function initBridge(callback) {
            if(window.HupuBridge){
                callback();
            }else{
                document.addEventListener("hupuBridgeReady", function(){
                    callback();
                });
            }
        }
    {%/script%}
    {%style%}
        section.gift-rank { display: block!important;}
    {%/style%}
{%/block%}

{%block name="content"%}
    {%widget name="app:widget/gift_rank/gift_rank.tpl"%}
{%/block%}
