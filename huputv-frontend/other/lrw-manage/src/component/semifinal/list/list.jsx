import React, {Component} from 'react';
import {Link} from 'react-router';
import Modal, {Popup} from 'MODAL';
import Util from 'UTIL';

import "./list.scss";

class List extends Component {
  constructor(props) {
    super();

    this.state = {
      option_area: {},
      visibleModal: false,
      semfinalFlag:false,
    }
  }
  componentWillMount() {
    // this.setProps();
  }
  componentWillReceiveProps(nextProps) {
    // this.setProps(nextProps);
  }
  //计分工具 半决赛 只出现一次
  showSem(num,index){

    if(num == 11) {

      this.state.semfinalFlag = true;
      return this.state.semfinalFlag;

    }else if(num == 12) {
      if(index == 0){
        this.state.semfinalFlag = true;
        return this.state.semfinalFlag;
      }
      return !this.state.semfinalFlag;

    }else if(num == 13) {
      if(index == 0){
        this.state.semfinalFlag = true;
        return this.state.semfinalFlag;
      }
      return !this.state.semfinalFlag;
    }
  }
  getListElement(item, index) {
    const number = (index + 1);

    //  操作后台 半决赛 标题 显示
    let semFlag= !this.props.tools || this.showSem(item.num, index);


    const {left, right} = item;
    const matchText = {
      5: {
        left: '第1场败者',
        right: '第2场败者'
      },
      6: {
        left: '第3场败者',
        right: '第4场败者'
      },
      7: {
        left: '第1场赢家',
        right: '第2场赢家'
      },
      8: {
        left: '第3场赢家',
        right: '第4场赢家'
      },
      9: {
        left: '第7场败者',
        right: '第6场赢家'
      },
      10: {
        left: '第8场败者',
        right: '第5场赢家'
      },
      11: {
        left: '第7场赢家',
        right: '第8场赢家'
      },
      12: {
        left: '第9场赢家',
        right: '第10场赢家'
      },
      13: {
        left: '第11场败者',
        right: '第12场赢家'
      },
      14: {
        left: '第11场赢家 ',
        right: '第13场赢家'
      }
    }
    let mark=this.props.mark?"-":":";
    let subscribeClassName=item.subscribe? "ui-play-list-subscribe" : "";
    let isFail = (type) => {
      let className = '';

      if(type === 'left') {
          className = (item.status == 2 ? 'match-fail' : '');
        }else{
          className = (item.status == 1 ? 'match-fail' : '');
        }

      return className;
    }
    const getElement =
      ( +item.left_puid || +item.right_puid ) ? (
      <div key={index} className={`semifinal-item semifinal-item-notstart ${subscribeClassName}`}>
        {
          (this.props.isRank && item.num == 13)?(<div className="match-title">
                <h5>半决赛</h5>
              </div>):null
        }
        {
          (this.props.isRank && item.num == 10)?(<div className="match-title">
                <h5>8强赛</h5>
              </div>):null
        }
        {
          (!this.props.isRank && this.props.isTitle && item.num < 14 && item.num > 10 && semFlag ) ? (
              <div className="match-title">
                <h5>半决赛</h5>
              </div>
          ) : null
        }
        {
          (this.props.isTitle && item.num == 14) ? (
              <div className="match-title">
                <h5>决赛</h5>
              </div>
          ) : null
        }
        <div className={item.subscribe?"subscribe match-row":"match-row"}>
          <div className="col-left">
            {
              left ? (
                <div className={`${isFail("left")}`}> 
                  <div className="avatar-inner">
                    <span className="number">{left.player_num}</span>
                    <div className="avatar">
                      <img src={left.header} />
                    </div>
                  </div>
                  <h4 className="title">{Util.subBtyesString(left.nickname)}</h4>
                  <div className="info">
                    胜{left.total_win}({left.rate}%)
                  </div>
                </div>
              ) : (
                <span className="unknown-person">{matchText[+item.num].left}</span>
              )
            }
          </div>
          <div className="col-center">
            <div className="match-score">
              <div className="course-number">第{item.num}场</div>
              <div className="score">
                {
                  !+item.status ?
                    "未开始" : (
                      <div className="score-color">{item.left_score}{mark}{item.right_score}</div>
                    )
                }
              </div>
            </div>
          </div>
          <div className="col-right">
            {
              right ? (
                <div className={`${isFail("right")}`}>
                  <div className="avatar-inner">
                    <div className="avatar">
                      <img src={right.header} />
                    </div>
                    <span className="number">{right.player_num}</span>
                  </div>

                  <h4 className="title">{Util.subBtyesString(right.nickname)}</h4>
                  <div className="info">
                    胜{right.total_win}({right.rate}%)
                  </div>
                </div>
              ) : (
                <span className="unknown-person">{matchText[+item.num].right}</span>
              )
            }
          </div>
        </div>
      </div>
    ) : null;

    return getElement;
  }

  render() {
    let {lists} = this.props;

    return (
      <div className="ui-semifinal-list">

        {
          lists.map((item, index) => {
            if(item.right_puid || item.left_puid){

              return this.getListElement(item, index)
            }
          })
        }

      </div>
    );
  }
};

List.defaultProps = {
  lists: [],
  isTitle: false,
  isRank:false,
  mark:false,
  tools:false
}

List.propTypes = {
  lists: React.PropTypes.array,
  isTitle: React.PropTypes.bool,
  isRank:React.PropTypes.bool,
  tools:React.PropTypes.bool
}

export default List;
