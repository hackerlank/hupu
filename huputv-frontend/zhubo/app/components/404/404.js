import angular from 'angular';
import uiRouter from 'angular-ui-router';
import Component from './404.component';

let loginModule = angular.module('no404', [
  uiRouter
])
.config(($stateProvider, $urlRouterProvider) => {
  "ngInject";

  $stateProvider
    .state('app.404', {
      url: '/404',
      views: {
        'content@': {
          template: '<ui404></ui404>'
        },
        'footer@': {
          template: ''
        }
      }
    });
})

.component('ui404', Component);

export default loginModule;
