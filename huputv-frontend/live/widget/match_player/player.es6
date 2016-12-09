var _ = require('common:static/js/underscore/underscore.js');
var tapLink = require("common:widget/tap-link/tap-link.js");
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
  // 送礼物
  sendGift: '/gift/send'
};

/**
 * 送礼物
 */
var PlayerCard = {
  init() {
    var self = this;
    this.targetSidebar = $(".target-sidebar");

    this.bind();
    tapLink.init(this.targetSidebar);
  },
  bind() {
    var self = this;

  }
};

module.exports = PlayerCard;
