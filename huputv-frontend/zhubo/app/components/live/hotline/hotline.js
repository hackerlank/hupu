import angular from 'angular';
import hotlineComponent from './hotline.component';

let hotlineModule = angular.module('live.hotline', [])
.component('liveHotline', hotlineComponent);

export default hotlineModule;
