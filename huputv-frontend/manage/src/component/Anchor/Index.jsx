import React from 'react';
import {Link} from 'react-router';
import { Table, Icon, Form,  Modal, Menu, Row, Col, Input,  Button, Checkbox, InputNumber, Radio, Cascader, Popconfirm, message   } from 'antd';
import classNames from 'classnames';
import dataService from 'common/dataService';
import _ from 'common/underscore';


const InputGroup = Input.Group;
const FormItem = Form.Item;
const RadioGroup = Radio.Group;

const Api = {
    anchor: '/manage/anchor',
    update: '/manage/anchor/:id',
    ban: '/manage/ban-anchor',
    checkId: '/manage/check'
};

// 禁言
    function cancel(){

    }


//搜索框
const SearchInput = React.createClass({
   getInitialState() {
        return {
          value: '',
          focus: false,
        };
    },
   handleInputChange(e) {
        this.setState({
          value: e.target.value,
        });
    },
   handleFocusBlur(e) {
        this.setState({
          focus: e.target === document.activeElement,
        });
   },
   handleSearch(event) {
      event.preventDefault();
      this.props.getAnchorList(1, this.state.value);
   },

   render() {
        const btnCls = classNames({
            'ant-search-btn': true,
            'ant-search-btn-noempty': !!this.state.value.trim(),
        });
        const searchCls = classNames({
            'ant-search-input': true,
            'ant-search-input-focus': this.state.focus,
        });
        return (
            <Form inline onSubmit={this.handleSearch}>
              <InputGroup className={searchCls} style={this.props.style}>
                <Input {...this.props} value={this.state.value} className="ant-search" onChange={this.handleInputChange}
                onFocus={this.handleFocusBlur} onBlur={this.handleFocusBlur} />
                <div className="ant-input-group-wrap">
                    <Button className={btnCls} size={this.props.size} onClick={this.handleSearch}>
                        <Icon type="search" />
                    </Button>
                </div>
              </InputGroup>
            </Form>
        );
   }
   });

class anchor extends React.Component {
  constructor(props) {
    super(props);
    let self = this;
    this.state = {
      loading: true,
      visible: false,
      action: '',
      showInput: 0,
      assignID: 0,
      popupData: {},
      data: [],
      count: 0,
      per: 20,
      page: 1,
      anchor: '',
      defaultId: 0,
      loadingPop: false
    }

    this.showModal.bind(this);
  }
  componentDidMount() {
      this.getAnchorList();
  }
   //获取数据
  getAnchorList(page = 1, anchor = ''){
      this.setState({
          loading: true,
          anchor: anchor
      });

      dataService.get(Api.anchor, {page: page, anchor: anchor}).then((res) =>{
          this.setState({
             data: res.data.list,
             count: res.data.count,
             per: res.data.per,
             page: res.data.page,
             loading: false
         });
     })
   }

  // 添加
  addone () {
      this.showModal();
  }

  // 点击取消
  popCancel() {
      this.hideModal();
  }

  // 处理表单提交
  handleSubmit (e) {
    let method = 'post';

    if (this.state.action == 'edit') {
        method = 'put';
    }

    this.props.form.validateFieldsAndScroll((errors, values) => {
      if (!!errors) {
        return;
      }

      let sendData = this.props.form.getFieldsValue();

      // 指定ID
      if(+sendData.id === 1){
        sendData.id = this.state.assignID;
      }else if(sendData.id == 0) {
        sendData.id = -1;
      }

      sendData.allow_predict = sendData.allow_predict ? 1 : 0;

      dataService[method](Api.anchor, sendData)
        .then((res) => {
          if (res && res.code == 1) {
              this.hideModal();
              message.success(res.msg);
              this.getAnchorList();
          } else {
              message.error(res.msg);
          }

        });
    })

  }
  //编辑
  editAnchor(record) {
    let url = Api.update.replace(':id', record.id);

    this.setState({loading: true});


    dataService.get(url)
      .then(res => {
        console.log(res);
        res.data.allow_predict = res.data.allow_predict == '0' ? '' : 'checked';
        this.setState({
          popupData: res.data,
          loading: false
        });
        this.showModal('edit');
        this.props.form.setFieldsValue(res.data);
      });
  }

