import angular from 'angular';
import uiTree from 'angular-ui-tree';
import template from './gift.html';
import controller from './gift.controller';

import './gift.scss';

let app = angular.module('shuttleGift', [
    uiTree
  ])
  .directive('shuttleGift', () => {
    return {
      restrict: 'E',
      require: '^uiPopup',
      bindings: {},
      link: (scope, element, attrs, popup) => {
        scope.popup = popup;
      },
      template,
      controller
    }
  })

export default app;
