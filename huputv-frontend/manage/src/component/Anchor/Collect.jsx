import React from 'react';
import { Link } from 'react-router';
import { Table, Form, DatePicker, Button, Input, message } from 'antd';

import dataService from 'common/dataService';

const FormItem = Form.Item;

/**
 * 接口地址
 * @type {Object}
 */
const apiUrl = {
  //
  collect: '/manage/anchor/collect'
}

/**
 * 搜索
 */
const SearchInput = React.createClass({
  getInitialState() {
    return {
      startValue: '',
      endValue: '',
      anchor: ''
    };
  },
  disabledStartDate(startValue) {
    if (!startValue || !this.state.endValue) {
      return false;
    }
    return startValue.getTime() >= this.state.endValue.getTime();
  },
  disabledEndDate(endValue) {
    if (!endValue || !this.state.startValue) {
      return false;
    }
    return endValue.getTime() <= this.state.startValue.getTime();
  },
  onChange(field, value) {
    this.setState({
      [field]: value
    });
  },
  format(value) {
    if(!value){
      return '';
    }
    var date = new Date(value);

    return date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate();
  },
  handleBlurAnchor(e) {
    this.setState({
      anchor: e.target.value
    });
  },
  /**
   * 搜索提交
   */
  handleSubmit(event){
    this.props.handlePageUpload({
      start_time: this.format(this.state.startValue),
      end_time: this.format(this.state.endValue),
      anchor: this.state.anchor
    });
  },
  render() {
    return (
      <div>
        <Form inline>
          <FormItem label="主播名称：">
              <Input placeholder="请输入主播名称" onBlur={this.handleBlurAnchor} />
          </FormItem>
          <FormItem label="统计周期：">
            <DatePicker disabledDate={this.disabledStartDate}
              value={this.state.startValue}
              placeholder="开始时间"
              onChange={this.onChange.bind(this, 'startValue')} />
            <span style={{ marginRight:10, marginLeft: 10 }}>至</span>
            <DatePicker disabledDate={this.disabledEndDate}
              value={this.state.endValue}
              placeholder="结束时间"
              onChange={this.onChange.bind(this, 'endValue')} />
          </FormItem>

          <Button type="primary" htmlType="submit" onClick={this.handleSubmit}>查询</Button>
        </Form>
      </div>
    );
  }
});


const Collect = React.createClass({
  getInitialState() {
    return {
      loading: true,
      count: 0,
      list: [],
      per: 20,
      currentPage: 1,
      search: {
        start_time: '',
        end_time: ''
      }
    }
  },
  componentWillMount() {
    this.handlePageUpload(1);
  },
  /**
   * 分页更新列表
   * @return {[type]} [description]
   */
  handlePageUpload(data) {

    let sendData = {
    };

    if(typeof data == 'object' && data.constructor == Object){
      sendData = {
        page: 1,
        ...data
      }

      this.setState({
        currentPage: 1,
        loading: true,
        search: {
          ...data
        }
      });
    }else{
      sendData = {
        page: data,
        ...this.state.search
      }

      this.setState({
        currentPage: data,
        loading: true,
        ...this.state.search
      });
    }

    dataService
      .get(apiUrl.collect, sendData)
      .then((result) => {
        this.setState({
          loading: false
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
  render() {
    const self = this;
    const pagination = {
      total: this.state.count,
      pageSize: this.state.per,
      current: this.state.currentPage,
      onChange: (index) => {
        this.handlePageUpload(index);
      }
    };

    const columns = [
      {
        title: '主播名称',
        dataIndex: 'anchor_nickname',
        key: 'anchor_nickname'
      },
      {
        title: '汇总周期',
        dataIndex: 'live_time',
        key: 'live_time'
      },
      {
        title: '虎扑币数',
        dataIndex: 'gold',
        key: 'gold'
      },
      {
        title: '金豆数',
        dataIndex: 'beans',
        key: 'beans'
      },
      {
        title: '热线数',
        dataIndex: 'message',
        key: 'message'
      },
      {
        title: '操作',
        dataIndex: 'oprations',
        key: 'oprations',
        render(text, record) {
          return (
            <span>
              <Link to={`/anchor/collect/${record.puid}`} query={{start_time: `${self.state.search.start_time}`, end_time: `${self.state.search.end_time}`}} className="ant-btn">分日明细</Link>
            </span>
          );
       }
      }
    ];

    return (
      <div className="gift-detail">
        <h2 style={{marginBottom: 10}}>直播数据汇总</h2>
        <div style={{marginBottom: 10}}>
          <SearchInput handlePageUpload={this.handlePageUpload} />
        </div>

        <Table
          columns={columns}
          rowKey={record => record.uid}
          loading={this.state.loading}
          dataSource={this.state.list}
          pagination={pagination}
        />

      </div>
    );
  }
});

Collect.key = 'anchor';

export default Collect;
