var toast = require("app:widget/ui-toast/ui-toast.js");
var common = require("app:widget/ui-common/ui-common.js");

var Anchor = {

    init: function(){
        this.render();
        this.bind();
    },

    render: function(){
        this.followWrap = $("#J-follow-wrap");
        this.method = "";
    },

    bind: function(){
        var self = this;

        self.followWrap.find("a").on("click", function(){
            var _self = $(this);
            common.login(GM.islogin, function(){
                if(_self.hasClass("btn-follow")){
                    self.method = "doFollow";
                    self.ajaxFollow(GM.room_id, self.method);
                }else{
                    self.method = "undoFollow";
                    toast.confirm({
                        content: "确认取消对该主播的关注？",
                        submitHandler: function(){
                            self.ajaxFollow(GM.room_id, self.method);
                        }
                    });
                }
            });
        });
    },

    ajaxFollow: function(room_id, method){
        var self = this;
        $.ajax({
            //url: "/"+self.method, //test
            url: "/m/follow/"+self.method, //线上
            type: "POST",
            dataType: "json",
            data: {
                room_id: room_id,
            },
            success: function(data){
                if(data.code == 1){
                    if(self.method == "doFollow"){
                        self.followWrap.find("a").removeClass("btn-follow").addClass("btn-unfollow");
                        self.followWrap.find("a").html("取消关注");
                        self.followWrap.find(".num").html(parseInt(self.followWrap.find(".num").html())+1);
                        self.followWrap.find(".num").removeClass("follow-num").addClass("unfollow-num");
                    }else{
                        self.followWrap.find("a").removeClass("btn-unfollow").addClass("btn-follow");
                        self.followWrap.find("a").html("关注");
                        self.followWrap.find(".num").html(parseInt(self.followWrap.find(".num").html())-1);
                        self.followWrap.find(".num").removeClass("unfollow-num").addClass("follow-num");
                    }
                }
            }
        });
    }
};

module.exports = Anchor;
