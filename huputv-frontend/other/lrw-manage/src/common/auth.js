import { hashHistory } from 'react-router';
import { bindActionCreators } from 'redux';
import * as IndexActions from 'ACTION/index';

import Util from 'UTIL';
import dataService from 'DATASERVICE';

const Api = {
  basic: '/passerbyking/game/info/:id',
  notice:'/m/passerbyking/game/:id'
};


export function go(url) {
  const { hash } = window.location;
  const current = hash.match(/\/\w{0,}(\/\w{1,}){0,}/)[0] || '/';

  if(current !== url) {
    hashHistory.push(url);
  }
}

/**
 * 管理页面跳转
 * @param  {number} status    [比赛状态]
 * @param {object}  nextState [路由]
 */
export function goAdmin(status) {
  const routeAll = ['/', '/start', '/semifinal', '/semifinal/match', '/top'];

  let number = 0;

  // 比赛状态 0:未开始 1:车轮战 2:8强赛淘汰赛 3:8强赛 9:比赛结束
  switch(+status) {
    case 1:
      number = 1;
      break;
    case 2:
      number = 2;
      break;
    case 3:
      number = 3;
      break;
    case 9:
      number = 4;
      break;
    default:
  }

  const url = routeAll[number];

  go(url);
}

/**
 * 球员通知页
 * @param  {number} status    [比赛状态]
 * @param {object} nextState  [路由]
 */
export function goH5(status, nextState) {
  const routeAll = ['/', '/semifinal', '/top'];

  const { hash } = window.location;

  if(/tab=\d+/.test(hash)) {
    return;
  }

  let number = 0;

  status = +status;

  // 比赛状态 0:未开始 1:车轮战 2:8强赛淘汰赛 3:半决赛 4:决赛 9:比赛结束
  switch(true) {
    case status > 2 && status <= 4:
      number = 1;
      break;
    case status > 4:
      number = 2;
      break;
    default:
  }

  const url = routeAll[number];

  go(url);
}

/**
 * 获取用户信息
 * @param  {[type]} nextState    [description]
 * @param  {[type]} store        [description]
 * @return {[type]}              [description]
 */
export default (nextState, store) => {
  const gameID = Util.getGameId();
  const actions = bindActionCreators(IndexActions, store.dispatch);

  const pageName = Util.getPageName();
  const isAdmin = (pageName === 'admin');

  let url = isAdmin ? Api.basic : Api.notice;
  let params = {
    is_api : 1
  }

  url = url.replace(':id', gameID);

  dataService
    .get(url, params)
    .then(result => {
      if(result.code == 1){
        actions.addBasic(result.data);

        // 计分后台
        if(isAdmin) {
          goAdmin(result.data.match_status, nextState);
        }else{
          goH5(result.data.game_info.match_status, nextState);
        }
      }
    });
}
