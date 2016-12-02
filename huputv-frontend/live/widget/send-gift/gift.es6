var _ = require('common:static/js/underscore/underscore.js');
var User = require("common:widget/login/login.js");
var Toast = require("common:widget/toast/toast.js");
var dace = require("common:widget/page-dace/page-dace.es6");
var VideoPlay = require('live:widget/video-play/video.js');
var Dialog = require('common:widget/dialog/dialog');


/**
 * 接口地址
 */
var apiUrl = {
    // 送礼物
    sendGift: '/gift/send'
};

/**
 * 送礼物
 */
var SendGift = {
    init(callback) {

        this.$wrap = $('#J_sendGiftList');

        if(!this.$wrap.length){
            return;
        }

        this.$list = this.$wrap.find('li');
        this.$button = this.$wrap.find('.J_giftButton');
        this.$batchGiftList = this.$wrap.find('.J_batchSendGift a');
        // 钱包
        this.$walletCount = $('#J_myWallet .J_count');

        this.$body = $('body');
        this.width = this.$list.eq(0).width();
        this.beansCount = +this.$wrap.attr('data-beans');
        this.goldCount = +this.$wrap.attr('data-gold');

        this.len = this.$list.length;
        this.timer = null;
        this.toastTime = null;
        this._client = 'chat_' + HTV.chatSocketData + '_' + (HTV.isLogin ? HTV.getUserId : '0' );
        // 获取最后请求
        this.ajaxQueue = 0;
        // 临时礼物ID
        this.tempGiftId = 0;

        this.bind();
    },
    bind() {

        let $parent = null,
            $target = null;

        this.$list.hover(
            (event) => {
                clearTimeout(this.timer);
                this.$list.removeClass('hover');
                $(event.currentTarget).addClass('hover');
            },
            (event) => {
                this.timer = setTimeout(() => {
                    this.$list.removeClass('hover');
                }, 500)
            }
        );

        this.$button.on('click', (event) => {
            $parent = $(event.currentTarget).parents('li');
            this.send($parent);
        });

        this.$batchGiftList
            .hover(
                (event) => {
                    this.overEvent(event);
                },
                (event) => {
                    this.outEvent(event);
                }
            )
            .on('click', (event) =>{
                $target = $(event.currentTarget);
                $parent = $target.parents('li');
                this.send($parent, this.getGiftCount($target));
            });
    },
    /**
     * 移上事件
     * @param event
     */
    overEvent(event) {
        let $target = $(event.currentTarget),
            $parent = $target.parents('li'),
            sendGiftCount = +this.getGiftCount($target),
            $price = $parent.find('.J_giftPrice'),
            priceCount = +$price.attr('data-price');

        $price.html(sendGiftCount * priceCount);
    },
    /**
     * 离开事件
     * @param event
     */
    outEvent(event){
        let $target = $(event.currentTarget),
            $parent = $target.parents('li'),
            $price = $parent.find('.J_giftPrice'),
            priceCount = +$price.attr('data-price');

        $price.html(priceCount);
    },
    /**
     *
     */
    addBeans(count = 0) {

        this.beansCount += count;
        this.uploadBeansDOM();
    },
    /**
     * 显示提示层
     * @param e
     */
    send(parent, number = 1, params, callback) {
        let isElem = parent instanceof jQuery;

        let giftID = isElem ? parent.attr('data-id') : parent;

        if(!HTV.isLogin){
            User.login();
            return;
        }

        let sendData = {
            room_id: HTV.roomID,
            gift_id: giftID,
            number: number,
            live_type: 1
        }

        // 其它参数
        if(_.isObject(params)){
          sendData = _.extend(sendData, params)
        }

        // 获取礼物详情
        let giftData = this.getGiftDetail(giftID, sendData.live_type);

        if(_.isUndefined(giftData.id)){
            return;
        }

        // 价格
        let price = (+giftData.price) * (+number);

        // 礼物类型 1金豆 6虎扑币
        if(+giftData.money_type == 6){
            if(this.goldCount < price){
                Dialog({
                    content: '你的虎扑币余额不足，是否立即充值？',
                    confirm: {
                      text: '充值',
                      callback: function() {
                        window.location.href = HTV.rechargeUrl;
                      }
                    }
                });
                return;
            }
        }else{
            if(this.beansCount < price){
                if(this.goldCount >= price ){
                    Dialog({
                        content: '你的金豆余额不足，是否使用虎扑币购买？<br /><div style="font-size: 14px;color:#c01e2f">虎扑币与余额兑换比例为 1：1</div>',
                        confirm: {
                          text: '购买',
                          callback: function() {
                            window.location.href = HTV.beansRechargeUrl;
                          }
                        }
                    });
                }else{
                    Dialog({
                        content: '你的虎扑币余额不足，是否立即充值？',
                        confirm: {
                          text: '充值',
                          callback: function() {
                            window.location.href = HTV.rechargeUrl;
                          }
                        }
                    });
                }
                return;
            }
        }

        dace.sendBaiduEvent(["PC礼物发送总数", "PC_礼物次数_" + giftData.name, "PC_礼物次数_" + giftData.name + "_" + HTV.roomID + "_" + JSON.stringify(sendData)]);

        // 取最后ajax最后的请求
        this.ajaxQueue++;
        sendData.queue = this.ajaxQueue;
        this.tempGiftId = giftID;

        $.ajax({
            url: apiUrl.sendGift,
            type: "POST",
            data: sendData,
            dataType: 'json',
            success: (data) => {
                // 未登录
                if(data.code == -3011){
                    User.login();
                    return;
                }

                // 金额不足
                if(data.code == -3005){
                    return;
                    //this.popupBuy();
                }

                if(data.code == 1){
                    if(this.ajaxQueue == data.data.queue){
                        // 更新金额
                        this.beansCount = data.data.balance[1];
                        this.goldCount = data.data.balance[6];

                        this.uploadBeansDOM();
                    }

                    dace.sendBaiduEvent(["PC礼物发送成功数", "PC_礼物次数_发送成功", "PC_礼物次数_发送成功_" + HTV.roomID + "_" + JSON.stringify(sendData)]);
                    callback && callback(data);
                    return;
                }

                // 礼物未上架
                if(data.code == -3004){
                    HTV.giftDataId[this.tempGiftId].enable = "0";
                }

                Toast.toast(data.msg);
            }
        });

    },
    /**
     * 获取礼物详细
     * @param datas
     */
    getGiftDetail(id, type){
        let result = {};

        if(+type === 1){
            _.map(HTV.giftData, item => {
                // 礼物下架，查找不到礼物过滤
                if(item.id === id){
                    result = item;
                }
            })
        }else if(+type === 2){
            _.map(HTV.chaoneng.chaoneng_gift, item => {
                if(item.id == id){
                    //获取技能代表队伍的名称
                    if(item.id == HTV.chaoneng.home_gift){
                       item.teamName = HTV.chaoneng.home_team_info.cn_name;
                    } else{
                       item.teamName = HTV.chaoneng.guest_team_info.cn_name;
                    }

                    result = item;
               }
            });

        }else{
          result = {
            id: 0,
            money_type: 1,
            price: 1,
            name: '路人王球员卡片'
          }
        }

        return result;
    },
    /**
     * 成功提示
     */
    successToast(elem, data) {
        let width = $(elem).width(),
            $toast = $('#J_uiSuccessToast');

        if(!$toast.length){
            return;
        }

        let left = elem.index() * width + 15,
            str = `x${data[0].giftDetail.sent_total}`;

        clearTimeout(this.toastTime);

        $toast
            .addClass('ui-success-toast-hide')
            .html(str)
            .css({
                left: left
            });

        this.toastTime = setTimeout(() => {
            clearTimeout(this.toastTime);
            $toast
                .removeClass('ui-success-toast-hide')
        }, 1130);
    },
    /**
     * 更新DOM
     */
    uploadBeansDOM() {
        this.$walletCount.eq(0).html(this.goldCount);
        this.$walletCount.eq(1).html(this.beansCount);
    },
    /**
     * 获取礼物数
     * @param elem
     */
    getGiftCount(elem) {
        return elem.text().replace(/[^0-9]/ig,"") || 1;
    }
};

module.exports = SendGift;
