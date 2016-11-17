var _ = require('common:static/js/underscore/underscore.js');
var VideoPlay = require('live:widget/video-play/video.js');
var GiftTop = require('live:widget/gift-top/top');

// 位置数组
let postionArray = [],
    // 累计数组
    queueGiftArray = [];

for(var i = 0; i < 3; i++) {
    postionArray.push({
        id: '',
        username: '',
        className: '',
        count: 0,
        timer: null,

        showTime: 0
    });
}

/**
 * 礼物特效
 */
var GiftEffects = {
    init() {
        this.$batterTip = $('#J_giftBatterTip');
    },
    /**
     * 热线数据
     * @param data
     */
    wall(data, isGiftTop) {
        if(data.length !== 1 ){
            return;
        }

        if(typeof data[0].tv_gift === 'undefined'){
            return;
        }

        var giftData = this.getGiftData(data[0]);

        // 礼物类型 1金豆 6虎扑币
        if(giftData.money_type == 1){
            return;
        }

        if(!isGiftTop){
            // 更新礼物排行榜
            GiftTop.getTopData();
        }

        if(giftData.position){
            try {
                /**
                 * 送礼物
                 * @param  {object} data                   礼物信息
                 * @config {string} cover_url              封面
                 * @config {string} effect_file_flash_url  动画flash
                 * @config {string} effect_file_gif_url    GIF素材
                 * @config {string} effect_file_icon_url   icon
                 * @config {number} id                     礼物ID
                 * @config {number} money_type             礼物类型 {1金豆 6虎扑币}
                 * @config {string} name                   礼物名字
                 * @config {number} number                 这次送礼物数量
                 * @config {number} total                  送礼物总数
                 * @config {number} position               送礼位置 ｛1右上角从右至左展出 2人浪 增加屏幕特效-屏幕下方由下至上展出｝
                 * @config {string} username               礼物名字
                 */
                VideoPlay.videoFlashMovie().vjs_rcvGift(giftData);
            } catch(err) {
            }
        }

        this.batter(giftData);

        return giftData;
    },
    batter(data) {

        // 对比礼物是否在展示
        let repeatIndex = this.compareSameValue(data, postionArray);
        let nullIndex = this.getArrNullIndex(postionArray);

        // 展示超过3个，阻止
        if((nullIndex == -1 && repeatIndex == -1)){
            this.pushGiftData(data);
            return;
        }


        if(repeatIndex == -1){
            let arr = postionArray[nullIndex],
                newName = 'J_batterList_' + (+new Date);

            // 生成礼物层
            let tpl = this.tipRender(data, newName, nullIndex);
            this.$batterTip.append(tpl);

            let $tips = $('.' + newName),
                $bg = $tips.find('.batter-bg');

            $bg.animate({
                width: '300px'
            }, 300, () => {
                this.countRender($tips, data, nullIndex, true);
            });

            arr.id = data.id;
            arr.className = newName;
            arr.username = data.username;

        }else{
            let $tips = $('.' + postionArray[repeatIndex].className);
            this.countRender($tips, data, repeatIndex);
        }

    },
    /**
     * 连击渲染模板
     */
    tipRender(data, className, index) {
        let top = (index * 65 + 5) + 'px';

        let username = this.sub(data.username, 12);

        let tpl = `
            <div class="batter-list ${className}" style="top: ${top}">
                <i class="icon-dec"></i>
                <div class="batter-bg">
                    <div class="batter-inner">
                        <div class="gift-pic">
                            <img src="${data.effect_file_gif_url}" alt=""/>
                        </div>
                        <div class="gift-text">
                            <div class="name">${username}</div>
                            <div class="send-gift-name">送出了${data.name}</div>
                        </div>
                        <i class="icons-multiply"></i>
                        <div class="better-count"></div>
                    </div>
                </div>
            </div>
        `;

        return tpl;
    },
    /**
     * 数字模板
     */
    countRender(elem, data, index, isBatter) {
        let tpl = '',
            arr = data.total.toString().split('');

        for(var i in arr){
            tpl += `<i class="count-${arr[i]}"></i>`;
        }

        let $countWarp = elem.find('.better-count'),
            $bg = elem.find('.batter-bg');

        $countWarp.html(tpl);

        let tempArr = postionArray[index],
            showTime = 0;

        clearTimeout(tempArr.timer);

        // 连击事件,已展示时间
        if(!isBatter){
            showTime = ((+new Date()) - tempArr.showTime) / 1300;
        }else{
            tempArr.showTime = (+new Date());
        }

        // 退场时间，最大20秒
        let timeout = () => {
            let number = data.number,
                tempTime = 0;

            // 批量送礼
            if(number > 1){
                tempTime = Math.abs(data.number / 3);
            }else{
                tempTime = Math.abs(tempArr.count + .5 - showTime)
            }

            // 批量送礼
            if(data.number > 2333){
                tempTime = 40;
            }else{
                tempTime = (tempTime > 20 ? 20 : tempTime);
            }

            return tempTime;
        };



        tempArr.count++;

        tempArr.timer = setTimeout(() => {
            $bg.animate({
                width: 0
            }, 300, () => {
                // 重置
                tempArr.id = '';
                tempArr.username = '';
                tempArr.timer = null;
                tempArr.count = 0;
                tempArr.showTime = 0;
                elem.remove();

                this.grandTotailData();
            });
        }, timeout() * 1000);

        !isBatter && $countWarp
            .addClass('gift-better-antmation')
            .on('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend ', () => {
                $countWarp.removeClass('gift-better-antmation');
            });
    },
    /**
     * 获取礼物数据
     * @param data
     */
    getGiftData(data) {

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
     * 对比相同值
     */
    compareSameValue(data, arr) {
        let index = -1;

        // 送礼物数为1，才会有连击
        if(data.number == 1){
            index = _.findIndex(arr, {
                id: data.id,
                username: data.username
            })
        }

        return index;
    },
    // 取空值key位置
    getArrNullIndex(arr) {
        var index = -1;

        for(var i = 0, len = arr.length; i < len; i++) {
            if(arr[i].id == ""){
                index = i;
                break;
            }
        }

        return index;
    },
    /**
     * 推送礼物数据
     * @param data
     */
    pushGiftData(data) {

        if(!queueGiftArray.length){
            data.batter = 0;
            queueGiftArray.push(data);
            return;
        }

        let findIndex = _.findIndex(queueGiftArray, {
            id: data.id,
            username: data.username
        });

        //
        if(findIndex == -1){
            data.batter = 0;
            queueGiftArray.push(data);
        }else{
            queueGiftArray[findIndex].batter += 1;
        }
    },
    /**
     * 累计数据
     */
    grandTotailData() {
        if(!queueGiftArray.length){
            return;
        }

        let data = queueGiftArray.shift();

        // 连击效果
        if(!_.isUndefined(data.batter) && data.batter >= 1){
            let timer = setInterval(() => {

                if(data.batter <= 0){
                    clearInterval(timer);
                    return;
                }

                data.total++;
                this.batter(data);

                data.batter--;
            }, 400);
        }

        this.batter(data);
    },
    /**
     * 截取
     * @param str
     * @param n
     * @returns {*}
     */
    sub(str,n) {
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
};

module.exports = GiftEffects;

