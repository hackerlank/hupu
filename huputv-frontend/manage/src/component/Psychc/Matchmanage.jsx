import React from 'react';
import { Link, withRouter } from 'react-router';
import { Icon, QueueAnim, Table, Button, Popconfirm, Modal, notification, Form, Row, Col, Input, DatePicker, Select} from 'antd';
import dataService from 'common/dataService';
const FormItem = Form.Item;
const Option = Select.Option;
let lockForm = false;
//关联直播间
const Room = React.createClass({
    getInitialState(){
        return {
            roomDetail:"",
            roomid: ""
        }
    },
    handleSubmit(){
        let formData = this.props.form.getFieldsValue();
        if(formData.number){
            let rid = formData.number;
            dataService
                .get('/lunbo/room/getByRid', {rid})
                .then(res => {
                  let detail = res.data;
                  detail.nickname = detail.anchor_nickname;
                  detail.roomname = detail.name;
                  detail.roomid = detail.id;
                  this.setState({
                    roomDetail: detail
                  });
                });
        }
    },
    render(){
        const roomDetail = this.state.roomDetail;
        const roomid = roomDetail ? roomDetail.roomid : '';
        const handleCancel = this.props.handleCancel;
        const handleLive = this.props.handleLive;
        const { getFieldProps } = this.props.form;
        const visible = this.props.visible;


        return <Modal title="关联房间" visible={visible} onOk={handleLive.bind(null, roomid)} onCancel={handleCancel}>
            <Form inline>
              <FormItem
                label="房间号：">
                <Input {...getFieldProps('number')} />
              </FormItem>
              <FormItem>
                <Button type="primary" onClick={this.handleSubmit}>查看该房间号</Button>
              </FormItem>
          </Form>
          <div>{roomDetail ? (
              <ul className="tb10">
                <li>直播间ID：{roomDetail.roomid}</li>
                <li>直播间名称：{roomDetail.roomname}</li>
                <li>主播名称：{roomDetail.nickname}</li>
                <li>主播状态：{roomDetail.is_live ? "直播中":"未开播"}</li>
              </ul>
            ) : ""}</div>
        </Modal>
    }
});

const CompomentRoom = Form.create()(Room);

// 关联技能


