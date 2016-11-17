import React, {Component} from 'react';
import {Link} from 'react-router';
import {Table, Row, Message, Modal, Select, message} from 'antd';
import dataService from 'common/dataService';

const Api = {
    roomInfoName: '/manage/room/:id'    
};

class TypeChange extends Component {
    constructor(props) {
        super(props);
        
        this.state = {
            id: 0,
            typeName: ''
        }  
    }

    componentWillReceiveProps(nextProps) {
        this.setState({
            typeName: nextProps.typeName
        })
    }

    handleChange(value, label){
        this.setState({
            id: value,
            typeName: label
        })
    }

    handleOk(){
        let api = Api.roomInfoName.replace(':id', this.props.roomId);
        dataService.post(api, { key: 'room_type',value: this.state.id }).then((res) =>{
            if(res.code == 1){
                this.props.handleTypeOk();
                message.success('修改直播间分类成功！');
            }
        })
    }

    render() {
        return(
            <Modal title="修改直播间分类" 
                visible={this.props.visible}
                onOk={this.handleOk.bind(this)} 
                onCancel={this.props.handleTypeCancel}>
                <Select value={this.state.typeName} style={{ width: 120 }} onChange={this.handleChange.bind(this)}>
                    {
                        this.props.typeList.map(function(item){
                            return <Option value={item.sid}>{item.sname}</Option>
                        })
                    }
                </Select>

            </Modal>
        )
    }
}

export default TypeChange;
