import React from 'react';
import {Table, Row, Select, Pagination} from 'antd';
import './History.less'
import dataService from 'common/dataService';

const Option = Select.Option;
const index_api = '/manage/gift-history/:id';
const gift_list_api = '/manage/gift';

export default class History extends React.Component {
    static key = 'gift';

    constructor (props) {
        super(props);
        this.state = {
            giftList: [],
            dataSource: [],
            dataCount: 0,
            per: 20,
            page: 1,
            gift_id: 0,
            columns: [
                { title: 'id', dataIndex: 'id', key: 'id' },
                {
                    title: '直播间',
                    dataIndex: 'room_name',
                    key: 'room_name',
                    render: (text, record) => {
                        return (<a target="_blank" href={dataService.getApiBase()+'/'+record.room_id}>{record.room_name}</a>);
                    }
                },
                { title: '直播场次', dataIndex: 'match_id', key: 'match_id' },
                { title: '用户', dataIndex: 'sent_name', key: 'sent_name' },
                { title: '主播', dataIndex: 'anchor_nickname', key: 'anchor_nickname' },
                { title: '礼物', dataIndex: 'gift_name', key: 'gift_name' },
                { title: '数量(个)', dataIndex: 'number', key: 'number' },
                {
                    title: '支付类型',
                    dataIndex: 'pay_type',
                    key: 'pay_type',
                    render: (text, record) => {
                        return (record.pay_type == 1 ? '金豆' : '虎扑币');
                    }
                },
                { title: '支付金额', dataIndex: 'pay_total', key: 'pay_total' },
                { title: '送礼后余额', dataIndex: 'pay_balance', key: 'pay_balance' },
                { title: 'iBilling 扣费订单号', dataIndex: 'ibilling_purchase_order', key: 'ibilling_purchase_order' },
                { title: '送礼时间', dataIndex: 'created_at', key: 'created_at' },
                {
                    title: '结果',
                    dataIndex: 'success',
                    key: 'success',
                    render: (text, record) => {
                        return (
                            record.success == 2 ?
                            <font color="green">成功</font>: (
                                record.success == 1 ?
                                <font color="red">失败</font> :
                                <font color="blue">进行中</font>
                            )
                        );
                    }
                },
                { title: '完成时间', dataIndex: 'updated_at', key: 'updated_at' }
            ],
            loading: true
        }
    }

    componentDidMount () {
        dataService.get(gift_list_api).then((response) =>{
            this.setState({
                giftList: response.data.list
            });
        })
        // fetch(gift_list_api, {credentials: 'include'}).then((response) => response.json()).then(response => {
        //     this.setState({
        //         giftList: response.data.list
        //     });
        // });

        this.getHistoryList(1);
    }

    getHistoryList(page = 1, gift_id = 0) {
        gift_id = gift_id ? gift_id : this.state.gift_id;

        let api = index_api.replace(':id', gift_id) + '?page=' + page;

        dataService.get(api).then((response) =>{
            this.setState({
                dataSource: response.data.list,
                dataCount: response.data.count,
                per: response.data.per,
                loading: false,
                page: page,
                gift_id: gift_id
            });
        });

        // fetch(api, {credentials: 'include'}).then((response) => response.json()).then(response => {
        //     this.setState({
        //         dataSource: response.data.list,
        //         dataCount: response.data.count,
        //         per: response.data.per,
        //         loading: false,
        //         page: page,
        //         gift_id: gift_id
        //     });
        // });
    }

    selectGift (value) {
        this.getHistoryList(1, value)
    }

    render () {
        const pagination = {
            total: this.state.dataCount,
            pageSize: this.state.per,
            onChange: this.getHistoryList.bind(this),
            current: this.state.page
        };

        const giftSelect = [];
        giftSelect.push(<Option key="0">全部</Option>);
        this.state.giftList.map((item, index) => {
            giftSelect.push(<Option key={item.id}>{item.name}</Option>);
        });

        return (
            <Row>
                <span>礼物列表: </span>
                <Select showSearch
                    className="giftSelect"
                    placeholder="选择礼物进行过滤"
                    notFoundContent="无法找到"
                    optionFilterProp="children"
                    searchPlaceholder="输入关键词"
                    style={{ width: 200 }}
                    onChange={this.selectGift.bind(this)}>
                    {giftSelect}
                </Select>

                <Table
                    key={record => record.id}
                    rowKey={record => record.id}
                    dataSource={this.state.dataSource}
                    columns={this.state.columns}
                    pagination={pagination}
                    loading={this.state.loading}
                    bordered />
            </Row>
        )
    }
}
