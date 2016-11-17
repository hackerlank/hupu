import React from 'react';
import { Link } from 'react-router';
import { Icon, QueueAnim, Table, Button, Popconfirm, Modal, notification, Radio} from 'antd';
import dataService from 'common/dataService';
import message from 'common/message';

let roomid = null;
let liveRoomNum = 0;

const showWarning = (msg) => {
    notification.info({
      message: msg,
      duration: 60
    });
};
setInterval(()=>{
  if(~location.hash.indexOf("huiti")){
    request.getLiveApiData(rooms=>{
        let liveNum = 0;
        rooms.map(room =>{
          if(room.liveStatus == 2){
            liveNum++
          }
        })
        if(liveNum != liveRoomNum && liveRoomNum != 0){
          showWarning("发现有新的直播间, 可以刷新看看!");
          liveRoomNum = liveNum
        }
    })
  }
}, 15000)

let handleRooms = data => {
  const status = {
    0: "未安排直播",
    1: "未开始",
    2: "直播中",
    3: "已结束"
  }
  //处理数据
  data.map(item => {
    item.statusText = status[item.liveStatus];
    item.address = item.position ? `${item.position.stadiumName}-${item.position.courtName}` : '';
    item.leagueName = item.league ? item.league.name : "无";
    item.refRoom = item.rid || (item.liveInfo ? item.liveInfo.id : 0);
    return item
  });
  return data;
}

const request = {
  liveOpen(rid, gameId, callback){
    let type = 1;
    dataService.post('/lunbo/jobs/update',{rid, gameId, type}).then((res) => {
      if(res.code == 1){
        notification.success({message: res.msg});
        callback && callback(res);
      }else{
        notification.error({message: res.msg});
      }
    });
  },
  liveClose(rid, gameId, callback){
    let type = 1;
    dataService.post('/lunbo/jobs/close',{rid, gameId, type}).then((res) => {
      if(res.code == 1){
        notification.success({message: res.msg});
        callback && callback(res);
      }else{
        notification.error({message: res.msg});
      }
    });
  },
  setRoomGame(rid, gameId, callback){
    let type = 1;
    dataService.post('/lunbo/jobs/setRoomGame',{rid, gameId, type}).then((res) => {
      if(res.code == 1){
        notification.success({message: res.msg});
        callback && callback(res);
      }else{
        notification.error({message: res.msg});
      }
    });
  },
  liveChange(oldrid, newrid, gameId, callback){
    let type = 1;
    dataService.post('/lunbo/jobs/change',{oldrid, newrid, gameId, type}).then((res) => {
      if(res.code == 1){
        notification.success({message: res.msg});
        callback && callback(res);
      }else{
        notification.error({message: res.msg});
      }
    });
  },
  getLiveRoom(callback){
    dataService.get('/lunbo/room/getAll').then((res) => {
      if(res.code == 1){
        let data = [];
        res.data.map(item =>{
          //只显示空闲的主播房间.
          if(item.is_live == "0"){
            data.push(item);
          }
        })
        callback( data )
      }else{
        notification.error({message: res.msg});
      }
    });
  },
  getNeedOpen(callback){
    dataService.get('/lunbo/huiti/getNeedOpen').then((res) => {
      if(res.code == 1){
        callback( handleRooms(res.data) )
      }else{
        notification.error({message: res.msg});
      }
    });
  },
  getNeedClose(callback){
    dataService.get('/lunbo/huiti/getNeedClose').then((res) => {
      if(res.code == 1){
        callback( handleRooms(res.data) )
      }else{
        notification.error({message: res.msg});
      }
    });
  },
  getLiveApiData(callback){
    dataService.get('/lunbo/huiti/getAll').then((res) => {
      if(res.code == 1){
        callback( handleRooms(res.data) )
      }else{
        notification.error({message: res.msg});
      }
    });
  }
}

const roomColumns = [{
   title:"直播间Id",
   dataIndex: "id"
},{
   title:"直播间名称",
   dataIndex: "room_name"
},{
  title:"主播名称",
  dataIndex: "nickname"
}];

const rowSelection = {
  type: "radio",
  onSelect(record){
    roomid = record.id;
  }
};

