import React, {Component} from 'react';
import {Link} from 'react-router';
import {Table, Row, Popconfirm, Message, Modal, Button, Form, Radio, Input, Col} from 'antd';
import dataService from 'common/dataService';
import _ from 'common/underscore';

const FormItem = Form.Item;

class RoomResult extends Component {
    constructor(props) {
        super(props);
        this.state = {
            roomDataResult: this.props.roomDataResult,
            selectedRowKeys: [],  // 这里配置默认勾选列
            pagination: {},
            current: 1,
            resultArr: []
        }
    }

    componentDidMount() {

    }

    componentWillReceiveProps() {
        this.setState({
            roomDataResult: this.props.roomDataResult
        })
    }

    handleRemove(rowArr) {
        let roomDataResult = this.state.roomDataResult;

        for(var i = 0; i < roomDataResult.length; i++) {
            if(~rowArr.indexOf(roomDataResult[i].id)) {
                roomDataResult.splice(i, 1);
                i--;
            }
        }

        this.setState({
            roomDataResult: roomDataResult
        })
    }

    renderResAction(o, row, index) {
        let rowArr = [];
        rowArr.push(row.id);
        return (
            <span>
                <Button type="primary" style={{ marginRight: 10 }} onClick={this.handleRemove.bind(this, rowArr)}>移除</Button>
            </span>
        );
    }

    handleTableChange(pagination) {
        let current = pagination.current;
        
        this.setState({
            current
        });
    }

    batchRemove(){
        let selectedRowKeys = this.state.selectedRowKeys;
        this.handleRemove(selectedRowKeys);
    } 

    // 反选功能
    selectReverse(current) {
        let selectedRowKeys = this.state.selectedRowKeys;
        let curArr = []; // 当前页的所有选项
        let filterArr = []; // 当前页选中的选项

        curArr = this.state.roomDataResult.slice((current-1)*10, current*10);
        curArr = _.map(curArr, function(item){ return item.id });

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
    }

    filterCurrentSelect(element) {
        let cur = this.state.current;

        return element <= cur*10 && element >= cur*10 - 9
    }

    onSelectChange(selectedRowKeys) {
        console.log('selectedRowKeys changed: ', selectedRowKeys);
        this.setState({ selectedRowKeys });
    }

    render() {

        const { selectedRowKeys } = this.state;

        const roomColumns = [
            {
                title: '主播间信息',
                dataIndex: 'roomInfo'
            },
            {
                title: '操作',
                dataIndex: 'operation',
                render: this.renderResAction.bind(this)
            }
        ];

        const rowSelection = {
            selectedRowKeys: selectedRowKeys,
            onChange: this.onSelectChange.bind(this)
        };

        const pagination = this.state.pagination;
        pagination.total = this.state.roomDataResult.length;

        let roomResultTable;
        if(this.props.roomDataResult.length == 0){
            roomResultTable = null;
        }else{
            roomResultTable = 
                            <Table
                                rowKey={record => record.id}
                                rowSelection={rowSelection} 
                                columns = {roomColumns}
                                dataSource = {this.state.roomDataResult}
                                pagination = {this.state.pagination}
                                onChange = {this.handleTableChange.bind(this)}
                                footer={
                                    () => 
                                        <div>
                                            <Button type="primary" style={{marginRight:10}} onClick={this.selectReverse.bind(this, this.state.current)}>反选</Button>
                                            <Button type="primary" onClick={this.batchRemove.bind(this)}>批量删除</Button>
                                        </div>
                                }
                            />
        }
        return(
            <div>
                {roomResultTable}
            </div>
        )

    }
}

export default RoomResult