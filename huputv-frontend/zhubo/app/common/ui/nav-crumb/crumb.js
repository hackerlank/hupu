import angular from 'angular';
import crumbComponent from './crumb.component';

let crumbModule = angular.module('nav-crumb', [])
.component('uiNavCrumb', crumbComponent);

export default crumbModule;
