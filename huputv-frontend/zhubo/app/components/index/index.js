import angular from 'angular';
import uiRouter from 'angular-ui-router';
import indexComponent from './index.component';

let loginModule = angular.module('index', [
  uiRouter
])
.config(['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) => {
  "ngInject";

  $stateProvider
    .state('app.index', {
      url: '/index',
      views: {
        'content@': {
          template: '<index></index>'
        }
      },
      data: {
        displayName: '首页'
      }
    });
}])

.component('index', indexComponent);

export default loginModule;
