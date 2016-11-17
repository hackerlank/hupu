import React from 'react';
import { Table, Button } from 'antd';
import { Link, History } from 'react-router';

import dataService from 'common/dataService';


const apiUrl = {
  rank: '/manage/rank-match'
}

let GiftRank = React.createClass({
  mixins: [History],
  getInitialState() {
    return {
      id: 0,
      list: []
    }
  },
  componentWillMount() {
    this.setState({
      id: this.props.location.query.id
    });

    this.pageUpload();
  },
  /**
   * 分页更新列表
   * @return {[type]} [description]
   */
  pageUpload(page = 1) {

    this.setState({
      loading: true
    });

    dataService
      .get(apiUrl.rank, {page: page, match_id: this.props.location.query.id})
      .then((result) => {
        this.setState({
          loading: false
        });

        if(result.code === 1){
          this.setState({
            list: result.data.room
          });
        }else{
          message.error(result.msg);
        }
      })
  },
  render(){
      const mapper = (item) => { return (
          <span> <span className="gift-numbs">{item.total}</span>/{item.name}</span>
      )}

      const columns = [
        {
          title: '排名',
          dataIndex: 'puid',
          key: 'puid',
          render(text, record, key) {
            return key + 1;
          }
        },
        {
          title: '用户昵称',
          dataIndex: 'nickname',
          key: 'nickname' 
        },
        {
          title: '礼物金额',  
          dataIndex: 'total',  
          key: 'total'
        }
      ];

      return(
        <div>
          <div style={{marginBottom:10}}>
            <Button type="primary" onClick={this.history.goBack} style={{marginBottom:15}}>返回列表</Button>
            <h3>总送礼排行</h3>
            <p className="single-p">场次ID: {this.state.id}</p>
          </div>
          <Table 
            className="table-pre"
            rowKey={record => record.puid} 
            columns={columns} 
            dataSource={this.state.list} 
            pagination={false} />
        </div>
      );

  }

});

export default GiftRank;
