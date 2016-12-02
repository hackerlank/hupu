import angular from 'angular';
import footerComponent from './footer.component';

let footerModule = angular.module('footer', [])
.component('uiFooter', footerComponent);

export default footerModule;
