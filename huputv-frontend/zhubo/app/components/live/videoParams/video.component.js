import template from './video.html';
import controller from './video.controller';
import './video.scss';

let Component = {
  restrict: 'E',
  bindings: {},
  scope: {
    'root_id': '='
  },
  link: (scope, elem, attrs, controller) => {
    console.log(attrs.id);
    scope.root_id = attrs.id;
  },
  template,
  controller
};

export default Component;
