import React, {Component} from 'react';
import {Link} from 'react-router';
import Modal, {Toast} from 'MODAL';
import dataService from 'DATASERVICE';
import Util from 'UTIL';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import * as IndexActions from 'ACTION/index';
import Tab from 'COMMON/h5/tab/tab';
import List from 'CUI/list/list';
import NoMatch from 'COMMON/noMatch';

import "./h5.scss";

const Api = {
    getMatch: '/m/passerbyking/rank/list/:id'
};

class Confirm extends Component {
  constructor(props) {
    super(props);

    this.state = {
      game_id: Util.getGameId(),
      title: '最终战绩表',
      match_list: [],
      basicInfo: {
        stream: {
          publish: {},
          play: ''
        },
        game_info:{

        },
        rank_url:"",
        top8_match_url:"",
        top8_rank_url:"",
        wheel_match_url:"",
        wheel_rank_url:""
      },    
    }
  }
  componentWillMount() {
    this.getBasicInfo();
    this.getMatchList();
  }
  getBasicInfo(props = this.props) {
    const basicInfo = Object.assign(this.state.basicInfo, props.basicInfo);
    this.setState({
      basicInfo
    })
  }
  componentWillReceiveProps(nextProps) {
    this.getBasicInfo(nextProps);
  }
  /**
   * 获取比赛列表
   * @return {[type]} [description]
   */
  getMatchList(status = 1) {
    const { basicInfo } = this.state;
    if(basicInfo.game_info.match_status<=4){      
      return;
    }
    let url = Api.getMatch.replace(':id', this.state.game_id);

    dataService
      .get(url)
      .then(result => {
        if(result.code == 1){
          this.setState({
            match_list: result.data.rank_list
          });
        }
      })
  }
  getElementRank(){
    const elementRank = (
      <div className = "start-confirm-wrap">
        
        <List
          lists = {this.state.match_list}
          game_id = {this.state.game_id}
          isTopNumber = {true}
          isOptionButton = {false}
          isNotice = {true}
          iswaiver = {true}
          isWheelRankList={true}
        />
      </div>
    );
    return elementRank;
  }
  getElementNoMatch(text){
    const elementNoMatch = (
      <div><NoMatch title = {text}/></div>
    );
    return elementNoMatch;
  }
  render() {
    const { basicInfo } = this.state;
    return (<div><Tab active = "3"/>{basicInfo.game_info.match_status>4?(<div>{this.getElementRank()}</div>):(<div>{this.getElementNoMatch("比赛尚未结束，暂无战绩表")}</div>)}</div>
      
    );
  }
};
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
)(Confirm);
/*export default Confirm;*/
