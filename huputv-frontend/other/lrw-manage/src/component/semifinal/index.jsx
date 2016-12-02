import React, {Component} from 'react';
import {Link, hashHistory} from 'react-router';
import { connect } from 'react-redux';
import * as IndexActions from 'ACTION';

import Modal, {Toast} from 'MODAL';
import dataService from 'DATASERVICE';
import Util from 'UTIL';


import ListTitle from 'CUI/list-title/title';
import List from 'CUI/list/list';

import "./index.scss";

const Api = {
    getMatch: '/passerbyking/top8/readyplayers/:id',
    getOutMatch: '/passerbyking/top8/outplayers/:id',
    startGame: '/passerbyking/match/start/:id'
};

class Index extends Component {
  constructor(props) {
    super();

    this.state = {
      title: '8强名单',
      game_id: Util.getGameId(),
      match_id: 0,
      match_list: [],
      out_list: []
    }
  }
  componentWillMount() {
    this.getBasicInfo();
    this.getMatchList();
    this.getOutMatchList();
  }
  componentWillReceiveProps(nextProps) {
    this.getBasicInfo(nextProps);
  }
  /**
   * 获取基本信息
   * @param {[type]} props [description]
   */
  getBasicInfo(props = this.props) {
    const {basicInfo} = props;

    this.setState({
      match_id: basicInfo.match_id
    })
  }
  /**
   * 获取比赛列表
   * @return {[type]} [description]
   */
  getMatchList() {
    let url = Api.getMatch.replace(':id', this.state.game_id);

    dataService
      .get(url)
      .then(result => {
        if(result.code == 1){
          this.setState({
            match_list: result.data
          });
        }
      })
  }
  /**
   * 获取OUT比赛列表
   * @return {[type]} [description]
   */
  getOutMatchList() {
    let url = Api.getOutMatch.replace(':id', this.state.game_id);

    dataService
      .get(url)
      .then(result => {
        if(result.code == 1){
          this.setState({
            out_list: result.data
          });
        }
      })
  }
  gameCallback() {
    this.getMatchList();
    this.getOutMatchList();
  }
  /**
   * 获取确认名单
   * @return {[type]} [description]
   */
  getModalElement() {
    let styles = {
      textAlign: "left",
      paddingLeft: "20px"
    }

    let {match_list} = this.state;

    let modalElement = (
      <div style={styles}>
        {
          match_list.map((item, index) => {
            return <div key={index}>{item.player_num} {item.nickname}</div>
          })
        }
      </div>
    );

    return modalElement;
  }
  handleOk() {
    let url = Api.startGame.replace(':id', this.state.game_id);

    let params = {
      match_id: this.state.match_id
    }

    Modal.alert('8强名单', this.getModalElement(), () => {
      dataService
        .put(url, params)
        .then(result => {
          if(result.code == 1){
            hashHistory.push('/semifinal/match');
          }else{
            Toast.show(result.msg);
          }
        })
    });
  }
  render() {
    return (
      <div className="start-confirm-wrap">
        <div className="ui-header-title">
          <h2>{this.state.title}</h2>
        </div>
        <List
          isTopNumber= {true}
          lists= {this.state.match_list}
          game_id = {this.state.game_id}
          callback = {this.gameCallback.bind(this)}
         />

        <div className="ok-inner">
          <a href="javascript:" onClick={this.handleOk.bind(this)}>确认8强名单</a>
        </div>

        <ListTitle 
          title = "已OUT球员"
         />
        <List
          lists= {this.state.out_list}
          game_id = {this.state.game_id}
          callback = {this.gameCallback.bind(this)}
         />
      </div>
    );
  }
};


const mapStateToProps = state => {
  return {
    basicInfo: state.basicInfo
  }
}

export default connect(
  mapStateToProps
)(Index);

