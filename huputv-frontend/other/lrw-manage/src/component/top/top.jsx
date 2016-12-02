import React, {Component} from 'react';
import {Link} from 'react-router';
import Modal, {Toast} from 'MODAL';
import dataService from 'DATASERVICE';
import Util from 'UTIL';

import ListTitle from 'CUI/list-title/title';
import List from 'CUI/list/list';

import "./top.scss";

const Api = {
    getMatch: '/passerbyking/game/rank/:id'
};

class Confirm extends Component {
  constructor(props) {
    super(props);

    this.state = {
      game_id: Util.getGameId(),
      title: '最终战绩表',
      match_list: []
    }
  }
  componentWillMount() {
    this.getMatchList();
  }
  /**
   * 获取比赛列表
   * @return {[type]} [description]
   */
  getMatchList(status = 1) {
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
  render() {
    return (
      <div className="start-confirm-wrap">
        <div className="ui-header-title">
          <h2>{this.state.title}</h2>
        </div>
        <List 
          lists = {this.state.match_list}
          game_id = {this.state.game_id}
          isTopNumber= {true}
          isOptionButton= {false}
        />
      </div>
    );
  }
};

export default Confirm;

