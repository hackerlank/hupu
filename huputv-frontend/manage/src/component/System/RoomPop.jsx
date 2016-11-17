import React, {Component} from 'react';
import {Table, Row, Popconfirm, Message, Modal, Button, Form, Radio, Input, Col} from 'antd';
import dataService from 'common/dataService';
import _ from 'common/underscore';


const FormItem = Form.Item;
const Api = {
    search: '/manage/room'
}

class RoomPop extends Component {
    constructor(props) {
        super(props);
        this.state = {
            selectedRowKeys: [],  // 这里配置默认勾选列
            current: 1,
            loading: false,
            result: []
        }
    }

    componentDidMount() {
        
    }

    handleCancel() {
        this.setState({
            current: 1,
            result: [],
            selectedRowKeys: []
        })
        this.props.handleCancel();
    }

    renderAction(o, row, index) {
        let rowArr = [];
        rowArr.push(row);
        return (
            <span>
                <Button type="primary" style={{ marginRight: 10 }} onClick={this.batchAdd.bind(this, rowArr)}>选择</Button>
            </span>
        );
    }

    handleTableChange(pagination) {
        let current = pagination.current;
        
        this.setState({
            current
        });

    }

    batchAdd(result){
        console.log("点击选择时的数据: " + Object.keys(result[0]));
        this.props.handleRoomLine(result);

        this.setState({
            selectedRowKeys: [],
            result: [],
            current: 1
        })
    }   

    onSelectChange(selectedRowKeys) {
        this.setState({ selectedRowKeys });
        this.generateData(selectedRowKeys);
    }

    generateData(selectedRowKeys) {
        let { result } = this.state;
        console.log('selectedRowKeys changed: ', selectedRowKeys);
        if(selectedRowKeys.length == 0 ) {
            console.log("长度为0！！！！");
            result.length = 0;
        }

        for(var i = 0; i < selectedRowKeys.length; i++) {
            for(var j = 0; j < this.props.roomData.length; j++) {
                if(this.props.roomData[j].id == selectedRowKeys[i] && _.find(result, function(item){ return item.id == selectedRowKeys[i] }) == undefined) {
                    result.push(this.props.roomData[j]);
                }
            }
        }

        let matchArr = [];

        for(var i = 0; i < selectedRowKeys.length; i++) {
            for(var j = 0; j < result.length; j++) {
                if( result[j].id == selectedRowKeys[i] ) {
                    matchArr.push(result[j]);
                }
            }
        }

        this.setState({
            result: matchArr
        })
    }

    // 反选功能
    selectReverse(current) {
        let { selectedRowKeys, result } = this.state; 

        let curArr = []; // 当前页的所有选项
        let filterArr = []; // 当前页选中的选项

        curArr = _.map(this.props.roomData, function(item){ return item.id });

        // 获取当前页选中的选项        
        filterArr = _.intersection(selectedRowKeys, curArr);

        // 获取当前页中未选中的选项
        curArr = _.difference(curArr, filterArr);

        // 删除所有已选的选项中当前页的选项
        selectedRowKeys = _.difference(selectedRowKeys, filterArr);

        let resultArr = selectedRowKeys.concat(curArr);

        this.setState({
            selectedRowKeys: resultArr
        })

        this.generateData(resultArr);

    }

    filterCurrentSelect(element) {
        let cur = this.state.current;

        return element <= cur*10 && element >= cur*10 - 9
    }

    handleSearch(e) {
        e.preventDefault();
        let search = this.props.form.getFieldValue('search');
        this.setState({
            loading: true
        })
        dataService.get(Api.search, {search})
            .then((res) => {
                if(res.code == 1) {
                    this.props.handleSearch(res.data.list, res.data.count);
                }
                this.setState({
                    loading: false
                })

            })
    }

    render() {
        const self = this;

        const { getFieldProps } = this.props.form;
        const { selectedRowKeys, current } = this.state;


        const rowSelection = {
            selectedRowKeys: selectedRowKeys,
            onChange: this.onSelectChange.bind(this)
        };

        const columns = [
            {
                title: '房间ID',
                dataIndex: 'id',
            },
            {
                title: '主播名称',
                dataIndex: 'zhuboName',
            },
            {
                title: '直播间名称',
                dataIndex: 'roomName',
            },
            {
                title: '操作',
                dataIndex: 'operation',
                render: this.renderAction.bind(this)
            }
        ];

        let pagination = {
            total: this.props.count,
            pageSize: 10,
            current: this.state.current,
            onChange(current) {
                self.setState({
                    current
                })
                self.props.handleChange(current);
            }
        }

        return (
            <Modal title="选择直播间"
                style={{ top: 20 }}
                visible={this.props.visible}
                onCancel={this.handleCancel.bind(this)}
                footer = {() => null}
                >
                <Form inline form={this.props.form} onSubmit={this.handleSearch.bind(this)} style={{marginBottom:10}}>
                    <Input placeholder="搜索直播间" {...getFieldProps('search')} />
                    <Button type="primary" style={{marginLeft:10}} htmlType="submit" loading={this.state.loading}>搜索</Button>
                    {/*<Button type="primary" style={{marginLeft:10}} onClick={this.handleSearch.bind(this)} loading={this.state.loading}>搜索</Button>*/}
                    <p style={{marginBottom:10,color: '#999'}}>
                        说明：输入主播名称、主播ID或直播间名称，多个请用英文逗号隔开
                    </p>
                </Form>

                <Table
                    rowKey={record => record.id}
                    rowSelection={rowSelection} 
                    columns = {columns}
                    dataSource = {this.props.roomData}
                    pagination = {pagination}
                    onChange = {this.handleTableChange.bind(this)}
                    loading = {this.props.loading}
                    footer={
                        () => 
                            <div>
                                <Button type="primary" style={{marginRight:10}} onClick={this.selectReverse.bind(this, this.state.current)}>反选</Button>
                                <Button type="primary" onClick={this.batchAdd.bind(this, this.state.result)}>批量添加</Button>
                            </div>
                    }

                />   

            </Modal>
        )
    }
}   

RoomPop = Form.create()(RoomPop);


export default RoomPop;