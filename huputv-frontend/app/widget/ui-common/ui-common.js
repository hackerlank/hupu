var app = require('app:widget/ui-app/ui-app.js');

var common = {
  isInApp : ~navigator.userAgent.indexOf('kanqiu'),
  isInWeixin: ~navigator.userAgent.indexOf('MicroMessenger'),
  login: function(login, callback){
    if(login){
      callback && callback()
    } else{
      //APP唤起app登陆
      if(common.isInApp){
        app.checkLogin(callback, 0);
      //其他唤起无线登陆
      }else {
        location.href = this.joinJump(GM.login_url, location.href);
      }
    }
  },
  joinJump: function(loginbase, jump){
    var concat = ~loginbase.indexOf("?") ? '&' : '?';
    return loginbase + concat + 'jumpurl=' + encodeURIComponent(jump)
  },
  withRoomUrl: function(roomId){
    var isInApp = GM.isInApp;
    var url = "";
    if(isInApp) {
        url = 'huputiyu://huputv/room/' + roomId;
    } else {
        url = '/m/room/' + roomId + '?n=' + GM.n + '&client=' + GM.client;
    }
    return url;
  }
};

module.exports = common
