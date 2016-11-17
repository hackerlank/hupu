var _ = require("app:static/js/underscore/underscore.js");

var rpz_rank = {

    init: function(){
        this.render();
        this.bind();
    },

    render: function(){
        this.tab = $("#J-tab");
        this.tContents = $(".t-content");
        this.header = $("#J-layout-header");
        this.main = $("#J-layout-main");
        this.ruleWrap = $("#J-rpz-rule");
        this.close = $("#J-close");
        this.open = $("#J-open");
        this.curPage = 1;
        this.trNum = 20;
        this.trHeight = 44;
        this.todayPage = 2;
        this.monthPage = 2;
        this.array = ["today_rank_list", "month_rank_list"];

        this.tplRender = _.template($("#J-rank-tpl").html());

        this.iHeight = $(window).height();
        this.main.css({
            "height": this.iHeight - this.header.height()
        });
        this.ruleWrap.css({
            "height": this.iHeight
        });
    },

    bind: function(){
        var self = this;
        var scrollHeight = 0;
        var timer = null;
        var scrollTop = 0;

        // 打开弹层
        self.open.on("click", function(){
            self.ruleWrap.css({
                "z-index": 2,
                "opacity": 1
            });
        });
        // 关闭弹层
        self.close.on("click", function(){
            self.ruleWrap.css({
                "z-index": -1,
                "opacity": 0
            });
        });

        // tab切换
        self.tab.find("a").on("click", function(){
            $(this).addClass("active").siblings().removeClass("active");
            self.tContents.eq($(this).index()).show().siblings().hide();
            self.main.scrollTop(0);
        });

        // 滚动加载
        self.main.on("scroll", function(){
            clearTimeout(timer);
            scrollTop = $(this).scrollTop();
            scrollHeight = self.curPage * self.trNum * self.trHeight;

            timer = setTimeout(function() {
                if( scrollTop >= scrollHeight - self.iHeight + self.header.height()){
                    if((self.getType() == 1 && GM.today_next) || (self.getType() == 2 && GM.month_next)){
                        self.main.find(".loading").show();
                        self.ajaxMore(self.getType());
                    }
                }
            }, 300);
        });
    },

    getType: function(){
        var self = this;
        var index = 0;

        self.tab.find("a").each(function(){
            if($(this).hasClass("active")){
                index = $(this).index() + 1;
            }
        });

        return index;
    },

    ajaxMore: function(type){
        var self = this;
        var page = 0;

        if(type == 1){
            page = self.todayPage ++;
        }else{
            page = self.monthPage ++;
        }

        $.ajax({
            //url: "/predict/rank/list_" + self.page, // test
            url: "/m/predict/ranking", // 线上
            type: "GET",
            dataType: "json",
            data: {
                is_api: 1,
                need_count: 1,
                from: 1,
                pageSize: "20",
                page: page,
                type: type
            },
            success: function(data){
                self.main.find(".loading").hide();
                if(type == 1){
                    GM.today_next = !!parseInt(data.data.next, 10);
                }else{
                    GM.month_next = !!parseInt(data.data.next, 10);
                }

                $("#"+self.array[self.getType() - 1]).find("tbody").append(self.tplRender({
                    datas: data.data.rankList,
                    type: self.getType()
                }));
            }
        });
    }
};

module.exports = rpz_rank;
