import angular from 'angular';
import videoComponent from './video.component';

let videoModule = angular.module('live.videoParams', [])
.component('videoParams', videoComponent);

export default videoModule;
