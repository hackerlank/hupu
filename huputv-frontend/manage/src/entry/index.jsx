import '../common/lib';
import React from 'react';
import {render} from 'react-dom';
import {Router, Route, IndexRoute, Link, hashHistory} from 'react-router';

import App from '../component/App';
import Login from '../component/Login';
import RoomList from '../component/Room/RoomList';

// 礼物管理
import GiftIndex from '../component/Gift/Index';
import AddForm from '../component/Gift/AddForm';
import EditForm from '../component/Gift/EditForm';
import GiftHistory from '../component/Gift/History';
import GiftDetail from '../component/Gift/GiftDetail';
import Bean from '../component/Gift/Bean';
import GiftTop from '../component/Gift/top';

// 管理员
import OtherManage from '../component/Admin/Index';
import AdminList from '../component/Admin/List';
import AdminAdd from '../component/Admin/Add';
import AdminEdit from '../component/Admin/Edit';

// 直播分类
//import Catalog from '../component/Catalog';
import CatalogIndex from '../component/Catalog/Index';

// 主播管理
import Anchor from '../component/Anchor/Index';
import AnchorCollect from '../component/Anchor/Collect';
import AnchorCollectDetail from '../component/Anchor/CollectDetail';

//直播明细
import RoomIncome from '../component/Room/RoomIncome';
//热线
import Hotline from '../component/Room/Hotline';
//单场礼物
import SingleGift from '../component/Room/SingleGift';
//总送礼排行
import GiftRank from '../component/Room/GiftRank';
// 在线人数
import RoomOnlineNumber from '../component/Room/OnlineNumber';
// 慧体直播间
import HuiTiLiveRoom from '../component/Room/HuiTiLiveRoom';

// 慧体直播相关
import {
  LiveIndex,
  LiveOpen,
  LiveClose,
  LiveRoomList
} from '../component/Room/HuiTiLiveRoomList';

// 慧体运营管理
import HuiTiOperate from '../component/Room/HuiTiOperate';

// 超能比赛-比赛管理
import PsychcIndex from '../component/Psychc/Index';
import PsychcMatch from '../component/Psychc/Matchmanage';
// 超能比赛-球队管理
import PsychcTeam from '../component/Psychc/Teammanage';
import PsychcTeamMatchDetail from '../component/Psychc/TeamMatchDetail';
// 超能比赛-技能管理
import PsychcSkill from '../component/Psychc/Skillmanage';
// 超能比赛-操作后台
import PsychcOperate from '../component/Psychc/OperateManage';

import Task from '../component/Task/Index';
import TaskCollect from '../component/Task/Collect';

import NoMatch from '../component/NotFound/NoMatch';

//比赛预测管理
import Predict from '../component/Predict/Index';
import Rank from '../component/Predict/Rank';

// 系统消息
import SystemIndex from '../component/System/index';
import SystemAddInfo from '../component/System/AddInfo';

// 违禁词库
import BannedwordsIndex from '../component/Bannedwords/Index';

// 比赛管理

render((
        <Router history={hashHistory}>
            <Route path="/" component={App}>

                <IndexRoute component={RoomList}/>
                <Route path="room">
                    <IndexRoute component={RoomList}/>

                    <Route path="huiti" component={HuiTiLiveRoom}>
                        <Route component={LiveRoomList}>
                          <Route path="main" component={LiveIndex} />
                          <Route path="open" component={LiveOpen} />
                          <Route path="close" component={LiveClose} />
                        </Route>
                        <Route path="operate" component={HuiTiOperate} />
                    </Route>

                    <Route path="detail/:id" component={RoomIncome}/>
                    <Route path="single/:id" component={SingleGift}/>
                    <Route path="hotline/:id" component={Hotline}/>
                    <Route path="online" component={RoomOnlineNumber}/>
                    <Route path="rank" component={GiftRank}/>
                </Route>

                <Route path="anchor" >
                    <IndexRoute component={Anchor} />
                    <Route path="collect" component={AnchorCollect} />
                    <Route path="collect/:id" component={AnchorCollectDetail} />
                </Route>

                <Route path="gift">
                    <IndexRoute component={GiftIndex}/>
                    <Route path="add" component={AddForm} />
                    <Route path="history" component={GiftHistory} />
                    <Route path="top" component={GiftTop} />
                    <Route path="gift-detail/:id" component={GiftDetail} />
                    <Route path=":id" component={EditForm} />
                </Route>

                <Route path="task">
                    <IndexRoute component={Task}/>
                    <Route path="collect" component={TaskCollect} />
                </Route>

                <Route path="bean" component={Bean} />

                <Route path="catalog">
                    <IndexRoute component={CatalogIndex}/>
                </Route>

                <Route path="psychc" component={PsychcIndex}>
                    <Route path="match" component={PsychcMatch} />
                    <Route path="team" component={PsychcTeam} />
                    <Route path="teammatch/:id" component={PsychcTeamMatchDetail} />
                    <Route path="skill" component={PsychcSkill} />
                    <Route path="operate/:id" component={PsychcOperate} />
                </Route>

                <Route path="predict">
                    <IndexRoute component={Predict}/>
                    <Route path="rank" component={Rank} />
                </Route>

                <Route path="other" component={OtherManage}>
                    <IndexRoute component={AdminList}/>
                    <Route path="bannedwords" component={BannedwordsIndex} />
                    <Route path="admin" >
                        <IndexRoute component={AdminList}/>
                        <Route path="add" component={AdminAdd} />
                        <Route path="edit/:id" component={AdminEdit} />
                    </Route>
                    <Route path="system" >
                        <IndexRoute component={SystemIndex}/>
                        <Route path="add" component={SystemAddInfo} />
                    </Route>
                </Route>
                
            </Route>

            <Route path="login" component={Login}/>

            <Route path="*" component={NoMatch}/>
        </Router>
    ),
    document.getElementById('react-content')
);
