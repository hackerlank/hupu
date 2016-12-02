import angular from 'angular';
import template from './popup.html';
import controller from './popup.controller';
import Popup from './lib/popup';

import './popup.scss';

let popupModule = angular.module('popup', [])
  .directive('uiPopup', () => {
    return {
      restrict: 'E',
      replace: true,
      transclude: true,
      template,
      controller,
      scope: {
        'ngIf': '=',
        'ngShow': '=',
        'ngHide': '=',
        'reset': '=',
        'close': '&'
      },
      link: (scope, elem, attrs, controller) => {
        let content = elem[0].querySelector('.ui-popup-inner');
        
        let popups = new Popup({
            node: elem[0]
        });

        var $document = $(document);

        // 模型同步UI显示、隐藏事件
        if (attrs.ngIf) scope.$watch('ngIf', change);
        if (attrs.ngShow) scope.$watch('ngShow', change);
        if (attrs.ngHide) scope.$watch('ngHide', function(value) {
            change(!value);
        });
        
        scope.resets = () => {
          change(true);
        }

        // ng 销毁事件控制对话框关闭
        // 控制器销毁或者 ng-if="false" 都可能触发此
        // scope.$on('$destroy', callback) >> 这种方式对 ngAnimate 支持不好
        elem.one('$destroy', function() {
          change(false);
          popups.remove();
        });  

        // UI 的显示与隐藏、删除事件
        function change(open) {

          var anchor = getAnchor(attrs['for']);

          if (angular.isUndefined(open)) {
              return;
          }

          if (angular.isObject(open)) {
              // HTMLElement, Event
              anchor = open;
          }

          if (open) {
              // 使用 setTimeout 等待 ng-show 在 UI 上生效
              elem.css('visibility', 'hidden');
              setTimeout(function() {
                  elem.css('visibility', 'visible');
                  popups.show(anchor);
                  setEvent(open);
              }, 0);
          } else {
              popups.close();
              setEvent(open);
          }

        }  

        function getAnchor(id) {
          return document.getElementById(id);
        }

        // 外部点击关闭
        function outerclick(event) {
            if (!content.contains(event.target)) {
                controller.close(event);
            }
        }

        function setEvent(open) {
            controller.closeAction.forEach(function(action) {
                switch (action) {
                    case 'outerchick':
                        if (open) {
                            $document
                                .on('ontouchend', outerclick)
                                .on('click', outerclick);
                        } else {
                            $document
                                .off('ontouchend', outerclick)
                                .off('click', outerclick);
                        }
                        break;
                    case 'click':
                    //case 'focusout': // Error: [$rootScope:inprog]
                        if (open) {
                            elem.on(action, controller.close);
                        } else {
                            elem.off(action, controller.close);
                        }
                        break;
                }
            });
        }
      }
    }    
  });

export default popupModule;
