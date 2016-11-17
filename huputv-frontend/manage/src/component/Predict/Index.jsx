import React, {Component} from 'react'
import { Link } from 'react-router'
import dataService from 'common/dataService'
import { Form, Input, Row, Col, Button, Tabs, Table, Popconfirm, message, Modal, DatePicker } from 'antd'
import Lottery from './Lottery'
import Modify from './Modify'
import './Index.less'

const FormItem = Form.Item;
const TabPane = Tabs.TabPane;

const Api = {
    list: '/manage/topic/list',
    stop: '/manage/topic/stop',
    cancel: '/manage/topic/cancel'
}

class Predict extends Component {
    constructor(props) {
        super(props);

        this.state = {
            statusData1: [],
            statusData2: [],
            statusData3: [],
            statusData4: [],
            loading: false,
            count1: 0,
            count2: 0,
            count3: 0,
            count4: 0,
            page1: 1,
            page2: 1,
            page3: 1,
            page4: 1,
            size: 20,
            popVisible: false,
            popData: {},
            modifyVisible: false,
            modifyData: {},
            search: ''
        }
    }

    componentDidMount() {
        this.fetch();
    }

    fetch() {
        this.getStatusList(1, 0);
        this.getStatusList(1, 1);
        this.getStatusList(1, 2);
        this.getStatusList(1, 3);
    }

    callback(key) {
        // console.log(key);
    }

    getStatusList(page = 1, status = 0, search = '', pageSize = 20) {
        this.setState({
            loading: true
        });

        dataService.get(Api.list, {page, status, search, pageSize}).then((res) =>{
            if(res.code == 1){
                    switch (status) {
                        case 0:
                            if(res.data.length != 0) {
                                this.setState({
                                    statusData1: res.data.data,
                                    count1: res.data.allCount,
                                    page1: +res.data.page,
                                    loading: false
                                });
                            }else{
                                this.setState({
                                    statusData1: [],
                                    count1: 0,
                                    page1: 1,
                                    loading: false
                                });
                            }
                            break;
                        case 1:
                            if(res.data.length != 0) {
                                this.setState({
                                    statusData2: res.data.data,
                                    count2: res.data.allCount,
                                    page2: +res.data.page,
                                    loading: false
                                });
                            }else{
                                this.setState({
                                    statusData2: [],
                                    count2: 0,
                                    page2: 1,
                                    loading: false
                                });
                            }
                            break;
                        case 2:
                            if(res.data.length != 0) {
                                this.setState({
                                    statusData3: res.data.data,
                                    count3: res.data.allCount,
                                    page3: +res.data.page,
                                    loading: false
                                });
                            }else{
                                this.setState({
                                    statusData3: [],
                                    count3: 0,
                                    page3: 1,
                                    loading: false
                                });
                            }
                            break;
                        case 3:
                            if(res.data.length != 0) {
                                this.setState({
                                    statusData4: res.data.data,
                                    count4: res.data.allCount,
                                    page4: +res.data.page,
                                    loading: false
                                });
                            }else{
                                this.setState({
                                    statusData4: [],
                                    count4: 0,
                                    page4: 1,
                                    loading: false
                                });
                            }
                            break;
                    }
            }else{
                message.error(res.data.msg);
            }
        })
    }

    getStatusList1(page) {
        this.getStatusList(page, 0, this.state.search);
    }

    getStatusList2(page) {
        this.getStatusList(page, 1, this.state.search);
    }

    getStatusList3(page) {
        this.getStatusList(page, 2, this.state.search);
    }

    getStatusList4(page) {
        this.getStatusList(page, 3, this.state.search);
    }

    renderTitle(text, record, index) {
        return (
            <div>{record.liveInfo.room_name}</div>
        )
    }

    renderName(text, record, index) {
        return (
            <div>{record.liveInfo.anchor_nickname}</div>
        )
    }

    renderStatus(text, record, index) {
        return (
            <div>{record.liveInfo.is_live == 1 ? '直播中' : '休息'}</div>
        )
    }

    renderOption1(text, record, index) {
        return (
            <div className={record.status == 2 && record.right_option == 1 ? 'highlight' : ''}>
                <p>{record.option1}</p>
                <p>参与：{record.total_count_1}</p>
            </div>
        )
    }

