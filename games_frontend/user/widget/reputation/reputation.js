var toast = require("common:widget/ui-toast/ui-toast.js"),
    refresh = require("common:widget/ui-refresh/ui-refresh.js"),
    dace = require("common:widget/ui-dace/ui-dace.js"),
    _ = require("underscore");

var reputation = {
    lastId: GM.lastId,
    init: function(){
        var self = this;
        $(window).on("load", function(){
            setTimeout(self.start.bind(self), 10);
        });
    },
    start: function(){
        this.container = $("#J-rep-list");
        this.listTpl = _.template( $("#J_rep-tpl").html() );
        this.lastTips = $("#J-last-tips");
        var height = this.initWindowHeight = $(window).height();
        this.hideShare();
        this.bindEvent();

        //有详情的用户
        if(GM.hasList){
            //有下一页的
            if(GM.nextPage){
                this.initPage();
            } else{
                this.lastTips.show();
            }
        } else{
        //无详情的用户
            $("#J-reputation-background").css({"height": height, "padding-top":150});
            $("body").css("height", height);
        }
       this.resetPageHeight();
    },
    resetPageHeight: function(){
        var winHeight = this.initWindowHeight;
        var docHeight = $(document).height();
        if(docHeight < winHeight){
            var style = document.createElement("style");
            style.innerHTML = "html,body{height:100%;}";
            document.body.appendChild(style);
        }
    },
    hideShare: function(){
        function initBridge(callback) {
            if(window.HupuBridge){
                callback();
            }else{
                document.addEventListener("hupuBridgeReady", function(){
                    callback();
                });
            }
        }

        initBridge(function() {
            HupuBridge.send("hupu.ui.share", {
                    open: false
                }, function() {}
            );
        });
    },
    initPage: function(){
        var self = this;
        refresh({
            contentEl: this.container,
            isRefresh: false,
            loadingMoreCallback: function(complete) {
                self.getMoreData(complete);
            },
            isLoadingMore: !!GM.nextPage
        });
    },
    getMoreData: function(callback){
        var self = this;
        var requestGetData = "/" + GM.projectId + "/" + GM.version + "/prestige/list";
        dace.send("myPrestigeLoad");
        $.ajax({
            type: 'GET',
            url: requestGetData,
            data: {
                id: this.lastId,
                puid: GM.puid,
                client: GM.client
            },
            dataType: 'json',
            timeout: 30000,
            success: function(res) {
                var list = res.result.list;

                var html = self.listTpl({datas: list});
                self.container.append(html);

                self.lastId = list[list.length-1].id;
                callback && callback();

                var hasNextPage = res.result.hasNextPage;
                if(hasNextPage) {
                    callback();
                }else{
                    callback('finish');
                    self.lastTips.show();
                }
            },
            error: function() {
                callback && callback("finish");
                self.lastTips.show();
            }
        });
    },
    bindEvent: function(){
        $("#J-reputation-up").on("click", function(){
            toast.alert({
                content:[
                    '1.鼓励以下这些行为：<br />',
                    '- 产出优质主题帖<br />',
                    '- 产出被人认可的回帖或新闻评论<br />',
                    '- 正确举报破坏社区氛围的主题帖、回帖或新闻评论<br />',

                    '2.避免以下这些行为：<br />',
                    '- 产出违规（低质量）的主题帖、回帖或新闻评论<br />',
                    '- 点亮、回复或者推荐违规（低质量）的主题帖、回帖或新闻评论，扣除原作者声望的同时，您的声望同样会受到影响<br />',
                    '- 恶意举报正常内容'
                ].join(""),
                align: "left",
                submitText: "关闭"
            })
        });

        $("#J-reputation-use").on("click", function(){
            toast.alert({
                content:[
                    '声望的用途有<br />',
                    '- 赢得他人尊重<br />',
                    '- 开通论坛内的点灭功能<br />',
                    '- 浏览开放区等有声望限制的版块<br />',
                    '- 获得参与实物有奖竞猜的资格<br />',
                    '- 尚处在公测灰度阶段，部分用途尚未投入使用'
                ].join(""),
                align: "left",
                submitText: "关闭"
            })
        });

        $("#J-reputation-top-tips").on("click", function(){
            toast.alert({
                content:[
                    '根据每日的内容产出质量和社区行为进行声望更新<br />',
                    '- 初始声望计算规则：<br />',
                    '根据新闻和论坛的历史内容与行为进行初始评估<br />',
                    '尚处在公测灰度阶段，根据实际情况与需要，可能会调整声望的各项算法、参数和用途等等'
                ].join(""),
                align: "left",
                submitText: "关闭"
            })
        });
    }
}

module.exports = reputation
