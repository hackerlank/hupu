/**
 * 直播
 */
!function(){
    "use strict";

    var dace = require("common:widget/page-dace/page-dace.es6");
    var Share = require("common:widget/share/share.js");
    var QRCode = require("common:widget/share/qrcode/qrcode.js");
    var User = require("common:widget/login/login.js");

    var pageId = __dacePageName;
    var timer = null;

    /**
     * 接口地址
     */
    var apiUrl = {
        // 关注
        follow: '/user/follow-ajax'
    };

    var LiveContent = {
        init: function() {
            var that = this;

            this.$buttonFollow = $('#J_buttonFollow');

            if ( !this.$buttonFollow.length ) {
                return;
            }

            this.$followCount = $('#J_followCount');
            this.$wallet = $('#J_myWallet');
            this.walletTimer = null;
            this.shareTimer = null;

            this.bind();
            this.shareBind();
        },
        bind: function() {
            var that = this,
                $self = null;

            // 关注
            this.$buttonFollow.on('click', function() {
                that.sendFollow($(this).attr('data-type'));
            });

            this.$wallet.hover(
                function() {
                    that.walletTimer && clearTimeout(that.walletTimer);
                    $(this).addClass('wallet-hover');
                },
                function(){
                    $self = $(this);

                    that.walletTimer = setTimeout(function() {
                        $self.removeClass('wallet-hover');
                    }, 300);

                }
            )

            //新增人品值notify
            $(document).bind("rpzAddNotify", function(){
                $(".rpz-link .thumb").addClass("on");
            });
            //移除人品值notify
            $(document).bind("rpzRemoveNotify", function(){
                $(".rpz-link .thumb").removeClass("on");
            });

            //点击人品值区域，去掉红点提示.
            $(".rpz-link").on("mouseover", function(){
                $(document).trigger("rpzRemoveNotify");
            })
        },
        /**
         * 分享
         */
        shareBind: function() {
            var self = this;

            if(document.getElementById("J_zeroClipboard")){
                var client = new ZeroClipboard(document.getElementById("J_zeroClipboard"),{
                    moviePath: "http://b3.hoopchina.com.cn/code/zeroClipboard/1.3.5/ZeroClipboard.swf"
                });

                client.on("load", function(client) {
                    client.setText(window.location.href);

                    client.on( "complete", function(client, args) {
                        self.copyTips();
                    } );
                });

            }

            var $share = $('#J_uiTopShare'),
                $tips = $share.find('.J_shareTips');


            $share.hover(
                function() {
                    self.shareShow($tips);
                },
                function() {
                    self.shareHide($tips);
                }
            );

            $('#global-zeroclipboard-html-bridge').hover(
                function() {
                    clearTimeout(self.shareTimer);
                    $tips.show();
                },
                function() {
                }
            );

            var $shareTips = $('#J_shareWeixinTips');

            // 生成weixin二维码
            var qrcode = new QRCode("J_shareQrcode", {
                text: HTV.shareUrl,
                width: 98,
                height: 98
            });

            $share.find('.icons-weixin').hover(
                function() {
                    $shareTips.show();
                },
                function() {
                    $shareTips.hide();
                }
            );


            var type = '',
                shareData = HTV.shareData;

            shareData.tempTitle = shareData.title;

            $share.find('.icons').on('click', function(){
                type = $(this).data('type');

                if(type == 'qq'){
                    shareData.title = document.title;
                    shareData.summary = shareData.qqSubTitle;
                }else{
                    shareData.title = shareData.tempTitle;
                    shareData.summary = '';
                }

                new Share(type, shareData);
            })
        },
        shareShow: function($tips) {
            clearTimeout(this.shareTimer);
            $tips.show();
        },
        shareHide: function($tips) {
            var that = this;

            this.shareTimer = setTimeout(function() {
                $tips.hide();
            }, 500);
        },
        /**
         * 关注
         */
        sendFollow: function(type) {
            var that = this;
            var followType = 'follow';

            if(!HTV.isLogin){
                User.login();
                return;
            }

            // 取消关注
            if(type == 0){
                followType = 'unfollow';
            }

            var sendData = {
                room_id: HTV.roomID,
                type: followType
            }

            $.ajax({
                url: apiUrl.follow,
                type: "POST",
                data: sendData,
                dataType: 'json',
                success: function(data) {
                    if(data.code === 1){
                        var _count = parseInt(that.$followCount.html());

                        that.$followCount.html(data.data.following);

                        // 取消关注
                        if(type == 0){
                            that.$buttonFollow
                                .attr('data-type', '1')
                                .removeClass("button-unfollow")
                                .find("span.text")
                                .text('关注');

                            dace.send(pageId + "_unfollowClick");
                        }else{
                            that.$buttonFollow
                                .attr('data-type', '0')
                                .addClass("button-unfollow")
                                .find("span.text")
                                .text('取消关注');

                            dace.send(pageId + "_followClick");
                        }
                    }
                }
            });
        },
        copyTips: function() {
            var $tips = $('#J_shareCopyTips');

            clearTimeout(timer);
            $tips.show();

            timer = setTimeout(function(){
                clearTimeout(timer);
                $tips.hide();
            }, 1130);
        }
    }

    $(function(){
        LiveContent.init();
    })
}();
