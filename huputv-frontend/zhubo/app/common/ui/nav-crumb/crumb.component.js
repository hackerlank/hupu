import template from './crumb.html';
import controller from './crumb.controller';
import './crumb.scss';

let component = {
  restrict: 'E',
  bindings: {},
  template,
  controller,
  controllerAs: 'vm'
};

export default component;
