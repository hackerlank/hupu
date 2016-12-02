import angular from 'angular';
import Login from './login/login';
import Index from './index/index';
import PredGame from './predGame/index';
import Live from './live/live';
import NoCompetence from './error/error';

let componentModule = angular.module('app.components', [
  Login.name,
  Index.name,
  Live.name,
  PredGame.name,
  NoCompetence.name
]);

export default componentModule;
