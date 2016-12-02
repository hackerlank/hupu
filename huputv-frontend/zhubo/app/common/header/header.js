import angular from 'angular';
import headerComponent from './header.component';

let headerModule = angular.module('header', [])
.component('uiHeader', headerComponent);

export default headerModule;
