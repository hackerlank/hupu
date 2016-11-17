var _ = require('common:static/js/underscore/underscore.js');

var Instance;

function Timeline() {}

Timeline.prototype = {
    defalut: {
        data: {},
        type: 1000,
        timeout: 2500,
        // 节点被加载
        onLoad: function(time, node) {},
        // 节点被更新
        onUpload: function(time, node) {},
        // 节点被销毁
        onDestroy: function(time, node) {}
    },
    start() {
        var self = this;

        this.$wrap = $('#J_giftBatterTip');

        this.queue = this.queueData();

        this.timerHeart = null;
        this.heart();
    },
    nodes: [{}, {}, {}],
    create(params = {}) {
        params = $.extend(true, {}, this.defalut, params || {});

        let compareIndex = this.getCompare(params);

        if(compareIndex === -1){
            this.queue.add(params);
            this.render();
        }else{
            this.upload(compareIndex);
        }
    },
    render() {
        let index = this.getNullIndex();

        if(index === -1){
            return;
        }

        let data = this.queue.get();

        if(this.isUndefined(data.type)){
            return;
        }

        if(data.type === 1000){
            this.renderGift(data, index);
        }else{
            this.message(data, index);
        }
    },
    /**
     * 更新礼物
     */
    upload(index) {
        let data = this.nodes[index],
            $tip = $('.' + data.className),
            timestamp = +new Date(),
            showTime = (timestamp - data.startDate) / 1300;

        data.data.tn++

        let number = data.data.tn,
            times = this.timeout(number, showTime);

        data.timeout = times;
        data.startDate = timestamp;

        this.giftNumberOffect($tip, number, true);
    },
    heart(){
        let self = this,
            timestamp = 0;

        this.timerHeart = setInterval(() => {
            timestamp = +new Date();

            this.nodes.map((value, index) => {
                if(!this.isUndefined(value.className)
                    && (timestamp - value.startDate) >= value.timeout){

                    if(value.type === 1000){
                        this.removeGift(value.className, index);
                    }else{
                        this.removeMessage(value.className, index);
                    }
                }
            })
        }, 200);
    },
    stop() {

    },
    /**
     * 消息
     */
    message(data, index) {
        let self = this,
            className = 'J_giftMessageList' + (+new Date),
            link = data.data.l,
            top = (index * 65 + 5) + 'px',
            tpl = '';

        var linkTpl = (link ? `<a href="${link}">${link}</a>` : '');

        // 发播发言
        if(data.type === 3001){
            tpl = `
                <div class="gift-message-list zhubo-speak-list ${className}" data-index="${index}" style="top: ${top}">
                    <a href="javascript:" class="button-close J_buttonClose"></a>
                    <div class="message-list-wrap">
                        <dl class="speak-dl">
                            <dd class="speak-avatar">
                                <img src="${data.data.avater_url}" alt="">
                            </dd>
                            <dt class="speak-name">
                                ${data.data.an}
                            </dt>
                            <dd class="speak-content">
                                ${data.data.cnt} ${linkTpl}
                            </dd>
                        </dl>
                    </div>
                </div>
            `;
        }else{
            tpl = `
                <div class="gift-message-list system-speak-list ${className}" data-index="${index}" style="top: ${top}">
                    <a href="javascript:" class="button-close J_buttonClose"></a>
                    <div class="message-list-wrap">
                        <div class="message-title">
                            <i class="icon-system"></i>
                            系统消息
                        </div>
                        <div class="message-content">
                            ${data.data.cnt} ${linkTpl}
                        </div>
                    </div>
                </div>
            `;
        }

        this.$wrap.append(tpl);

        this.$wrap.find('.J_buttonClose')
            .off('click')
            .on('click', function(event){
                var parent = $(this).parents('.gift-message-list');
                self.removeMessage(parent, parent.attr('data-index'));
            });

        data = $.extend(true, {}, data, {
            className: className,
            startDate: +new Date()
        });

        this.nodes[index] = data;

        $('.' + className).animate({
            width: '330px'
        }, 500);
    },
    /**
     * 礼物
     */
    renderGift(data, index) {
        let className = 'J_batterList_' + (+new Date),
            top = (index * 65 + 5) + 'px',
            giftDetail = data.data.giftDetail,
            timeout = (data.data.et === 2001 ? this.timeout(data.data.giftn) : data.timeout),
            username = this.sub(data.data.un, 12);

        let tpl = `
            <div class="batter-list ${className}" style="top: ${top}">
                <i class="icon-dec"></i>
                <div class="batter-bg">
                    <div class="batter-inner">
                        <div class="gift-pic">
                            <img src="${giftDetail.effect_file_gif_url}" alt=""/>
                        </div>
                        <div class="gift-text">
                            <div class="name">${username}</div>
                            <div class="send-gift-name">送出了${giftDetail.name}</div>
                        </div>
                        <i class="icons-multiply"></i>
                        <div class="better-count"></div>
                    </div>
                </div>
            </div>
        `;

        this.$wrap.append(tpl);

        data = $.extend(true, {}, data, {
            className: className,
            un: username,
            giftid: data.data.giftid,
            timeout: timeout,
            startDate: +new Date()
        });

        this.nodes[index] = data;
        this.giftOffect(data);
    },
    /**
     * 礼物效果
     */
    giftOffect(data, isBatter) {
        let $tip = $('.' + data.className),
            $bg = $tip.find('.batter-bg');

        let number = data.data.tn;

        $bg.animate({
            width: '300px'
        }, 300, () => {
            this.giftNumberOffect($tip, number);
        });
    },
    /**
     * 礼物数字效果
     */
    giftNumberOffect($tip, number, isBatter){
        let str = '',
            $numberWarp = $tip.find('.better-count'),
            arr = number.toString().split('');

        for(var i in arr){
            str += `<i class="count-${arr[i]}"></i>`;
        }

        $numberWarp.html(str);

        isBatter && $numberWarp
            .addClass('gift-better-antmation')
            .on('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend ', () => {
                $numberWarp.removeClass('gift-better-antmation');
            });

    },
    removeGift(name, index) {
        let $tip = $('.' + name),
            $bg = $tip.find('.batter-bg');

        $bg.animate({
            width: 0
        }, 300, () => {
            $tip.remove();
            this.nodes[index] = {};
            this.render();
        });
    },
    removeMessage(name, index) {
        let $tip = null;

        if(this.isStringType(name)){
            $tip = $('.' + name);
        }else{
            $tip = name;
        }

        $tip.animate({
            width: 0
        }, 300, () => {
            $tip.remove();
            this.nodes[index] = {};
            this.render();
        });

        this.$wrap.find('.J_buttonClose').off('click');
    },
    /**
     * 数据
     */
    queueData() {
        return {
            data: [],
            // 获取一条
            get() {
                return this.data.length ? this.data.shift() : [];
            },
            // 获取全部
            getAll() {
                return this.data;
            },
            // 添加
            add(params) {
                this.data.push(params);
            }
        }
    },
    /**
     * 对比相同值
     */
    getCompare(data) {
        let index = -1;

        if(data.type === 1000){
            let param = data.data,
                node;

            if(param.giftn == 1){
                for(var i = 0, len = this.nodes.length; i < len; i++) {
                    node = this.nodes[i];
                    if(!this.isUndefined(node.giftid) && node.giftid === param.giftid && node.un === param.un){
                        index = i;
                    }
                }
            }
        }

        return index;
    },
    /**
     * 取空值key位置
     */
    getNullIndex() {
        let index = -1;

        for(var i = 0, len = this.nodes.length; i < len; i++) {
            if(this.isUndefined(this.nodes[i].className)){
                index = i;
                break;
            }
        }

        return index;
    },
    isUndefined(value) {
        return typeof value === 'undefined';
    },
    isStringType(value) {
        return typeof value === "string";
    },
    timeout(number, showTime = 0) {
        var times = 0;

        number = +number;

        // 批量送礼
        if(!showTime && number > 1){
            times = Math.abs(number / 3);
        }else{
            times = Math.abs(number + .5 - showTime)
        }

        // 批量送礼
        if(number > 2333){
            times = 40;
        }else{
            times = (times > 20 ? 20 : times);
        }

        return times * 1000;
    },
    /**
     * 获取礼物数据
     * @param data
     */
    getVideoGiftData(data) {

        let _temp = {
            username: data.username,
            id: data.tv_gift.gift_id,
            number: data.tv_gift.number,
            total: data.tv_gift.total
        }

        if (typeof data.giftDetail !== 'undefined') {
            _temp.cover = data.giftDetail.cover;
            _temp.effect_file_flash_url = data.giftDetail.effect_file_flash_url;
            _temp.effect_file_gif_url = data.giftDetail.effect_file_gif_url;
            _temp.effect_file_icon_url = data.giftDetail.effect_file_icon_url;
            // 1金豆 6虎扑币
            _temp.money_type = data.giftDetail.money_type;
            _temp.name = data.giftDetail.name;
            _temp.position = data.giftDetail.position;
        }

        return _temp;
    },
    /**
     * 截取
     * @param str
     * @param n
     * @returns {*}
     */
    sub(str = "",n) {
        if(typeof str != "string") return "";
        var r = /[^\x00-\xff]/g;
        if(str.replace(r,"mm").length <= n){
            return str;
        }
        var m = Math.floor(n/2);
        for(var i = m; i < str.length; i++){
            if(str.substr(0,i).replace(r,"mm").length>=n){
                return str.substr(0,i);
            }
        }
        return str;
    }
}


module.exports = Timeline;
