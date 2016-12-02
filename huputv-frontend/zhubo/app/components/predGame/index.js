import angular from 'angular';
import uiRouter from 'angular-ui-router';
import indexComponent from './index.component';
// 新建预测
import createPred from './createPred/pred.directive';

let loginModule = angular.module('predGame', [
  uiRouter,
  createPred.name
])
.config(['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) => {
  "ngInject";

  $stateProvider
    .state('app.predGame', {
      url: '/pred_game',
      views: {
        'content@': {
          template: '<pred-game></pred-game>'
        }
      },
      data: {
        displayName: '比赛预测'
      }
    });
}])

.component('predGame', indexComponent);

export default loginModule;
