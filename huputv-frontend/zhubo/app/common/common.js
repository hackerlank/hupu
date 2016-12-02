import angular from 'angular';

import Header from './header/header';
import Footer from './footer/footer';
// 面包屑
import NavCrumb from './ui/nav-crumb/crumb';
// 弹层
import Popup from './ui/popup/popup.directive';

let commonModule = angular.module('app.common', [
  Header.name,
  Footer.name,
  NavCrumb.name,
  Popup.name
])

export default commonModule;
