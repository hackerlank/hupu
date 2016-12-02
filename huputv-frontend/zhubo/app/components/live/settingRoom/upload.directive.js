import angular from 'angular';

let app = angular.module('roomUpload', [])
  .directive('uploadFiles', ['$parse', ($parse) => {
    return {
      restrict: 'A',
      link: function (scope, element, attrs, ngModel) {
        var attrHandler = $parse(attrs['uploadFiles']);

        var handler = function (e) {
          scope.$apply(function () {
            attrHandler(scope, { $event: e, files: e.target.files });
          });
        };

        element[0].addEventListener('change', handler, false);
      }
    };
  }])

export default app
