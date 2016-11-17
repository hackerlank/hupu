import React, { Component } from 'react';
import update from 'react/lib/update';
import Card from './Card'; 
import { Table, Icon, Button, Modal, Upload, Form, Input, Select, Checkbox, Radio, message, Row, Col } from 'antd'
import { DragDropContext } from 'react-dnd';
import HTML5Backend from 'react-dnd-html5-backend';
import _ from 'common/underscore';
import dataService from 'common/dataService';

const Api = {
    sort: '/manage/room-recommend/sort'
}

class RecommendPop extends Component {

    constructor(props) {
        super(props);
    
        this.moveCard = this.moveCard.bind(this);
        this.handleOk = this.handleOk.bind(this);
        this.handleCancel = this.handleCancel.bind(this);

        this.state = {
            cards: props.RecommendData.cards || []
        };
    }

    componentWillReceiveProps(nextProps) {
        this.setState(
            {
                cards: nextProps.RecommendData.cards
            }
        );
    }

    moveCard(dragIndex, hoverIndex) {
        const { cards } = this.state;
        const dragCard = cards[dragIndex];

        this.setState( update(this.state, {
            cards: {
                $splice: [
                    [dragIndex, 1],
                    [hoverIndex, 0, dragCard]
                ]
            }
        }) );
    }

    handleOk() {
        var RecommendData = this.state.cards.reduce(function(result, item, index) {
                result.push(
                    {
                        "recommend_tag": item.tag,
                        "room_id": item.roomId
                    }
                )
                return result;
            }, []);

        if(RecommendData.length == 0) {
            this.props.handleCancel();
        }

        dataService.post(Api.sort, {sort: RecommendData}).then((res) => {
            if(res.code == 1) {
                this.props.handleCancel();
                message.success('推荐修改成功');
            }
        })
    }

    handleCancel() {
        this.props.handleCancel();
    }

    handleChange(roomId, value) {
        let cards = this.state.cards;

        cards.forEach(function(item) {
            if(item.roomId == roomId) {
                item.tag = value;
            }
        })

        this.setState({
            cards: cards
        })
    }

    handleCancelRecommend(roomId) {
        let cards = this.state.cards;
        
        for(var i = 0; i < cards.length; i++) {
            if(cards[i].roomId == roomId) {
                cards.splice(i, 1);
                i--;
            }
        }

        this.setState({
            cards: cards
        })

        message.success('已取消推荐');
    }

    render() {

        const { cards } = this.state;

        return (
            <Modal ref="modal"
                    visible={this.props.visible}
                    title="推荐管理" 
                    onCancel={this.handleCancel}
                    width="650"
                    footer={[
                        <Button key="back" type="ghost" size="large" onClick={this.handleCancel}>返 回</Button>,
                        <Button key="submit" type="primary" size="large" onClick={this.handleOk.bind(this)}>提 交</Button>
                    ]}>
                <div className = "ant-table">
                    <table rowKey={record => record.id}>
                        <thead>
                        <tr>
                            <th>推荐位</th>
                            <th>直播间ID</th>
                            <th>直播间名称</th>
                            <th>主播名称</th>
                            <th>所属分类</th>
                            <th>推荐标签</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                            {cards.map((card, i) => {
                                return (
                                    <Card key={card.id}
                                        index={i}
                                        id={i}
                                        name={card.id}
                                        data={card}
                                        cancelRecommend={this.handleCancelRecommend.bind(this)}
                                        handleChange={this.handleChange.bind(this)}
                                        moveCard={this.moveCard} />
                                );
                            })}
                        </tbody>
                    </table>
                </div>
            </Modal>
        );
  }
}

export default DragDropContext(HTML5Backend)(RecommendPop);
