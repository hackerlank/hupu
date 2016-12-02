'use strict';

import angular from 'angular';
import uiRouter from 'angular-ui-router';
import clipboardModule from 'angular-clipboard';
import UserService from './common/user/user.service';
import CacheService from './common/cache/cache.service';
import Common from 'common/common';
import Components from './components/components';
import UploadImage from './common/uploadImage/upload.service';
import AppComponent from './app.component';

// Test Data
// import TestData from './test/test';
// 

import './static/sass/common.scss';

const app = angular.module('app', [
    uiRouter,
    clipboardModule.name,
    Common.name,
    Components.name,
    UserService.name,
    CacheService.name,
    UploadImage.name
  ])
  .component('app', AppComponent)
  .config(['$stateProvider', '$urlRouterProvider', '$locationProvider', ($stateProvider, $urlRouterProvider, $locationProvider) => {
    'ngInject';
    
    $stateProvider
      .state('app', {
        views: {
          'header': {
            template: '<ui-header></ui-header>'
          },
          'footer': {
            template: '<ui-footer></ui-footer>'
          }
        },
        data: {
          pageTitle: '主播助手',
          bodyClassName: 'body-bg-black',
          loginCheck: true
        }
      });

      // $locationProvider.html5Mode(true);
 

      $urlRouterProvider.otherwise(($injector, $location) => {
        let cachePool = $injector.get('cachePool');
        let userData = cachePool.pull('user');

        if(!userData || !userData.is_login){
          $location.path('index');   
        }else{
          $location.path('login'); 
        }
      });
  }])
  // 权限  
  .run(['$rootScope', '$state', 'userService', 'cachePool', ($rootScope, $state, userService, cachePool) => {
    'ngInject';

    let isUserData = false;

    $rootScope.$on('$stateChangeStart', (event, toState, toParams, fromState, fromParams, options) => {
      let isloginCheck = angular.isObject(toState.data)
                           && toState.data.loginCheck === true;                        

      if(isUserData){
        isUserData = false;
        return;
      }                     

      event.preventDefault();

      userService
        .get()
        .then(data => {
          isUserData = true;
          cachePool.push('user', data); 
          $rootScope.common = data;

          let isNoCompetence = angular.isUndefined(data.id);
          // 没有权限
          if(isNoCompetence){
            $state.go('app.error', {page: 1000});
            return;
          }

          // 封禁
          if(+data.status === 1){
            $state.go('app.error', {page: 1001});
            return;    
          }
          
          if(!isloginCheck && !data.is_login){
            $state.go('app.index');
          }else{
            $state.go(toState.name, toParams);
          }
        },
        data => {
          isUserData = true;
          $state.go('login');
        })
    });

    $rootScope.$on('$stateChangeSuccess', (event, toState, toParams, fromState, fromParams, options) => { 
      const imageUrl  = (location.port == 80 || location.port == 9091 || location.port == '') ? '/zhubo/static' : '/static';

      // 图片本地路径/服务器路径不一样
      $rootScope.stateUrl = imageUrl;

      // 设置Title
      $rootScope.pageTitle = (toState.data && toState.data.pageTitle) ? toState.data.pageTitle : '主播助手';
      $rootScope.bodyClassName = (toState.data && toState.data.bodyClassName) ? toState.data.bodyClassName : '';      

    })
  }]);

export default app;
