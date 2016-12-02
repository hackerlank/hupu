import angular from 'angular';
import uiRouter from 'angular-ui-router';
import liveComponent from './live.component';
// 热线
import liveHotline from './hotline/hotline';
// 视频参数
import liveVideoParams from './videoParams/video';
// 主播发言
import ZhuboSpeak from './speak/speak';
// 设置房间
import SettingRoom from './settingRoom/room.directive';
// // 设置礼物
import Gift from './gift/gift.directive';

let loginModule = angular.module('live', [
  uiRouter,
  liveHotline.name,
  liveVideoParams.name,
  ZhuboSpeak.name,
  Gift.name,
  SettingRoom.name
])
.config(['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) => {
  "ngInject";

  $stateProvider
    .state('app.live', {
      url: '/live',
      views: {
        'content@': {
          template: '<live></live>'
        }
      },
      data: {
        displayName: '直播间'
      }
    });
}])
.component('live', liveComponent);


export default loginModule;
