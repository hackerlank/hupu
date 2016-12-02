import React, { Component } from 'react';
import { Link } from 'react-router';
import { DatePicker, Button, Table } from 'antd';

import dataService from 'common/dataService';

/**
 * 接口地址
 * @type {Object}
 */
const apiUrl = {
}

class Match extends Component {
  constructor(props) {
    super(props);

    this.state = {
      lists: [
        {
          id: "222",
          title: "路人王上海站第1轮",
          area: "上海",
          game_status: "9",
          date: "2016年8月16日 20:00开赛"
        },
        {
          id: "002",
          title: "路人王上海站第2轮",
          area: "上海",
          game_status: "0",
          date: "2016年8月16日 20:00开赛"
        }
      ],
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
        title: '球员编号',
        dataIndex: 'id',
        key: 'id'
      },
      {
        title: '球员姓名',
        dataIndex: 'username',
        key: 'username'
      },
      {
        title: 'PassportId',
        dataIndex: 'uid',
        key: 'uid'
      },
      {
        title: '虎扑昵称',
        dataIndex: 'uname',
        key: 'uname'
      },
      {
        title: '头像',
        dataIndex: 'uid',
        key: 'uid'
      },
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

        </div>

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
