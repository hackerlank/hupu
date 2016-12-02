import React, { Component } from 'react';
import { Link } from 'react-router';
import { Modal, Form, Button, Input, Select, DatePicker, Row, Col,Upload,Icon,message } from 'antd';

import dataService from 'common/dataService';
const FormItem  =  Form.Item;
let datalist  =  [];
let datalist1  =  [];
class PlayersEdit extends Component{
  	construct(props){
		supper(props);
		this.state = {
			visible:false,
			basicData:{}
		}
	}
	componentWillMount() {
    	this.showModal();
  	}
	componentWillReceiveProps(nextProps){
	    this.showModal(nextProps);
	}
	showModal(props  =  this.props) {
	   
	    //datalist = props.playList;
	    let tempdata = props.playList;
	    //let datalist = Object.assign(datalist1, props.playList);
	    for(let attr in tempdata){
	    	datalist[attr] = tempdata[attr];
	    }
	    console.log(datalist);
	    this.setState({
	      visible: props.visible	      
		})
	    
	}
    handleOk() {
	    this.setState({
	      visible: false
	    });

 	 }
 	handleCancel(e) {
	    this.setState({
	      visible: false
	    });
	    this.props.callback && this.props.callback();
  	}
	render() {
		const formItemLayout  =  {
	      labelCol:{ span: 10 },
        wrapperCol:{ span: 14 }
    	};
    	const boolReal = true;
    	const props  =  {
		    name: 'file',
			action: '',
			headers: {
				authorization: 'authorization-text',
			},
			onChange(info) {
			    if (info.file.status !==  'uploading') {
			      console.log(info.file, info.fileList);
			    }
			    if (info.file.status  ===  'done') {
			      message.success(`${info.file.name} 上传成功。`);
			    } else if (info.file.status  ===  'error') {
			      message.error(`${info.file.name} 上传失败。`);
			    }
			}
		};

	    return (
	      <div>
	        <Modal title = "编辑" visible = { this.state.visible } maskClosable = { !boolReal }
	          onOk = {this.handleOk.bind(this)} onCancel = {this.handleCancel.bind(this)} width = "980">
	         	<Form inline className = "advanced-search-form">
		          	<Row>
				        <Col span = "8">
					      	<FormItem {...formItemLayout}
				          		label = "球员编号：">
				          		<Input  defaultValue = { datalist.id  }/>
			          		</FormItem>
			          	</Col>	
			          	<Col span = "8">	          	
					      	<FormItem {...formItemLayout}
				          		label = "球员姓名：">
				          		<Input defaultValue = { datalist.name  }/>
			          		</FormItem>	
			          	</Col>
			          	<Col span = "8">			    
					      	<FormItem {...formItemLayout}
				          		label = "所属地区：">
				          		<Input  defaultValue = { datalist.area  }/>
			          		</FormItem>
				        </Col>
				        <Col span = "8">
					      	<FormItem {...formItemLayout}
				          		label = "PassPortId：">
				          		<Input  disabled = "true" defaultValue = { datalist.PassPortId }/>
			          		</FormItem>
			          	</Col>
			          	<Col span = "8">			          		
					      	<FormItem {...formItemLayout}
				          		label = "虎扑昵称：">
				          		<Input  disabled = "true" defaultValue = { datalist.nickname }/>
			          		</FormItem>	
			          	</Col>
			          	<Col span = "8">				        
					      	<FormItem {...formItemLayout}
				          		label = "所属战团：">
				          		<Input defaultValue = { datalist.battleGroup }/>
			          		</FormItem>
		          		</Col>
				     	<Col span = "8">
					      	<FormItem {...formItemLayout}
				          		label = "所属球队：">
				          		<Input defaultValue = { datalist.team }/>
			          		</FormItem>	
			          	</Col>
			          	<Col span = "8">			       
					      	<FormItem {...formItemLayout}
				          		label = "QQ：">
				          		<Input defaultValue = { datalist.qq } />
			          		</FormItem>
			          	</Col>
			          	<Col span = "8">
					      	<FormItem {...formItemLayout}
				          		label = "微信号：">
				          		<Input defaultValue = { datalist.wechat } />
			          		</FormItem>
		          		</Col>
				        <Col span = "8">
					      	<FormItem {...formItemLayout}
				          		label = "手机号：">
				          		<Input defaultValue = { datalist.phone } />
			          		</FormItem>
			          	</Col>
			          	<Col span = "8">
					      	<FormItem {...formItemLayout}
				          		label = "身份证：">
				          		<Input defaultValue = { datalist.idCard  }/>
			          		</FormItem>
			          	</Col>
			          	<Col span = "8">
					      	<FormItem {...formItemLayout}
				          		label = "身高：">
				          		<Input defaultValue = { datalist.height} />
			          		</FormItem>
		          		</Col>
				     	<Col span = "8">
					      	<FormItem {...formItemLayout}
				          		label = "体重：">
				          		<Input defaultValue = { datalist.wight} />
			          		</FormItem>
			          	</Col>
			          	<Col span = "8">
					      	<FormItem {...formItemLayout}
				          		label = "球星模板：">
				          		<Input defaultValue = { datalist.starIdol }/>
			          		</FormItem>
			          	</Col>
			          	<Col span = "8">
					      	<FormItem {...formItemLayout}
				          		label = "喜爱球星：">
				          		<Input defaultValue = { datalist.idol } />
			          		</FormItem>
		          		</Col>
				        <Col span = "8">
					      	<FormItem {...formItemLayout }
				          		label = "助跑摸高：">
				          		<Input defaultValue = { datalist.bounce } />
			          		</FormItem>
			          	</Col>
			          	<Col span = "8">
					      	<FormItem {...formItemLayout }
				          		label = "百米速度：">
				          		<Input defaultValue = { datalist.speed } />
			          		</FormItem>
			          	</Col>
			          	<Col span = "8">
					      	<FormItem {...formItemLayout }
				          		label = "惯用手：">
				          		<Input defaultValue = { datalist.hand } />
			          		</FormItem>
				        </Col>
				        <Col span = "8">
					      	<FormItem {...formItemLayout }
				          		label = "球鞋：">
				          		<Input defaultValue = { datalist.shoe } />
			          		</FormItem>
			          	</Col>
			          	<Col span = "8">
					      	<FormItem {...formItemLayout }
				          		label = "球龄：">
				          		<Input defaultValue = { datalist.playTime } />
			          		</FormItem>
			          	</Col>
			          	<Col span = "8">
					      	<FormItem {...formItemLayout }
				          		label = "出没球场：">
				          		<Input defaultValue = { datalist.court } />
			          		</FormItem>
				        </Col>
				        <Col span = "8">
					      	<FormItem {...formItemLayout }
				          		label = "校队及其它球队经历：">
				          		<Input defaultValue = { datalist.experience } />
			          		</FormItem>
			          	</Col>
			          	<Col span = "8">
					      	<FormItem {...formItemLayout }
				          		label = "是否单身：">
				          		<Input defaultValue = { datalist.singleDog } />
			          		</FormItem>
			          	</Col>
			          	<Col span = "8">
					      	<FormItem {...formItemLayout }
				          		label = "总人气：">
				          		<Input defaultValue = { datalist.popularity }disabled = "true" />
			          		</FormItem>
		          		</Col>
				        <Col span = "8">
					      	<FormItem {...formItemLayout }
				          		label = "总场数：">
				          		<Input defaultValue = { datalist.total } disabled = "true"/>
			          		</FormItem>
			          	</Col>
			          	<Col span = "8">
					      	<FormItem {...formItemLayout }
				          		label = "总胜：">
				          		<Input defaultValue = { datalist.win } disabled = "true"/>
			          		</FormItem>
			          	</Col>
			          	<Col span = "8">
					      	<FormItem {...formItemLayout }
				          		label = "总负：">
				          		<Input defaultValue = { datalist.faile }disabled = "true" />
			          		</FormItem>
		          		</Col>		          	
				        <Col span = "8">
					      	<FormItem {...formItemLayout }
				          		label = "总胜率：">
				          		<Input defaultValue = { datalist.rate } disabled = "true"/>
			          		</FormItem>
			          	</Col>
			          	<Col span = "8">
					      	<FormItem {...formItemLayout }
				          		label = "虎扑币总收入：">
				          		<Input defaultValue = { datalist.income } disabled = "true"/>
			          		</FormItem>
				        </Col>				        
				    </Row>
				    <Row>
				    	<Col span = "12">
					      	<FormItem {...formItemLayout }
				          		label = "参赛感言：">
				          		<Input defaultValue = { datalist.speech }  type = "textarea" size = "large"/>
			          		</FormItem>
				        </Col>
				        <Col span = "12">
					      	<FormItem {...formItemLayout }
				          		label = "头像：">
				          		<Upload  {...props }>
								    <Button type = "ghost">
								      <Icon type = "upload" /> 点击上传
								    </Button>
								</Upload>
			          		</FormItem>
				        </Col>				        
				    </Row> 
	        	</Form>
	        </Modal>
	      </div>
	    );
	}
}
PlayersEdit.defaultProps = {
	playList: [],
	callback: () => {}
	
}

PlayersEdit.propTypes = {
	// game_id: React.PropTypes.number,
	playList: React.PropTypes.array,
	callback: React.PropTypes.func
}
export default PlayersEdit;