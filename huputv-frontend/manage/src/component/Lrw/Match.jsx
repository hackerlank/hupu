import React, { Component } from 'react';
import { Link } from 'react-router';
import { DatePicker, Form, Button, Select, Table } from 'antd';

import dataService from 'common/dataService';
import MatchModal from './MatchModal';

const FormItem = Form.Item;
const Option = Select.Option;

/**
 * 接口地址
 * @type {Object}
 */
const apiUrl = {
}

/**
 * 搜索
 */
class SearchInput extends Component {
  constructor(props) {
    super(props);

    this.state = {
      startValue: '',
      endValue: '',
      selectValue: ''
    };
  }
  disabledStartDate(startValue) {
    if (!startValue || !this.state.endValue) {
      return false;
    }
    return startValue.getTime() >= this.state.endValue.getTime();
  }
  disabledEndDate(endValue) {
    if (!endValue || !this.state.startValue) {
      return false;
    }
    return endValue.getTime() <= this.state.startValue.getTime();
  }
  format(value) {
    if(!value){
      return '';
    }
    var date = new Date(value);

    return date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate();
  }
  onChange(field, value) {
    this.setState({
      [field]: value
    });
  }
  selectChange(value) {
    this.setState({
      selectValue: value
    });
  }
  /**
   * 搜索提交
   * @param  {[type]} event [description]
   * @return {[type]}       [description]
   */
  handleSubmit(event){
    this.props.handlePageUpload({
      start_date: this.format(this.state.startValue),
      end_date: this.format(this.state.endValue),
      selectValue: this.state.selectValue
    });

  }
  render() {
    return (
      <div>
        <Form inline>
          <FormItem label="统计周期：">
              <DatePicker disabledDate={this.disabledStartDate.bind(this)}
                value={this.state.startValue}
                placeholder="开始时间"
                onChange={this.onChange.bind(this, 'startValue')} />
              <span style={{ marginRight:10, marginLeft: 10 }}>至</span>
              <DatePicker disabledDate={this.disabledEndDate.bind(this)}
                value={this.state.endValue}
                placeholder="结束时间"
                onChange={this.onChange.bind(this, 'endValue')} />
          </FormItem>
          <FormItem label="选择赛区：">
            <Select
              defaultValue="0"
              style={{ width: 100 }}
              onChange={this.selectChange.bind(this)}
              >
              <Option value="0">全部</Option>
              <Option value="1">上海</Option>
              <Option value="2">深圳</Option>
              <Option value="3">南京</Option>
            </Select>
          </FormItem>
          <Button type="primary" htmlType="submit" onClick={this.handleSubmit.bind(this)}>查询</Button>
        </Form>
      </div>
    );
  }
};

class Match extends Component {
  constructor(props) {
    super(props);

    this.state = {
      lists: [],
      loading: false,
      visibleModal: false
    };
  }
  componentWillMount() {
  }
  handlePageUpload() {

  }
  /**
   * 显示新建比赛
   */
  handleShowModal() {
    this.setState({
      visibleModal: true
    })
  }
  render() {
    const columns = [
      {
        title: '比赛ID',
        dataIndex: 'id',
        key: 'id'
      },
      {
        title: '比赛标题',
        dataIndex: 'title',
        key: 'title'
      },
      {
        title: '所属赛区',
        dataIndex: 'area',
        key: 'area'
      },
      {
        title: '进度',
        dataIndex: 'schedule',
        key: 'schedule',
        render: (o, row, index) => {
          return (
            <div>
              {row.date}<br />
              报名中 待抽签
            </div>
          );
        }
      },
      {
        title: '操作',
        dataIndex: 'operate',
        key: 'operate',
        render: (o, row, index) => {
          return (
            <div>
              <div>比赛：<Link to="">查看比赛</Link></div>
              <div>
                直播间：ND11
              </div>
              <div>
                球员列表：
                <Link to="lrw/view_players/11">查看球员</Link>&nbsp;
                <Link to="">开始抽签</Link>&nbsp;
                <Link to="">检录管理</Link>&nbsp;
                <Link to="">查看对阵</Link>
              </div>
            </div>
          )
        }
      }
    ]

    const pagination = {
      // total: this.state.dataCount,
      // pageSize: this.state.per,
      // onChange: this.getHistoryList.bind(this),
      // current: this.state.page
    }

    return (
      <div>
        <div style={{marginBottom:10 }}>
          <Button type="primary" onClick={this.handleShowModal.bind(this)}>新建比赛</Button>
        </div>
        <div style={{marginBottom: 10}}>
          <SearchInput
            handlePageUpload={this.handlePageUpload.bind(this)}
          />
        </div>

        <MatchModal
          visible = {this.state.visibleModal}
           />

        <Table
          columns={columns}
          dataSource={this.state.lists}
          pagination={pagination}
          loading={this.state.loading}
          />
      </div>
    );
  }
}

Match.key = 'match';

export default Match;
