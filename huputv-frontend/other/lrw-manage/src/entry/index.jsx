import React from 'react';
import { render } from 'react-dom';
import { Router, Route, IndexRoute, hashHistory } from 'react-router';

import { createStore } from 'redux';
import { Provider } from 'react-redux';
import reducersIndex from 'REDUCER/index';
import Auth from 'COMMON/auth';

import '../static/sass/common.scss'
import Layout from 'COMMON/layout';
import Wrap from 'COMMON/wrap';
import NoMatch from 'COMMON/noMatch';

// 首页
import Index from '../component/index';
// 公告
import Bulletin from '../component/bulletin/bulletin';
// 车轮站
import StartGame from '../component/start-game/start';
// 8强赛
import SemifinalIndex from '../component/semifinal';
import SemifinalMatch from '../component/semifinal/match';
// top
import Top from '../component/top/top';

const store = createStore(reducersIndex);

render((
    <Provider store={store}>
      <Router history={hashHistory}>
        <Route path="/" onEnter={requireAuth} onChange={requireAuth} component={Layout}>
          <Route path="bulletin" component={Bulletin}></Route>
          <Route component={Wrap}>
            <IndexRoute component={Index}/>
            <Route path="start" component={StartGame}></Route>
            <Route path="semifinal">
              <IndexRoute component={SemifinalIndex}/>
              <Route path="match" component={SemifinalMatch}></Route>
            </Route>
            <Route path="top" component={Top}></Route>
            <Route path="*" component={NoMatch}/>
          </Route>
        </Route>
      </Router>
    </Provider>
  ),
  document.getElementById('react-content')
);


function requireAuth(nextState, replace) {
  Auth(nextState, store);
}