  // 隐藏弹出, 清空数据
  hideModal(action = 'add') {
    this.setState({
        visible: false,
        action: action,
        showInput: 0,
        popupData:{
            puid: '',
            nickname: '',
            anchor_nickname: ''
        }
    });

    this.props.form.resetFields();
  }

  // 显示弹出
  showModal(action = 'add') {
    this.setState({
        visible: true,
        action: action
    });
  }
  onChangeID(e) {
    console.log(e.target.value);
    if(+e.target.value === 1) {
      dataService.get(Api.checkId).then((res) => {
        this.setState({
          defaultId: res.data,
          assignID: res.data,
          showInput: +e.target.value
        })
      })
    }else{
      this.setState({
          showInput: +e.target.value
        })
    }

  }
  assignChange(e){
    this.setState({
      loadingPop: true
    })
    let val = e.target.value;
    dataService.get(Api.checkId, {id: val}).then((res) => {
      if(res.data.checked){
        message.error('该ID已被占用，请输入新的ID');
        return;
      }else{
        message.success('该ID未被占用，可分配');
        this.setState({
          assignID: val
        })
      }
      this.setState({
        loadingPop: false
      })
    })

  }

  //禁言
  bannedSpeak(index){
    let puid = this.state.data[index].puid,
        status = this.state.data[index].status == 0 ? 1 : 0,
        data = {};

    data.puid = puid;
    data.status = status;

    this.setState({loading: true});
    dataService.get(Api.ban, data).then((res) =>{
        if (res && res.code == 1) {
            this.state.data[index].status = status;
            this.setState({
                data: this.state.data,
                loading: false
            })
            let text = status == 0 ? '解禁成功！' : '禁言成功！';
            message.success(text);
        }
        else {
            message.error(res.msg);
        }
    })

  }

  checkName(rule, value, callback) {
      if(!value){
          callback(new Error('请输入主播昵称!'))
      }
      // else if(value.length > 8){
      //     callback(new Error('主播昵称不能超过8个字符'))
      // }
      else{
          callback();
      }
  }

  checkId(rule, value, callback) {
      // let last = null;
      // clearTimeout(last);

      // last = setTimeout(function(){
      //   console.log(123);
      // }, 300);
      // _.debounce(function(value){
      //   console.log(value);
      // }, 300);

      if(!value){
          callback(new Error('请输入主播昵称!'))
      }
      // else if(value.length > 8){
      //     callback(new Error('主播昵称不能超过8个字符'))
      // }
      else{
          callback();
      }
  }

  handleChangeHiddenId(e) {
    this.setState({
      popupData: {
        id: e.target.value
      }
    })
  }

