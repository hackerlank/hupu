import angular from 'angular';
import moment from 'moment';
//因为开源的插件兼容有点问题，所以拷贝到项目里来自己修改的. 20160801
import 'common/ui/angular-bootstrap-datetimepicker';
import 'common/ui/angular-bootstrap-datetimepicker/src/js/datetimepicker.templates';

import template from './pred.html';
import controller from './pred.controller';

import './pred.scss';


moment.locale('zh-cn');

let Module = angular.module('popupPredGame', ['ui.bootstrap.datetimepicker'])
  .directive('popupPredGame', () => {
    return {
      restrict: 'E',
      bindings: {},
      scope: {
        'close': '&',
        'isedit': '@',
        'iscreate': '@',
        'id': '@',
        'preddata': '@',
        'predOption': '@'
      },
      link: (scope, element, attrs, popup) => {
      },
      template,
      controller
    }
  })

export default Module;


