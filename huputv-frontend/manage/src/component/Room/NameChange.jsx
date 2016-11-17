import React, {Component} from 'react';
import {Link} from 'react-router';
import {Table, Row, Popconfirm, Message, Modal, Button, Form, Radio, Input, Col} from 'antd';
import dataService from 'common/dataService';

const FormItem = Form.Item;

class NameChange extends Component {
    constructor(props) {
        super(props);
    }

    componentWillReceiveProps(nextProps) {
        this.setState({
            name: nextProps.name
        })
    }

    handleNameCancel() {
        this.props.handleNameCancel();
        this.props.form.resetFields();
    }

    handleOk(){
        this.props.form.validateFields((errors, values) => {
            if (!!errors) {
                console.log('Errors in form!!!');
                return;
            }

            let name = this.props.form.getFieldValue('room');
            this.props.handleNameOk(name, this.props.roomId);
        });
    }

    render() {
        const { getFieldProps } = this.props.form;

        console.log(this.props.name);

        const nameProps = getFieldProps('room', {
            initialValue: this.props.name,
            rules: [
                { required: true, message: '请输入直播间名称' }
            ]
        });

        return(
            <Modal title="修改直播间名称" 
                visible={this.props.visible}
                onOk={this.handleOk.bind(this)} 
                onCancel={this.handleNameCancel.bind(this)}>
                <Form horizontal form={this.props.form}>
                    <FormItem required >
                        <Input  {...nameProps} />
                    </FormItem>
                </Form>
            </Modal>
        )
    }
}
NameChange = Form.create()(NameChange);


export default NameChange;
