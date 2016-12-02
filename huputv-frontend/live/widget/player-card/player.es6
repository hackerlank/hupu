var _ = require('common:static/js/underscore/underscore.js');
var User = require("common:widget/login/login");
var Toast = require("common:widget/toast/toast");
var Dialog = require('common:widget/dialog/dialog');
var Basil = require('common:widget/sessionStorage/basil');
var Util = require('common:widget/util/util');
var SendGift = require('live:widget/send-gift/gift.es6');


/**
 * 接口地址
 */
var apiUrl = {
  // 获取列表
  list: '/passerbyking/player/list/:id',
  // 送礼物
  sendGift: '/gift/send'
};

/**
 * 送礼物
 */
var PlayerCard = {
  init() {
    var self = this;

    this.$wrap = $('#J_playerCardInfo');

    if(!this.$wrap.length){
        return;
    }

    this.playerData = {};
    this.giftID = 0;

    // 球员模板
    this.playerTpl = $('#player-card-tpl').html();

    this.getList();
    this.bind();
  },
  bind() {
    var self = this;

    //DOM会被重新替换，所以事件委托.
    this.$wrap.delegate('.J_buttonSupport', 'click', (e) => {
      this.handleSendGift($(e.currentTarget));
    })

    $(document).on('wall', (e, data) => {
      self.wall(data);
    })
  },
  wall(data) {
    if(!data.pid && !data.tgid) {
      return;
    }

    let pid = data.pid ? data.pid : data.tgid;

    let index = this.findIndex(pid);
    let list = this.playerData.lists[index];

    switch(data.et) {
      // 送礼
      case 2001:
        list.lightness = data.ln;
        let top5 = this.getTop5Data(this.playerData.lists);

        this.playerData.top = top5;
        break;
      // 赛事球员淘汰out
      case 4001:
        list.status = 2;
        break;
      // 赛事球员弃权
      case 4002:
        list.status = 3;
        break;
      // 赛事球员恢复上场（补位）
      case 4003:
        list.status = 1;
        break;
      // 赛事球员胜率更新
      case 4004:
        list = this.modifyPlayerData(list, data);
        break;
      default:
    }

    this.render();
  },
  /**
   * 获取列表
   */
  getList() {
    let url = apiUrl.list.replace(':id', HTV.gameID);

    $.ajax({
      url: url,
      type: "GET",
      dataType: 'json',
      success: data => {
        if(data.code === 1) {
          let lists = data.data.player;
          let top5 = this.getTop5Data(lists);



          this.giftID = data.data.light_type[0].gift_id;

          this.playerData = {
            lists: lists,
            top: top5
          };

          this.render();
        }
      }
    });
  },
  render() {
    let result = {
      datas: this.playerData.lists,
      top: this.playerData.top,
      sub: Util.subString,
      rate: (number, total) => {
        return (Math.round(number / total * 100) || 100) + '%'
      }
    }

    let template = _.template(this.playerTpl)(result);

    this.$wrap.html(template);
  },
  /**
   * 选择选项
   */
  handleSendGift(elem) {
    let self = this;
    let basil = Basil();

    let playerID = elem.attr('data-id');
    let username = elem.attr('data-name') || '';

    let params = {
      game_id: HTV.gameID,
      target_id: playerID,
      live_type: 3
    };

    let content = '<div style="font-size: 14px;color: #d04646;text-align: center;">将消耗您账户中的 1 虎扑币，球员会获得 10 瓦亮度</div> <div style="padding-top: 20px;font-size:14px;text-align: center;color: #999;">确认后不再提醒</div>';

    if(basil.get('playerCard')) {
      this.send(params, playerID, elem);
    }else{
      Dialog({
        title: '<div style="text-align: center;">确认支持 '+ username +'？</div>',
        content: content,
        confirm: {
          text: '确认',
          callback: () => {
            basil.set('playerCard', '1');

            this.send(params, playerID, elem);
          }
        }
      });
    }

  },
  /**
   * 发送礼物
   */
  send(params, playerID, elem) {
    let self = this;

    SendGift.send(this.giftID, 1, params, data => {
      Toast.addNumberToast('+10', this.$wrap.find('.J_buttonSupport[data-id="'+ playerID +'"]'));
    })
  },
  /**
   * 修改球员数据
   */
  modifyPlayerData(data, newData) {

    data.total_game = newData.tg;
    data.total_win = newData.tw;

    return data;
  },
  /**
   * 获取排行5数据
   */
  getTop5Data(data) {
    let sort = _.sortBy(data, item => +item.lightness).reverse();

    return sort.slice(0, 5);
  },
  /**
   * 查找相同ID位置
   */
  findIndex(id) {
    let index = -1;

    this.playerData.lists.map((item, key) => {
      if(+item.player_id == id) {
        index = key
      }
    });

    return index;
  }
};

module.exports = PlayerCard;
