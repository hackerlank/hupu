import React, { Component, PropTypes } from 'react';
import { findDOMNode } from 'react-dom';
import ItemTypes from './ItemTypes';
import { Button, Modal, Form, Input, message, Popconfirm, Row, Col } from 'antd'
import { DragSource, DropTarget } from 'react-dnd';
import dataService from 'common/dataService';

const Api = {
  cancelRecommend: '/manage/room-recommend/:id'
}


const divStyle = {
  padding: '0.2rem 1rem',
  marginBottom: '.5rem',
  backgroundColor: 'white',
  cursor: 'move'
};

const spanStyle = {
  display: 'inline-block',
  width: '250px',
  border: '1px dashed gray',
  padding: '0.5rem 1rem',
  backgroundColor: 'white',
  cursor: 'move'
}

const cardSource = {
  beginDrag(props) {
    return {
      id: props.id,
      index: props.index
    };
  }
};

const cardTarget = {
  hover(props, monitor, component) {
    const dragIndex = monitor.getItem().index;
    const hoverIndex = props.index;

    // Don't replace items with themselves
    if (dragIndex === hoverIndex) {
      return;
    }

    // Determine rectangle on screen
    const hoverBoundingRect = findDOMNode(component).getBoundingClientRect();

    // Get vertical middle
    const hoverMiddleY = (hoverBoundingRect.bottom - hoverBoundingRect.top) / 2;

    // Determine mouse position
    const clientOffset = monitor.getClientOffset();

    // Get pixels to the top
    const hoverClientY = clientOffset.y - hoverBoundingRect.top;

    // Only perform the move when the mouse has crossed half of the items height
    // When dragging downwards, only move when the cursor is below 50%
    // When dragging upwards, only move when the cursor is above 50%

    // Dragging downwards
    if (dragIndex < hoverIndex && hoverClientY < hoverMiddleY) {
      return;
    }

    // Dragging upwards
    if (dragIndex > hoverIndex && hoverClientY > hoverMiddleY) {
      return;
    }

    // Time to actually perform the action
    props.moveCard(dragIndex, hoverIndex);

    // Note: we're mutating the monitor item here!
    // Generally it's better to avoid mutations,
    // but it's good here for the sake of performance
    // to avoid expensive index searches.
    monitor.getItem().index = hoverIndex;
  }
};

@DropTarget(ItemTypes.CARD, cardTarget, connect => ({
  connectDropTarget: connect.dropTarget()
}))

@DragSource(ItemTypes.CARD, cardSource, (connect, monitor) => ({
  connectDragSource: connect.dragSource(),
  isDragging: monitor.isDragging()
}))

export default class Card extends Component {
  static propTypes = {
    connectDragSource: PropTypes.func.isRequired,
    connectDropTarget: PropTypes.func.isRequired,
    index: PropTypes.number.isRequired,
    isDragging: PropTypes.bool.isRequired,
    id: PropTypes.any.isRequired,
    name: PropTypes.string.isRequired,
    moveCard: PropTypes.func.isRequired
  };

  // state = {
  //   recommendData: this.props.data,
  //   name: ''
  // }

  cancelRecommend(roomId) {

    let api = Api.cancelRecommend.replace(':id', roomId);
    dataService.delete(api).then((res) => {
      if(res.code == 1){
        this.props.cancelRecommend(roomId);
      }
    })
  }

  handleTag(roomId, e) {
    this.props.handleChange(roomId, e.target.value);
    // this.props.data.tag = e.target.value;
    // this.setState({
    //   tag: e.target.value
    // })
  }

  render() {
    const { index, name, data, isDragging, connectDragSource, connectDropTarget } = this.props;

    const opacity = isDragging ? 0 : 1;

    return connectDragSource(connectDropTarget(
        <tr>
            <td>{data.sort}</td>
            <td>{data.roomId}</td>
            <td>{data.room_name}</td>
            <td>{data.zhuboName}</td>
            <td>{data.roomType}</td>
            <td><Input value={data.tag} style={{width: '80px'}} onChange={this.handleTag.bind(this, data.roomId)} /></td>
            <td> 
                <Popconfirm title="确定要取消推荐吗？" onConfirm={this.cancelRecommend.bind(this, data.roomId)}>
                  <Button> 取消推荐</Button>
                </Popconfirm>
            </td>
        </tr>
    ));
  }
}
