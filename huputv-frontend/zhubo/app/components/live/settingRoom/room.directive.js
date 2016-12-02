import angular from 'angular';
import template from './room.html';
import controller from './room.controller';
import FileUpload from './upload.directive';

import './room.scss';

let app = angular.module('settingRoom', [
    FileUpload.name
  ])
  .directive('settingRoom', () => {
    return {
      restrict: 'E',
      bindings: {},
      require: '^live',
      scope: true,
      scope: {
      //   giftopen: '&giftopen',
        close: '&close'
      },
      link: (scope, element, attrs, live) => {
        scope.giftOpen = live.$scope.setGiftOpen;
      },
      template,
      controller
    };
  })

export default app
