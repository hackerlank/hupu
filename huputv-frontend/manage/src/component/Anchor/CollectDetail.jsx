import React from 'react';
import { Link, History } from 'react-router';
import { Table, Form, DatePicker, Button, Input, message } from 'antd';

import dataService from 'common/dataService';
// 查看礼物
import GiftModal from './GiftModal';

const FormItem = Form.Item;

/**
 * 接口地址
 * @type {Object}
 */
const apiUrl = {
  //
  collectDetail: '/manage/anchor/collect-daily'
}


const Collect = React.createClass({
  mixins: [History],
  getInitialState() {
    return {
      loading: true,
      modalVisible: false,
      anchor: 0,
      id: 0,
      list: [],
      modalData: {}
    }
  },
  componentWillMount() {
    this.pageUpload();
  },
  /**
   * 分页更新列表
   * @return {[type]} [description]
   */
  pageUpload(data) {

    let sendData = {
      anchor: this.props.params.id,
      start_time: this.props.location.query.start_time,
      end_time: this.props.location.query.end_time,
    };

    dataService
      .get(apiUrl.collectDetail, sendData)
      .then((result) => {
        this.setState({
          loading: false,
          id: this.props.params.id
        });

        if(result.code === 1){
          this.setState({
            ...result.data
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
        anchor: this.state.id,
        type
      }
    });
  },
  render() {
    const self = this;

    const columns = [
      {
        title: '日期',
        dataIndex: 'date',
        key: 'date'
      },
      {
        title: '直播时长',
        dataIndex: 'live_time',
        key: 'live_time'
      },
      {
        title: '虎扑币数',
        dataIndex: 'gold',
        key: 'gold',
        render(text, record) {
         return <Button onClick={self.handleDaily.bind(self, record, '6')}>{text}</Button>;
         }
      },
      {
        title: '金豆数',
        dataIndex: 'beans',
        key: 'beans',
        render(text, record) {
         return <Button onClick={self.handleDaily.bind(self, record, '1')}>{text}</Button>;
         }
      },
      {
        title: '热线数',
        dataIndex: 'message',
        key: 'message'
      }
    ];

    return (
      <div className="gift-detail">
        <Button type="primary" onClick={this.history.goBack} style={{marginBottom:15}}>返回列表</Button>
        <h2 style={{marginBottom: 10}}>分日直播数据汇总</h2>
        <h4 style={{marginBottom: 10}}>
          时间：{this.state.start_date}到{this.state.end_date}<br />
          主播名称：{this.state.anchor}
        </h4>
        <Table
          columns={columns}
          rowKey={record => record.date}
          loading={this.state.loading}
          pagination={false}
          dataSource={this.state.list}
        />

        <GiftModal
          visible = {this.state.modalVisible}
          modalData = {this.state.modalData}
         />
      </div>
    );
  }
});

Collect.key = 'anchor';

export default Collect;
