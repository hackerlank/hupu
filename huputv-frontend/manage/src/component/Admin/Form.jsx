import React from 'react';

import { Button, Form, Input, Message } from 'antd';
import dataService from 'common/dataService';

const createForm = Form.create;
const FormItem = Form.Item;

const add_api = '/manage/admin';
const info_api = '/manage/admin/:id';
const edit_api = '/manage/admin/:id';

class AdminAdd extends React.Component {
    constructor(props) {
        super(props);
        this.state = {};
    }

    componentDidMount () {
        if (this.props.action == 'edit') {
            let api = info_api.replace(':id', this.props.params.id);

            dataService.get(api).then((response) =>{
                if (response && response.code == 1) {
                    this.props.form.setFieldsValue(response.data);
                }
                else {
                    Message.error(response.msg||'网络故障');
                }
            })
        }
    }

    handleSubmit() {
        this.props.form.validateFields((errors, values) => {
            console.log(errors);

            if (!!errors) {
                console.log('Errors in form!!!');
                return;
            }

            let api = add_api;
            let method = 'post';
            if (this.props.action == 'edit') {
                api = edit_api.replace(':id', this.props.params.id);
                method = 'put';
            }

            dataService[method](api, this.props.form.getFieldsValue()).then((response) =>{
                if(response.code == 1){
                    Message.success(response.msg);
                    this.props.history.replaceState(null, '/other');
                }else{
                    Message.error(response.msg);
                }
            })

        });
    }

    handleReset() {
        this.props.form.resetFields();
    }

    checkNum(rule, value, callback) {
        if(!value){
            callback(new Error('puid不能为空哦!'))
        }else if(!value.match(/^[0-9]*$/)){
            callback(new Error('puid是纯数字啊喂!'))
        }else{
            callback();
        }
    }

    render() {
        const { getFieldProps } = this.props.form;

        const puidProps = getFieldProps('puid', {
            rules: [
                { required: true, validator: this.checkNum }
            ]
        });

        const nameProps = getFieldProps('name', {
            rules: [
                { required: true, message: '请输入用户名' }
            ]
        });

        const markProps = getFieldProps('mark');

        const formItemLayout = {
            labelCol: { span: 7 },
            wrapperCol: { span: 12 }
        };

        return (
            <Form horizontal form={this.props.form} style={{width: 400, margin: 20}}>
                <FormItem
                    {...formItemLayout}
                    label="puid: "
                >
                    <Input {...puidProps} placeholder="请输入puid" />
                </FormItem>

                <FormItem
                    {...formItemLayout}
                    label="用户名: "
                >
                    <Input {...nameProps} placeholder="请输入用户名" />
                </FormItem>

                <FormItem
                    {...formItemLayout}
                    label="备注: "
                >
                    <Input {...markProps} placeholder="请输入备注" />
                </FormItem>

                <FormItem wrapperCol={{ span: 12, offset: 7 }}>
                    <Button type="primary" onClick={this.handleSubmit.bind(this)}>确定</Button>
                    &nbsp;&nbsp;&nbsp;
                    <Button type="ghost" onClick={this.handleReset.bind(this)}>重置</Button>
                </FormItem>
            </Form>
        );
    }
}

AdminAdd = Form.create()(AdminAdd);

export default AdminAdd;
