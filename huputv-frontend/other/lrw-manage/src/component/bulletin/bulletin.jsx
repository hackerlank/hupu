import React ,{Component} from 'react';
import {Link, hashHistory} from 'react-router';
import dataService from 'DATASERVICE';
import Modal, {Toast} from 'MODAL';
import Util from 'UTIL';
/*import cookie from 'react-cookie';*/

import './bulletin.scss';

const Api={
	getbulletin:'/passerbyking/announcement/list',
	stopGame:'/passerbyking/announcement/add',
	cancelbulletin:'/passerbyking/announcement/cancel'
};

/*let itemIndex=0;*/
let setInt = null;
class Bulletin extends Component {
	constructor(props){
		super(props);

		this.itemIndex = 0;
		/*this.setInt="";
*/
		this.state={
			confirmflag: null,	 
			currentBreak: null,			//确认开启公告后阻止任何操作
			template_list: [],		   //公告list
			id: 0,     
			time:0
		}
	}
	componentWillMount(){
		let url=Api.getbulletin;

		this.setState({
			id: Util.getGameId()
			/*confirmflag: cookie.load('confirmflag'),	 
			currentBreak: cookie.load('currentBreak'),*/
		})
		
		dataService
			.get(url)
			.then(result=>{
				if(result.code==1){
					let tempdata=result.data;
					tempdata.map((item,index)=>{
						tempdata[index]['status']=false;
					})

					this.setState({
						template_list:tempdata						
					})
				}else{
					Toast.show(result.msg);
				}
			})
	}
	confirmbtn(id,ev){
		if(this.state.currentBreak){	
			Modal.alert('提示','取消暂停', () => {
				this.cancelBreak();
			});
		}
		if(!this.state.confirmflag || this.state.currentBreak){
			return;
		}
		let url=Api.stopGame;
		let params={
			id: this.state.id,
			game_id:Util.getGameId()
		};		
		dataService
		.post(url,params)
		.then(result=>{
			if(result.code==1){
				this.setState({
					currentBreak:true
				})
				/*cookie.save("currentBreak",currentBreak);*/
				Toast.show(result.msg);
				this.getArrayIndex(this.state.template_list);
				this.setState({
					time:this.state.template_list[this.itemIndex].second
				})
				
				this.suspendGame();
			}else{
				Toast.show(result.msg);
			}
		})
	}
	touchbtn(ev,index,id){
		if(this.state.currentBreak){
			return;
		}
		this.state.template_list.map(item=>{
			item.status=false;
		})
		let template_list=this.state.template_list;
		let confirmflag=this.state.confirmflag;	
		if(ev){
			template_list[index].status=false;
			confirmflag=false;			
		}else{
			template_list[index].status=template_list[index].status?false:true;
			confirmflag=true;
			this.state.id=id;
		}			
		this.setState({			
			template_list:template_list,
			confirmflag:confirmflag	
		})
		/*cookie.save("confirmflag",confirmflag);*/
	}
	suspendGame(time){
	    setInt = setInterval(() => {
	    	this.action(time)
	    },1000);
	}
	getArrayIndex(array){
	 	array.map((item,index)=>{
	 		if(item.status){
	 			this.itemIndex=index;
	 		}
	 	})
 	}
 	action(){
		if(parseInt(this.state.time) > 0){
			let time = this.state.time - 1;

			this.setState({
				time
			})
		}else{
			clearInterval(setInt);
			this.state.template_list.map(item=>{
				item.status=false;
			})			
			this.setState({
				currentBreak:false
			})	
			/*cookie.save("currentBreak",currentBreak);*/					
		}
	}
 	cancelBreak(){
 		let url=Api.cancelbulletin;
 		let params={
 			game_id:Util.getGameId()
 		};
 		dataService
 			.post(url,params)
 			.then(result=>{
 				if(result.code==1){
 					clearInterval(setInt); 					
 					this.state.template_list.map(item=>{
						item.status=false;
					})
 					this.setState({
 						confirmflag:false,	  
						currentBreak:false 
 					})
 					/*cookie.save("currentBreak",currentBreak);*/
 				}
 			})
 	}
	historyGoBack(){
		this.props.history.goBack();
	}
  render() {
    return (
    	<div>
	     	<header className="ui-header">
	     		<a  className={this.state.currentBreak ? "btn-bulletin hide" : "btn-bulletin"} onClick={this.historyGoBack.bind(this)}><span className="goback"></span>返回</a>
	     		<h1 className="headerline">公告</h1>
	     		<span className={this.state.confirmflag?"btn-confirm active":"btn-confirm"} onClick={this.confirmbtn.bind(this)}>{this.state.currentBreak?"取消":"确认"}</span>
	     	</header>

			<div className="bulletin-wrap">
			{	
				this.state.template_list.map((item,index)=>{
				return (
					<div key={index} className={item.status?"item active":"item"}  onClick={this.touchbtn.bind(this,item.status,index,item.id)}>
						<div className="item-left">{item.text}</div>
						<div className="item-right">
							<div className="circle"></div>
						</div>
					</div>
				);
				})
			}				
			</div>
				<div className={this.state.currentBreak?"boxOverlay":"boxOverlay-hide"}>
					<span>{this.state.time}</span>
				</div>
			
		</div>
    );
  }
}



 

export default Bulletin;

