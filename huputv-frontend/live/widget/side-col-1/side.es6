var _ = require('common:static/js/underscore/underscore.js');
var GiftTop = require('live:widget/gift-top/top');

/**
 * 送礼物排行
 */
var SideTab = {
  init() {
    this.$wrap = $('#J_sideTab');

    if(!this.$wrap.length){
      return;
    }

    this.$tabList = this.$wrap.find('.J_tabList li');
    this.$contentList = this.$wrap.find('.J_contentList');
    this.newMes = this.$wrap.find('.J_predNewMessage');
    this.currentIndex = 0;
    // 是否点击预测
    this.isClickPred = false;

    this.bind();
  },
  /**
   * 当前tab
   */
  index() {
    return this.currentIndex + 1;
  },
  bind() {

    this.$tabList.on('click', (event) => {
      let index = $(event.currentTarget).index();
      this.currentIndex = index;
      this.switchTag(index);
    });
  },
  /**
   * 切换tab
   * @param event
   */
  switchTag(index = 0) {

    this.$tabList.removeClass('active');
    this.$tabList.eq(index).addClass('active');

    this.$contentList.removeClass('active');
    this.$contentList.eq(index).addClass('active');

    // 切换礼物排行
    if(this.currentIndex === 2) {
      GiftTop.getTopData();
    }

    (this.currentIndex === 1) && this.newMes.hide();
  },
  /**
   * 新消息
   */
  newMessage() {
    (this.currentIndex != 1) && this.newMes.show();
  }
};

module.exports = SideTab;
