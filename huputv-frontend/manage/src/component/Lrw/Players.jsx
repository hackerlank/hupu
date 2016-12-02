import React, { Component } from 'react';
import { Link } from 'react-router';
import { Form, Button, Select,Input,Table,Modal} from 'antd';
import PlayersModal from './PlayersModal';
import PlayersEdit  from './PlayersEdit';

import dataService from 'common/dataService';
const FormItem = Form.Item;
/**
 * 接口地址
 * @type {Object}
 */
const apiUrl = {
}
let list=[]
class Players extends Component {
  constructor(props) {
    super(props);

    this.state = {
      visibledata:false,
      visibledit:false,
      editList:[],
      dataModal:[]
    };
  }

  componentWillMount() {

  }

  handleSelectChange(){

  }

  handleEdit(row){
    this.setState({
      visibledit:true,
      editList:row
    })   
  }

  handleDataModal(){
    this.setState({
      visibledata:true
    })   
  }

  gameCallback(){

   // cancelModal();
    /*this.state.visibledata=false;
    this.state.visibledit=false;
    console.log(this.state.visibledit);*/
  }
  cancelModal(){    
    console.log("ye ");
  }
  render() {
    const self=this;
    let dataSource=[{
    id:"001",
    name:"zhangsan",
    area:"上海古",
    PassPortId:"001",
    nickname:"nickname",
    avatar:"svg",
    battleGroup:"1",
    team:"2",
    qq:"12345678901",
    wechat:"rewrw",
    phone:"12345678910",
    idCard:"12564",
    height:170,
    wight:50,
    starIdol:"abc",
    idol:"adv",
    bounce:"2.12",
    speed:40,
    hand:"right",
    shoe:40,
    playTime:"fdfd",
    court:"dfsd",
    experience:"4念",
    singleDog:"yes",
    speech:"chiness",
    popularity:"yes",
    total:780,
    win:4,
    faile:4,
    rate:30,
    income:450

    }]
    const columns=[
    {
      title:"球员编号",
      dataIndex:"id",
      key:"id",
      width:60,
      fixed:"left"
    },{
      title:"球员姓名",
      dataIndex:"name",
      key:"name",
      width:70
    },{
      title:"所属地区",
      dataIndex:"area",
      key:"area",
      width:80
    },{
      title:"PassPortId",
      dataIndex:"PassPortId",
      key:"PassPortId",
      width:100
    },{
      title:"虎扑昵称",
      dataIndex:"nickname",
      key:"nickname",
      width:100
    },{
      title:"头像",
      dataIndex:"avatar",
      key:"avatar",
      width:150
    },{
      title:"所属战团",
      dataIndex:"battleGroup",
      key:"battleGroup",
      width:100
    },{
      title:"所属球队",
      dataIndex:"team",
      key:"team",
      width:100
    },{
      title:"QQ",
      dataIndex:"qq",
      key:"qq",
      width:100
    },{
      title:"微信号",
      dataIndex:"wechat",
      key:"wechat",
      width:100
    },{
      title:"手机号",
      dataIndex:"phone",
      key:"phone",
      width:150
    },{
      title:"身份证号",
      dataIndex:"idCard",
      key:"idCard",
      width:200
    },{
      title:"身高",
      dataIndex:"height",
      key:"height",
      width:70
    },{
      title:"体重",
      dataIndex:"wight",
      key:"wight",
      width:70
    },{
      title:"球星模板",
      dataIndex:"starIdol",
      key:"starIdol",
      width:80
    },{
      title:"喜爱球星",
      dataIndex:"idol",
      key:"idol",
      width:80
    },{
      title:"助跑摸高",
      dataIndex:"bounce",
      key:"bounce",
      width:100
    },{
      title:"百米速度",
      dataIndex:"speed",
      key:"speed",
      width:80
    },{
      title:"惯用手",
      dataIndex:"hand",
      key:"hand",
      width:70
    },{
      title:"球鞋",
      dataIndex:"shoe",
      key:"shoe",
      width:70
    },{
      title:"球龄",
      dataIndex:"playTime",
      key:"playTime",
      width:60
    },{
      title:"出没球场",
      dataIndex:"court",
      key:"court",
      width:100
    },{
      title:"校队及其球队经历",
      dataIndex:"experience",
      key:"experience",
      width:100
    },{
      title:"是否单身",
      dataIndex:"singleDog",
      key:"singleDog",
      width:50
    },{
      title:"参赛感言",
      dataIndex:"speech",
      key:"speech",
      width:70
    },{
      title:"总人气",
      dataIndex:"popularity",
      key:"popularity",
      width:80
    },{
      title:"总场数",
      dataIndex:"total",
      key:"total",
      width:80
    },{
      title:"总胜",
      dataIndex:"win",
      key:"win",
      width:80
    },{
      title:"总负",
      dataIndex:"faile",
      key:"faile",
      width:80
    },{
      title:"总胜率",
      dataIndex:"rate",
      key:"rate",
      width:80
    }
    ,{
      title:"虎扑币总收入",
      dataIndex:"income",
      key:"income",
      width:100,
      fixed:"right"
    }
    ,{
      title:"操作",
      dataIndex:"operation",
      key:"operation",
      width:"100",
      fixed:"right",
      render:(text,row,index)=>{
          return (
            <div>
              <Button  size="small"  onClick={self.handleEdit.bind(self,row)}>编辑</Button>
              <Button  size="small" onClick={self.handleDataModal.bind(self)}>单场数据</Button>
            </div>
          )
      }
    }]
    return (
      <div>
        <div style={{marginBottom:10}}>
          <Button type="primary">结算管理</Button>
        </div>
        <Form inline onSubmit={this.handleSubmit} style={{marginBottom:10}}>
          <FormItem label="球员搜索：">
              <Input  type="text" style={{width:200}}placeholder="球员名称、虎扑昵称、PassPortId" />          
          </FormItem>
          <FormItem label="选择战团：">
            <Select id="select" size="large" defaultValue="全部战团" style={{ width: 200 }} onChange={this.handleSelectChange.bind(this)}>
              <Option value="全部战团">全部战团</Option>
              <Option value="jack">jack</Option>
              <Option value="lucy">lucy</Option>
              <Option value="nice">disabled</Option>
              <Option value="yiminghe">yiminghe</Option>
            </Select>
          </FormItem>
          <FormItem label="选择球队：">
            <Select id="select" size="large" defaultValue="全部战团" style={{ width: 200 }} onChange={this.handleSelectChange.bind(this)}>
              <Option value="全部球队">全部球队</Option>
              <Option value="jack">jack</Option>
              <Option value="lucy">lucy</Option>
              <Option value="nice">disabled</Option>
              <Option value="yiminghe">yiminghe</Option>
            </Select>
          </FormItem>
          <Button type="primary" htmlType="submit">查询</Button>
        </Form>
       
        <Table dataSource={dataSource} columns={columns}   scroll={{ x: 2500,y: 300}} rowKey={record => record.id} />
        <PlayersModal visible={this.state.visibledata} callback = {this.gameCallback}/>
        <PlayersEdit visible={this.state.visibledit} callback = {this.gameCallback} playList={this.state.editList} />
       
      </div>
    );
  }
}

Players.key = 'players';

export default Players;
