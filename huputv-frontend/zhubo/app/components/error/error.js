import angular from 'angular';
import uiRouter from 'angular-ui-router';
import Component from './error.component';

let loginModule = angular.module('noCompetence', [
  uiRouter
])
.config(($stateProvider, $urlRouterProvider) => {
  "ngInject";

  $stateProvider
    .state('app.error', {
      url: '/error',
      params: {
        page: 1000,
      },
      views: {
        'content@': {
          template: '<ui-no-competence></ui-no-competence>'
        },
        'footer@': {
          template: ''
        }
      }
    });
})

.component('uiNoCompetence', Component);

export default loginModule;
