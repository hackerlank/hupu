import React from 'react';
import { render } from 'react-dom';
import { Router, Route, IndexRoute, hashHistory } from 'react-router';

import { createStore } from 'redux';
import { Provider } from 'react-redux';
import reducersIndex from 'REDUCER/index';
import Auth from 'COMMON/auth';

import '../static/sass/common.scss'
import Layout from 'COMMON/layout';
import Wrap from 'COMMON/h5/wrap';
// import NoMatch from 'COMMON/noMatch';

// 首页
import Index from '../component/index/h5';
// 8强赛
import Semifinal from '../component/semifinal/h5';
// // top
import Top from '../component/top/h5';

const store = createStore(reducersIndex);

render((
    <Provider store={store}>
      <Router history={hashHistory}>
        <Route path="/" onEnter={requireAuth} onChange={requireAuth} component={Layout}>
          <Route component={Wrap}>
            <IndexRoute component={Index}/>
            <Route path="semifinal" component={Semifinal}></Route>
            <Route path="top" component={Top}></Route>
          </Route>
        </Route>
      </Router>
    </Provider>
  ),
  document.getElementById('react-content')
);

function requireAuth(nextState, replaceState) {
  Auth(nextState, store);
}
