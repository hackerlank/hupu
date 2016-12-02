import React from 'react';
import { Link } from 'react-router';
import CopyToClipboard from 'react-copy-to-clipboard';
import { Icon, QueueAnim, Table, Button, Popconfirm, Modal, notification, Row, Col, Checkbox,Select, Badge, Tag, message} from 'antd';
import dataService from 'common/dataService';
import ReactSWFCompat from 'react-swf/compat';

let socketClient = null;
const App = React.createClass({
  getInitialState(){
    return {
      id: "",
      home_team: {},
      guest_team: {},
      home_score: 0,
      guest_score: 0,
      game_starttime: 0,
      game_endtime: "",
      game_typename: "",
      home_gift: "",
      guest_gift: "",
      game_sectiontime: "",
      game_sectionnum: "",
      game_description: "",
      gameStatus: {},
      home_team_info: {},
      guest_team_info: {},
      home_power: {},
      guest_power: {},
      time:{},
      live_info: {},
      home_skill:[],
      guest_skill:[],
      streams: [],
      sections: [],
      defaultAddTime: 300
    }
  },
  getMatchInfo( callback ){
    let room_id = parseInt(this.props.params.id);
    dataService
      .get('/chaoneng/games/getById',{room_id})
      .then(res=>{
        let game_sectionnum = Math.max(parseInt(res.data.time.section), parseInt(res.data.game_sectionnum));


        let sections = [];
        for(let i = 1; i<= game_sectionnum;i++){
          sections.push(i);
        }
        this.initVideo(res.data);
        this.setState({
          id: res.data.id,
          home_team: res.data.home_team,
          guest_team: res.data.guest_team,
          home_score: res.data.home_score,
          guest_score: res.data.guest_score,
          game_starttime: res.data.game_starttime,
          game_endtime: res.data.game_endtime,
          game_typename: res.data.game_typename,
          home_gift: res.data.home_gift,
          guest_gift: res.data.guest_gift,
          game_sectiontime: res.data.game_sectiontime,
          game_sectionnum: res.data.game_sectionnum,
          game_description: res.data.game_description,
          gameStatus: res.data.gameStatus,
          home_team_info: res.data.home_team_info,
          guest_team_info: res.data.guest_team_info,
          home_power: res.data.home_power,
          guest_power: res.data.guest_power,
          home_skill: res.data.home_skill,
          guest_skill: res.data.guest_skill,
          live_info: res.data.live_info,
          time: res.data.time,
          streams: [
              res.data.live_info.live_addr.result[2].hls,
              res.data.live_info.live_addr.result[2].rtmp
          ],
          sections: sections
        });

        callback && callback(res.data);
      })
  },
  initVideo(res) {
      window.HTV = window.HTV || {};

      const conf = {
          anchor: res.videojj.anchor || 1,
          appkey: res.videojj.appkey,
          referer: res.videojj.referer,
          source: res.videojj.source,
          type: res.videojj.type || 0,
          userID: res.videojj.userID,
          userPwd: res.videojj.userPwd
      };
      HTV.getVideoJJ = () => conf;

      const stream = res.live_info.live_addr.result;
      HTV.flashStreamAddress = () => stream;
  },
  componentWillUnmount(){
      if(socketClient){
          socketClient.close();
      }
  },
  componentDidMount(){
    const self = this;
    this.getMatchInfo(match => {
        var joinData = {
            et: 1000,
            via: 5,
            room_id: this.props.params.id,
            match_id: match.id
        };

        const ip = match.chaoneng_socket[(Math.random() * match.chaoneng_socket.length)|0];

        socketClient = io.connect(ip);
        socketClient.on('connect', () => {
          socketClient.emit('join', joinData);
        });


        //时间更新时间
        socketClient.on('wall', data => {
          console.log(data);

          if(data.et === 3009){
            let time = this.state.time;
            time.minute = data.min || "00";
            time.second = data.s || "00";
            time.section = data.sec;
            this.setState({time});
          }
        });

        //时间更新时间
        // socketClient.on('timer', function(msg){
        //     let time = self. state.time;
        //     time.minute = msg.data.minute || "00";
        //     time.second = msg.data.second || "00";
        //     time.section = msg.data.section;
        //     self.setState({time: time});
        // });

        //能量变更事件
        socketClient.on('power', function(msg){
            let isHomeTeam = msg.data.team_id == self.state.home_team;
            if(isHomeTeam){
                let power  = self.state.home_power;
                power.left = msg.data.power;
                self.setState({
                    home_power: power
                });
            }else{
                let power  = self.state.guest_power;
                power.left = msg.data.power;
                self.setState({
                    guest_power: power
                });
            }
        });
    });

  },
  startFirstSection(){
      //开始第一节计时.
      this.startSection(1, this.state.game_sectiontime);
  },
  //修改主队分数
  handleHomeScoreChange(home_score){
    if(home_score === 0)return;
    const game_id = this.state.id;
    const room_id = this.state.live_info.id;
    dataService.post('/chaoneng/games/updateGameScore',{
      game_id,
      room_id,
      home_score
    }).then(res=>{
      if(res.code == 1){
          notification.success({message:'主队分数修改成功'})
          this.getMatchInfo();
      } else {
          notification.error({message: res.msg })
      }
    })
  },
  //修改客队分数
  handleGuestScoreChange(guest_score){
    if(guest_score === 0)return;
    const game_id = this.state.id;
    const room_id = this.state.live_info.id;
    dataService.post('/chaoneng/games/updateGameScore',{
      game_id,
      room_id,
      guest_score
    }).then(res=>{
        if(res.code == 1){
            notification.success({message:'客队分数修改成功'})
            this.getMatchInfo();
        } else {
            notification.error({message: res.msg })
        }
    })
  },
  //购买技能
  skillbuy(skill, team_id){
    let game_id = this.state.id;
    let skill_id = skill.skill_id;
    let room_id = this.state.live_info.id;

    dataService.post('/chaoneng/games/buySkill',{
      game_id,
      skill_id,
      room_id,
      team_id
    }).then(res =>{
      if(res.code == 1){
          notification.success({message: `${skill.skill_info.skill_name}购买成功`})
          this.getMatchInfo()
      } else{
          notification.error({message: res.msg })
      }
    })
  },
  //开启技能
  skillStart(skill, team_id){
    const game_id = this.state.id;
    const skill_id = skill.skill_id;
    const room_id = this.state.live_info.id;

    dataService.post('/chaoneng/games/useSkill',{
      game_id,
      skill_id,
      room_id,
      team_id
    }).then(res => {
      if(res.code == 1){
          notification.success({message: `${skill.skill_info.skill_name}使用成功`})
          this.getMatchInfo();
      } else{
          notification.error({message: res.msg })
      }
    })
  },
  //下线技能
  skillStop(skill, team_id){
    const game_id = this.state.id;
    const skill_id = skill.skill_id;
    const room_id = this.state.live_info.id;

    dataService.post('/chaoneng/games/offGameSkill',{
      game_id,
      skill_id,
      room_id,
      team_id
    }).then(res=>{
      if(res.code == 1){
          notification.success({message: `${skill.skill_info.skill_name}下线成功`})
          this.getMatchInfo();
      } else{
          notification.error({message:res.msg})
      }
    })
  },
  //比赛暂停
  matchPause(){
    let game_id = this.state.id;
    let room_id = this.state.live_info.id;
    let pase = !!parseInt(this.state.time.pase);

    if(pase){
        dataService.post('/chaoneng/games/runGameTime',{
          game_id,
          room_id
        }).then(res=>{
          if(res.code == 1){
            notification.success({message:"取消暂停成功"});
            this.getMatchInfo();
          } else{
            notification.error({message: res.msg})
          }
        })
    }else{
        dataService.post('/chaoneng/games/pauseGameTime',{
          game_id,
          room_id
        }).then(res=>{
          if(res.code == 1){
            notification.success({message:"暂停成功"});
            this.getMatchInfo();
          } else{
            notification.error({message: res.msg})
          }
        })
    }
  },
  updateTime( update_ime ){
    const game_id = this.state.id;
    const room_id = this.state.live_info.id;
    dataService.post('/chaoneng/games/updateGameTime',{
      game_id,
      room_id,
      update_ime
    }).then(res=>{
        if(res.code == 1){

        } else{
          notification.error({message: res.msg})
        }
    })
  },
  startSection(section, section_time){
    const game_id = this.state.id;
    const room_id = this.state.live_info.id;

    dataService.post('/chaoneng/games/startGameSection', {
        game_id,
        room_id,
        section_time,
        section
    }).then(res=>{
        if(res.code == 1){
          this.getMatchInfo();
        } else{
          notification.error({message: res.msg})
        }
    })
  },
  handleCopy(){
    message.success("复制成功");
  },
  addMatchTime(section){
      this.startSection(section, this.state.defaultAddTime);
  },
  setAddMatchTime(section_time){
      this.setState({
          defaultAddTime: parseInt(section_time)
      });
  },
  endGame(){
    let game_id = this.state.id;
    let room_id = this.state.live_info.id;
    dataService.post('/chaoneng/games/endGame',{
      game_id,
      room_id
    }).then(res=>{
        if(res.code == 1){
          notification.success({message:"结束比赛成功"});
          location.reload(true);
        } else{
          notification.error({message: res.msg});
        }
    })
  },
  render() {
    let sections = [];
    let currentSection = parseInt(this.state.time.section) || 1;
    let sectionLength = parseInt(this.state.game_sectionnum);

    if(parseInt(this.state.gameStatus.status) == 1 && !this.state.time.time_status){
        sections.push(
            <li><Button type="primary" onClick={this.startFirstSection}>开启计分和计时</Button></li>
        )
    } else{
        this.state.sections.map(section => {
            let end  = section  > sectionLength ? '加时':'节';
            let rank = section  > sectionLength ? (section - sectionLength) : section;

          if(section < currentSection){
            sections.push(
              <li>
                <span>第{rank}{end}已结束</span>
              </li>
            )
          }

          if(section == currentSection){
            sections.push(
              <li>
                <span>{this.state.time.time_status ? <span>正在进行</span>:''}第{rank}{end}：{this.state.time.minute}:{this.state.time.second}</span>
                <Button type="primary" style={{marginLeft:5, marginRight:10}} onClick={this.matchPause}>{!!parseInt(this.state.time.pase) ? '取消暂停':'暂停'}</Button>
                <Button type="ghost" style={{marginRight:10}} onClick={this.updateTime.bind(null, 1)}>+1s</Button>
                <Button type="dashed" style={{marginRight:10}} onClick={this.updateTime.bind(null, -1)}>-1s</Button>
              </li>
            )
            if(currentSection == this.state.sections.length){
                sections.push(
                  <li>
                      加时：
                      <Select defaultValue="300" style={{ marginLeft:10, width: 100 }} onChange={this.setAddMatchTime}>
                        <Option value="60">1分钟</Option>
                        <Option value="180">3分钟</Option>
                        <Option value="300">5分钟</Option>
                        <Option value="600">10分钟</Option>
                      </Select>
                      <Button type="primary" style={{ marginLeft:10 }} onClick={this.addMatchTime.bind(null, section + 1)}>开始加时</Button>
                  </li>
                )
            }
          }

          if(section > currentSection){
            sections.push(
              <li>
                <span>第{rank}{end}：</span>
                {(currentSection + 1) == section ? <Button type="primary" onClick={this.startSection.bind(null, section, this.state.game_sectiontime)}>开始计时</Button> : '未开始'}
              </li>
            )
          }
        });
    }
    if(parseInt(this.state.gameStatus.status) == 1){
        sections.push(
          <li>
              <Popconfirm
                title="请确认是否关闭"
                onConfirm={this.endGame}>
                <Button type="primary">结束比赛</Button>
              </Popconfirm>
          </li>
        )
    } else{
        sections.push(
          <li>
            比赛已结束
          </li>
        )
    }

    let defaultScores = [-1, 1, 2, 3];
    let  homeScores = [],
        guestScores = [];
    defaultScores.map(score =>{
        homeScores.push(<Button type="primary" style={{marginLeft: 2}} onClick={this.handleHomeScoreChange.bind(null, score)}>{score}</Button>)
        guestScores.push(<Button type="primary" style={{marginLeft: 2}} onClick={this.handleGuestScoreChange.bind(null, score)}>{score}</Button>);
    });

    let streams = [];
    this.state.streams.map(stream =>{
        streams.push(<source src={stream} />)
    });

    return (
      <QueueAnim delay={500}>
        <div className="tb10 pr">
          <Row type="flex" justify="center" align="top">
            <Col span={3}>
              <div className="psychc-skills-left">
                <h3>{this.state.home_team_info.cn_name}的技能库</h3>
                <div className="skill-con">
                <p className="border-1">可用资金: {this.state.home_power.left} 虎扑币</p>
                {this.state.home_skill.map(skill=>{
                    let useSkillTitle = `确认使用该【${skill.skill_info.skill_name}】`
                    let useOfflineSkillTitle = `确认下线该【${skill.skill_info.skill_name}】`
                    let buySkillTitle = `确认购买【${skill.skill_info.skill_name}】,将消耗 ${skill.skill_info.skill_value} 虎扑币`
                    let lastSkillCount = parseInt(skill.skill_totlenum) - parseInt(skill.skill_usednum);
                    return (
                      <div className="skill-block">
                        <Badge count={lastSkillCount}>
                            <img  width="40" height="40" src={skill.skill_info.skill_logo} />
                        </Badge>

                        <p className="btns">
                            <Popconfirm title={buySkillTitle} onConfirm={this.skillbuy.bind(null, skill, this.state.home_team_info.id)}>
                                <span className="btn">购买</span>
                            </Popconfirm>

                            {parseInt(skill.skill_status) == 0 ? (lastSkillCount > 0 ?
                            <Popconfirm title={useSkillTitle} onConfirm={this.skillStart.bind(null, skill, this.state.home_team_info.id)}>
                                <span className="btn">开启</span>
                            </Popconfirm> : '')
                            :
                            <Popconfirm title={useOfflineSkillTitle} onConfirm={this.skillStop.bind(null, skill, this.state.home_team_info.id)}>
                                <span className="btn offline">下线</span>
                            </Popconfirm>}
                        </p>
                      </div>
                  )
                })}
               </div>
              </div>
            </Col>

            <Col span={18}>
              <Row type="flex" justify="center" align="top">
                <Col span={2}><img width="60" height="60" src={this.state.live_info.cover} /></Col>
                <Col span={20}>
                  <h2>{this.state.live_info.roomname}</h2>
                  <p>{this.state.live_info.nickname}</p>
                </Col>
              </Row>
              <Row>
                <Col span={22}>
                  <div className="video-main">
                      {this.state.id ? <ReactSWFCompat
                        container={<div style={{background: 'transparent'}} />}
                        src="/manage/static/huputv_1.swf"
                        width="800"
                        height="460"
                        wmode="transparent"
                        allowScriptAccess="always"
                        allowNetworking="all"
                        allowFullScreen="true"
                      /> : ''}
                  </div>
                </Col>
              </Row>
              <Row>
                <div>
                  <div className="psychc-controller">
                    <ul className="psychc-team">
                      <li><Tag color="blue">{this.state.home_team_info.cn_name} 当前得分： {this.state.home_score}</Tag>
                          {homeScores}
                      </li>
                      <li><Tag color="red">{this.state.guest_team_info.cn_name} 当前得分： {this.state.guest_score}</Tag>
                          {guestScores}
                      </li>
                    </ul>
                    <div className="psychc-section">
                      <ul className="psychc-section-list">
                        {sections}
                        <li>
                        <CopyToClipboard text={this.state.live_info.obs_browser_url}
                          onCopy={this.handleCopy}
                          style={{marginTop: '15px'}}>
                          <button className="ant-btn ant-btn-primary">复制OBS地址</button>
                        </CopyToClipboard>
                        </li>
                      </ul>
                    </div>
                  </div>

                </div>
              </Row>
            </Col>

            <Col span={3}>
              <div className="psychc-skills-right">
                <h3>{this.state.guest_team_info.cn_name}的技能库</h3>
                <div className="skill-con">
                <p className="border-1">可用资金: {this.state.guest_power.left} 虎扑币</p>
                  {this.state.guest_skill.map(skill=>{
                      let useSkillTitle = `确认使用该【${skill.skill_info.skill_name}】`
                      let useOfflineSkillTitle = `确认下线该【${skill.skill_info.skill_name}】`
                      let buySkillTitle = `确认购买【${skill.skill_info.skill_name}】,将消耗 ${skill.skill_info.skill_value} 虎扑币`
                      let lastSkillCount = parseInt(skill.skill_totlenum) - parseInt(skill.skill_usednum);
                      return (
                        <div className="skill-block">
                        <Badge count={lastSkillCount}>
                            <img  width="40" height="40" src={skill.skill_info.skill_logo} />
                        </Badge>
                          <p className="btns">
                              <Popconfirm title={buySkillTitle} onConfirm={this.skillbuy.bind(null, skill, this.state.guest_team_info.id)}>
                                  <span className="btn">购买</span>
                              </Popconfirm>

                              {parseInt(skill.skill_status) == 0 ? (lastSkillCount > 0 ?
                              <Popconfirm title={useSkillTitle} onConfirm={this.skillStart.bind(null, skill, this.state.guest_team_info.id)}>
                                  <span className="btn">开启</span>
                              </Popconfirm> : '')
                              :
                              <Popconfirm title={useOfflineSkillTitle} onConfirm={this.skillStop.bind(null, skill, this.state.guest_team_info.id)}>
                                  <span className="btn offline">下线</span>
                              </Popconfirm>}
                          </p>
                        </div>
                    )
                  })}
               </div>
              </div>
            </Col>
          </Row>
        </div>
      </QueueAnim>
    );
  }
});

export default App;
