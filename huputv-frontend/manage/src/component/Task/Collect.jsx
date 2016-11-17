import React from 'react';
import {Link} from 'react-router';
import {Table, Row, Button, Input, Icon, Form, Select} from 'antd';
import dataService from 'common/dataService';

const FormItem = Form.Item;

const Api = {
    list: '/manage/task/collect'
};

class Collect extends React.Component {
    static key = 'task';

    constructor(props) {
        super(props);
        this.state = {
            cols: [
                { title: '日期', dataIndex: 'date', key: 'date' },
                { title: '平台', dataIndex: 'platform', key: 'platform' },
                { title: '领取总人数', dataIndex: 'total_people', key: 'total_people' },
                { title: '领取总金豆数', dataIndex: 'total_amount', key: 'total_amount' },
                { title: '签到人数', dataIndex: 'sign_people', key: 'client' },
                { title: '签到金豆数', dataIndex: 'sign_amount', key: 'sign_amount' },
                { title: '在线领金豆人数', dataIndex: 'online_people', key: 'online_people' },
                { title: '在线领金豆数', dataIndex: 'online_amount', key: 'online_amount' },
                { title: '分享人数', dataIndex: 'share_people', key: 'share_people' },
                { title: '分享领金豆数', dataIndex: 'share_amount', key: 'share_amount' }
            ],
            data: [],
            count: 0,
            per: 20,
            page: 1,
            loading: true,
            minYear: 2016,
            currentYear: new Date().getFullYear(),
            currentMonth:  new Date().getMonth() + 1
        }
    }

    componentDidMount () {
        console.log(this.state);
        this.getList(this.state.currentYear, this.state.currentMonth);
    }

    getList (year, month) {
        dataService.get(Api.list, {year: year, month: month}).then((response) => {
            console.log(response);
            this.setState({
                data: response.data.list,
                count: response.data.count,
                loading: false
            });
        });
    }

    onChangeYear(y) {
        this.getList(y, 1);
    }

    onChangeMonth(m) {
        this.getList(this.state.currentYear, m);
    }

    render () {
        let yearOptions = [];
        for (let y = this.state.minYear; y <= this.state.currentYear; y++) {
            yearOptions.push(<Option value={y}>{y}</Option>);
        }

        return (
            <Row>
                <Form inline style={{marginBottom:10}}>
                    <FormItem>
                        <Link className="ant-btn ant-btn-primary" to="/task">返回任务记录</Link>
                    </FormItem>

                    <FormItem
                        label="请选择年：">
                        <Select style={{ width: 100 }}
                                defaultValue={this.state.currentYear}
                                onChange={this.onChangeYear.bind(this)}>
                            {yearOptions.reverse()}
                        </Select>

                        <span>月: </span>
                        <Select style={{ width: 100 }}
                                defaultValue={this.state.currentMonth}
                                onChange={this.onChangeMonth.bind(this)}>
                            <Option value={1}>1</Option>
                            <Option value={2}>2</Option>
                            <Option value={3}>3</Option>
                            <Option value={4}>4</Option>
                            <Option value={5}>5</Option>
                            <Option value={6}>6</Option>
                            <Option value={7}>7</Option>
                            <Option value={8}>8</Option>
                            <Option value={9}>9</Option>
                            <Option value={10}>10</Option>
                            <Option value={11}>11</Option>
                            <Option value={12}>12</Option>
                        </Select>
                    </FormItem>
                </Form>

                <Table
                    key={record => record.date + record.platform}
                    rowKey={record => record.date + record.platform}
                    dataSource={this.state.data}
                    columns={this.state.cols}
                    pagination={false}
                    loading={this.state.loading}
                    bordered />
            </Row>
        );
    }
}

Collect = Form.create()(Collect);
export default Collect;
