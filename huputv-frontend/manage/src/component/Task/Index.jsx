import React from 'react';
import {Link} from 'react-router';
import {Table, Row, Button, Input, Icon, Form, Select} from 'antd';
import dataService from 'common/dataService';

const FormItem = Form.Item;

const Api = {
    list: '/manage/task'
};

class Index extends React.Component {
    static key = 'task';

    constructor(props) {
        super(props);
        this.state = {
            cols: [
                { title: 'ID', dataIndex: 'tid', key: 'tid' },
                { title: '用户ID', dataIndex: 'puid', key: 'puid', render: (text, record) => {
                    return (<a href={"http://my.hupu.com/" + record.puid} target="_blank">{record.puid}</a>);
                } },
                { title: '昵称', dataIndex: 'nickname', key: 'nickname' },
                { title: '平台', dataIndex: 'platform', key: 'platform' },
                { title: '类型', dataIndex: 'type', key: 'type' },
                { title: '金额', dataIndex: 'money', key: 'money' },
                { title: '时间', dataIndex: 'created_at', key: 'created_at' }
            ],
            data: [],
            count: 0,
            per: 20,
            page: 1,
            loading: true,
            search: {
                search: '',
                task: ''
            }
        }
    }

    componentDidMount () {
        this.getList();
    }

    getList (page = 1, search = null, task = null) {
        search = search !== null ? search : this.state.search.search;
        task = task !== null ? task : this.state.search.task;

        dataService.get(Api.list, {nickname: search, type:task, page: page}).then((response) => {
            this.setState({
                per: response.data.per,
                data: response.data.list,
                count: response.data.count,
                page: page,
                loading: false,
                search: {search: search, task: task}
            });
        });
    }

    handleSearch(e) {
        e.preventDefault();
        let search =this.props.form.getFieldsValue();
        this.getList(1, search.search, search.task);
    }

    render () {
        const { getFieldProps } = this.props.form;

        const pagination = {
            total: this.state.count,
            pageSize: this.state.per,
            onChange: this.getList.bind(this),
            current: this.state.page
        };

        return (
            <Row>
                <Form inline onSubmit={this.handleSearch.bind(this)} style={{marginBottom:10}}>
                    <FormItem>
                        <Link className="ant-btn ant-btn-primary" to="/task/collect">数据汇总</Link>
                    </FormItem>

                    <FormItem
                        label="输入用户昵称：">
                        <Input placeholder="输入用户昵称" {...getFieldProps('search', {initialValue: ''})} />
                    </FormItem>

                    <FormItem
                        label="选择任务类型：">
                        <Select style={{ width: 200 }} {...getFieldProps('task', {initialValue: ''})}>
                            <Option value="">全部</Option>
                            <Option value="sign">签到任务</Option>
                            <Option value="online">在线时长任务</Option>
                            <Option value="share">分享任务</Option>
                        </Select>
                    </FormItem>

                    <Button type="primary" htmlType="submit">查询</Button>
                </Form>

                <Table
                    key={record => record.tid}
                    rowKey={record => record.tid}
                    dataSource={this.state.data}
                    columns={this.state.cols}
                    pagination={pagination}
                    loading={this.state.loading}
                    bordered />
            </Row>
        );
    }
}

Index = Form.create()(Index);
export default Index;
