var _ = require("app:static/js/underscore/underscore.js");

var Gift = {

    init: function(){
        this.render();
        this.bind();
    },

    render: function(){
        this.roomContainer = $("#J-room-wrap");
        this.matchContainer = $("#J-match-wrap");
        if($("#J-gift-tpl").html()){
            this.tplRender = _.template($("#J-gift-tpl").html());
        }
        this.bOn = true;
    },

    bind: function(){
        var self = this;

        self.getGift();

        $(".sub-tab").find("a").on("click", function(){
            $(this).addClass("active").siblings().removeClass("active");
            $(".subt-content").eq($(this).index()).show().siblings(".subt-content").hide();
        });
    },

    getGift: function(){
        var self = this;

        if(self.bOn){
            self.bOn = false;
            self.roomContainer.empty();
            self.matchContainer.empty();

            $.ajax({
                //url: "/gift", //test
                url: "/m/gift/ranking/" + GM.room_id, //线上
                type: "GET",
                dataType: "json",
                data: {
                    is_api: 1,
                    t: (new Date().getTime())
                },
                success: function(data){
                    self.bOn = true;
                    if(data.code == 1){
                        self.roomContainer.append(self.tplRender({
                            rank_list: data.data.room_ranking.room,
                            user: data.data.room_ranking.user
                        }));

                        self.matchContainer.append(self.tplRender({
                            rank_list: data.data.match_ranking.room,
                            user: data.data.match_ranking.user
                        }));
                    }
                }
            });
        }
    }
};

module.exports = Gift;