let tableBaseColumns = [{
    title: '球队',
    width: 220,
    dataIndex: 'gameName',
  },{
    title: '预计开始时间',
    width: 140,
    dataIndex: 'startTime',
  },{
    title: '赛事',
    width: 70,
    dataIndex: 'sportType',
  },{
    title: '直播状态',
    width: 70,
    dataIndex: 'statusText',
  }, {
    title: '直播方式',
    width: 70,
    dataIndex: 'gameModel',
  },{
    title: '球馆',
    width: 160,
    dataIndex: 'address',
  },{
    title: '联赛',
    width: 160,
    dataIndex: 'leagueName',
  }];

const LiveIndex = React.createClass({
    getInitialState() {
        return {
            data: [],
            loading: false
        };
    },
    componentDidMount(){
      this.refresh();
    },
    refresh(){
      this.setState({
        loading: true
      });
      request.getLiveApiData(rooms => {
          let liveNum = 0;
          rooms.map(room =>{
            if(room.liveStatus == 2){
              liveNum++
            }
          })
          liveRoomNum = liveNum;

          this.setState({
            data: rooms,
            loading: false
          })
      });
    },
    render() {
        let originData = this.state.data;
        let data = [];
        let self = this;
        let columns = tableBaseColumns.concat([{
          title: '操作',
          key: 'setting',
          render(text, record) {
            //开关直播，是指开关直播间 & 开发直播流转换.
            function toggleLive(record){
                if(!!record.refRoom){
                  request.liveClose(record.refRoom, record.gameId, ()=>{
                      self.refresh();
                  });
                } else{
                  message.fire("chooseroom", record.gameId, record.refRoom, ()=>{
                      self.refresh();
                  });
                }
            }
            function gotoOnlink(record){
              let action = `${record.liveInfo.abs_url}`
              window.open(action);
            }
            function videoPreview(record){
              let action = `http://www.videohupu.com/manage/static/saplayer.html?addr=${record.livePullPatch}`
              window.open(action);
            }
            let html = !!record.refRoom ? "关闭直播":"开启直播";
            let title = `确定要${html}吗？`;
            return (
              <p>
                {record.liveStatus == 1 ? '开启直播':
                (<Popconfirm title={title} onConfirm={toggleLive.bind(null, record)}>
                  <a href="#" className={record.refRoom ?'red':''}>{html}</a>
                </Popconfirm>)}
                <span className="ant-divider"></span>
                {record.refRoom
                ?  <a onClick={gotoOnlink.bind(null, record)}>查看直播({record.refRoom})</a>
                :  '查看直播'}
                <span className="ant-divider"></span>
                <a onClick={videoPreview.bind(null, record)}>视频预览</a>
              </p>
            )
          }
        }]);
        originData.map(item => {
          if(item.liveStatus == 1 || item.liveStatus == 2){
            data.push(item);
          }
        });
        return (
            <div>
              <div className="tb10">
                <Button type="primary" onClick={this.refresh}><Icon type="reload" />刷新当前列表</Button>
              </div>
                <Table rowKey={record => record.gameId} loading={this.state.loading} columns={columns} dataSource={data} />
            </div>
        );
    }
});

//待关闭直播间列表
const LiveClose = React.createClass({
    getInitialState() {
        return {
            data: [],
            loading: false
        };
    },
    componentDidMount(){
      this.refresh();
    },
    refresh(){
      this.setState({
        loading: true
      });
      request.getNeedClose(rooms => {
          this.setState({
            data: rooms,
            loading: false
          })
      });
    },
    render() {
      let self = this;
      let columns = tableBaseColumns.concat([{
        title: '操作',
        key: 'setting',
        render(text, record) {
          //开关直播，是指开关直播间 & 开发直播流转换.
          function toggleLive(record){
              if(!!record.refRoom){
                request.liveClose(record.refRoom, record.gameId, ()=>{
                    self.refresh();
                });
              } else{
                message.fire("chooseroom", record.gameId, record.refRoom, ()=>{
                    self.refresh();
                });
              }
          }
          function gotoOnlink(record){
            let action = `${record.liveInfo.abs_url}`
            window.open(action);
          }
          function videoPreview(record){
            let action = `http://www.videohupu.com/manage/static/saplayer.html?addr=${record.livePullPatch}`
            window.open(action);
          }
          let html = !!record.refRoom ? "关闭直播":"开启直播";
          let title = `确定要${html}吗？`;
          return (
            <p>
              {record.liveStatus == 1 ? '开启直播':
              (<Popconfirm title={title} onConfirm={toggleLive.bind(null, record)}>
                <a href="#" className={record.refRoom ?'red':''}>{html}</a>
              </Popconfirm>)}
              <span className="ant-divider"></span>
              {record.refRoom
              ?  <a onClick={gotoOnlink.bind(null, record)}>查看直播({record.refRoom})</a>
              :  '查看直播'}
              <span className="ant-divider"></span>
              <a onClick={videoPreview.bind(null, record)}>视频预览</a>
            </p>
          )
        }
      }]);

        return (
            <div>
              <div className="tb10">
                <Button type="primary" onClick={this.refresh}><Icon type="reload" />刷新当前列表</Button>
              </div>
              <Table rowKey={record => record.gameId} loading={this.state.loading} columns={columns} dataSource={this.state.data} />
            </div>
        );
    }
});

