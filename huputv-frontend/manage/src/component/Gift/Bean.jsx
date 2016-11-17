import React from 'react';

import { Button, Form, Input, message } from 'antd';
import dataService from 'common/dataService';

const createForm = Form.create;
const FormItem = Form.Item;

const stageAddApi = '/manage/gold-bean-step';

class ManagerAdd extends React.Component {
    constructor(props) {
        super(props);
        this.state = {};
    }

    componentDidMount () {
        dataService.get(stageAddApi).then((response) =>{
            if (response && response.code == 1) {
                this.props.form.setFieldsValue(response.data);
            }
            else {
                Message.error(response.msg || '网络故障');
            }
        })
        // fetch(stageAddApi).then((response) => response.json()).then((response) => {
        //     if (response && response.code == 1) {
        //         this.props.form.setFieldsValue(response.data);
        //     }
        //     else {
        //         Message.error(response.msg||'网络故障');
        //     }
        // });
    }

    handleSubmit() {
        this.props.form.validateFields((errors, values) => {
            console.log(errors);

            if (!!errors) {
                console.log('Errors in form!!!');
                return;
            }

            var fieldsValue = this.props.form.getFieldsValue();
            
            var stageData = Object.keys(fieldsValue).map(function(item) {
                return fieldsValue[item];
            }) 

            console.log({stageData});

            // let init = {
            //     method: 'POST',
            //     headers: {
            //         'Content-Type': 'application/json'
            //     },
            //     body: JSON.stringify({stageData})
            // }

            dataService.post(stageAddApi, {stageData}).then((response) =>{
                if(response.code == 1){
                    message.success('提交成功');
                    setTimeout(() => {
                        this.props.history.replaceState(null, '/giftList');
                    }, 300);
                }else{
                    message.error(response.msg);
                }
            })

            // fetch(stageAddApi, init)
            //     .then((response) => response.json())
            //     .then((response) => {
            //         console.log("response: " + response);
            //         if(response.code == 1){
            //             this.props.history.replaceState(null, '/giftlist');
            //         }else{
            //             message.error(response.msg);
            //         }
            //     })
        });
    }

    handleReset() {
        this.props.form.resetFields();
    }

    checkNum(rule, value, callback) {
        if(!value){
            callback(new Error('金豆数不能为空哦!'))
        }else if(!value.match(/^[0-9]*$/)){
            callback(new Error('金豆数是纯数字啊喂!'))
        }else{
            callback();
        }
    }

    render() {

        const { getFieldProps } = this.props.form;

        const stage1Props = getFieldProps('stage_1', {
            rules: [
                { required: true, validator: this.checkNum }
            ]
        });

        const stage2Props = getFieldProps('stage_2', {
            rules: [
                { required: true, validator: this.checkNum }
            ]
        });

        const stage3Props = getFieldProps('stage_3', {
            rules: [
                { required: true, validator: this.checkNum }
            ]
        });

        const stage4Props = getFieldProps('stage_4', {
            rules: [
                { required: true, validator: this.checkNum }
            ]
        });

        const stage5Props = getFieldProps('stage_5', {
            rules: [
                { required: true, validator: this.checkNum }
            ]
        });

        const stage6Props = getFieldProps('stage_6', {
            rules: [
                { required: true, validator: this.checkNum }
            ]
        });

        const stage7Props = getFieldProps('stage_7', {
            rules: [
                { required: true, validator: this.checkNum }
            ]
        });

        const formItemLayout = {
            labelCol: { span: 7 },
            wrapperCol: { span: 12 }
        };

        return (
            <Form horizontal form={this.props.form} style={{width: 400, margin: 20}}>
                <FormItem
                    {...formItemLayout}
                    label="1: "
                    >
                  <Input {...stage1Props} />
                </FormItem>
                <FormItem
                    {...formItemLayout}
                    label="2: "
                    >
                  <Input {...stage2Props} />
                </FormItem>

                <FormItem
                    {...formItemLayout}
                    label="3: "
                    >
                  <Input {...stage3Props} />
                </FormItem>

                <FormItem
                    {...formItemLayout}
                    label="4: "
                    >
                  <Input {...stage4Props} />
                </FormItem>

                <FormItem
                    {...formItemLayout}
                    label="5: "
                    >
                  <Input {...stage5Props} />
                </FormItem>

                <FormItem
                    {...formItemLayout}
                    label="6: "
                    >
                  <Input {...stage6Props} />
                </FormItem>

                <FormItem
                    {...formItemLayout}
                    label="7: "
                    >
                  <Input {...stage7Props} />
                </FormItem>
                <p style={{marginBottom:15}}>*注意：金豆购买数额必须为整数，且每项的金额必须递增。 </p>
                <FormItem wrapperCol={{ span: 12, offset: 7 }}>
                    <Button type="primary" onClick={this.handleSubmit.bind(this)}>确定</Button>
                    &nbsp;&nbsp;&nbsp;
                    <Button type="ghost" onClick={this.handleReset.bind(this)}>重置</Button>
                </FormItem>
            </Form>
        );
    }
}

ManagerAdd = Form.create()(ManagerAdd);

export default ManagerAdd;

