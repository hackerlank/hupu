import React, { Component } from 'react';
import { Link } from 'react-router';
import { Modal, Form, Button, Input, Select, DatePicker } from 'antd';

import dataService from 'common/dataService';

const createForm = Form.create;
const FormItem = Form.Item;
const Option = Select.Option;

/**
 * 接口地址
 * @type {Object}
 */
const apiUrl = {
}

class MatchModal extends Component {
  constructor(props) {
    super(props);

    this.state = {
      visible: false,
      startValue: '',
      endValue: '',
      selectValue: '',
      startMatchDate: ''
    };
  }
  componentWillMount() {
    this.showModal();
  }
  componentWillReceiveProps(nextProps){
    this.showModal(nextProps);
  }
  showModal(props = this.props) {
    this.setState({
      visible: props.visible
    })
  }
  handleOk(e) {
    const { form } = this.props;

    form.validateFieldsAndScroll((errors, values) => {
      if (!!errors) {
        console.log('Errors in form!!!');
        return;
      }

      console.log(form.getFieldsValue());
    })
  }
  handleCancel(e) {
    this.setState({
      visible: false
    })
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
  render() {
    const formItemLayout = {
      labelCol: { span: 4 },
      wrapperCol: { span: 18 },
    };

    const { getFieldProps } = this.props.form;

    return (
      <div>
        <Modal
          title="新建比赛"
          visible={this.state.visible}
          onOk={this.handleOk.bind(this)}
          onCancel={this.handleCancel.bind(this)}
          >
            <Form horizontal form={this.props.form}>
              <FormItem
                {...formItemLayout}
                label="比赛标题："
              >
                <Input
                  {...getFieldProps('title', {
                    initialValue: "",
                    rules: [
                      { required: true, message: '请输入比赛标题' }
                    ]
                  })}
                 />
              </FormItem>
              <FormItem
                {...formItemLayout}
                label="所属赛区："
              >
                <Select
                  style = {{ width: 100 }}
                   {...getFieldProps('area', {
                     initialValue: "0",
                     rules: [
                       { required: true, message: '请选择赛区' }
                     ]
                   })}
                  >
                  <Option value="0">全部</Option>
                  <Option value="1">上海</Option>
                  <Option value="2">深圳</Option>
                  <Option value="3">南京</Option>
                </Select>
              </FormItem>
              <FormItem
                {...formItemLayout}
                label="报名时间："
              >
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
              <FormItem
                {...formItemLayout}
                label="开赛时间："
              >
                <DatePicker
                  value={this.state.startMatchDate}
                  {...getFieldProps('startMatchDate', {
                    initialValue: "",
                    rules: [
                      { required: true, type: 'date', message: '请选择开赛时间' }
                    ]
                  })}
                  placeholder="开始时间"
                   />
              </FormItem>
            </Form>
          </Modal>
      </div>
    );
  }
}

MatchModal.defaultProps = {
	visible: true,
  title: ""
}

MatchModal.propTypes = {
	visible: React.PropTypes.bool,
  title: React.PropTypes.string
}

export default createForm()(MatchModal);