//待开启直播间列表
const LiveOpen = React.createClass({
    getInitialState() {
        return {
            data: [],
            loading: false
        };
    },
    componentDidMount(){
      this.refresh();
    },
    refresh(){
      this.setState({
        loading: true
      });
      request.getNeedOpen(rooms => {
          this.setState({
            data: rooms,
            loading: false
          })
      });
    },
    render() {
      let self = this;
      let columns = tableBaseColumns.concat([{
        title: '操作',
        key: 'setting',
        render(text, record) {
          //开关直播，是指开关直播间 & 开发直播流转换.
          function toggleLive(record){
              if(!!record.refRoom){
                request.liveClose(record.refRoom, record.gameId, ()=>{
                    self.refresh();
                });
              } else{
                message.fire("chooseroom", record.gameId, record.refRoom, ()=>{
                    self.refresh();
                });
              }
          }
          function gotoOnlink(record){
            let action = `${record.liveInfo.abs_url}`
            window.open(action);
          }
          function videoPreview(record){
            let action = `http://www.videohupu.com/manage/static/saplayer.html?addr=${record.livePullPatch}`
            window.open(action);
          }
          let html = !!record.refRoom ? "关闭直播":"开启直播";
          let title = `确定要${html}吗？`;
          return (
            <p>
              {record.liveStatus == 1 ? '开启直播':
              (<Popconfirm title={title} onConfirm={toggleLive.bind(null, record)}>
                <a href="#" className={record.refRoom ?'red':''}>{html}</a>
              </Popconfirm>)}
              <span className="ant-divider"></span>
              {record.refRoom
              ?  <a onClick={gotoOnlink.bind(null, record)}>查看直播({record.refRoom})</a>
              :  '查看直播'}
              <span className="ant-divider"></span>
              <a onClick={videoPreview.bind(null, record)}>视频预览</a>
            </p>
          )
        }
      }]);
        return (
            <div>
              <div className="tb10">
                <Button type="primary" onClick={this.refresh}><Icon type="reload" />刷新当前列表</Button>
              </div>
              <Table rowKey={record => record.gameId} loading={this.state.loading} columns={columns} dataSource={this.state.data} />
            </div>
        );
    }
});

const LiveRoomList = React.createClass({
    getInitialState() {
        return {
            rooms: [],
            visible: false,
            gameId: 0,
            oldrid: 0,
            callback: function(){}
        };
    },
    componentDidMount(){
      message.on("chooseroom", this.showRooms);
    },
    showRooms( gameId, oldrid, callback){
      let self = this;
      request.getLiveRoom(function(rooms){
          self.setRooms(rooms, gameId, oldrid, callback);
      });
    },
    setRooms(rooms = [], gameId, oldrid = null, callback = null){
      this.setState({
         rooms: rooms,
         visible: true,
         gameId: gameId,
         oldrid: oldrid,
         callback: callback
      });
    },
    handleOk(){
      if(this.state.oldrid){
        request.liveChange(this.state.oldrid, roomid, this.state.gameId, ()=>{
            this.handleCancel();
        });
      } else{
        request.liveOpen(roomid, this.state.gameId, () => {
            this.handleCancel();
        });
      }
    },
    handleCancel(){
      this.setState({
         visible: false
      });
      this.state.callback && this.state.callback();
    },
    render() {
        let rooms = this.state.rooms;
        return (
            <QueueAnim delay={500}>
              {this.props.children}
              <Modal title="关联房间" visible={this.state.visible} onOk={this.handleOk} onCancel={this.handleCancel}>
                <Table rowSelection={rowSelection} rowKey={room => room.id} columns={roomColumns} dataSource={rooms} />
              </Modal>
            </QueueAnim>
        );
    }
});

export default {
  LiveIndex,
  LiveOpen,
  LiveClose,
  LiveRoomList
}
