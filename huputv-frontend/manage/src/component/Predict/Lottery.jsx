import React, {Component} from 'react'
import { Link } from 'react-router'
import dataService from 'common/dataService'
import { Form, Input, Row, Col, Radio, Button, Tabs, Table, Lotteryconfirm, message, Modal, DatePicker } from 'antd'

const FormItem = Form.Item;
const RadioGroup = Radio.Group;

const Api = {
    finish: '/manage/topic/finish'
}

class Lottery extends Component {
    constructor(props) {
        super(props);
    }

    handleCancel() {
        this.props.form.resetFields();
        this.props.handleCancel();
    }

    handleOk() {
        this.props.form.validateFieldsAndScroll((errors, values) => {
            if (!!errors) {
                console.log('Errors in form!!!');
                return;
            }

            let data = this.props.form.getFieldsValue();

            dataService.put(Api.finish, data).then((res) =>{
                if(res.code == 1) {
                    this.props.handleOk();
                }else{
                    message.error(res.msg);
                }
            })



        })
    }

    render() {

        const { getFieldProps } = this.props.form;

        const formItemLayout = {
            labelCol: { span: 6 },
            wrapperCol: { span: 14 },
        };
        const radioProps = getFieldProps('option', {
            rules: [
                { required: true, message: '请选择正确选项' },
            ],
        });

        return (
            <div>
                <Modal 
                    title='预测详情'
                    width='360'
                    visible = {this.props.visible}
                    onCancel={this.handleCancel.bind(this)}
                    footer = {[
                        <Button key="back" type="ghost" size="large" onClick={this.handleCancel.bind(this)}>返 回</Button>,
                        <Button key="submit" type="primary" size="large" onClick={this.handleOk.bind(this)}>开 奖</Button>
                    ]}
                >
                    <Form horizontal form={this.props.form} >
                        <FormItem
                          {...formItemLayout}
                          label="预测状态"
                        >
                            <p className="ant-form-text" >待开奖</p>
                        </FormItem>
                        <FormItem
                          {...formItemLayout}
                          label="预测选项"
                        >
                            <RadioGroup {...radioProps}>
                                <Radio value="1">{this.props.data.option1}</Radio>
                                <Radio value="2">{this.props.data.option2}</Radio>
                            </RadioGroup>
                        </FormItem>
                        <FormItem
                          {...formItemLayout}
                          label="题目得分"
                        >
                            <p className="ant-form-text" >{this.props.data.score}分</p>
                        </FormItem>
                        <FormItem
                          {...formItemLayout}
                          label="封盘时间"
                        >
                            <p className="ant-form-text" >{this.props.data.stoped_at}</p>
                        </FormItem>

                        <Input type="hidden" {...getFieldProps('match_id', {
                            initialValue: this.props.data.match_id
                        })} />
                    </Form>
                    
                </Modal>    
            </div>
            
        )
    }
}

Lottery = Form.create()(Lottery);

export default Lottery;