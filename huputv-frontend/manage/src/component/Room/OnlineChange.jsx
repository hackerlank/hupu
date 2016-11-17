import React, {Component} from 'react';
import {Link} from 'react-router';
import {Table, Row, Popconfirm, Message, Modal, Button, Form, Radio, Input, Col} from 'antd';
import dataService from 'common/dataService';

const FormItem = Form.Item;

class OnlineChange extends Component {
    constructor(props) {
        super(props);
        
        this.state = {
            num: this.props.num
        }       
    }

    componentWillReceiveProps(nextProps) {
        this.setState({
            num: nextProps.num
        })
    }

    handleChange(e){
        console.log(e.target.value);
        this.setState({
            num: e.target.value
        })
    }

    handleOk(){
        let num = this.props.form.getFieldValue('num');

        this.props.form.validateFields((errors, values) => {
            if (!!errors) {
                console.log('Errors in form!!!');
                return;
            }

            this.props.handleOnlineOk(num, this.props.roomId);
        });
    }

    checkNum(rule, value, callback) {
        if(!value){
            callback(new Error('在线人数不能为空哦!'))
        }else if(!value.match(/^[0-9]*$/)){
            callback(new Error('在线人数是纯数字啊喂!'))
        }else{
            callback();
        }
    }

    render() {
        const { getFieldProps } = this.props.form;

        const nameProps = getFieldProps('num', {
            initialValue: this.state.num,
            rules: [
                { required: true, validator: this.checkNum }
            ]
        });

        return(
            <Modal title="在当前人数的基础上增加人数" 
                visible={this.props.visible}
                onOk={this.handleOk.bind(this)} 
                onCancel={this.props.handleOnlineCancel}>
                <Form horizontal form={this.props.form}>
                    <FormItem required >
                        <Input {...nameProps}/>
                    </FormItem>
                </Form>
            </Modal>
        )
    }
}
OnlineChange = Form.create()(OnlineChange);


export default OnlineChange;
