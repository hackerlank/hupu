/**
 * 直播
 */

    var dace = require("common:widget/page-dace/page-dace.es6");
    var Share = require("common:widget/share/share.js");
    var User = require("common:widget/login/login.js");
    var Toast = require("common:widget/toast/toast.js");
    var _ = require('common:static/js/underscore/underscore.js');
    var VideoPlay = require('live:widget/video-play/video.js');
    var Flash = require('common:widget/flash-movie/flash');
    var SendGift = require('live:widget/send-gift/gift.es6');


    var pageId = __dacePageName;
    var beanClass = ['beans-num1','beans-num2','beans-num2','beans-num3','beans-num3'];

    /**
     * 接口地址
     */
    var apiUrl = {
        // 关注
        sign: '/sign',
        share: '/share',
        online: '/online',
        listen: '/task-info'
    };

    var Task = {
        init(chaoneng) {
            this.tabWrap = $('.mask-tab-wrap');
            this.wrap = $('.task-left');
            this.taskBtn = $('.task-btn');
            this.tab = $('.mask-tab');
            this.chaoneng = !!chaoneng;

            this.timer = null;
            this.intervalTask = 15000;

            this.bind();
        },

        bind() {
          /**
           * 网页全屏
           */
          Flash.register('getBeans', str => {
            this.requestOnline();
          });

            $('#J_login4task').on('click', function(e) {
                e.preventDefault();
                User.login();
            })

            this.wrap.delegate(".task-item", "mouseenter", (e) => {
                e.preventDefault();
                clearTimeout(this.timer);
                var index = $(e.currentTarget).index();
                this.showBoard(index);
            });

            this.wrap.delegate(".task-item", "mouseleave", (e) => {
                e.preventDefault();
                clearTimeout(this.timer);
                this.timer = setTimeout(() => {
                    this.board.hide();
                }, 500);
            });

            this.bindSign();
            this.bindOnline();
            this.bindShare();
            this.renderBtn();
            // HM 本地环境防止报错
            this.listenTask();

            if(HTV.onlineStatus == 3 ){
                return ;
            }
            this.countDown(HTV.countTime);
        },

        showBoard(index) {
            this.board = $('.mask-board');
            this.tabcon = $('.mask-con');
            this.close = $('#J_close');
            this.tab.eq(index).addClass('active').siblings().removeClass('active');
            this.tabcon.eq(index).show().siblings().hide();
            this.board.show();
            this.operateBoard();
        },

        operateBoard() {
            this.board.hover(
                (e) => {
                    e.preventDefault();
                    clearTimeout(this.timer);
                },
                (e) => {
                    e.preventDefault();
                    clearTimeout(this.timer);
                    this.timer = setTimeout(() => {
                        this.board.hide();
                    }, 500);
                }
            );

            this.tab.off('mouseover').on('mouseover', (e) => {
                var index = $(e.currentTarget).index();
                this.tab.eq(index).addClass('active').siblings().removeClass('active');
                this.tabcon.eq(index).show().siblings().hide();

            });

            this.close.off('click').on('click', (e) => {
                this.board.hide();
            });

        },

        bindSign() {
            this.signTab = $('.J_signTab');
            this.signInfo = $('#J_signInfo');
            this.signDays = $('#J_signDays');

            this.signInfo.delegate('.sign-btn', 'click', (e) => {
                var $this = $(e.currentTarget);
                if($this.hasClass('signed')){
                    return;
                }

                $.ajax({
                    url: apiUrl.sign,
                    type: 'POST',
                    dataType: 'json',
                    success: (data) => {
                        if(data.code == 1) {
                            this.renderSign(data.data);
                            this.signDays.text(data.data.keep_days);
                            SendGift.addBeans(data.data.add_bean);
                            Toast.toast(`获得${data.data.add_bean}金豆`, '.mask-con-wrap');
                        }
                    }
                })

            });
        },

        renderSign(datas) {
            if(datas.has_sign){
                this.signTab.removeClass('notice');
            }else{
                this.signTab.addClass('notice');
            }
            this.renderBtn();

            var signTpl = _.template( $("#sign-tpl").html(), {datas: datas} );
            this.signInfo.html( signTpl );
        },

        bindShare() {
            this.shareTab = $('.J_shareTab');
            this.shareInfo = $('#J_shareInfo');
            this.shareTimesRest = $('.J_shareTimesRest');

            this.shareInfo.delegate('.share-btn', 'click', (e) => {
                var $this = $(e.currentTarget);

                if($this.hasClass('unGet') || $this.hasClass('fullGet')) {
                    return ;
                }

                $.ajax({
                    url: apiUrl.share,
                    type: 'POST',
                    dataType: 'json',
                    success: (data) => {
                        if(data.code == 1) {
                            this.renderShare(data.data);
                            SendGift.addBeans(data.data.add_bean);
                            Toast.toast(`获得${data.data.add_bean}金豆`, '.mask-con-wrap');
                        }
                    }
                })
            })
        },

        listenTask() {
            this.timerTask = setInterval(() => {
                $.ajax({
                    url: apiUrl.listen,
                    type: 'GET',
                    dataType: 'json',
                    success: (data) => {
                        if(data.code == 1) {

                            this.renderSign(data.data.sign_data);
                            this.renderShare(data.data.share_data);
                        }
                    }
                })
            }, this.intervalTask);
        },

        renderShare(datas) {
            switch(datas.status) {
                case 0:
                    this.shareTab.removeClass('notice');
                    break;
                case 1:
                    this.shareTab.addClass('notice');
                    break;
                case 2:
                    this.shareTab.removeClass('notice');
                    break;
                default:
                    this.shareTab.removeClass('notice');
            }
            this.renderBtn();

            this.shareTimesRest.text(datas.rest_times);
            var shareTpl = _.template( $("#share-tpl").html(), {datas: datas} );
            this.shareInfo.html( shareTpl );

        },

        bindOnline() {
            this.onlineTab = $('.J_onlineTab');

            $('.online-list').delegate('.able','click', (e) => {
                this.requestOnline();
            });

            this.wrap.delegate('.getbeans-btn','click', (e) => {
                if($(e.currentTarget).hasClass('disabled')){
                    return;
                }
                this.requestOnline();
            });
        },

        requestOnline() {
            $.ajax({
                url: apiUrl.online,
                type: 'POST',
                dataType: 'json',
                success: (data) => {
                    if(data.code == 1) {
                        HTV.countTime = data.data.rest_time;
                        Task.renderOnlineTask(data.data);
                        SendGift.addBeans(data.data.pre_score);
                        Toast.toast(`获得${data.data.pre_score}金豆`, '.mask-con-wrap');
                        HTV.beansNum = data.data.cur_score;

                        //通知领取金豆结果
                        Flash.send('getBeansResult', {
                            "msg":`获得${data.data.pre_score}金豆`
                        });
                    }else if(data.code == -3015){
                        clearInterval(this.countTimer);
                        HTV.countTime = data.data.rest_time;
                        Task.renderOnlineTask(data.data);
                    }
                }
            })
        },

        renderOnlineTask(datas) {
            var minute = parseInt(datas.rest_time/60) < 10 ? '0'+parseInt(datas.rest_time/60) : parseInt(datas.rest_time/60);
            var second = parseInt(datas.rest_time%60) < 10 ? '0'+parseInt(datas.rest_time%60) : parseInt(datas.rest_time%60);

            var time = `${minute} : ${second}`;

            var onlineTpl = _.template( $("#online-tpl").html(), {"datas": datas,beanClass: beanClass,time: time} );
            $('.online-list').html( onlineTpl );

            if(!this.chaoneng){
                var btnTpl = _.template( $("#btn-tpl").html(), {datas: datas, time: time} );
                $('.task-btn').next('.task-item').remove().end().after(btnTpl);
            }

            this.onlineTab.removeClass('notice');
            this.renderBtn();

            if(datas.status == 3){
                this.tabWrap.find('.tab-timing').text('已完成');
                return;
            }
            this.countDown(HTV.countTime);
        },

        countDown(time) {
            this.taskTabTime = $('.tab-timing');
            this.taskItemTime = $('.item-timing');
            this.btnTaskTime = $('.btn-timing');

            this.countTimer = setInterval(() => {
                if(time == 0){
                    clearInterval(this.countTimer);
                    this.taskTabTime.html('可领取');

                    this.onlineTab.addClass('notice');
                    this.renderBtn();

                    this.taskItemTime
                        .removeClass('item-timing disable')
                        .addClass('able').text('领取');

                    $('.getbeans-btn')
                        .removeClass('disabled')
                        .find('.beans').text('x'+HTV.beansNum)
                        .end().find('.btn-timing').hide()
                        .siblings('span').text('领取');

                    //通知领取金豆结果
                    Flash.send('getBeans', {
                      "msg": "你有" + HTV.beansNum + "个金豆可 <FONT COLOR='#ff7e00'><a href='event:getBeans'>领取</a></FONT>",
                      "dur": 1.5
                    });
                    return ;
                }
                var minute = parseInt(time/60) < 10 ? '0'+parseInt(time/60) : parseInt(time/60);
                var second = parseInt(time%60) < 10 ? '0'+parseInt(time%60) : parseInt(time%60);

                this.taskTabTime.html(minute+':'+second+'后可领取');
                this.taskItemTime.html(minute+':'+second);
                this.btnTaskTime.html(minute + ':' + second);

                time--;

            }, 1000);

        },

        renderBtn() {
            if(this.tab.hasClass('notice')){
                this.taskBtn.addClass('notice');
            }else{
                this.taskBtn.removeClass('notice');
            }
        }

    };

    module.exports = Task;
