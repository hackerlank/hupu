import angular from 'angular';
import Component from './speak.component';

let Module = angular.module('live.zhuboSpeak', [])
.component('zhuboSpeak', Component);

export default Module;
