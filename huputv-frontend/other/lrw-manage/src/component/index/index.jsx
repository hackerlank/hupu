import React from 'react';
import {Link, hashHistory} from 'react-router';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import * as IndexActions from 'ACTION/index';

import { findDOMNode } from 'react-dom';

import Modal, { Toast } from 'MODAL';
import dataService from 'DATASERVICE';
import Util from 'UTIL';
import List from 'CUI/list/list';
import './index.scss';

const Api = {
    match: '/passerbyking/game/players/:id',
    startGame: '/passerbyking/match/start/:id'
};


const Index = React.createClass({
  getInitialState() {
    return {
      game_id: Util.getGameId(),
      basicInfo: {
        stream: {
          publish: {},
          play: ''
        }
      },
      game_number: 0,
      match_list: []
    };
  },
  componentWillMount() {
    this.getBasicInfo();
    this.getPlayers();
  },
  componentWillReceiveProps(nextProps) {
    this.getBasicInfo(nextProps);
  },
  /**
   * 获取基本信息
   * @param {[type]} props [description]
   */
  getBasicInfo(props = this.props) {
    const basicInfo = Object.assign(this.state.basicInfo, props.basicInfo);

    this.setState({
      basicInfo
    })
  },
  /**
   * 获取待比赛球员
   * @return {[type]} [description]
   */
  getPlayers() {
    let url = Api.match.replace(':id', this.state.game_id);

    dataService
      .get(url)
      .then(result => {
        if(result.code == 1){
          this.setState({
            game_number: result.data.length,
            match_list: result.data
          });
        }else{
          Toast.show(result.msg);
        }
      })
  },
  handleStartGame() {
    let url = Api.startGame.replace(':id', this.state.game_id);

    dataService
      .put(url)
      .then(result => {
        if(result.code == 1){
          hashHistory.push('/start');
        }else{
          Toast.show(result.msg);
        }
      })
  },
  gameCallback() {
    this.getPlayers();
  },
  render() {
    const {basicInfo} = this.state;

    return (
      <div>
        <a href="javascript:" className="fir-start" onClick={this.handleStartGame}>车轮战开始</a>
        <div className="ui-header-title">
          <h2>待比赛球员<span>({this.state.game_number})</span></h2>
        </div>

        <List
          lists = {this.state.match_list}
          game_id = {this.state.game_id}
          callback = {this.gameCallback}
         />

        <ul className="bottom-video-url">
          <li>
            <div className="item">
              <span className="label">贴片地址：</span>
              <input type="text" className="input-border"  value={basicInfo.score_patch_url} />
            </div>
          </li>
          <li>
            推流参数：<br />
            <div className="item">
              <span className="label">stream：</span>
              <input type="text" className="input-border" value={basicInfo.stream.publish.stream} />
            </div>
            <div className="item">
              <span className="label">url：</span>
              <input type="text" className="input-border" value={basicInfo.stream.publish.url} />
            </div>
          </li>
          <li>
            <div className="item">
              <span className="label">视频合成地址：</span>
              <input type="text" className="input-border" value={basicInfo.stream.play} />
            </div>
          </li>
          <li>
            <div className="item">
              <span className="label">8强对阵图页面：</span>
              <input type="text" className="input-border" value={basicInfo.top8_map_url} />
            </div>
          </li>
          <li>
            <div className="item">
              <span className="label">战团&个人排行页面：</span>
              <input type="text" className="input-border" value={basicInfo.group_rank_url} />
            </div>
          </li>
        </ul>
      </div>
    );
  }
});

const mapStateToProps = state => {
  return {
    basicInfo: state.basicInfo
  }
}

const mapDispatchToProps = dispatch => {
  return {
    actions: bindActionCreators(IndexActions, dispatch)
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Index);
