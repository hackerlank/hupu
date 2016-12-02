import React, {Component} from 'react';
import {Link} from 'react-router';
import Cookie from 'react-cookie';
import Modal, {Toast} from 'MODAL';
import dataService from 'DATASERVICE';
import Util from 'UTIL';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import * as IndexActions from 'ACTION/index';

import Header from 'CUI/header/header';
import ListTitle from 'CUI/list-title/title';
import Tab from 'COMMON/h5/tab/tab';
import Lists from './list/list';
import NoMatch from 'COMMON/noMatch';

import "./match.scss";

const Api = {
    getMatch: '/m/passerbyking/top8/match/:id',
    getMatchRank:'/m/passerbyking/top8/rank/:id'
};

class Semifinal extends Component {
  constructor(props) {
    super();

    this.state = {
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
      out_match_list: [],
      match_rank:[],
      semList:[],
      ready_num:-1
    }
  }
  componentWillMount() {
    this.getBasicInfo();
    
  }
  getBasicInfo(props = this.props) {
    const basicInfo = Object.assign(this.state.basicInfo, props.basicInfo);
    this.setState({
      basicInfo
    })
   if(basicInfo.game_info.match_status){
      this.getMatchList();
      this.getMatchRank();
   }
  }
  componentWillReceiveProps(nextProps) {
    this.getBasicInfo(nextProps);
  }
  /**
   * 获取比赛列表
   * @return {[type]} [description]
   */
  getMatchList() {
    const { basicInfo } = this.state;
    if(basicInfo.game_info.match_status<3){
      return;
    }    
    let urls = Api.getMatch.replace(':id', this.state.game_id);
    dataService
      .get(urls)
      .then(result => {
        if(result.code == 1) {          
          let tempdata_ready = result.data.match_list.ready;
          let tempdata_end = result.data.match_list.end;

          let puid = Cookie.load("puid");          
          if(tempdata_ready.length){

            tempdata_ready.map((item,index)=>{            
             tempdata_ready[index]["subscribe"]=false;

            });
           
            puid?(tempdata_ready.map((item,index)=>{

                if(tempdata_ready[index].left_puid == puid || tempdata_ready[index].right_puid == puid ){
                    tempdata_ready[index].subscribe = true;
                    
                    this.setState({
                      ready_num:index
                    })        
                  }                
                })
              ):"";
          }

          if(tempdata_end.length) {

            tempdata_end.map((item,index) => { 
            tempdata_end[index]["subscribe"]=false;
          });      

          puid?(tempdata_end.map((item,index) => {

                if(tempdata_end[index].puid == puid){
                    tempdata_end[index].subscribe = true; 

                    this.setState({
                      ready_num:-1
                    })      
                  }                
                })
              ):"";
          };
          let tempdataSem = [];

           tempdataSem.push(result.data.playing);  
           tempdataSem.map((item,index) => {
              tempdataSem[index].status = "4";
            })

          this.setState({
            match_list: tempdata_ready,
            out_match_list: tempdata_end,
            semList:tempdataSem
          });
        }
      })
  }
  getMatchRank(){ 
  //get 8match rank
    const { basicInfo } = this.state;
    if(basicInfo.game_info.match_status<4){
      return;
    } 

    let urls = Api.getMatchRank.replace(':id', this.state.game_id);     

      dataService
      .get(urls)
      .then(result => {
        if(result.code == 1){
          let puid=Cookie.load("puid");

           puid?(result.data.rank_list.map((item,index) => {
                if(result.data.rank_list[index].puid == puid){
                    Cookie.remove("puid",{path:'/'}); 
                  }                
                })
              ):"";

          this.setState({
            match_rank:result.data.rank_list
          })
        }
      });
  }
  handleOk() {
    console.log('ok');
  }
  getElementMap(){
    const getElement = (
        <div>
          {
            <div>
               <ListTitle title='进行中比赛' />
                <Lists
                  lists = {this.state.semList}
                  mark = {true}
                  />
            </div>
          }
          {
            this.state.match_list.length ? (
              <div>
                <ListTitle
                  title = {this.state.ready_num >=0 ?(<div>待比赛场次(前面还有<span>{this.state.ready_num}</span>场比赛)</div>):"待比赛场次"} 
                 />
                <Lists
                  lists= {this.state.match_list}
                  isTitle= {true}
                  tools={true}                  
                 />
              </div>
            ) : null
          }
        {
          this.state.out_match_list.length ? (
            <div>
              <ListTitle
                title = "已结束比赛"
               />
              <Lists
                lists= {this.state.out_match_list}
                mark={true}                
               />
            </div>
          ) : null
        }       
        </div>
      );
    return getElement;
  }
  getElementNoMatch(text){
    const getElementNoText = (
      <div>
      <NoMatch title = {text}/></div>
    );
    return getElementNoText;
  }
  getElement8Rank(){
    const getRank = (
        <div>  not action</div>
    );
    return getRank;
  }
  render() {
    const { basicInfo } = this.state;
    return (
      <div><div className="semifinal-wrap" ><Tab   active = "2"   />
          {basicInfo.game_info.match_status >=3 && basicInfo.game_info.match_status <=4 ?(<div>{this.getElementMap()}</div>):<div>{basicInfo.game_info.match_status>4?(<div><Lists 
                  lists= {this.state.match_rank}
                  isTitle= {true}
                  isRank={true}                  
                 /></div>):(<div>{this.getElementNoMatch("8强赛尚未开始")}</div>)}</div>}
      </div>
      </div>
    )
  }
};
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
)(Semifinal);

/*export default Semifinal
*/