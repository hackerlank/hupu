import React, { Component } from 'react'
import { Link } from 'react-router';
import { Input, Form, Button, Select, Table, Popconfirm } from 'antd';

import dataService from 'common/dataService';

const Api = {
    list: '/manage/robot/list/10109'
}

const FormItem = Form.Item;
const Option = Select.Option;

class List extends Component {
  constructor(props) {
    super(props);
    this.state = {
      lists: [
      ],
      loading: false
    }
  }
  componentWillMount() {
    this.getListData();
  }
  getListData() {

  }
  selectChange() {

  }
  handleSubmit() {

  }
  /**
   * 操作冻结
   */
  handleConfirm(status) {
    console.log(status);

  }
  render() {
    const { getFieldProps } = this.props.form;

    const columns = [
      {
        title: 'PassPortID',
        dataIndex: 'puid',
        key: 'puid'
      },
      {
        title: '昵称',
        dataIndex: 'username',
        key: 'username'
      },
      {
        title: '头像',
        dataIndex: 'avatar',
        key: 'avatar'
      },
      {
        title: '性别',
        dataIndex: 'sex',
        key: 'sex'
      },
      {
        title: '城市',
        dataIndex: 'city',
        key: 'city'
      },
      {
        title: '学校',
        dataIndex: 'school',
        key: 'school'
      },
      {
        title: '加入虎扑N天',
        dataIndex: 'join',
        key: 'join'
      },
      {
        title: '人品值',
        dataIndex: 'rp',
        key: 'rp'
      },
      {
        title: '声望',
        dataIndex: 'prestige',
        key: 'prestige'
      },
      {
        title: '状态',
        dataIndex: 'status',
        key: 'status'
      },
      {
        title: '操作',
        dataIndex: 'operate',
        key: 'operate',
        render: (o, row, index) => {
          const text = +row.status ? '冻结' : '解冻';

          return (
            <div>
              <Popconfirm title={`确定要${text}吗？`} onConfirm={this.handleConfirm.bind(this, +row.status)}>
                <Button type="primary">
                  {text}
                </Button>
              </Popconfirm>
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
        <div style={{padding:10}}>
          <Form inline>
            <FormItem label="用户名：">
                <Input placeholder="输入用户名或ID" {...getFieldProps('search', {initialValue: ''})} />
            </FormItem>
            <FormItem label="状态：">
              <Select
                defaultValue="0"
                style={{ width: 100 }}
                onChange={this.selectChange.bind(this)}
                >
                <Option value="0">全部</Option>
                <Option value="1">正常</Option>
                <Option value="2">冻结</Option>
              </Select>
            </FormItem>
            <Button type="primary" htmlType="submit" onClick={this.handleSubmit.bind(this)}>查询</Button>
          </Form>
        </div>

        <Table
          columns={columns}
          dataSource={this.state.lists}
          pagination={pagination}
          loading={this.state.loading}
          />
      </div>
    )
  }
}

List.key = 'waterarmy';

List = Form.create()(List);

export default List;
