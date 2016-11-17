var _ = require('common:static/js/underscore/underscore.js');


/**
 * 接口地址
 */
var apiUrl = {
    // 获取排行榜
    getGiftTop: '/' + HTV.roomID + '/ranking'
};

/**
 * 送礼物排行
 */
var TopGift = {
    init() {
        this.$wrap = $('#J_giftTop');

        if(!this.$wrap.length){
            return;
        }

        this.$tabList = this.$wrap.find('.J_tabList li');
        this.$content = this.$wrap.find('.J_content');

        // 排行榜模板
        this.topTpl = $('#gift-top-tpl').html();
        this.timer = null;

        this.getTopData();
    },
    bind() {
        this.$tabList.on('mouseover', (event) => {
            this.switchTag(event);
        });

        this.$contentList.hover(
            (event) => {
                $(event.currentTarget).addClass('hover');
            },
            (event) => {
                $(event.currentTarget).removeClass('hover');
            }
        )
    },
    /**
     * 获取数据
     */
    getTopData() {

        $.ajax({
            url: apiUrl.getGiftTop,
            type: "GET",
            data: {},
            dataType: 'json',
            success: (data) => {
                if(data.code === 1){
                    let list1 = {},
                        list2 = {},
                        str = '';

                    if(data.data.match_ranking){
                        list1 = {
                            datas: this.subName(data.data.match_ranking.room),
                            self: this.subName(data.data.match_ranking.user),
                            isLogin: HTV.isLogin,
                            active: true
                        };
                    }else{
                        list1 = {
                            datas: [],
                            self: [],
                            isLogin: HTV.isLogin,
                            active: true
                        };
                    }

                    if(data.data.room_ranking || data.data.room_ranking.length){
                        list2 = {
                            datas: this.subName(data.data.room_ranking.room),
                            self: this.subName(data.data.room_ranking.user),
                            isLogin: HTV.isLogin
                        };
                    }else{
                        list2 = {
                            datas: [],
                            self: [],
                            isLogin: HTV.isLogin
                        };
                    }

                    str = _.template(this.topTpl)(list1) + _.template(this.topTpl)(list2);

                    this.$content.html(str);

                    this.$contentList = this.$wrap.find('.J_contentList');
                    this.bind();
                }
            }
        });
    },
    /**
     * 渲染
     */
    render() {



    },
    /**
     * 切换tab
     * @param event
     */
    switchTag(event) {
        let $current = $(event.currentTarget);

        this.$tabList.removeClass('active');
        $current.addClass('active');

        this.$contentList.removeClass('active');
        this.$contentList.eq( $current.index() ).addClass('active');
    },
    /**
     * 截取名字
     * @param data
     * @returns {Array}
     */
    subName(data) {
        let _temp = [],
            str = '';

        if(_.isArray(data)){
            _.map(data, (item) => {
                item.nickname = this.sub(item.nickname, 12);
                _temp.push(item);
            });
        }else{
            data.nickname = this.sub(data.nickname, 12);
            _temp = data;
        }

        return _temp;
    },
    /**
     * 截取
     * @param str
     * @param n
     * @returns {*}
     */
    sub(str="",n) {
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
};

module.exports = TopGift;
