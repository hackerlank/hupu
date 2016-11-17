import React from 'react';
import { Link, History } from 'react-router';
import { Table, Form, DatePicker, Button, Input, message } from 'antd';
import dataService from 'common/dataService';

/**
 * 接口地址
 * @type {Object}
 */
const apiUrl = {
  //
  detail: '/manage/room-income/:id'
}

const FormItem = Form.Item;

const RoomIncome = React.createClass({
  mixins: [History],
  getInitialState() {
    return {
      loading: true,
      modalVisible: false,
      anchor: 0,
      id: 0,
      gift_total: 0,
      list: [],
      count: 0,
      per: 20,
      page: 1,
      modalData: {}
    }
  },
  componentWillMount() {
    this.setState({
      id: this.props.params.id
    });

    this.pageUpload();
  },
  /**
   * 分页更新列表
   * @return {[type]} [description]
   */
  pageUpload(page = 1) {

    var url = apiUrl.detail.replace(':id', this.props.params.id);

    this.setState({
      loading: true
    });

    dataService
      .get(url, {page: page})
      .then((result) => {

        if(result.code === 1){

          this.setState({
            list: result.data.list,
            count: result.data.count,
            page: result.data.page,
            gift_total: result.data.total,
            per: result.data.per,
            loading: false
          });
        }else{
          message.error(result.msg);
        }
    })
  },
  /**
   * 查看虎扑币详细
   * @param  {[type]} record [description]
   * @param  {[type]} type   [description]
   * @return {[type]}        [description]
   */
  handleDaily(record, type) {
    this.setState({
      modalVisible: true,
      modalData: {
        date: record.date,
        anchor: this.state.id
      }
    });
  },
  render() {
    const self = this;

    const columns = [
      {
        title: '场次ID',
        dataIndex: 'data',
        key: 'gid',
        render(text, record) {
          return record.id
        }
      },
      {
        title: '开始时间',
        dataIndex: 'data',
        key: 'begin_time',
        render(text, record) {
          return record.begin_time
        }
      },
      {
        title: '直播时长',
        dataIndex: 'data',
        key: 'live_time',
        render(text, record) {
          return record.live_time
        }
      },
      {
        title: '礼物数',
        dataIndex: 'total',
        key: 'total',
        render(text, record) {
          return <Link to={`/room/single/${record.id}`} query={{room_id: `${self.state.id}`, match_id: `${record.id}`}} className="ant-btn">{record.gift_number}</Link>;
        }
      },
      {
        title: '送礼人数',
        dataIndex: 'userCount',
        key: 'userCount',
        render(text, record) {
         return <Link to='/room/rank' query={{id: `${record.id}`}} className="ant-btn">{record.gift_people_number}</Link>;
         }
      },
      {
        title: '热线数',
        dataIndex: 'message',
        key: 'message'
      },
      {
        title: '发言人数',
        dataIndex: 'users',
        key: 'users'
      },
      {
        title: '在线人数',
        dataIndex: 'rid',
        key: 'rid',
        render(text, record) {
          return <Link to={`/room/online`}  query={{room_id: `${self.state.id}`, match_id: `${record.id}`}} className="ant-btn">进入在线图表</Link>;
        }
      }
    ];

    const pagination = {
        total: this.state.count,
        pageSize: this.state.per,
        onChange: this.pageUpload,
        current: this.state.page
    };


    return (
      <div className="gift-detail">
        <Button type="primary" onClick={this.history.goBack} style={{marginBottom:15}}>返回</Button>
        <h2 style={{marginBottom: 10}}>直播明细</h2>
        <h4 style={{marginBottom: 10}}>
          礼物总收益：{this.state.gift_total}/礼物
        </h4>
        <Table
          columns={columns}
          rowKey={record => record.id}
          loading={this.state.loading}
          pagination={pagination}
          dataSource={this.state.list}
        />
      </div>
    );
  }
});


export default RoomIncome;
