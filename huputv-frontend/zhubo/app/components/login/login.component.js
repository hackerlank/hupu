import template from './login.html';
import controller from './login.controller';
import './login.scss';

let homeComponent = {
  restrict: 'E',
  bindings: {},
  template,
  controller,
  controllerAs: 'vm'
};

export default homeComponent;
