import React, { Component } from 'react'
import Card from './Card'
import { Table, Icon, Button, Modal, Form, Input, Checkbox, Radio, message, Row, Col, Transfer } from 'antd'
import dataService from 'common/dataService';
import './ConfigPop.less'


const giftOrderList = '/manage/gift/order';
const giftOrderApi = '/manage/order';

class ConfigPop extends Component{
    constructor(props) {
        super(props);
        this.state = {
            originData: [],
            targetData: [],
            leftSelectedRowKeys: [],
            rightSelectedRowKeys: [],
            roomId: 0
        }
    }

    componentWillReceiveProps(nextProps) {
        
        if(nextProps.roomId != undefined && (nextProps.roomId <= 0 || nextProps.roomId === this.state.roomId)){
            return;
        }

        this.setState({
            roomId: nextProps.roomId
        })
        
        let room_id = nextProps.roomId;
        let data = room_id ? {room_id} : {};

        dataService.get(giftOrderList, data).then((result) =>{
            let data = result.data.list;
                this.setState({
                    originData: result.data.list,
                    targetData: result.data.giftOrder,
                    configVisible: true,
                    loading: false
                });
        })
    }

    sortNumber(a, b) {
        return a - b;
    }

    handleAdd() {
        let self = this,
            indexArray = this.state.leftSelectedRowKeys;

        if(this.state.targetData.length >= 6) {
            message.warn('默认礼物最多6个');
            return;
        }

        if(indexArray.length == 0) {
            message.warn('请选择需要添加的礼物');
            return;
        }

        indexArray.sort(this.sortNumber);

        indexArray.forEach(function(item, index) {
            var addItem = self.state.originData.splice(item-index, 1);
            self.state.targetData.push(addItem[0]);
        });

        this.setState({
            leftSelectedRowKeys: [],
            originData: this.state.originData,
            targetData: this.state.targetData
        })
    }

    handleRemove() {
        let self = this,
            indexArray = this.state.rightSelectedRowKeys;

        if(indexArray.length == 0) {
            message.warn('请选择需要移除的礼物');
            return;
        }

        indexArray.sort(this.sortNumber);

        indexArray.forEach(function(item, index) {
            var removeItem = self.state.targetData.splice(item-index,1);
            self.state.originData.push(removeItem[0]);
        });

        this.setState({
            rightSelectedRowKeys: [],
            originData: this.state.originData,
            targetData: this.state.targetData
        })

    }

    swapItems(index1, index2) {
        let { targetData } = this.state;
        targetData[index1] = targetData.splice(index2, 1, targetData[index1])[0];
        
        this.setState({
            targetData: targetData
        })
    }

    goUp() {
        if(!this.state.rightSelectedRowKeys.length) {
            message.error('未选择礼物');
            return false;
        }

        if(this.state.rightSelectedRowKeys.length > 1) {
            message.warn('只能选择一条来移动');
            return false;
        }

        if(this.state.rightSelectedRowKeys[0] == 0) {
            message.warn('已到第一条');
            return false;
        }

        this.swapItems(this.state.rightSelectedRowKeys[0], this.state.rightSelectedRowKeys[0] - 1);

        this.setState({
            rightSelectedRowKeys: [this.state.rightSelectedRowKeys[0] - 1]
        })
    }

    goDown() {
        if(!this.state.rightSelectedRowKeys.length) {
            message.error('未选择礼物');
            return false;
        }

        if(this.state.rightSelectedRowKeys.length > 1) {
            message.warn('只能选择一条来移动');
            return false;
        }

        if(this.state.rightSelectedRowKeys[0] == this.state.targetData.length-1) {
            message.warn('已到最后一条');
            return false;
        }

        this.swapItems(this.state.rightSelectedRowKeys[0], this.state.rightSelectedRowKeys[0] + 1);

        this.setState({
            rightSelectedRowKeys: [this.state.rightSelectedRowKeys[0] + 1]
        })
    }