  render () {
    const self = this;
    const { getFieldProps, getFieldError } = this.props.form;

    console.log(this.state.popupData);

    const uidProps = getFieldProps('puid', {
      initialValue: this.state.popupData.puid,
      rules: [
        { required: true, message: '请输入passport Uid' }
      ]
    });

    const nicknameProps = getFieldProps('nickname', {
      initialValue: this.state.popupData.nickname,
      rules: [
        { required: true, message: '请输入昵称' },
      ]

    });

    const anchorNicknameProps = getFieldProps('anchor_nickname', {
      initialValue: this.state.popupData.anchor_nickname,
      rules: [
        { required: true,  validator: this.checkName },
      ]
    });

    const idProps = getFieldProps('id', {
      initialValue: '0',
      onChange: this.onChangeID.bind(this)
    });


    // const idHiddenProps = getFieldProps('id', {
    //   initialValue: this.state.popupData.id
    // });

    const tipsProps = getFieldProps('tips', {
      initialValue: this.state.popupData.tips
    });

    const formItemLayout = {
      labelCol: { span: 6 },
      wrapperCol: { span: 17 }
    };

    const columns = [
      { title: '主播直播间ID', dataIndex: 'id', key: 'id',
        render(t, record) {
          return <a href={dataService.getApiBase() + '/' + record.id} target="_blank">{record.id}</a>;
        }
      },
      { title: 'passporUid',dataIndex: 'puid',key: 'puid',
        render(text, record) {
          return <a href={'http://my.hupu.com/' + record.puid} target="_blank">{record.puid}</a>;
        }
      },
      { title: '昵称',dataIndex: 'nickname',key: 'nickname' },
      { title: '主播昵称',  dataIndex: 'anchor_nickname',  key: 'anchor_nickname' },
      { title: '关注人数',dataIndex: 'following',  key: 'following' },
      { title: 'Tips',dataIndex: 'tips',key: 'tips' },
      { title: '操作',key: 'operation',
        render(text, record, index) {
          let banned = record.status == 1 ? '解禁' : '禁言';
          return (
            <span>
              <Button onClick={self.editAnchor.bind(self,record)}>编辑</Button>
            </span>
          );
        }
      }
    ]

    const pagination = {
        total: this.state.count,
        pageSize: this.state.per,
        onChange: this.getAnchorList.bind(this),
        current: this.state.page
    };

    const predictPermission = getFieldProps('allow_predict', {
        valuePropName: 'checked'
    });

    let addStyle = {
      display: (this.state.action === 'add' ? 'block' : 'none')
    }

    let editable = this.state.action === 'add' ? '' : 'disabled';

    let inputProps = getFieldProps('defaultId', {
      initialValue: this.state.defaultId
    });

    return (
        <Row>
          <div style={{marginBottom: 10}}>
            <h3 className="h3-pre" style={{marginRight: 10}} >主播列表</h3>
            <div className="input-group-pre">
                <SearchInput placeholder="搜索" getAnchorList={this.getAnchorList.bind(this)}  style={{ width: 200 }} />
            </div>
            <Button className="btn-pre" type="primary" onClick={this.addone.bind(this)} style={{marginRight: 10}}>添加主播</Button>
            <Link className="ant-btn" to="/anchor/collect">直播数据汇总</Link>
          </div>

          <Modal
            title={this.state.action === 'add' ? '添加' : '编辑'}
            visible={this.state.visible}
            onCancel={this.popCancel.bind(this)}
            footer={[
                <Button key="back" type="ghost" size="large" onClick={this.popCancel.bind(this)}>返 回</Button>,
                <Button key="submit" type="primary" size="large" loading={this.state.loadingPop} onClick={this.handleSubmit.bind(this, )}>提 交</Button>
            ]}>

              <Form horizontal form={this.props.form}>
                <FormItem  {...formItemLayout}
                  label="passport Uid："
                  >
                  <Input placeholder="请输入passport Uid" disabled={editable} {...uidProps}/>
                </FormItem>
                <FormItem  {...formItemLayout}
                  label="昵称：">
                  <Input placeholder="请输入昵称" disabled={editable} {...nicknameProps} />
                </FormItem>

                <FormItem    {...formItemLayout}
                  label="主播昵称：">
                  <Input placeholder="请输入主播昵称" {...anchorNicknameProps} />
                </FormItem>
                {
                  this.state.action === 'add' ?
                    <FormItem style={addStyle} {...formItemLayout}
                      label="ID号段：">
                      <RadioGroup {...idProps}>
                        <Radio value="0">默认</Radio>
                        <Radio value="1"> <span>指定</span></Radio>
                          { this.state.showInput ? <Input type="number" style={{width: 150}}  onBlur={this.assignChange.bind(this)} {...inputProps} /> : null }
                      </RadioGroup>
                    </FormItem> :
                    <Input type="hidden" {...getFieldProps('id', {
                      initialValue: this.state.popupData.id
                    })} />
                }
                <FormItem  {...formItemLayout}
                  label="Tips：">
                      <Input {...tipsProps} />
                </FormItem>

                <FormItem  {...formItemLayout}
                  label="开通权限：">
                       <Checkbox {...predictPermission} />比赛预测
                </FormItem>
              </Form>

          </Modal>

        <Table className="table-pre"
               Key={record => record.id}
               rowKey={record => record.id}
               columns={columns}
               dataSource={this.state.data}
               pagination={pagination}
               loading={this.state.loading} />

        </Row>
      );
  }
}

anchor.key = 'anchor';

anchor = Form.create()(anchor);
export default anchor;
