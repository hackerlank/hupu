import angular from 'angular';
import Component from './room.component';
import FileUpload from './upload.directive';
import './room.scss';

let Module = angular.module('settingRoom', [
    FileUpload.name
  ])
  .component('settingRoom', Component)
  .directive('popupSetHeight', ['$window', ($window) => {
    return {
      link: (scope, elem, attrs) => {
        let h = elem[0].offsetHeight;

        var resize = () => {
          let viewHeight = $window.innerHeight;
          let scrollHeight = (h > viewHeight) ? viewHeight - 40 : null;

          if(scrollHeight){
            elem.css('height', scrollHeight + 'px');
          }
        }

        resize();

        angular.element($window).bind('resize', () => {
          resize();
        })
      }
    }
  }]);

export default Module;
