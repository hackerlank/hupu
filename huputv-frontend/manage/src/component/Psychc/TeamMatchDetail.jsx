import React from 'react';
import { Link } from 'react-router';
import { Icon, QueueAnim, Table, Button, Modal, notification, Upload, Form, Row, Col, DatePicker} from 'antd';
import dataService from 'common/dataService';
const FormItem = Form.Item;
const RangePicker = DatePicker.RangePicker;

const App = React.createClass({
  getInitialState() {
    return {
      data: [],
      visible: false,
      skills: [],
      start_time: "",
      end_time: ""
    };
  },
  getTeamMatch(){
    const team_id = this.props.params.id;
    const {start_time, end_time} = this.state;

    dataService.get('/chaoneng/games/getGameDetail',{team_id, start_time, end_time}).then(res=>{
      if(res.code == 1){
        console.log(res.data);
        this.setState({
          data: res.data.gameDetail
        })
      } else{
        notification.error({message: res.msg})
      }
    })
  },
  componentDidMount(){
    this.getTeamMatch();
  },
  showSkills(match, e){
    e.preventDefault();
    this.setState({
        skills: match.skillUsed,
        visible: true
    });
  },
  onHide(){
      this.setState({
          visible: false,
          skills: []
      });
  },
  onChange(value, dateString){
     const startDate = (value[0].getTime() / 1000)|0;
     const endDate   = (value[1].getTime() / 1000)|0;
     this.setState({
         start_time: startDate,
         end_time: endDate
     })
  },
  render() {
    let self = this;
    let columns = [{
        title: 'ID',
        name: "id",
        render(text, record){
            return <span>{record.game.id}</span>
        }
    },{
        title:'比赛名称',
        dataIndex: "gameName"
    },{
        title:'比赛时间',
        name:'startTime',
        render(text, record){
            return <span>{record.game.game_starttime}</span>
        }
    },{
        title:'比赛类型',
        name: "typename",
        render(text, record){
            return <span>{record.game.game_typename}</span>
        }
    },{
        title:'比赛结果',
        name: "result",
        render(text, record){
            let home_score = parseInt(record.game.home_score);
            let guest_score = parseInt(record.game.guest_score);
            let isHome = record.isHome;
            let result = "";
            if(isHome){
                result = (home_score > guest_score ? "胜" : "败") + `${home_score} VS ${guest_score}`
            } else{
                result = `${home_score} VS ${guest_score}` + (guest_score > home_score ? "胜" : "败");
            }
            return <span>{result}</span>
        }
    },{
        title:'比赛收入',
        dataIndex: "rcvGift"
    },{
        title:'比赛支出',
        dataIndex: "useGift"
    },{
        title:'操作',
        name:'handle',
        render(text, record){
            return <a onClick={self.showSkills.bind(null, record)}>支出明细</a>
        }
    }];
    let skillcolumns = [{
        title: 'id',
        dataIndex: 'skill_id'
    },{
        title: '技能名称',
        dataIndex: 'skill_name'
    },{
        title: '技能花费汇总',
        dataIndex: 'skill_pay_total'
    }];
    const pagination = {
      total: this.state.skills.length,
      showSizeChanger: true,
      pageSize: 20
    };

    return (
      <QueueAnim delay={500}>
      <div style={{padding: 8}}>
          <Row>
              <Col span={4}><RangePicker style={{ width: 184 }} onChange={this.onChange} /></Col>
              <Col span={2}><Button type="primary" onClick={this.getTeamMatch}>查询</Button></Col>
          </Row>
      </div>
        <Table columns={columns} dataSource={this.state.data}></Table>
        <Modal visible={this.state.visible} onOk={this.onHide} onCancel={this.onHide}>
            <Table columns={skillcolumns} dataSource={this.state.skills} pagination={pagination}></Table>
        </Modal>
      </QueueAnim>
    );
  }
});

export default App
