import React from 'react';
import { Table, Button } from 'antd';
import { Link, History } from 'react-router';

import dataService from 'common/dataService';


const apiUrl = {
  matchIncom: '/manage/match-income/:id',
  total: '/manage/match-income/total/:id'
}

let SingleGift = React.createClass({
  mixins: [History],
  getInitialState() {
    return {
      id: 0,
      total: 0,
      list: [],
      total_gift: 0,
      gifts: {},
      per: 20,
      page: 1,
    }
  },
  componentWillMount() {
    this.setState({
      id: this.props.params.id,
      room_id: this.props.location.query.room_id,
      match_id: this.props.location.query.match_id
    });


    this.getTotal();
    this.pageUpload();
  },
  /**
   * 获取总数
   * @return {[type]} [description]
   */
  getTotal() {
    let url = apiUrl.total.replace(':id', this.props.params.id);

    let params = {
      room_id: this.props.location.query.room_id
    }

    dataService
      .get(url, params)
      .then((result) => {
        if(result.code === 1){
          this.setState({
            ...result.data
          });
          console.log(result.data);
        }
      })
  },
  /**
   * 分页更新列表
   * @return {[type]} [description]
   */
  pageUpload(page = 1) {
    var url = apiUrl.matchIncom.replace(':id', this.props.params.id);

    let params = {
      room_id: this.props.location.query.room_id,
      match_id: this.props.location.query.match_id,
      page
    }

    this.setState({
      loading: true
    });

    dataService
      .get(url, params)
      .then((result) => {
        this.setState({
          loading: false
        });

        if(result.code === 1){
          this.setState({
            list: result.data
          });
        }else{
          message.error(result.msg);
        }
      })
  },

  exportTable(){
    var url = apiUrl.matchIncom.replace(':id', this.props.params.id);

    dataService
      .get(url, {export: 1})
      .then((result) => {

      })
  },
  render(){
    let self = this;
    let gifts = this.state.gifts;

      const giftsRender = function() {
        var arr = [];

        for(var i in gifts) {
          arr.push(<span> <span className="gift-numbs">{i}</span>/{gifts[i]}</span>)
        }

        return arr;
      }

      const columns = [
        {
          title: '礼物名称',
          dataIndex: 'gift_name',
          key: 'gift_name'
        },
        {
          title: '数量',
          dataIndex: 'number',
          key: 'number' 
        },
        {
          title: '用户昵称',  
          dataIndex: 'sent_nickname',  
          key: 'sent_nickname'
        },
        {
          title: '赠送时间',
          dataIndex: 'created_at',  
          key: 'created_at'
        }
      ];

      const pagination = {
        total: this.state.total,
        pageSize: this.state.per,
        onChange: this.pageUpload,
        // current: this.state.page
      };

      const data = [];

      return(
        <div>
          <Button type="primary" onClick={this.history.goBack} style={{marginBottom:15}}>返回列表</Button>
          <h3>单场礼物</h3>
          <p className="single-p">场次ID: {this.state.id},本场礼物总收益：{this.state.total_gift}</p>
          <p className="gift-earnings">本场收益：
            {giftsRender()}
          </p>
          <a className="ant-btn ant-btn-primary" href={`/manage/match-income/${this.state.id}?match_id=${this.state.match_id}&room_id=${this.state.room_id}&export=1`} style={{marginBottom:15}}>导出</a>
          <Table 
            className="table-pre" 
            columns={columns} 
            dataSource={this.state.list} 
            pagination={pagination} />
        </div>
      );

  }

});
export default SingleGift;
