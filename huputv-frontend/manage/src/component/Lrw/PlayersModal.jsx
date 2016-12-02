import React, {Component} from 'react';
import {Table,Modal} from 'antd';

import dataService from 'common/dataService';

const apiUrl={}
const footer=[{
	num:"总3场",
	title:"",
	area:"",
	time:"",
	popularity:"",
	win:4,
	fail:4,
	rate:"50%",
	income:"3423424"
}]
const dataSource=[{
	
}]
const columns=[{
	title:"场数",
	dataIndex:"num",
	key:"num"
},{
	title:"比赛标题",
	dataIndex:"title",
	key:"title"
},{
	title:"所属赛区",
	dataIndex:"area",
	key:"area"
},{
	title:"比赛时间",
	dataIndex:"time",
	key:"time"
},{
	title:"人气值",
	dataIndex:"popularity",
	key:"popularity"
},{
	title:"胜",
	dataIndex:"win",
	key:"win"
},{
	title:"负",
	dataIndex:"fail",
	key:"fail"
},{
	title:"胜率",
	dataIndex:"rate",
	key:"rate"
},{
	title:"虎扑币收入",
	dataIndex:"income",
	key:"income"
},]
const boolReal=true;
class PlayersModal extends Component{
	construct(props){
		supper(props);
		this.state={
			visible:false
		}
	}	
	componentWillMount() {
    	this.showModal();
  	}
	componentWillReceiveProps(nextProps){
	    this.showModal(nextProps);
	}
	showModal(props = this.props) {
	    this.setState({
	      visible: props.visible
		})
	}
	handleCancel(e){
		this.setState({
			visible:false
		})
	}
	render(){
		return (
			<Modal visible={this.state.visible}	title="单场数据" onCancel={this.handleCancel.bind(this)}
			 maskClosable={!boolReal} width="980" wrapClassName="single-data-wrap" pagination={{ pageSize: 30 }}>
				<Table dataSource={dataSource} columns={columns} rowKey={record => record.id} />
			</Modal>
		)
	}
}
PlayersModal.defaultProps={	
	visible:false
}
PlayersModal.propTypes = {
	visible: React.PropTypes.bool
}
export default PlayersModal;