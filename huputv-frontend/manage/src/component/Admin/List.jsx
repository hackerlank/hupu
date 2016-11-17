import React from 'react';
import {Link} from 'react-router';
import {Table, Row, Popconfirm, Message} from 'antd';
import dataService from 'common/dataService';

const index_api = '/manage/admin';
const delete_api = '/manage/admin/:id';

class AdminIndex extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            columns: [
                { title: 'id', dataIndex: 'id', key: 'id' },
                { title: 'puid', dataIndex: 'puid', key: 'puid' },
                { title: '用户名', dataIndex: 'name', key: 'name' },
                { title: '备注', dataIndex: 'mark', key: 'mark' },
                {
                    title: '操作',
                    dataIndex: 'handle',
                    key: 'handle',
                    render: (text, record) => {
                        return (
                            <Row>
                                <Link to={"/other/admin/edit/" + record.id}>修改</Link> <br/>
                                <Popconfirm title="确定要删除吗？" onConfirm={this.confirm.bind(this, record)}>
                                    <a href="#">删除</a>
                                </Popconfirm>
                            </Row>
                        );
                    }
                }
            ],
            dataSource: [],
            loading: true
        };
    }

    componentDidMount () {
        this.getAdminList();
    }

    getAdminList() {
        dataService.get(index_api).then((response) =>{
            this.setState({
                dataSource: response.data.list,
                loading: false
            });
        })
        // fetch(index_api, {credentials: 'include'}).then((response) => response.json()).then(response => {
        //     this.setState({
        //         dataSource: response.data.list,
        //         loading: false
        //     });
        // });
    }

    confirm(record) {
        console.log('--------'+record.id);
        let api = delete_api.replace(':id', record.id);

        dataService.delete(api).then((response) =>{
            if (response && response.code == 1) {
                Message.success(response.msg);
                this.getAdminList();
            }
            else {
                Message.error(response.msg||'网络故障');
            }
        })
        // fetch(api, {method:'delete', credentials: 'include'})
        //     .then((response) => response.json())
        //     .then((response) => {
        //         if (response && response.code == 1) {
        //             Message.success(response.msg);
        //             this.getAdminList();
        //         }
        //         else {
        //             Message.error(response.msg||'网络故障');
        //         }
        //     });
    }

    render () {
        return (
            <Row>
                <div style={{margin: 10}}>
                    <Link to={"/other/admin/add"}>添加管理员</Link>
                </div>

                <Table
                    rowKey={record => record.id}
                    dataSource={this.state.dataSource}
                    columns={this.state.columns}
                    pagination={false}
                    loading={this.state.loading}
                    bordered />
            </Row>
        );
    }
}

AdminIndex.key = 'admin';
export default AdminIndex;
