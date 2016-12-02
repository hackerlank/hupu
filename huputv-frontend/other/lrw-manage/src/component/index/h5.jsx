import React from 'react';
import {Link, hashHistory} from 'react-router';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import Cookie from 'react-cookie';
import * as IndexActions from 'ACTION/index';

import { findDOMNode } from 'react-dom';

import Modal, {Toast} from 'MODAL';
import dataService from 'DATASERVICE';
import Tab from 'COMMON/h5/tab/tab';
import SenList from 'COMPONENT/semifinal/list/list';
import Util from 'UTIL';
import List from 'CUI/list/list';
import NoMatch from 'COMMON/noMatch';
import ListTitle from 'CUI/list-title/title';
import './h5.scss';

const Api = {
    match: '/m/passerbyking/wheel/match/:id',
   // outPlayers: '/m/passerbyking/wheel/outplayers/:id',
    rankList:'/m/passerbyking/wheel/rank/:id'
};


const Index = React.createClass({
  getInitialState() {
    return {
      game_id: Util.getGameId(),
      basicInfo: {
        stream: {
          publish: {},
          play: ''
        },
        game_info:{

        },
        rank_url:"",
        top8_match_url:"",
        top8_rank_url:"",
        wheel_match_url:"",
        wheel_rank_url:""
      },    
      match_list: [], 
      out_list:[],     
      rank_promote:[],
      rank_outlist:[],
      rankList:[],
      semList:[],
      ready_num:-1
    };
  },
  componentWillMount() {
    this.getBasicInfo();
    
   // this.getOutPlayers();
    
  },
  componentWillReceiveProps(nextProps) {
    this.getBasicInfo(nextProps);
   
  },
  /**
   * 获取基本信息
   * @param {[type]} props [description]
   */
  getBasicInfo(props = this.props) { 

    const basicInfo = Object.assign(this.state.basicInfo, props.basicInfo);
    this.setState({
      basicInfo
    });
   if(basicInfo.game_info.match_status){
      this.getPlayers();
      this.getRankPlayers();
   }
  },
  /**
   * 获取待比赛球员
   * @return {[type]} [description]
   */
  getPlayers() {
    if( this.state.basicInfo.game_info.match_status != 1){
      return;
    }

    let url = Api.match.replace(':id', this.state.game_id);

    dataService
      .get(url)
      .then(result => {
        if(result.code == 1){
          //待比赛球员
          let tempdataReady=result.data.ready;
          tempdataReady.map((item,index)=>{            
           tempdataReady[index]["subscribe"]=false;
          })
          let puid=Cookie.load("puid");          
          puid?(tempdataReady.map((item,index)=>{
                  if(tempdataReady[index].puid==puid){
                      tempdataReady[index].subscribe=true;                     
                      this.setState({
                        ready_num:index
                      })
                    }
                  })
                ):"";
          //已out球员
          let tempdataOut=result.data.out;
          tempdataOut.map((item,index)=>{            
           tempdataOut[index]["subscribe"]=false;
          })            
          puid?(tempdataOut.map((item,index)=>{
                  if(tempdataOut[index].puid==puid){
                      tempdataOut[index].subscribe=false;
                      Cookie.remove("puid",{path:'/'});                     
                      this.setState({
                        ready_num:-1                        
                      })
                    }
                  })
                ):"";
          //进行中球员
         let tempdataSem=[];

         tempdataSem.push(result.data.playing);
         tempdataSem.map((item,index) => {
          tempdataSem[index].status="4";
         })
          this.setState({
            match_list: tempdataReady,
            out_list: tempdataOut,
            semList:tempdataSem
          });
        }else{
          Toast.show(result.msg);
        }
      })
  },  
  getRankPlayers(){
    
    if(this.state.basicInfo.game_info.match_status<2){
      return;
    }
    let url = Api.rankList.replace(':id', this.state.game_id);
    dataService
    .get(url)
    .then(result=>{
      if(result.code==1){          
            let temp_promote=result.data.rank_list.top8;
            let temp_outlist=result.data.rank_list.out;
            let wheelRankList=[];            
            
            let puid=Cookie.load("puid");
            temp_promote.map((item,index)=>{            
             temp_promote[index]["subscribe"] = false;
            });
            puid?(temp_promote.map((item,index)=>{
                  if(temp_promote[index].puid==puid){
                      temp_promote[index].subscribe=true;        
                    }                
                  })
            ):"";    
            temp_promote.map((item,index) => {
              wheelRankList.push(item);
            })  
            temp_outlist.map((item,index) => {
              wheelRankList.push(item);
            })    
            this.setState({
              rank_promote:temp_promote,
              rank_outlist:temp_outlist,
              rankList:wheelRankList              
            })               
      }else{
        Toast.show(result.msg);
      }
    })
  },
  gameCallback() {
    this.getPlayers();
  },
  render() {
    const { basicInfo } = this.state;
    return basicInfo.game_info.match_status==1?(
      <div>
        <Tab active = "1"/> 
      {
        this.state.semList.length?(
          <div>                   
            <ListTitle 
              title = "进行中球员"
              />
            <SenList lists= {this.state.semList}
              mark={true}
             />
          </div>):null
      }
      {  
        this.state.match_list.length?(
          <div> 
            <div className="ui-header-left">
              <h2>待比赛球员{this.state.ready_num>=0?(<span>(前面还有<i>{this.state.ready_num}</i>位球员)</span>):""}</h2>
            </div>
            <List
              lists = {this.state.match_list}
              game_id = {this.state.game_id}
              callback = {this.gameCallback}
              isNotice={true}
             />
          </div>):null
      }
      {
       this.state.out_list.length?(
          <div>
            <ListTitle 
            title = "已OUT球员"
            />
            <List 
            lists = {this.state.out_list}
            game_id = {this.state.game_id}
            callback = {this.gameEndCallback}
            isNotice={true}
          />
          </div>):null
      }
       
      </div>
    ):basicInfo.game_info.match_status >=3?(
      <div> 
        <Tab active = "1"/>       
        <ListTitle 
          title = "已晋级球员"
         />
        <List lists={this.state.rank_promote} 
          callback = {this.gameEndCallback}
          isTopNumber={true}
          isOptionButton={false}
          isNotice={true}
        />        
        <ListTitle 
          title = "已OUT球员"
         />
        <List lists={this.state.rank_outlist} 
          isNotice={true}
        />
      </div>
    ):basicInfo.game_info.match_status ==2?(
        <div>
       <Tab active = "1"/>       
        <ListTitle 
          title = "车轮战战绩表"
         />
        <List lists={this.state.rankList} 
          callback = {this.gameEndCallback}
          isTopNumber={true}
          isOptionButton={false}
          isNotice={true}
          iswaiver={true} 
          isWheelRankList={true}


        />  
        </div>
    ):
    (
      <div>
        <Tab active = "1"/> 
        <NoMatch title='比赛尚未开始' />
      </div>
    )
  }
});

const mapStateToProps = state => {
  return {
    basicInfo: state.basicInfo
  }
}

const mapDispatchToProps = dispatch => {
  return {
    actions: bindActionCreators(IndexActions, dispatch)
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Index);
