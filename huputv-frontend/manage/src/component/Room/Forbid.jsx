import React, { Component } from 'react';

import { Form, Input, Row, Col, Button, Select, Table, Modal, Message } from 'antd';

const createForm = Form.create;
const FormItem = Form.Item;

class Forbid extends Component {
    constructor(props) {
        super(props);

        this.state = {
            loading: false,
            display: 'none'
        }
    }

    handleCancel(e) {
        e.preventDefault();
        this.props.form.resetFields();
        this.setState({
            display: 'none'
        })
        this.props.handleCancel();
    }

    handleOk() {
        this.props.form.validateFields((errors, values) => {
            let self = this;
            if (!!errors) {
                console.log('Errors in form!!!');
                return;
            }

            let status = this.props.status == 0 ? 1 : 0;
            let data = this.props.form.getFieldsValue();
            if(this.props.form.getFieldValue('reason') == '其他') {
                data.reason = this.props.form.getFieldValue('otherReason');
            }
            
            data.room_id = this.props.forbidID;
            data.status = status;
            
            this.props.handleForid(data);
            setTimeout(function() {
                self.setState({
                    display: 'none'
                })
                self.props.form.resetFields();
            }, 800);

        });
    }

    checkNum(rule, value, callback) {
        if(!value){
            callback(new Error('封禁时长不能为空哦!'))
        }else if(!value.match(/^[0-9]*$/)){
            callback(new Error('封禁时长是纯数字啊喂!'))
        }else if(value > 999) {
            callback(new Error('封禁时长最大值为999!'));
        }else{
            callback();
        }
    }

    render() {
        let self = this;
        const { getFieldProps } = this.props.form;

        const forbidReasonProps = getFieldProps('reason', {
            initialValue: '播放色情低俗内容',
            rules: [
                { required: true, message: '请选择封禁理由' }
            ],
            onChange: function(e) {
                if(e == '其他') {
                    self.setState({
                        display: 'block'
                    })
                }else{
                    self.setState({
                        display: 'none'
                    })
                }
            }
        });

        const forbidTimeProps = getFieldProps('duration', {
            initialValue: '24',
            rules: [
                { required: true, validator: this.checkNum }
            ]
        });

        const forbidOtherProps = getFieldProps('otherReason', {
            initialValue: ''
        });

        const formItemLayout = {
            labelCol: { span: 6 },
            wrapperCol: { span: 18 },
        };

        return(
            <Modal ref = "modal"
                    visible={this.props.visible} 
                    onOk={this.handleOk.bind(this)} 
                    onCancel={this.handleCancel.bind(this)}
                    title = "封禁主播" 
                    width = "380">
                  <Form horizontal form={this.props.form}>
                    <FormItem
                        {...formItemLayout}
                        label="封禁理由：">
                            <Select id="select" size="large"  style={{ width: 200 }} {...forbidReasonProps}>
                                <Option value="播放色情低俗内容">播放色情低俗内容</Option>
                                <Option value="播放反动政治内容">播放反动政治内容</Option>
                                <Option value="谩骂用户">谩骂用户</Option>
                                <Option value="广告欺诈">广告欺诈</Option>
                                <Option value="长时间黑屏">长时间黑屏</Option>
                                <Option value="其他">其他</Option>
                            </Select>
                    </FormItem>
                    <FormItem
                      {...formItemLayout}
                      label="其他理由：" style={{display:this.state.display}}>
                      <Input style={{ width: 200 }} {...forbidOtherProps} placeholder="请输入其他封禁理由" /> 
                    </FormItem>
                    <FormItem
                      {...formItemLayout}
                      label="封禁时间：">
                      <Input style={{ width: 200 }} {...forbidTimeProps} placeholder="请输入封禁时长" /> 
                    </FormItem>
                    <p style={{color: '#999'}}>封禁时间以小时为单位，最大值999小时代表永久封禁。</p>
                  </Form>
            </Modal>
        )
    }
}

Forbid = Form.create()(Forbid);

export default Forbid;