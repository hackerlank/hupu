import React from 'react';
import { Link } from 'react-router';
import dataService from 'common/dataService';
import {Table, Form, Button, Input, Modal, Popconfirm, notification, Icon} from 'antd';
const FormItem = Form.Item;

const request = {
  getAllRoom(callback){
    dataService.get('/lunbo/room/getAll').then(res => {
      if(res.code == 1){
        callback(res.data)
      }else{
        notification.error({message: res.msg});
      }
    });
  },
  getRoomId(rid, callback){
    dataService.get('/lunbo/room/getByRid', {rid})
                .then(res => {
                  if(res.code == 1){
                    callback && callback(res)
                  } else{
                    notification.error({message: res.msg})
                  }
                });
  },
  addOperate(rid, callback, errCallback) {
    dataService.post('/lunbo/room/create',{rid})
               .then(res => {
                 if(res.code == 1){
                   callback && callback(res)
                 }else{
                   notification.error({message: res.msg});
                   errCallback && errCallback();
                 }
               });
  },
  removeOperate(rid, callback){
    dataService.post('/lunbo/room/delete',{rid})
               .then(res => {
                  if(res.code == 1){
                    callback && callback(res)
                  }else{
                    notification.error({message: res.msg});
                  }
               });
  },
  closeOperate(rid, callback){
    let type = 1;
    dataService.post('/lunbo/jobs/close',{rid, type})
               .then(res => {
                  if(res.code == 1){
                    callback && callback(res)
                  }else{
                    notification.error({message: res.msg});
                  }
               });
  }
}

const rowSelection = {
  type: "radio",
  onSelect(record){
    roomid = record.id;
  }
};


const Rooms = React.createClass({
    getInitialState() {
      return {
        operates: [],
        visible: false,
        roomDetail:""
      }
    },
    componentDidMount(){
      this.refresh();
    },
    refresh(){
      request.getAllRoom(operates => {
          operates.map(operate => {
            operate.liveStatus = operate.is_live == "1" ? "直播中":"未开始";
          });
          operates = operates.sort(item =>{
            return item.is_live == "1" ? -1 : 1;
          });
          this.setState({
            operates: operates
          })
      });
    },
    showAddOperate(){
      this.setState({
        visible: true
      })
    },
    handleSubmit(e){
      e.preventDefault();
      let formData = this.props.form.getFieldsValue();
      if(formData.number){
        request.getRoomId(formData.number, res =>{
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
    handleOk(){
      let formData = this.props.form.getFieldsValue();
      if(formData.number){
        request.addOperate(formData.number, res =>{
            notification.success({message: "添加成功"});

            this.setState({
              visible: false,
              roomDetail: ""
            });
            this.refresh();
        }, ()=>{
          this.setState({
            visible: false,
            roomDetail: ""
          });
        });
      }
    },
    handleCancel(){
      this.setState({
        visible: false,
        roomDetail: ""
      });
    },
    render() {
        const { getFieldProps } = this.props.form;
        let roomDetail = this.state.roomDetail;
        let self = this;
        const formItemLayout = {
          labelCol: { span: 3 },
          wrapperCol: { span: 10 },
        };
        const columns = [{
          title: "直播间ID",
          dataIndex: "id"
        },{
          title:"直播间名称",
          dataIndex: "room_name"
        },{
          title:"主播名称",
          dataIndex: "nickname"
        },{
          title:"直播状态",
          dataIndex:"liveStatus"
        },{
          title:"操作",
          key: 'settings',
          render(text, record) {
            function removeRoom(record){
              request.removeOperate(record.id, (res)=>{
                notification.success({message: res.msg});
                self.refresh();
              });
            }
            function closeRoom(record){
              request.closeOperate(record.id, (res)=>{
                notification.success({message: res.msg});
                self.refresh();
              });
            }
            return (
              <p>
              {record.is_live == '0' ? '关闭直播间' :
                <Popconfirm title="确定要关闭该直播间吗？" onConfirm={closeRoom.bind(null, record)}>
                  <a href="#">关闭直播间</a>
                </Popconfirm>
              }
              <span className="ant-divider"></span>
              <Popconfirm title="确定要删除该直播间吗？" onConfirm={removeRoom.bind(null, record)}>
                <a href="#">删除</a>
              </Popconfirm>
              </p>
            )
          }
        }];

        return (
            <div>
              <div className="tb10">
                <Button type="primary" onClick={this.refresh} style={{marginRight:10}}><Icon type="reload" />刷新当前列表</Button>
                <Button type="primary" onClick={this.showAddOperate}>关联主播房间号</Button>
              </div>
              <Table columns={columns} rowKey={room => room.id} dataSource={this.state.operates} />

              <Modal title="关联房间" visible={this.state.visible} onOk={this.handleOk.bind(this)} onCancel={this.handleCancel}>
                  <Form inline onSubmit={this.handleSubmit}>
                    <FormItem
                      label="房间号：">
                      <Input {...getFieldProps('number')} />
                    </FormItem>
                    <FormItem>
                      <Button type="primary" htmlType="submit">查看该房间号</Button>
                    </FormItem>
                </Form>
                <div>{roomDetail ? (
                    <ul className="tb10">
                      <li>直播间ID：{roomDetail.id}</li>
                      <li>直播间名称：{roomDetail.room_name}</li>
                      <li>主播名称：{roomDetail.nickname}</li>
                      <li>主播状态：{roomDetail.is_live ? "直播中":"未开播"}</li>
                    </ul>
                  ) : ""}</div>
              </Modal>
            </div>
        );
    }
});

export default Form.create()(Rooms);
