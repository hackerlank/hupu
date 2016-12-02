import React from 'react';
import { hashHistory } from 'react-router';
import Modal, { Toast } from 'MODAL';
import dataService from 'DATASERVICE';
import Util from 'UTIL';

import "./match.scss";

const Api = {
    // 开始计分
    startGame: '/passerbyking/match/start/:id',
    getMatch: '/passerbyking/match/:id',
    match: '/passerbyking/match/:id',
    playergiveup: '/passerbyking/wheel/currentplayergiveup'
};

const Match = React.createClass({
  getInitialState() {
    return {
      game_id: 1,
      id: 1,
      visible: false,
      modalContent: '比赛已结束，查看本轮战绩表',
      footerItems: ['确认'],
      modalCode: 0,
      left_player_info: {},
      right_player_info: {},
      left_player_status: {},
      right_player_status: {}
    };
  },
  componentWillMount() {
    this.getAllInfo();
  },
  /**
   * 获取全部信息
   * @return {[type]} [description]
   */
  getAllInfo() {
    let url = Api.getMatch.replace(':id', this.props.game_id);

    dataService
      .get(url)
      .then(result => {
        if(result.code == 1){
          this.setState(result.data);
        }
      })
  },
  /**
   * 开始计分
   * @return {[type]} [description]
   */
  startScore() {
    let url = Api.match.replace(':id', this.props.game_id);

    let params = {
      key: 'game_start',
      value: 1,
      match_id: this.state.id
    }

    dataService
      .post(url, params)
      .then(result => {
        Toast.show(result.msg);

        if(result.code == 1) {
          this.getAllInfo();
        }
      })
  },
  /**
   * 提交结束
   * @return {[type]} [description]
   */
  submitEnd() {
    if(this.state.left_score == this.state.right_score) {
      Toast.show('比分不能相等');
      return;
    }

    Modal.alert('', this.getVictoryElement(), () => {
      let url = Api.match.replace(':id', this.props.game_id);
      let params = {
        match_id: this.state.id
      }

      dataService
        .put(url, params)
        .then(result => {
          // 已结束，查看8强名单
          if(result.code == 1000){
            this.setState({
              visible: true,
              modalContent: "车轮战已结束，查看8强赛名单",
              modalCode: result.code,
            });
            return;
          }

          // 已结束，进入排行榜
          if(result.code == 1001){
            this.setState({
              visible: true,
              modalContent: "比赛已结束，查看本轮战绩表",
              modalCode: result.code,
            });
            return;
          }

          if(result.code == 1){
            this.getAllInfo();
            this.props.gameEndCallback && this.props.gameEndCallback();
            return;
          }

          Toast.show(result.msg);
        })

    });
  },
  handleOk() {
    if(+this.state.game_start) {
      this.submitEnd();
    }else{
      this.startScore();
    }
  },
  handleUploadGame(type, number) {
    if(!(+this.state.game_start)) {
      return Toast.show('先开始计分');
    }

    let url = Api.match.replace(':id', this.props.game_id);

    let params = {
      key: type,
      value: number,
      match_id: this.state.id
    }

    dataService
      .post(url, params)
      .then(result => {
        console.log(result);
        if(result.code == 1){
          this.getAllInfo();
        }
      })
    // Toast.show('请先点击 [开始计分]');
  },
  handleWaiver(type, player_puid, nickname) {
    const url = Api.playergiveup;
    const { left_player_status, right_player_status } = this.state;

    let params = {
      game_id: this.props.game_id,
      player_puid
    };

    let styles = {
			color: "#c01e2f"
		}
		let contentElement = (
			<div style={styles}>弃权后将无法复活</div>
		)

    Modal.alert(`${nickname} 是否确定要弃权？`, contentElement, () => {

      dataService
        .post(url, params)
        .then(result => {
          // console.log(info);
          if(result.code == 1){

            if(type == 'left'){
              let lose = +left_player_status.lose + 1;

              let player_info = Object.assign({}, left_player_status, {
                lose
              })

              this.setState({
                left_player_status: player_info
              })
            }else{
              let lose = +right_player_status.lose + 1;

              let player_info = Object.assign({}, right_player_status, {
                lose
              })

              this.setState({
                right_player_status: player_info
              })
            }
          }
        })
    })
  },
  handleModal() {
    const {modalCode} = this.state;

    // 已结束，查看8强名单
    if(modalCode == 1000){
        hashHistory.push('/semifinal');
    }

    // 已结束，进入排行榜
    if(modalCode == 1001){
        hashHistory.push('/top');
    }
  },
  /** 获取胜元素 */
  getVictoryElement() {
    let maskElement;

    let isLeftWin = (this.state.left_score > this.state.right_score);

    maskElement = (
      <div className="ui-team-flex">
        <div className="team-red">
          <div className="team-name">{Util.subBtyesString(this.state.left_player_info.nickname)}</div>
          {
            isLeftWin ? <span className="icon-win">Win</span> : null
          }
        </div>
        <div className="team-score">{this.state.left_score}-{this.state.right_score}</div>
        <div className="team-blue">
          <div className="team-name">{Util.subBtyesString(this.state.right_player_info.nickname)}</div>
          {
            !isLeftWin ? <span className="icon-win">Win</span> : null
          }
        </div>
      </div>
    )

    return maskElement
  },
  render() {
    const {left_player_info, right_player_info, left_player_status, right_player_status} = this.state;

    return (
      <div>
        <div className="ui-match">
          <div className="match-row">
            <div className="col-left">
              <div className="avatar-inner">
                <span className="number">{left_player_status.player_num}</span>
                <div className="avatar">
                  <img src={left_player_info.header} />
                </div>
              </div>

              <h4 className="title">{Util.subBtyesString(left_player_info.nickname)}</h4>
              <div className="info">
                胜{left_player_status.total_win} ({Util.changePct(left_player_status.total_win, left_player_status.total_game)}) | 犯规{this.state.left_foul}
              </div>
              {
                (this.props.from == 'start' && left_player_status.lose >= 1) ? (
                  <div className="defeat-number">连败{left_player_status.lose}</div>
                ) : null
              }
            </div>
            <div className="col-center">
              <div className="match-score">
                <div className="course-number">第{this.state.num}场</div>
                <div className="score">{this.state.left_score}:{this.state.right_score}</div>
              </div>
            </div>
            <div className="col-right">
              <div className="avatar-inner">
                <div className="avatar">
                  <img src={right_player_info.header} />
                </div>
                <span className="number">{right_player_status.player_num}</span>
              </div>

              <h4 className="title">{Util.subBtyesString(right_player_info.nickname)}</h4>
              <div className="info">
                胜{right_player_status.total_win} ({Util.changePct(right_player_status.total_win, right_player_status.total_game)}) | 犯规{this.state.right_foul}
              </div>
              {
                (this.props.from == 'start' && right_player_status.lose >= 1) ? (
                  <div className="defeat-number">连败{right_player_status.lose}</div>
                ) : null
              }
            </div>
          </div>

          <div className="option-area">
            <div className="col-left">
              <div className="area-item">
                <button type="button" className="button-add" onClick={this.handleUploadGame.bind(this, 'left_score', '1')}>+1</button>
                <span className="text">比分</span>
                <button type="button" className="button-less" onClick={this.handleUploadGame.bind(this, 'left_score', '-1')}>-1</button>
              </div>
              <div className="area-item">
                <button type="button" className="button-add" onClick={this.handleUploadGame.bind(this, 'left_foul', '1')}>+1</button>
                <span className="text">犯规</span>
                <button type="button" className="button-less" onClick={this.handleUploadGame.bind(this, 'left_foul', '-1')}>-1</button>
              </div>
              {
                this.props.from == 'start' ? (
                  <a href="javascript:" className="button-waiver" onClick={this.handleWaiver.bind(this, 'left', left_player_info.puid, left_player_info.nickname )}>弃权</a>
                ) : null
              }
            </div>
            <div className="col-right">
              <div className="area-item">
                <button type="button" className="button-add" onClick={this.handleUploadGame.bind(this, 'right_score', '1')}>+1</button>
                <span className="text">比分</span>
                <button type="button" className="button-less" onClick={this.handleUploadGame.bind(this, 'right_score', '-1')}>-1</button>
              </div>
              <div className="area-item">
                <button type="button" className="button-add" onClick={this.handleUploadGame.bind(this, 'right_foul', '1')}>+1</button>
                <span className="text">犯规</span>
                <button type="button" className="button-less" onClick={this.handleUploadGame.bind(this, 'right_foul', '-1')}>-1</button>
              </div>
              {
                this.props.from == 'start' ? (
                  <a href="javascript:" className="button-waiver" onClick={this.handleWaiver.bind(this, 'right', right_player_info.puid, right_player_info.nickname )}>弃权</a>
                ) : null
              }
            </div>
          </div>

          <div className="ok-inner">
            <a href="javascript:" onClick={this.handleOk}>
              {
                (+this.state.game_start) ? '提交结果' : '开始计分'
              }
            </a>
          </div>
        </div>

        <Modal
          visible = {this.state.visible}
          children = {this.state.modalContent}
          onOk= {this.handleModal}
          footer = {this.state.footerItems}
         />
      </div>
    );
  }
});


Match.defaultProps = {
  game_id: '',
  match_id: '',
  from: '',
  gameEndCallback: () => {}
}

Match.propTypes = {
  game_id: React.PropTypes.number,
  from: React.PropTypes.string,
  gameEndCallback: React.PropTypes.func
}

export default Match;
