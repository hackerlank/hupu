var Toast = require("app:widget/ui-toast/ui-toast.js");
var _ = require("app:static/js/underscore/underscore.js");
var common = require("app:widget/ui-common/ui-common.js");
var _escape = _.escape;

var requestActions = {
    follow: "/m/follow/doFollow",
    unfollow: "/m/follow/undoFollow",
    myFollow: "/m/follow/getFollowing",
    getAllAnchor:"/m/anchor/list"
};
var zhubo_list = {
    init: function() {
        var self = this;
        this.bindEvent();
        this.ajaxLock = false;
        this.allContainer = $("#J-zhubo-list");
        this.followContainer = $("#J-myFollow-list");
        this.noFollowContainer = $("#J-follow-null-wrap");
        this.tplRender = _.template($("#J-follow-list").html());
        if(GM.pagetab == "follow"){
            $("#J-myfollow").addClass("active").siblings().removeClass("active");
            self.tabFollow(function(){
                self.isFollow(self.followContainer);
                GM.show = "follow";
                self.followContainer.show();
                self.allContainer.hide();
            });
        }else{
            $("#J-all").addClass("active").siblings().removeClass("active");
            self.tabAll(function(){
                self.isFollow(self.allContainer);
                GM.show = "all";
                self.followContainer.hide();
                self.allContainer.show();
            });
        }
    },
    bindEvent:function(){
        var self = this;
        $("#J-zhubo-list").delegate('.J-follow-btn', 'click', function(e) {
            e.stopPropagation();
            e.preventDefault();
            var current = $(e.currentTarget);
            var zhubId = current.data("id");
            //var zhubId  = GM.room_id;
            if(current.hasClass('followed')){
                self.unfollowZhubo.call(self, zhubId, function(){
                    Toast.toast("取消关注");
                    current.removeClass('followed').text("关注");
                });
            }else{
                self.followZhubo.call(self, zhubId, function(){
                    Toast.toast("关注成功");
                    current.addClass('followed').text("已关注");
                });
            }
        });

        $("#J-myFollow-list").delegate('.J-follow-btn', 'click', function(e) {
            e.stopPropagation();
            e.preventDefault();

            var current = $(e.currentTarget);
            var zhubId = current.data("id");
            //var zhubId  = GM.room_id;
            if(current.hasClass('followed')){
                self.unfollowZhubo.call(self, zhubId, function(){
                    Toast.toast("取消关注");
                    current.removeClass('followed').text("关注");
                });
            }else{
                self.followZhubo.call(self, zhubId, function(){
                    Toast.toast("关注成功");
                    current.addClass('followed').text("已关注");
                });
            }
        });

        $("#J-all").on('click', function(e) {
            if(GM.show === "all") return;
            var current = $(e.currentTarget);
            $("#J-follow-null-wrap").hide();
            self.tabAll(function(){
                GM.show = "all";
                current.addClass("active").siblings().removeClass("active");
                self.isFollow(self.allContainer);
                self.followContainer.hide();
                self.allContainer.show();
            });
        });

        $("#J-myfollow").on('click', function(e) {
            if(GM.show === "follow") return;

            var followEvent = function(){
                var current = $(e.currentTarget);
                self.tabFollow(function(){
                    GM.show = "follow";
                    current.addClass("active").siblings().removeClass("active");
                    self.followContainer.show();
                    self.allContainer.hide();
                    self.isFollow(self.followContainer);
                });
            }
            common.login(GM.islogin, followEvent);
        });
    },
    followZhubo: function(id, callback) {
        var loginEvent = function() {
            $.ajax({
                url: requestActions.follow,
                type: "POST",
                dataType: "json",
                data:{
                    "room_id": id
                },
                success: function(data){
                    callback && callback();
                }
            });
        }
        common.login(GM.islogin, loginEvent);
    },
    unfollowZhubo: function(id, callback){
        var loginEvent = function() {
            $.ajax({
                url: requestActions.unfollow,
                type: "POST",
                dataType: "json",
                data:{
                    "room_id": id
                },
                success: function(data){
                    callback && callback();
                }
            });
        }
        common.login(GM.islogin, loginEvent);
    },
    tabFollow: function(callback){
        var self = this;
        if(this.ajaxLock) return;
        this.ajaxLock = true;
        $.ajax({
            url: requestActions.myFollow,
            type: "GET",
            dataType: "json",
            data:{
                "t": (new Date().getTime()),
                "json":1
            },
            success: function(data){
                self.ajaxLock = false;
                self.followContainer.html( self.tplRender({datas: data.data.followRoomList, type:"follow",_escape:_escape, withRoomUrl: common.withRoomUrl}) );
                callback && callback();
            }
        });
    },
    tabAll: function(callback){
        var self = this;
        if(this.ajaxLock) return;
        this.ajaxLock = true;
        $.ajax({
            url: requestActions.getAllAnchor,
            type: "GET",
            dataType: "json",
            data:{
                "t": (new Date().getTime()),
                "json":1
            },
            success: function(data){
                self.ajaxLock = false;
                self.allContainer.html( self.tplRender({datas: data.anchorList, type:"all",_escape:_escape, withRoomUrl: common.withRoomUrl}) );
                callback && callback();
            }
        });
    },
    isFollow: function(id){
        var self = this;
        if(!id.find("li").size()){
            self.noFollowContainer.find(".inner").css({
                "height" : $(window).height()-40
            });
            self.noFollowContainer.find("p").css({
                "position" : "relative",
                "top" : ($(window).height()-20)/2
            });
            self.noFollowContainer.show();
        }else{
            self.noFollowContainer.hide();
        }
    }
}

module.exports = zhubo_list;