    renderItem(o, row, index) {
        return (
            <div className="custom-item clearfix">
                <span className="fl"><img src={row.cover} width="50" /></span>
                <div className="fl ml10">
                    <h3>{row.name}</h3>
                    {
                        row['multi_send'] == 0 ? <div>{row.price}</div> : <div>批量（{row.price}）</div>
                    }
                </div>
            </div>
        );
    }

    handleCancel() {
        this.setState({
            leftSelectedRowKeys: [],
            rightSelectedRowKeys: []
        })
        this.props.handleCancel();
    }

    handleOk() {
        if(this.state.targetData.length > 6) {
            message.warn('默认礼物最多6个');
            return;
        }

        this.setState({
            leftSelectedRowKeys: [],
            rightSelectedRowKeys: []
        })

        let resultArr = this.state.targetData.reduce(function(initial, cur, index) {
            initial.push(cur.id);
            return initial;
        }, []);

        let room_id = this.state.roomId;
        let data = room_id ? {rank: resultArr, room_id} : {rank: resultArr};
        
        dataService.post(giftOrderApi, data).then((result) =>{
            if(result.code == 1) {
                this.props.handleCancel();
                message.success("礼物设置成功");
            }
        })
    }

    onLeftSelectChange(selectedRowKeys) {
        console.log('leftSelectedRowKeys changed: ', selectedRowKeys);
        this.setState({ leftSelectedRowKeys: selectedRowKeys });
    }

    onRightSelectChange(selectedRowKeys) {
        console.log('rightSelectedRowKeys changed: ', selectedRowKeys);
        this.setState({ rightSelectedRowKeys: selectedRowKeys });
    }

    render() {
        const { leftSelectedRowKeys, rightSelectedRowKeys } = this.state;

        const leftColumns = [{
            title: '可选礼物',
            dataIndex: 'name',
            render: this.renderItem
        }];

        const rightColumns = [{
            title: '默认礼物（可设置6个）',
            dataIndex: 'name',
            render: this.renderItem
        }];

        const leftRowSelection = {
            selectedRowKeys: leftSelectedRowKeys,
            onChange: this.onLeftSelectChange.bind(this)
        };

        const rightRowSelection = {
            selectedRowKeys: rightSelectedRowKeys,
            onChange: this.onRightSelectChange.bind(this)
        };


        return (
            <Modal ref="modal"
                    visible={this.props.visible}
                    title="礼物排序" 
                    onCancel={this.handleCancel.bind(this)}
                    width="750"
                    footer={[
                        <Button key="back" type="ghost" size="large" onClick={this.handleCancel.bind(this)}>返 回</Button>,
                        <Button key="submit" type="primary" size="large" onClick={this.handleOk.bind(this)}>提 交</Button>
                    ]}>
                    <div className="table-wrap">
                        <div className="sourceTable">
                            <Table 
                                rowSelection={leftRowSelection} 
                                columns={leftColumns} 
                                dataSource={this.state.originData} 
                                pagination={false}
                                size='small'
                            /> 
                        </div>
                        <div className="operation">
                            <Button type="primary" style={{display:'block',marginBottom:10}} onClick={this.handleAdd.bind(this)}> 添加 &gt; </Button>
                            <Button type="primary" style={{display:'block'}} onClick={this.handleRemove.bind(this)}> &lt; 移除 </Button>
                        </div>
                        <div className="targetTable">
                            <Table 
                                rowSelection={rightRowSelection} 
                                columns={rightColumns} 
                                dataSource={this.state.targetData} 
                                pagination={false}
                                size='small'
                            /> 
                        </div>
                        <div className="arrow">
                            <Icon type="caret-up" onClick={this.goUp.bind(this)} />
                            <Icon type="caret-down" onClick={this.goDown.bind(this)} />
                        </div>
                    </div>
            </Modal>
        )
    }

}

export default ConfigPop;