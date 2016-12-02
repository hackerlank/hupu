import angular from 'angular';
import uiRouter from 'angular-ui-router';
import loginComponent from './login.component';

let loginModule = angular.module('login', [
  uiRouter
])
.config(['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) => {
  "ngInject";

  $stateProvider
    .state('login', {
      url: '/',
      views: {
        'content@': {
          template: '<login></login>'
        }
      },
      data: {
        loginCheck: false
      }
    });
}])

.component('login', loginComponent);

export default loginModule;
