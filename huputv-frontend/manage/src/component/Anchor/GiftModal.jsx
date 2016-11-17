import React from 'react';
import { Link } from 'react-router';
import { Modal, Table, message } from 'antd';

import dataService from 'common/dataService';

/**
 * 接口地址
 * @type {Object}
 */
const apiUrl = {
  daily: '/manage/anchor/collect-daily-detail'
}


const App = React.createClass({
  getInitialState() {
    return { 
      visible: false,
      columns: [],
      list: []
    };
  },
  componentWillMount() {
    this.setState({
      visible: this.props.visible
    })
  },
  componentWillReceiveProps(nextProps){
    if(!nextProps.modalData.type){
      return;
    }

    dataService
      .get(apiUrl.daily, nextProps.modalData)
      .then((result) => {
        if(result.code === 1){
          this.transData(result.data);
        }else{
          message.error(result.msg);
        }
    })

    this.setState({
      visible: nextProps.visible
    })
  },
  /**
   * 转换数据
   * @return {[type]} [description]
   */
  transData(data) {
    let list = [
        {
          id: 0
        }
      ],
      columns = [];

    data.map((item, index) => {
      columns.push({
        title: item.name,
        dataIndex: index,
        key: index
      });

      list[0][index] = item.count;
    });

    this.setState({
      list,
      columns
    });
  },
  handleCancel(e) {
    this.setState({
      visible: false
    });
  },
  render() {
    return (
      <div>
        <Modal 
          title="具体礼物个数"
          footer=""
          visible={this.state.visible}
          onCancel={this.handleCancel}
          cancelText="Cancel">
            <Table 
              columns={this.state.columns}
              pagination={false}
              dataSource={this.state.list}
            />  
        </Modal>
      </div>
    );
  }
});





export default App;
