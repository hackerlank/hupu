import React, { Component } from 'react';
import update from 'react/lib/update';
import Card from './Card';
import { Table, Icon, Button, Modal, Upload, Form, Input, Select, Checkbox, Radio, message, Row, Col } from 'antd'
import { DragDropContext } from 'react-dnd';
import HTML5Backend from 'react-dnd-html5-backend';


class RankPop extends Component {

    constructor(props) {
        super(props);
    
        this.moveCard = this.moveCard.bind(this);
        this.handleOk = this.handleOk.bind(this);
        this.handleCancel = this.handleCancel.bind(this);

        console.log( props.rankData.cards);
        this.state = {
            cards: props.rankData.cards || []
        };
    }

    componentWillReceiveProps(nextProps) {
        this.setState(
            {
                cards: nextProps.rankData.cards
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
        // console.log(this.state.cards);
        this.props.handleRank(this.state.cards);
    }

    handleCancel() {
        this.props.handleCancel();
    }

    render() {
        const { cards } = this.state;

        return (
        <Modal ref="modal"
                visible={this.props.visible}
                title="分类排序" 
                onCancel={this.handleCancel}
                width="360"
                footer={[
                    <Button key="back" type="ghost" size="large" onClick={this.handleCancel}>返 回</Button>,
                    <Button key="submit" type="primary" size="large" onClick={this.handleOk}>提 交</Button>
                ]}>
            <div>
                {cards.map((card, i) => {
                    return (
                        <Card key={card.id}
                            index={i}
                            id={card.id}
                            name={card.sname}
                            moveCard={this.moveCard} />
                    );
                })}
            </div>
        </Modal>
    );
  }
}

export default DragDropContext(HTML5Backend)(RankPop);
