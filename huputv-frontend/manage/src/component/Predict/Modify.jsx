import React, { Component } from 'react'
import { Link } from 'react-router'
import dataService from 'common/dataService'
import { Form, Input, Row, Col, Radio, Button, Tabs, Table, Popconfirm, Select, message, Modal, DatePicker, Checkbox } from 'antd'

const FormItem = Form.Item;
const InputGroup = Input.Group;
const RadioGroup = Radio.Group;

const Api = {
    finish: '/manage/topic/finish',
    modify: '/manage/topic/:id'
}

class Modify extends Component {
    constructor(props) {
        super(props);

        this.state = {
            id: 0,
            match_id: 0,
            option: [],
            score: 0,
            stop_time: 0
        }
    }

    componentWillReceiveProps(nextProps) {
        const props = Object.assign(this.state, nextProps.data);

        this.setState(props);
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
            let api = Api.modify.replace(':id', this.props.form.getFieldValue('id'));

            let option = [];

            // 选项处理
            for(var i in data) {
                if(/^option_\d$/.test(i)){
                    option.push(data[i]);
                    delete data[i];
                }
            }

            data.option = option.join(',')

            console.log("接收到的表单值",data);


            dataService
                .put(api, data)
                .then((res) => {
                    if(res.code == 1) {
                        this.props.handleOk();
                    }else{
                        message.error(res.msg);
                    }
                })

        })
    }

    handleChange(e) {
        console.log(e.target.checked);
        this.setState({
            checked: e.target.checked
        });
    }

    handleTimeChange(value) {
        console.log(value)
        this.setState({
            stop_time: value
        })
        // console.log(value, dateString);
    }

    render() {

        const { getFieldProps, getFieldValue } = this.props.form;

        const formItemLayout = {
            labelCol: { span: 6 },
            wrapperCol: { span: 14 },
        };

        const titleProps = getFieldProps('title', {
            initialValue: this.state.title,
            rules: [
                { required: true, message: `请输入题目标题` }
            ]
        });

        const scoreProps = getFieldProps('score', {
            initialValue: this.state.score

        });

        const timeProps = getFieldProps('stop_time', {
            initialValue: this.state.stop_time == '0000-00-00 00:00:00' ? '' : this.state.stop_time
        });


        let style = {
            display: this.state.checked ? 'block': 'none'
        };



        const optionRender = (item, index) => {
            index += 1;
            return (
                <Col>
                    <FormItem
                        {...formItemLayout} 
                        label={`选项${index}`}>
                        <Input 
                            placeholder={`请输入选项${index}`} 
                            {...getFieldProps(`option_${index}`, {
                                initialValue: item.option,
                                rules: [
                                    { required: true, message: `请输入选项${index}` }
                                ]
                            })} 
                        />
                    </FormItem>
                </Col>
            )
        }

        return (
            <div>
                <Modal 
                    title='预测详情'
                    width='360'
                    visible = {this.props.visible}
                    onCancel={this.handleCancel.bind(this)}
                    footer = {[
                        <Button key="back" type="ghost" size="large" onClick={this.handleCancel.bind(this)}>返 回</Button>,
                        <Button key="submit" type="primary" size="large" onClick={this.handleOk.bind(this)}>修 改</Button>
                    ]}
                >
                    <Form horizontal form={this.props.form} >
                        <FormItem
                          {...formItemLayout}
                          label="题目标题"
                        >
                            <Input 
                                type="textarea"
                                {...titleProps}
                             />
                        </FormItem>
                        <Row>
                            {
                                this.state.option.map((item, index) => {
                                    return (
                                        optionRender(item, index)
                                    )
                                })            
                            }
                        </Row>
                        <FormItem
                          {...formItemLayout}
                          label="题目得分"
                        >
                            <Select id="select" {...scoreProps} style={{ width: 200 }} >
                                <Option value="20">20</Option>
                                <Option value="40">40</Option>
                                <Option value="60">60</Option>
                            </Select>
                        </FormItem>

                        <FormItem
                          {...formItemLayout}
                          label="自动封盘"
                        >
                            <Checkbox 
                                checked={this.state.checked}
                                onChange={this.handleChange.bind(this)}
                               />自动封盘
                        </FormItem>

                        <FormItem
                          {...formItemLayout}
                          label="封盘时间"
                          style={style}
                        >
                            <DatePicker 
                                showTime 
                                format="yyyy-MM-dd HH:mm:ss"
                                {...timeProps} 
                                onChange={this.handleTimeChange.bind(this)} 
                            />
                        </FormItem>

                        <Input type="hidden" {...getFieldProps('id', {
                            initialValue: this.state.id
                        })} />
                    </Form>
                    
                </Modal>    
            </div>
            
        )
    }
}

Modify = Form.create()(Modify);

export default Modify;