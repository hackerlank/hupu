var _ = require('common:static/js/underscore/underscore.js');
var Gift = require('live:widget/send-gift/gift');
var SideTab = require('live:widget/side-col-1/side');

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

    this.$content = this.$wrap.find('.J_giftContent');
    // 排行榜模板
    this.topTpl = $('#gift-top-tpl').html();

    this.bind();
    this.getTopData();
  },
  bind() {

    // $(document).on('wall', (e, data) => {
    //   this.wall(data);
    // })
  },
  wall(data) {

    if(SideTab.index() !== 3) {
      return;
    }

    // 礼物
    if(data.et == 2001) {
      let detail = Gift.getGiftDetail(data.giftid, data.lt);

      // 送礼物是虎扑币
      if(+detail.money_type === 6 || +data.lt === 3) {
        this.getTopData();
      }
    }
  },
  /**
   * 获取数据
   */
  getTopData() {

    $.ajax({
      url: apiUrl.getGiftTop,
      type: "GET",
      cache: false,
      dataType: 'json',
      success: (data) => {
        if(data.code === 1) {
          let list1 = {
                datas: [],
                self: [],
                title: '本场排行',
                sub: this.sub,
                isLogin: HTV.isLogin
              },
              list2 = {
                datas: [],
                self: [],
                title: '总排行',
                sub: this.sub,
                isLogin: HTV.isLogin
              },
              str = '';

          if(data.data.match_ranking) {
            list1.datas = data.data.match_ranking.room;
            list1.self = data.data.match_ranking.user;
          }

          if(data.data.room_ranking) {
            list2.datas = data.data.room_ranking.room;
            list2.self = data.data.room_ranking.user;
          }

          if(!list1.datas.length && !list2.datas.length) {
            str = '<div class="all-not-gift">该主播还未收到礼物，快去打赏一下吧</div>'
          }else{
            str = _.template(this.topTpl)(list1) + _.template(this.topTpl)(list2);
          }

          this.$content.html(str);

        }
      }
    });
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
