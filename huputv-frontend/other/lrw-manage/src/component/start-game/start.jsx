import React from 'react';
import {Link} from 'react-router';

import Modal, {Toast} from 'MODAL';
import dataService from 'DATASERVICE';
import Util from 'UTIL';

import Match from 'CUI/match/match';
import ListTitle from 'CUI/list-title/title';
import List from 'CUI/list/list';

import "./start.scss";

const Api = {
    readyPlayers: '/passerbyking/wheel/readyplayers/:id',
    outPlayers: '/passerbyking/wheel/outplayers/:id'
};

const App = React.createClass({
  getInitialState() {
    return {
      game_id: Util.getGameId(),
      match_id: 0,
      game_number: 0,
      match_list: [],
      out_list: []
    };
  },
  componentWillMount() {
    this.getReadyPlayers();
    this.getOutPlayers();
  },
  /**
   * 获取待比赛球员
   * @return {[type]} [description]
   */
  getReadyPlayers() {
    let url = Api.readyPlayers.replace(':id', this.state.game_id);

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
  /**
   * 获取淘汰球员
   * @return {[type]} [description]
   */
  getOutPlayers() {
    let url = Api.outPlayers.replace(':id', this.state.game_id);

    dataService
      .get(url)
      .then(result => {
        if(result.code == 1){
          this.setState({
            out_list: result.data
          });
        }else{
          Toast.show(result.msg);
        }
      })
  },
  gameEndCallback() {
    this.getReadyPlayers();
    this.getOutPlayers();
  },
  render() {
    return (
      <div className="start-wrap">
        <div className="ui-header-title">
          <h2>车轮战</h2>
        </div>
        <Match
          game_id = {this.state.game_id}
          gameEndCallback = {this.gameEndCallback}
          from="start"
         />

         <ListTitle 
          title = {`待比赛球员（${this.state.game_number}）`}
         />
        <List
          lists = {this.state.match_list}
          game_id = {this.state.game_id}
          callback = {this.gameEndCallback}
         />

        <ListTitle 
          title = "已OUT球员"
         />
        <List 
          lists = {this.state.out_list}
          game_id = {this.state.game_id}
          callback = {this.gameEndCallback}
        />
      </div>
    );
  }
});


export default App

