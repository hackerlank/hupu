var User = require("common:widget/login/login.js");
var Toast = require("common:widget/toast/toast.js");
var Dialog = require('common:widget/dialog/dialog');
var Flash = require('common:widget/flash-movie/flash');
var SideTab = require('live:widget/side-col-1/side');
var _ = require('common:static/js/underscore/underscore.js');


/**
 * 接口地址
 */
var apiUrl = {
    // 获取列表
    list: '/predict/topic/list/:id',
    // 预测
    predict: '/predict/join'
};

/**
 * 送礼物
 */
var PredGame = {
  init() {
    var self = this;

    this.$wrap = $('#J_predGame');

    if(!this.$wrap.length){
        return;
    }

    this.$content = this.$wrap.find('.J_content');
    this.$buttonSubmit = this.$wrap.find('.J_buttonSubmit');
    this.$selectText = this.$wrap.find('.J_SelectText');

    // 排行榜模板
    this.predTpl = $('#pred-tpl').html();

    this.topic_id = 0;
    this.score = 20;
    this.option_id = 0;
    // 全部数据
    this.lists = {};
    this.timerHeart = null;
    // 待更新数据
    this.awaitUploadData = {};

    this.getList();
    this.heart();
    this.bind();
  },
  bind() {
    var self = this;

    //DOM会被重新替换，所以事件委托.
    this.$content.delegate('.J_buttonOption', 'click', (e) => {
      this.handleSelect($(e.currentTarget));
    })

    this.$buttonSubmit.on('click', e => {
      this.sendPred();
    })

    $(document).on('wall', (e, data) => {
      self.wall(data);
    })
  },
  wall(data) {
    // 预测题开奖用户小红点
    if(data.et == 2003) {
      $(document).trigger("rpzAddNotify");
    }

    if(!data.toid) {
      return;
    }

    let index = this.findIndex(data.toid);
    let list = this.lists[index];

    // 新增预测题
    if(data.et == 3015) {
      list = this.newPredData(data);
      this.lists.unshift(list);

      SideTab.newMessage();
      this.replaceRender([list], true);

      Flash.send('newPredict', list, json => {
        let params = $.parseJSON(json);

        this.topic_id = params.topic_id;
        this.option_id = params.option_id;

        this.sendPred();
      });
      return;
    }

    // 查找不能预测
    if(index == -1) {
      return;
    }

    // 参与预测
    if(data.et == 2002) {
      list = this.modifyPred(list, data);
      return;
    }

    switch(data.et) {
      // 预测题修改
      case 3016:
        list = this.newPredData(data);
        this.lists[index] = list;
        break;
      // 预测题封盘
      case 3017:
        list.status = 1;
        break;
      // 预测题开奖
      case 3018:
        list.status = 2;
        list.right_option = data.ro;

        SideTab.newMessage();
        break;
      // 预测题流盘
      case 3019:
        list.status = 3;
        break;
      default:
    }

    Flash.send('predictCancel', list);
    this.replaceRender([list]);
  },
  getList() {
    let url = apiUrl.list.replace(':id', HTV.roomID);

    $.ajax({
      url: url,
      type: "GET",
      dataType: 'json',
      success: data => {
        if(data.code === 1) {
          this.lists = data.data;

          this.render();
        }
      }
    });
  },
  /**
   * 默认渲染
   */
  render() {
    if(!this.lists.length) {
      return;
    }

    let result = {
      datas: this.lists,
      statusClass: this.statusClass,
      // 选择最大数
      max: this.max,
      // 转换百分比
      rate: this.rate
    }

    let template = _.template(this.predTpl)(result);

    this.$content.html(template);
  },
  /**
   * 替换渲染
   */
  replaceRender(list, isNewPred = false) {
    let result = {
      datas: list,
      statusClass: this.statusClass,
      // 选择最大数
      max: this.max,
      // 转换百分比
      rate: this.rate
    }

    let template = _.template(this.predTpl)(result);

    if(isNewPred) {
      this.$content.prepend(template);
      this.$content.find('.not-content').hide();
    }else{
      let $list = this.$content.find('.J_predGameList[data-id="'+ list[0].id +'"]');
      $(template).replaceAll($list);
    }

  },
  heart(){
    let self = this;

    this.timerHeart = setInterval(() => {
      this.remindOptionRender();
    }, 2000);
  },
  /**
   * 选择选项
   */
  handleSelect(elem) {
    let self = this;

    if(!HTV.isLogin){
      return User.login();
    }

    let $parent = elem.parents('.J_predGameList');

    this.topic_id = $parent.attr('data-id');
    this.score = $parent.attr('data-score');
    this.option_id = elem.attr('data-option-id');
    this.option_text = elem.text();

    let $buttonAll = this.$content.find('.J_buttonOption');

    // 选中状态
    if(elem.hasClass('button-hover')) {
      elem.removeClass('button-hover');
      this.comfimHide();
    }else{
      $buttonAll.removeClass('button-hover');
      elem.addClass('button-hover');
      this.comfimShow();
    }
  },
  handleSubmit() {
    let self = this;
    let rate = HTV.predData.magnification || 1 ;

    let content = '<div class="popup-pred-game"><div class="title">确认选择<b>' + this.option_text + '</b></div><div class="content">该题人品值基准分为' + this.score + '分，您的当前赢率为' + rate + '，<br />确认后将无法修改答案  </div></div>';

    Dialog({
      content: content,
      confirm: {
        text: '确认',
        callback: () => {
          this.sendPred();
        }
      }
    });
  },
  /**
   * 发送预测
   */
  sendPred() {
    let url = apiUrl.predict;

    if(!HTV.isLogin){
      return User.login();
    }

    let params = {
      topic_id: this.topic_id,
      option: this.option_id
    }

    $.ajax({
      url: url,
      type: 'POST',
      data: params,
      dataType: 'json',
      success: data => {
        if(data.code == 1){
          this.comfimHide();
          return;
        }

        Toast.toast(data.msg);
      }
    });
  },
  comfimShow(text) {
    this.$wrap.addClass('live-pred-game-active');
    this.$selectText.text(this.option_text);
  },
  comfimHide() {
    this.$wrap.removeClass('live-pred-game-active');
  },
  /**
   * 修改预测数据
   */
  modifyPred(data, newData) {
    let option = _.map(data.option, item => {
      (item.option_id == newData.uop) ? item.total_count = newData.tc : null;

      return item;
    })

    data.option = option;

    if(HTV.getUserId == newData.puid) {
      data.user_option = newData.uop;
      this.replaceRender([data]);
    }else{
      this.awaitUploadData[data.id] = data;
    }


    return data;
  },
  /**
   * 新预测数据
   */
  newPredData(data) {

    let option = _.map(data.option, item => {
      return {
        option: item.op,
        option_id: item.opid,
        total_count: 0
      }
    })

    let params = {
      id: data.toid,
      title: data.title,
      option: option,
      score: data.score,
      status: 0,
      right_option: 0,
      user_option: 0
    }

    return params;
  },
  /**
   * 提示选择题
   */
  remindOptionRender(data) {
    let lists = this.awaitUploadData;

    for(let i in lists) {
      let item = lists[i];

      let rate = this.rate(item.option);
      let optionText = this.max(item.option).option;
      let str = rate + '的人选择 [' + optionText + ']';
      let $content = this.$content.find('.J_predGameList[data-id="'+ item.id +'"] .remind-option');

      delete lists[i];

      $content
        .show()
        .text(str);
    }

  },
  /**
   * 状态class
   */
  statusClass(data, id) {
    let name = '';

    if(data.user_option) {
      // 用户选择
      if(data.user_option == id) {
        name += ' button-active'
      }
    }

    // 正常答案
    if(data.right_option == id) {
      name += ' button-correct'
    }

    return name;
  },
  /**
   * 查找相同ID位置
   */
  findIndex(id) {
    let index = -1;

    _.map(this.lists, (item, key) => {
      if(item.id == id) {
        index = key
      }
    })

    return index;
  },
  /**
   * 取最大数
   */
  max(data) {
    return _.max(data, function(option){ return option.total_count })
  },
  /**
   * 转换百分比
   * @param  {[type]} data [description]
   * @return {[type]}      [description]
   */
  rate(data) {
    let number = this.max(data).total_count,
      total = 0;

    _.map(data, item => {
      total += (+item.total_count);
    })

    return (Math.round(number / total * 100) || 100) + '%'
  }
};

module.exports = PredGame;