    renderOption2(text, record, index) {
        return (
            <div className={record.status == 2 && record.right_option == 2 ? 'highlight' : ''}>
                <p>{record.option2}</p>
                <p>参与：{record.total_count_2}</p>
            </div>
        )
    }

    renderTimeFn(record) {
        if(record.status == 0){
            return (
                <div>
                    <p>创建：{record.created_at}</p>
                    <p>截止：{record.stop_time == '0000-00-00 00:00:00' ? '手动封盘' : record.stop_time}</p>

                </div>
            )
        }else if(record.status == 1){
            return (
                <div>
                    <p>创建：{record.created_at}</p>
                    <p>截止：{record.stop_time == '0000-00-00 00:00:00' ? '手动封盘' : record.stop_time}</p>
                    <p>封盘：{record.stop_time == '0000-00-00 00:00:00' ? record.stoped_at : record.stop_time}</p>
                </div>
            )
        }else if(record.status == 2){
            return (
                <div>
                    <p>创建：{record.created_at}</p>
                    <p>截止：{record.stop_time == '0000-00-00 00:00:00' ? '手动封盘' : record.stop_time}</p>
                    <p>封盘：{record.stop_time == '0000-00-00 00:00:00' ? record.stoped_at : record.stop_time}</p>
                    <p>开奖：{record.finished_at}</p>
                </div>
            )
        }else{
            return (
                <div>
                    <p>创建：{record.created_at}</p>
                    <p>截止：{record.stop_time == '0000-00-00 00:00:00' ? '手动封盘' : record.stop_time}</p>
                    <p>封盘：{record.stop_time == '0000-00-00 00:00:00' ? record.stoped_at : record.stop_time}</p>
                    <p>流盘：{record.finished_at}</p>
                </div>
            )
        }
    }

    renderTime(text, record, index) {
        let time = this.renderTimeFn(record);
        return (
            <div>
                {time}
            </div>
        )
    }

    renderAction(text, record, index) {
        let renderButton = function() {
            if(record.status == 0) {
                return (
                    <div>
                        <Popconfirm title="确定要封盘吗？" onConfirm={this.handleClose.bind(this, record, 'close')}>
                                <Button className = "ant-btn-primary">封盘</Button>
                        </Popconfirm>
                        <span className = "ant-divider"></span>
                        <Button className = "ant-btn-primary" onClick={this.runModify.bind(this, record)}>修改</Button>
                    </div>
                 )
            }else if(record.status == 1) {
                return (
                    <div>
                        <Button className = "ant-btn-primary" onClick={this.runLottery.bind(this, record)}>开奖</Button>
                        <span className = "ant-divider"></span>
                        <Popconfirm title="确定要流盘吗？" onConfirm={this.handleClose.bind(this, record, 'abandon')}>
                                <Button className = "ant-btn-primary">流盘</Button>
                        </Popconfirm>
                    </div>
                 )
            }
        }.bind(this)

        return (
            <div>
                {
                    renderButton()
                }
            </div>
        )
    }

    onChange(value) {
        console.log('选择了时间：', value);
    }

    runLottery(record) {
        this.setState({
            popVisible: true,
            popData: record
        })
    }

    runModify(record) {
        this.setState({
            modifyVisible: true,
            modifyData: record
        })

    }

    handleCancel() {
        this.setState({
            popVisible: false
        })
    }

    handleModifyCancel() {
        this.setState({
            modifyVisible: false
        })
    }

    handleClose(record, action) {
        this.setState({
            loading: true
        })

        let api = action == 'close' ? Api.stop : Api.cancel;

        dataService.put(api, {match_id: record.match_id}).then((res) => {
            if(res.code == 1) {
                this.fetch();
                message.success("操作成功");
            }else{
                message.error(res.msg);
            }

            this.setState({
                loading: false
            })
        })
    }

    handleOk() {
        this.fetch();
        this.setState({
            popVisible: false,
            modifyVisible: false

        })
    }

    handleSearch() {
        let search = this.props.form.getFieldValue('search');
        this.setState({
            search
        })
        this.getStatusList(1, 0, search);
        this.getStatusList(1, 1, search);
        this.getStatusList(1, 2, search);
        this.getStatusList(1, 3, search);
    }

