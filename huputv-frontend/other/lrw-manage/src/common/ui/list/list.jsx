import React from 'react';
import Cookie from 'react-cookie';
import Modal, {Toast} from 'MODAL';
import dataService from 'DATASERVICE';
import Util from 'UTIL';

import './list.scss';

const Api = {
    giveup: '/passerbyking/player/giveup',
    subscribe:'/passerbyking/player/subscribe'
};

class List extends React.Component{	
	constructor(props) {
    super(props);

    this.state = {
    	 subscribe :false
    }
  }
  componentWillMount() {
  }
	handleWaiver(player_puid = 0, nickname = ''){
		if(!this.props.isNotice)  
		{
			let styles = {
				color: "#c01e2f"
			}
			let contentElement = (
				<div style={styles}>弃权后将无法复活</div>
			)

			Modal.alert(`${nickname} 是否确定要弃权？`, contentElement, () => {
	      		let params = {
	       			game_id: this.props.game_id,
	        		player_puid
	            }

	    		dataService
	      		.post(Api.giveup, params)
	     		.then(result => {
          			Toast.show(result.msg);

         			if(result.code == 1){
          				this.props.callback && this.props.callback();
          			}
	     		})
    		});
		}else{ //球员通知页   player_puid
			Cookie.remove("puid",{path:'/'})
			let userId=Cookie.save("puid",player_puid,{path:"/"});
    		this.props.callback && this.props.callback();
		}
	}
	getListElement(item, index) {
		let number = (index + 1);

		let status = (+item.status);
		let gameClassName = (status == 3 && this.props.isOptionButton) ? 'ui-play-list-gave' : '';
		let gameWheelOut = (status == 3 && this.props.isWheelRankList) ? 'ui-play-list-gave' : '';
		let nickname = Util.subBtyesString(item.nickname);
		let subscribeClassName=item.subscribe? "ui-play-list-subscribe" : "";
		let energeClassName=item.lightness>0?"player-energe":"";		
		let energeNum=item.lightness>0?item.lightness+"瓦":"";
		
		const getElement = (
				<div key={index} className={`ui-play-list ${gameClassName} ${gameWheelOut} ${subscribeClassName} ui-play-list-number-${number}`}>
					<div className="list-left">{item.player_num}</div>
					<div className="list-mid">
						<div className="avatar">
							<img src={item.header} />
						</div>
						<div className="list-text">
							<span className="player-nick">{nickname}</span>{this.props.isNotice?(<span className={energeClassName}><span className="energe-auto">{energeNum}</span></span>):""}
							<div className="play-message">{item.height}cm | {item.weight}kg  {item.total_win>0?(<span> | 胜{item.total_win}({item.rate}%)</span>):null}</div>
						</div>
					</div>
					{
						this.props.isTopNumber && !this.props.iswaiver? (
							<div className="list-rank">
								<span className="rank-item">{index + 1}</span>
							</div>
						) : <div>{item.status!=3 && this.props.iswaiver?(
								<div className="list-rank">
									<span className="rank-item">{index + 1}</span>
								</div>
							):(<div>{item.status==3 && this.props.iswaiver?(
									<div className="list-right">
										<span className="rank-waiver">已弃权</span>
									</div>
								):null
								}
							</div>)
							}									
							</div>
					}
					{
						((status != 2) && this.props.isOptionButton) ? (	
							<div className="list-right">
								{(() => {
									switch (status) {
								        case 0:     return <span className="waiver">已弃赛</span>;
								        case 3:     return <span className="waiver">已弃权</span>;
								        default:    return <div>{item.subscribe?(<span className="waiver subscribe">已订阅</span>):
								        (<span className="waiver" onClick={this.handleWaiver.bind(this, item.puid, nickname)}>{this.props.isNotice?"订阅":"弃权"}</span>)}</div>;
					        		}
								})()}
							</div>
						) : null
					}
				</div>
			)


		return getElement;
	}
	render(){
		let lists = this.props.lists;
		return (
			<div>
				{
					lists.map((item, index) => {
						return this.getListElement(item, index)
					})
				}
			</div>
		);
	}
}

List.defaultProps = {
	game_id: '',
	lists: [],
	callback: () => {},
	isTopNumber: false,
	isOptionButton: true,
	isNotice:false,
	iswaiver:false,
	isWheelRankList:false
}

List.propTypes = {
	// game_id: React.PropTypes.number,
	lists: React.PropTypes.array,
	callback: React.PropTypes.func,
	isOptionButton: React.PropTypes.bool,
	isTopNumber: React.PropTypes.bool,
	isNotice:React.PropTypes.bool,
	iswaiver:React.PropTypes.bool,
	isWheelRankList:React.PropTypes.bool
}

export default List;