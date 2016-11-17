var _ = require("app:static/js/underscore/underscore.js");

var my_rpz = {

    init: function(){
        this.render();
        this.bind();
        this.showChart();
    },

    render: function(){
        this.chart = $("#J-chart");
        this.data = $("#J-data");
        this.time = $("#J-time");
        this.moreBtn = $("#J-more-btn");
        this.detailList = $("#J-detail-list");
        this.explainWrap = $("#J-rpz-explain");
        this.close = $("#J-close");
        this.open = $("#J-open");
        this.bOn = true;

        if($("#J-rpz-tpl").html()){
            this.tplRender = _.template($("#J-rpz-tpl").html());
        }

        this.year = parseInt(new Date().getFullYear());
        if(this.year % 4 == 0){
            this.day = "29";
        }else{
            this.day = "28";
        }
        this.month = new Date().getMonth();
        this.months = [
            ["01/01", "01/08", "01/15", "01/22", "01/31"],
            ["02/01", "02/08", "02/15", "02/22", "02/"+this.day],
            ["03/01", "03/08", "03/15", "03/22", "03/31"],
            ["04/01", "04/08", "04/15", "04/22", "04/30"],
            ["05/01", "05/08", "05/15", "05/22", "05/31"],
            ["06/01", "06/08", "06/15", "06/22", "06/30"],
            ["07/01", "07/08", "07/15", "07/22", "07/31"],
            ["08/01", "08/08", "08/15", "08/22", "08/31"],
            ["09/01", "09/08", "09/15", "09/22", "09/30"],
            ["10/01", "10/08", "10/15", "10/22", "10/31"],
            ["11/01", "11/08", "11/15", "11/22", "11/30"],
            ["12/01", "12/08", "12/15", "12/22", "12/31"]
        ];

        this.height = $(window).height();
        $(".my-rpz-wrap").css("height", this.height);
    },

    bind: function(){
        var self = this;

        // 打开弹层
        self.open.on("click", function(){
            self.explainWrap.css({
                "z-index": 10,
                "opacity": 1
            });
        });
        // 关闭弹层
        self.close.on("click", function(){
            self.explainWrap.css({
                "z-index": -1,
                "opacity": 0
            });
        });

        self.moreBtn.on("click", function(){
            if(self.bOn && $(this).attr("data-more") != ""){
                self.getMoreMyRpz($(this).attr("data-more"));
                self.bOn = false;
            }
        });
    },

    showChart: function(){
        var self = this;
        var chartHeight = 240; // 图表固定高度为240
        var factHeight = 0; // 根据人品最高最低值实际高度
        var scaleHeight = 0; // 计算图表刻度比例高度
        var scale = 0; // 高度比例

        var html = "";

        if(GM.rpz_min >= 0){
            factHeight = GM.rpz_max;
        }else{
            factHeight = GM.rpz_max - GM.rpz_min;
        }

        scaleHeight = Math.ceil(factHeight/10)*10; // 向上取整 53 -> 60，图表刻度

        scale = chartHeight / factHeight;

        var selfSpan = null;
        for(var i = 0; i < self.data.find("span").length; i++){
            selfSpan = self.data.find("span").eq(i);
            selfSpan.css({
                "height": parseInt(selfSpan.css("height")) * scale
            });
        }

        // 当最小值的绝对值大于最大值，整体往上偏移
        if(Math.abs(GM.rpz_min) > Math.abs(GM.rpz_max)){
            self.data.css({
                "top": -(Math.abs(GM.rpz_min) - Math.abs(GM.rpz_max)) * scale
            });
        }

        if(GM.rpz_max > 0){
            self.data.find(".active").eq(0).addClass("active-style");
            self.data.find(".active-style").attr("data-rank", GM.rpz_max);
        }

        // 刻度超过10 显示5个刻度 不超过10，显示3个刻度
        for(var i = 0; i < 5; i++){
            self.chart.find(".line").eq(2*i).attr("data-line"+(2*i+1), Math.ceil(GM.rpz_max-2*i*(factHeight/4)));

            if(Math.ceil(GM.rpz_max) >= 10){
                self.chart.find(".line").eq(i).attr("data-line"+(i+1),  Math.ceil(GM.rpz_max-i*(factHeight/4)));
            }
        }

        // 展示日期
        for(var i = 0; i < 5; i++){
            html += "<span>"+self.months[self.month][i]+"</span>";
        }
        self.time.append(html);

        // 防止进来看到变化效果
        self.chart.css("opacity", 1);
    },

    getMoreMyRpz: function(next){
        var self = this;
        $.ajax({
            //url: "/predict/my_rpz" + next, // test
            url: "/m/predict/my/topiclist", // 线上
            type: "GET",
            dataType: "json",
            data: {
                next: next,
                is_api: 1
            },
            success: function(data){
                if(data.code ==1){
                    self.bOn = true;
                    self.moreBtn.attr("data-more", data.data.next);
                    if(!data.data.next){
                        self.moreBtn.html("暂无更多数据~");
                    }
                    self.detailList.append(self.tplRender({
                        result: data.data,
                        datas: data.data.data
                    }));
                }
            }
        });
    }
};

module.exports = my_rpz;