    render() {
        const { getFieldProps } = this.props.form;

        const columns = [
            { title: '序号', dataIndex: 'id', key: 'id' },
            { title: '直播间标题', dataIndex: 'title', key: 'title',
                render: this.renderTitle.bind(this)
            },
            { title: '主播名称', dataIndex: 'name', key: 'name',
                render: this.renderName.bind(this)
            },
            { title: '直播状态', dataIndex: 'live', key: 'live',
                render: this.renderStatus.bind(this)
            },
            { title: '题目得分', dataIndex: 'score', key: 'score' },
            { title: '选项1', dataIndex: 'option1', key: 'option1',
                render:  this.renderOption1.bind(this)
            },
            { title: '选项2', dataIndex: 'option2', key: 'option2',
                render:  this.renderOption2.bind(this)
            },
            { title: '时间', dataIndex: 'time', key: 'time',
                render: this.renderTime.bind(this)
            },
            { title: '操作', dataIndex: 'operation', key: 'operation',
                render: this.renderAction.bind(this)
            }
        ];

        let pagination1 = {
            total: this.state.count1,
            pageSize: this.state.size,
            onChange: this.getStatusList1.bind(this, this.state.page1),
            current: this.state.page1
        };

        let pagination2 = {
            total: this.state.count2,
            pageSize: this.state.size,
            onChange: this.getStatusList2.bind(this, this.state.page2),
            current: this.state.page2
        };

        let pagination3 = {
            total: this.state.count3,
            pageSize: this.state.size,
            onChange: this.getStatusList3.bind(this),
            current: this.state.page3
        };

        let pagination4 = {
            total: this.state.count4,
            pageSize: this.state.size,
            onChange: this.getStatusList4.bind(this),
            current: this.state.page4
        };

        return (
            <div>
                <h3 style={{marginBottom: 10}}> 直播间列表 </h3>
                <Form  inline form={this.props.form} >
                    <FormItem
                        labelCol={{ wrapperCol: 12 }}
                    >
                        <Input placeholder = "输入直播间标题或主播昵称"
                            {...getFieldProps('search')}  style={{ width: 200 }} />
                    </FormItem>

                    <Button
                        type = "primary"
                        htmlType = "submit"
                        onClick={this.handleSearch.bind(this)}
                        > 搜索
                    </Button>

                    <Link className="ant-btn ant-btn-primary" to='predict/rank' style={{marginLeft:15 }}>人品值排行</Link>
                </Form>

                <Tabs defaultActiveKey="1" onChange={this.callback.bind(this)} style={{marginTop:20}}>
                    <TabPane tab={`进行中（${this.state.count1}）`} key="1">
                        <Table
                            rowKey={record => record.id}
                            columns = {columns}
                            dataSource = {this.state.statusData1}
                            pagination = {pagination1}
                            loading={this.state.loading}
                        />
                    </TabPane>
                    <TabPane tab={`待开奖（${this.state.count2}）`} key="2">
                        <Table
                            rowKey={record => record.id}
                            columns = {columns}
                            dataSource = {this.state.statusData2}
                            pagination = {pagination2}
                            loading={this.state.loading}

                        />
                    </TabPane>
                    <TabPane tab={`已开奖（${this.state.count3}）`} key="3">
                        <Table
                            rowKey={record => record.id}
                            columns = {columns}
                            dataSource = {this.state.statusData3}
                            pagination = {pagination3}
                            loading={this.state.loading}

                        />
                    </TabPane>
                    <TabPane tab={`已流盘（${this.state.count4}）`} key="4">
                        <Table
                            rowKey={record => record.id}
                            columns = {columns}
                            dataSource = {this.state.statusData4}
                            pagination = {pagination4}
                            loading={this.state.loading}
                        />
                    </TabPane>
                </Tabs>

                <Lottery
                    visible = {this.state.popVisible}
                    handleCancel = {this.handleCancel.bind(this)}
                    handleOk = {this.handleOk.bind(this)}
                    data = {this.state.popData}
                />

                <Modify
                    visible = {this.state.modifyVisible}
                    handleCancel = {this.handleModifyCancel.bind(this)}
                    handleOk = {this.handleOk.bind(this)}
                    data = {this.state.modifyData}
                />



            </div>

        )
    }
}
Predict = Form.create()(Predict);

export default Predict;
