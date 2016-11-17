import React, {Component} from 'react';
import {Link} from 'react-router';
import {Table, Row, Popconfirm, Message, Modal, Button, Form, Radio, Input, Col} from 'antd';
import dataService from 'common/dataService';

const Api = {
    message: '/manage/message'
}

class SystemIndex extends Component {

    constructor(props) {
        super(props);

        this.state = {
            data: [],
            count: 0,
            per: 0,
            page: 1,
            loading: true
        };
    }

    componentDidMount () {
        this.fetch();
    }

    fetch(page=1) {
        let dataList = [];

        this.setState({
            loading: true
        });

        dataService.get(Api.message, {page}).then((res) =>{
            this.setState({
                data: res.data.list,
                count: res.data.count,
                loading: false
            })
        })

    }

    render() {
        // const { getFieldProps } = this.props.form;
        let self = this;

        const columns = [
            { title: '序号', dataIndex: 'id', key: 'id' }, 
            { title: '发送范围', dataIndex: 'range_str', key: 'range_str', 
                render(text, record, index) {
                    return <span>{text}</span>;
                }
            }, 
            { title: '发送时间', dataIndex: 'create_at', key: 'create_at' },
            { title: '发送人', dataIndex: 'username', key: 'username' },
            { title: '消息内容', dataIndex: 'content', key: 'content'}, 
            { title: '链接地址', dataIndex: 'url', key: 'url'}
        ];

        const pagination = {
            total: this.state.count,
            pageSize: 20,
            onShowSizeChange(current, pageSize) {
                console.log('Current: ', current, '; PageSize: ', pageSize);
            },
            onChange(current) {
                self.fetch(current);
            }
        };

        return (
            <div>
                <Link className="ant-btn ant-btn-primary" style={{marginTop: 10, marginBottom:10}} to='/other/system/add'>新建消息</Link>
                <Table 
                    rowKey={record => record.id}
                    columns={columns} 
                    dataSource={this.state.data} 
                    pagination={pagination} 
                />
            </div>
        )   
    }
}

SystemIndex.key = 'system';

export default SystemIndex;