const App = React.createClass({
  getInitialState() {
    return {
      matchs: [],
      teams: [],
      visible: false,
      liveVisible: false,
      skillVisible: false,
      editMatch: {
        home_team:"",
        guest_team:"",
        game_typename:'篮球3v3',
        game_starttime:'',
        game_sectiontime:'',
        game_sectionnum: '1',
        game_description:''
      },
      currentMatch: null,
      currentLiveRoom: null,
      liveRooms: [],
      currentSkills: [],
      skills: [],
      selectedSkills: [],
      AllSkills: []
    };
  },
  startGame(record, e){
    e.preventDefault();
    let data = {
      game_id: record.id,
      room_id: record.room_id
    }
    if(data.game_id && data.room_id){
      dataService.post('/chaoneng/games/startGame', data).then(res=>{
        if(res.code == 1){
          notification.success({message:"开始成功，正在跳转..."});
          this.props.router.replace(`/psychc/operate/${data.room_id}`);
        } else{
          notification.error({message: res.msg})
        }
      });
    } else{
      notification.error({message:"未关联直播间，无法开始比赛！"});
    }
  },
  addMatch(e){
    e.preventDefault();
    this.setState({
      visible: true,
      currentMatch: null,
      editMatch: {
        home_team:"",
        guest_team:"",
        game_typename:'篮球3v3',
        game_starttime:'',
        game_sectiontime:'',
        game_sectionnum: '1',
        game_description:''
      }
    })
  },
  showLive(info, e){
    e.preventDefault();
    this.setState({
      liveVisible: true,
      currentMatch: info.id
    });
  },
  showSkill(info, e){
    e.preventDefault();

    let allSkills = this.state.AllSkills.sort(function(){ return Math.random() > .5 ? 1 : -1 });
    let selectedSkills = [];
    let defaultSelectSkills = info.skill_info || [];
    allSkills.map(skill => {
        if(parseInt(skill.skill_visible)){
            defaultSelectSkills.map(skill1 => {
                if(skill.id == skill1.skill_id){
                    if(selectedSkills.indexOf(skill.id) == -1){
                        selectedSkills.push(skill.id);
                    }
                }
            })
        }
    });
    this.setState({
        skills: allSkills,
        skillVisible: true,
        currentMatch: info.id,
        currentSkills: selectedSkills
    });
  },
  editTeam( info, e ){
    e.preventDefault();
    this.setState({
      currentMatch: info.id,
      editMatch: info,
      visible: true
    })
  },
  getTeams(){
    dataService.get('/chaoneng/games/getAll').then(games=>{
      this.setState({
        matchs: games.data,
      })
    });
  },
  componentDidMount(){
    this.getTeams();
    //获取全部技能
    dataService.get('/chaoneng/skills/getAll').then(res=>{
        if(res.code == 1){
            this.setState({
                AllSkills: res.data
            });
        } else{
            notification.error({message: res.msg});
        }
    });
    //获取全部球队
    dataService.get('/chaoneng/teams/getAll').then(teams=>{
        this.setState({
          teams: teams.data
        })
    })
  },
  handleSubmit(){
    if(!lockForm){
        lockForm = true
    } else{
        return;
    }
    let isPassForm = true;
    this.props.form.validateFields((errors, values) => {
        if (!!errors) {
          isPassForm = false
          return;
        }
    });
    if(!isPassForm){
        lockForm = false
        return
    }
    let formData = this.props.form.getFieldsValue();
    if(formData.game_starttime){
        formData.game_starttime = (new Date(formData.game_starttime).getTime() / 1000) | 0;
    } else{
        formData.game_starttime = (new Date().getTime() / 1000) | 0;
    }
    let matchId = this.state.currentMatch;
    if(matchId){
      formData.id = matchId;
      dataService.post('/chaoneng/games/update', formData).then(res=>{
        if(res.code == 1){
           notification.success({message: "比赛更新成功"})
           this.getTeams();
           this.props.form.resetFields();
        } else{
           notification.error({message: res.msg})
        }
        this.handleCancel();
      })
    } else{
      dataService.post('/chaoneng/games/create', formData).then(res=>{
        if(res.code == 1){
           notification.success({message: "比赛创建成功"})
           this.getTeams();
           this.props.form.resetFields();
        } else{
           notification.error({message: res.msg})
        }
        this.handleCancel();
      })
    }

  },
  handleCancel(){
    this.setState({
      visible: false,
      liveVisible: false,
      skillVisible: false,
      selectedSkills: []
    });
    lockForm = false
  },
  handleLive( room_id ){
    if(!room_id) {
        notification.info({ message: "需要查看直播间" });
        return;
    }
    let currentLiveRoomId = room_id;
    let currentMatchId = this.state.currentMatch;
    if(currentLiveRoomId && currentMatchId){
      dataService.post('/chaoneng/games/setGameRoom', {
        game_id : currentMatchId,
        room_id : currentLiveRoomId
      }).then(res=>{
        if(res.code == 1){
          notification.success({ message:"关联直播间成功" });
          let matchs = this.state.matchs;
          matchs.map(item =>{
            if(item.id == currentMatchId){
              item.room_id = currentLiveRoomId;
            }
          });
          this.setState({
            matchs: matchs,
            liveVisible: false
          });
          this.getTeams();
        } else{
          notification.error({message: res.msg })
        }
      })
    }
    this.handleCancel();
  },
  handleSkill(){
    let currentSkills = this.state.currentSkills;
    let currentMatchId = this.state.currentMatch;
    let data = {
      game_id: currentMatchId,
      skill_ids: currentSkills
    }
    dataService.post('/chaoneng/games/addSkills', data).then(res=>{
        if(res.code == 1){
            notification.success({message:"技能关联成功！"});
            this.getTeams();
        }else{
            notification.error({message: res.msg});
        }
    })
    this.handleCancel();
  },
  render() {
    const { getFieldProps } = this.props.form;
    const self = this;
    const columns = [{
      title: '比赛ID',
      dataIndex: 'id',
    },{
      title: '主队VS客队',
      key: 'name',
      render(text, record){
        return (
          <span>
            {record.home_team_info.cn_name} {record.home_score} : {record.guest_score} {record.guest_team_info.cn_name}
            【{['未开始','正在进行','已结束'][record.game_status]}】
          </span>
        )
      }
    },{
      title: '比赛开始时间',
      dataIndex: 'game_starttime',
    },{
      title: '操作',
      key :'skillcon',
      render(text, record){
        return (
          <p>
            {record.game_status == 2 ? '':
             (<span>
              比赛:
              {record.game_status == 1 ?
                <Link to={`/psychc/operate/${record.room_id}`}>进入操作后台</Link> :
                <a href="#" onClick={self.startGame.bind(null, record)}>开始比赛</a>
              }
              <span className="ant-divider"></span>
                {record.game_status == 1 ?
                    <span>编辑比赛</span> :
                    <a href="#" onClick={self.editTeam.bind(null, record)}>编辑比赛</a>
                }
              <br />
            </span>)}
          直播间: {record.game_status == 0 ? <a href="#" onClick={self.showLive.bind(null, record)}>{record.room_id ? `更改直播间(${record.room_id})`:'关联直播间'}</a>:`已关联直播间(${record.room_id})`}

        <br />
        技能: {record.game_status == 0 ? <a href="#" onClick={self.showSkill.bind(null, record)}>已关联技能({record.skill_info ? (record.skill_info.length / 2) : 0})</a>: '进入操作后台查看'}
    </p>
  )
}
}];

const skillcolumns = [{
    title:'id',
    dataIndex: "id"
},{
  title: '技能名称',
  dataIndex: 'skill_name'
}];

const currentSkills = this.state.currentSkills;
const skillRowSelection = {
  type: "checkbox",
  onChange(selectedRowKeys, selectedRows){
    self.setState({
      currentSkills: selectedRowKeys
    })
  },
  getCheckboxProps(record) {
   return {
     defaultChecked : currentSkills.indexOf(record.id) != -1
   };
 }
};
let teamOptions = [];
this.state.teams.map(team=>{
  teamOptions.push(<Option value={team.id}>{team.cn_name}</Option>)
})
//不可选日期
const disabledDate = function (current) {
  return current && (current.getTime() + 2 * 3600 * 1000) < Date.now();
};

const pagination = {
  total: this.state.matchs.length,
  showSizeChanger: true,
  pageSize: 20
};

return (
  <QueueAnim delay={500}>
    <div className="tb10">
      <Button type="primary" onClick={this.addMatch}><Icon type="plus" />新建比赛</Button>
    </div>
    <Table
      rowKey={team => team.id}
      columns={columns}
      dataSource={this.state.matchs}
      pagination={pagination} />
    <Modal
      onOk={this.handleSubmit}
      title="新建比赛"
      onCancel={this.handleCancel}
      visible={this.state.visible}>
      <Form inline form={this.props.form}>
        <Row>
          <FormItem
            label="主队名称："
            labelCol={{ span: 10 }}
            wrapperCol={{ span: 12 }}>
            <Select
              {...getFieldProps('home_team',{
                initialValue: this.state.editMatch.home_team,
                rules: [
                   { required: true, message: '请选择主队' }
                ]
              })}
              style={{ width: 200 }}
              placeholder="选择主队">
              {teamOptions}
            </Select>
          </FormItem>
        </Row>
        <Row>
          <FormItem
            label="客队名称："
            labelCol={{ span: 10 }}
            wrapperCol={{ span: 12 }}>
            <Select
              {...getFieldProps('guest_team',{
                initialValue: this.state.editMatch.guest_team,
                rules: [
                   { required: true, message: '请选择客队' }
                ]
              })}
              style={{ width: 200 }}
              placeholder="选择客队">
              {teamOptions}
            </Select>
          </FormItem>
        </Row>

        <Row>
          <FormItem
            label="比赛时间："
            labelCol={{ span: 11 }}
            wrapperCol={{ span: 11 }}>
            <DatePicker
              {...getFieldProps('game_starttime',{
                initialValue: this.state.editMatch.game_starttime ? new Date(this.state.editMatch.game_starttime) : new Date(),
                rules: [
                   { required: true, type: 'date',message: '请选择比赛时间' }
                ]
              })}
              showTime
              disabledDate={disabledDate}
              format="yyyy-MM-dd HH:mm:ss" />
          </FormItem>
        </Row>

        <Row>
          <FormItem
            label="对阵类型："
            labelCol={{ span: 10 }}
            wrapperCol={{ span: 12 }}>
            <Select
              {...getFieldProps('game_type',{
                initialValue: this.state.editMatch.game_typename
              })}
              style={{ width: 200 }}
              placeholder="选择对阵类型">
              <Option value="篮球3v3">篮球3v3</Option>
              <Option value="篮球5v5">篮球5v5</Option>
            </Select>
          </FormItem>
        </Row>

        <Row>
          <FormItem
            label="比赛节数："
            labelCol={{ span: 10 }}
            wrapperCol={{ span: 12 }}>
            <Select
              {...getFieldProps('game_sectionnum',{
                  initialValue: this.state.editMatch.game_sectionnum
              })}
              style={{ width: 200 }}
              placeholder="选择比赛节数">
              <Option value="1">1</Option>
              <Option value="2">2</Option>
              <Option value="3">3</Option>
              <Option value="4">4</Option>
            </Select>
          </FormItem>
        </Row>

        <Row>
          <FormItem
            label="单节时间："
            labelCol={{ span: 10 }}
            wrapperCol={{ span: 12 }}>
            <Select
              {...getFieldProps('game_sectiontime',{
                initialValue: this.state.editMatch.game_sectiontime,
                rules: [
                   { required: true, message: '请选择单节时间' }
                ]
              })}
              style={{ width: 200 }}
              placeholder="选择单节时间">
              <Option value="480">8分钟</Option>
              <Option value="600">10分钟</Option>
              <Option value="720">12分钟</Option>
              <Option value="900">15分钟</Option>
              <Option value="1200">20分钟</Option>
              <Option value="1260">21分钟</Option>
            </Select>
          </FormItem>
        </Row>

        <Row>
          <FormItem
            label="比赛介绍："
            labelCol={{ span: 6 }}
            wrapperCol={{ span: 16 }}>
            <Input
              {...getFieldProps('game_description',{
                initialValue: this.state.editMatch.game_description,
                rules: [
                   { required: true, message: '请填写比赛介绍' }
                ]
              })}
              type="textarea"
              rows="3"
              cols="60"
              placeholder="填写比赛介绍，不得少于50个字" />
          </FormItem>
        </Row>
      </Form>
    </Modal>

    <Modal
      onOk={this.handleLive}
      title="关联直播间"
      onCancel={this.handleCancel}
      visible={this.state.liveVisible}>
      <CompomentRoom handleLive={this.handleLive} visible={this.state.liveVisible}  handleCancel={this.handleCancel} />
    </Modal>

    <Modal
      onOk={this.handleSkill}
      title="未关联技能列表"
      onCancel={this.handleCancel}
      visible={this.state.skillVisible}>
      <Table
        columns={skillcolumns}
        dataSource={this.state.skills}
        rowSelection={skillRowSelection}
        pagination={{ pageSize: 50 }}
        rowKey={skill => skill.id} />
    </Modal>
  </QueueAnim>
);
}
});

export default withRouter(Form.create()(App));
