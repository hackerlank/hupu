import React, { Component } from 'react';
import { Link } from 'react-router';
import { Modal, Form, Button, Input, Select, message, Checkbox, Table } from 'antd';

import dataService from 'common/dataService';
import _ from 'common/underscore';


const createForm = Form.create;
const FormItem = Form.Item;
const Option = Select.Option;

/**
 * 接口地址
 * @type {Object}
 */
const apiUrl = {
  list: '/manage/robot/list/:id',
  logout: '/manage/robot/logout/:id',
  sendMsg: '/manage/robot/sendMsg'
}

class ChatModal extends Component {
  constructor(props) {
    super(props);

    this.state = {
      visible: false,
      userVisible: false,
      roomId: 0,
      groupNumber: 0,
      checked: false,
      loading: false,
      lists: [],
      showLists: [],
      searchInput: '',
      per: 5,
      selectUser: {
        nickname: ''
      }
    };
  }
  componentWillMount() {
    this.showModal();

    window.addEventListener("beforeunload",  e => {
      var confirmationMessage = "确定离开此页面吗？";

      if(this.props.roomId) {
        this.logoutPage();

        (e || window.event).returnValue = confirmationMessage;     //Gecko + IE
        return confirmationMessage;
      }
    })
  }
  componentWillReceiveProps(nextProps){
    if((this.state.roomId === nextProps.roomId &&　this.state.visible === nextProps.visible) || !nextProps.roomId) {
      return;
    }

    this.showModal(nextProps);
    this.getListData(nextProps);
  }
  showModal(props = this.props) {
    this.setState({
      visible: props.visible,
      roomId: props.roomId
    })

  }
  getListData(props = this.props) {
    let url = apiUrl.list.replace(':id', props.roomId);

    dataService
      .get(url)
      .then(result => {
        if(result.code === 1) {
          const groupNumber = (this.state.groupNumber + 1);

          this.setState({
            lists: result.data,
            showLists: result.data,
            groupNumber: groupNumber
          })

          this.randomData();
        }

      })
  }
  /**
   * 结束页面
   */
  logoutPage() {
    const url = apiUrl.logout.replace(':id', this.props.roomId);

    this.props.handleCancel();

    dataService
      .put(url)
      .then(result => {})
  }
  handleGroup() {
    this.setState({
      checked: false
    });
    this.getListData();
  }
  handleOk(e) {
    const { form, roomId } = this.props;

    form.validateFieldsAndScroll((errors, values) => {
      if (!!errors) {
        return;
      }

      const url = apiUrl.sendMsg;
      let params = form.getFieldsValue();

      params = Object.assign(params, {
        room_id: roomId,
        puid: this.state.selectUser.puid
      });

      dataService
        .post(url, params)
        .then(result => {
          if(result.code === 1) {
            form.resetFields();
            if(!this.state.checked) {
              this.randomData();
            }
            return message.success(result.msg);
          }

          message.error(result.msg);
        })
    })
  }
  handleCancel(e) {
    this.setState({
      visible: false
    })

    this.logoutPage();
  }
  onChangeName(e) {
    this.setState({
      checked: e.target.checked
    });
  }
  onKeyUpTextarea(e) {
    if(!e) {
      return;
    }

    let value = e.target.value;

    // 回车
    if(/\n/.test(value)) {
      this.handleOk();
    }
  }
  /**
   * 选择用户显示
   */
  handleUserShowModal() {
    this.setState({
      userVisible: true,
      showLists: this.state.lists
    })
  }
  handleSelectUser(row) {
    this.handleUserCancel();

    this.setState({
      selectUser: row
    })
  }
  handleUserCancel() {
    this.setState({
      userVisible: false
    })
  }
  onChangeSearch(e) {
    this.setState({
      searchInput: e.target.value
    })
  }
  /**
   * 选择用户搜索
   */
  handleSearch() {
    const { searchInput, lists } = this.state;

    if(!searchInput) {
      this.setState({
        showLists: this.state.lists
      })
      return;
    }

    let list = _.find(lists, item => {
      return item.puid === searchInput
    })
    let showLists = []

    if(list) {
      showLists = [list]
    }

    this.setState({
      showLists
    })

  }
  handleRandomUser() {
    this.randomData();
  }
  /**
   * 随机数据
   */
  randomData() {
    const { lists } = this.state;

    if(!lists.length) {
      return;
    }

    let number = Math.floor(Math.random() * (lists.length));

    this.setState({
      selectUser: lists[number]
    })
  }
  render() {
    const formItemLayout = {
      labelCol: { span: 4 },
      wrapperCol: { span: 18 },
    };

    const { getFieldProps } = this.props.form;

    const contentProps = getFieldProps('content', {
        rules: [
            { required: true, whitespace: true, message: '请输入消息内容' }
        ]
    });


    const columns = [
      {
        title: '用户名',
        dataIndex: 'nickname',
        key: 'nickname'
      },
      {
        title: '操作',
        dataIndex: 'operate',
        key: 'operate',
        render: (o, row, index) => {
          return (
            <div>
                <Button type="primary" onClick={this.handleSelectUser.bind(this, row)}>选择</Button>
            </div>
          )
        }
      }
    ]

    const pagination = {
      total: this.state.showLists.length,
      pageSize: this.state.per
    }

    return (
      <div>
        <Modal
          title="热线发言"
          visible={this.state.visible}
          onOk={this.handleOk.bind(this)}
          onCancel={this.handleCancel.bind(this)}
          >
            <Form horizontal form={this.props.form}>
              <FormItem
                {...formItemLayout}
                label="用户组："
              >
                <div>
                  <a href="javascript:" onClick={this.handleUserShowModal.bind(this)}>用户组{this.state.groupNumber}</a>
                  <Button type="ghost" style={{marginLeft:10}} onClick={this.handleGroup.bind(this)}>换一组</Button>
                </div>
              </FormItem>
              <FormItem
                {...formItemLayout}
                label="发言用户："
              >
                <div>
                  {this.state.selectUser.nickname}
                  <Checkbox
                    checked={this.state.checked}
                    onChange={this.onChangeName.bind(this)}
                    style={{marginLeft:10}}
                    >固定用户名</Checkbox>
                  <Button type="ghost" onClick={this.handleRandomUser.bind(this, event)}>换一个</Button>
                </div>
              </FormItem>
              <FormItem
                {...formItemLayout}
                label="热线内容："
              >
                <Input
                  type="textarea"
                  {...contentProps}
                  rows={3}
                  onKeyUp={this.onKeyUpTextarea.bind(this)}
                  placeholder=""
                 />
              </FormItem>
            </Form>
          </Modal>

          <Modal
            title="选择发言用户名"
            visible={this.state.userVisible}
            onCancel={this.handleUserCancel.bind(this)}
            footer=""
            >
            <div>
              <div style={{marginBottom:10}}>
                <Form inline>
                  <FormItem label="">
                      <Input placeholder="输入ID" onChange={this.onChangeSearch.bind(this)} />
                  </FormItem>
                  <Button type="primary" onClick={this.handleSearch.bind(this)}>查询</Button>
                </Form>
              </div>
              <Table
                columns={columns}
                dataSource={this.state.showLists}
                pagination={pagination}
                loading={this.state.loading}
                />
            </div>
          </Modal>
      </div>
    );
  }
}

ChatModal.defaultProps = {
	visible: true,
  roomId: 0,
  handleCancel: () => {}
}

ChatModal.propTypes = {
	visible: React.PropTypes.bool,
  roomId: React.PropTypes.number,
  handleCancel: React.PropTypes.func
}

export default createForm()(ChatModal);
