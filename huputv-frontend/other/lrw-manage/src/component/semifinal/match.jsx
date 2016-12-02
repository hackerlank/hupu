import React, {Component} from 'react';
import {Link} from 'react-router';
import Modal, {Toast} from 'MODAL';
import dataService from 'DATASERVICE';
import Util from 'UTIL';

import Header from 'CUI/header/header';
import Match from 'CUI/match/match';
import ListTitle from 'CUI/list-title/title';
import Lists from './list/list';

import "./match.scss";

const Api = {
    getMatch: '/passerbyking/top8/matchmap/:id'
};

class Semifinal extends Component {
  constructor(props) {
    super();

    this.state = {
      game_id: Util.getGameId(),
      match_list: [],
      out_match_list: []
    }
  }
  componentWillMount() {
    this.getMatchList();
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
            match_list: result.data.ready,
            out_match_list: result.data.end
          });
        }
      })
  }
  handleOk() {
    console.log('ok');
  }
  gameEndCallback() {
    this.getMatchList();
  }
  render() {

    return (
      <div className="semifinal-wrap">
        <div className="ui-header-title">
          <h2>8强赛</h2>
        </div>
        <Match
          game_id = {this.state.game_id}
          gameEndCallback = {this.gameEndCallback.bind(this)}
         />
          {
            this.state.match_list.length ? (
              <div>
                <ListTitle 
                  title = "待比赛场次"
                 />
                <Lists 
                  lists= {this.state.match_list}
                  isTitle= {true}
                  tools= {true}
                 />
              </div>
            ) : null
          }
        {
          this.state.out_match_list.length ? (
            <div>
              <ListTitle 
                title = "已完场"
               />
              <Lists 
                lists= {this.state.out_match_list}
               />
            </div>
          ) : null
        } 
      </div>
    );
  }
};

export default Semifinal
