import React, {Component} from 'react'
import dataService from 'common/dataService'
import { Form, Input, Row, Col, Button, Select, Table, Popconfirm, message, Modal } from 'antd'
import './ShowGift.less'

import ConfigPop from '../Gift/ConfigPop'

const giftOrderList = '/manage/gift/order';
const giftOrderApi = '/manage/order';

class ShowGift extends Component {
    constructor(props) {
        super(props);

        this.state = {
            configVisible: false,
            loading: false,
            roomId: 0
        }
    }

    handleCancel() {
        this.props.handleCancel();
    }

    showGiftConfig() {
        this.setState({
            roomId: this.props.roomId,
            configVisible: true
        }); 

        this.props.handleCancel();
    }


    handleCancelConfig() {
       this.setState({
            configVisible: false
        }); 
    }

    render() {
        return (
            <div>
                <Modal 
                    title="当前礼物"
                    visible={this.props.visible}
                    title={
                            <div>
                                <span>礼物管理</span>
                                <Button type="primary" style={{marginLeft:10}} onClick={this.showGiftConfig.bind(this)} loading={this.state.loading}>修改礼物</Button>
                            </div>
                    } 
                    onCancel={this.handleCancel.bind(this)}
                    width="640"
                    footer={null}>

                    <ul className="giftList">
                    {
                        this.props.giftData.map(function(item) {
                            return (
                                <li>
                                    <img src={item.cover} width="50" />
                                    <h3>{item.name}</h3>    
                                    {
                                        item['multi_send'] == 0 ? <div>{item.price}</div> : <div>批量（{item.price}）</div>
                                    }
                                </li>
                            )
                        })
                    }
                        
                    </ul>

                </Modal>

                <ConfigPop 
                    visible = {this.state.configVisible}
                    handleCancel = {this.handleCancelConfig.bind(this)}
                    roomId = {this.state.roomId}
                />
            </div>
        )
    }
}

export default ShowGift;