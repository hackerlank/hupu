import React from 'react';
import { Link } from 'react-router';
import { Icon, Table, DatePicker, Form, Button, Row, Col, message } from 'antd';

import SearchMixin from 'common/mixin/SearchMixin';
import dataService from 'common/dataService';

const FormItem = Form.Item;

/**
 * 接口地址
 * @type {Object}
 */
const apiUrl = {
  // 
  giftDetail: '/manage/gift-daily-detail'
}

/**
 * 搜索
 */
const SearchInput = React.createClass({
  mixins: [SearchMixin],
  onChange(field, value) {
    console.log(field, 'change', value);
    this.setState({
      [field]: value
    });
  },
  /**
   * 搜索提交
   * @param  {[type]} event [description]
   * @return {[type]}       [description]
   */
  handleSubmit(event){
    this.props.handlePageUpload({
      start_date: this.format(this.state.startValue),
      end_date: this.format(this.state.endValue)
    });
  }
});


const Detail = React.createClass({
  getInitialState() {
    return {
      loading: true,
      gift_id: 0,
      start_date: '',
      end_date: '',
      list: []
    }
  },
  componentWillMount() {
    this.handlePageUpload();
  },
  /**
   * 分页更新列表
   * @return {[type]} [description]
   */
  handlePageUpload(params = {}) {
    let sendData = {
      gift_id: this.props.params.id,
      ...params
    };

    this.setState({
      loading: true,
      gift_id: this.props.params.id,
      ...params
    });

    dataService
      .get(apiUrl.giftDetail, sendData)
      .then((result) => {
        this.setState({
          loading: false
        });
        if(result.code === 1){
          this.setState({
            ...result.data
          });
        }else{
          message.error(result.msg);
        }
    })
  },
  render() {
    const self = this;
    const columns = [
      {title: '日期', dataIndex: 'date'}, 
      {title: 'PC个数', dataIndex: 'pc_number', 
        render(text, record) {
          return (
            <span>
              {text}个（{record.pc_percent_money}%） 
            </span>
          );
        }
      }, 
      {title: 'PC金额', dataIndex: 'pc_money',
        render(text, record) {
          return (
            <span>
              {text}{self.state.pay_type}（{record.pc_percent_money}%） 
            </span>
          );
        }
      },
      {title: 'Andriod个数', dataIndex: 'android_number',
        render(text, record) {
          return (
            <span>
              {text}个（{record.android_percent_number}%） 
            </span>
          );
        }
      },
      {title: 'Andriod金额', dataIndex: 'android_money',
        render(text, record) {
          return (
            <span>
              {text}{self.state.pay_type}（{record.android_percent_money}%） 
            </span>
          );
        }
      },
      {title: 'IOS个数', dataIndex: 'ios_number',
        render(text, record) {
          return (
            <span>
              {text}个（{record.ios_percent_number}%） 
            </span>
          );
        }
      },
      {title: 'IOS金额', dataIndex: 'ios_money',
        render(text, record) {
          return (
            <span>
              {text}{self.state.pay_type}（{record.ios_percent_money}%） 
            </span>
          );
        }
      },
      {title: '个数汇总', dataIndex: 'h_number',
        render(text, record) {
          return (
            <span>
              {text}个
            </span>
          );
        }
      },
      {title: '金额汇总', dataIndex: 'h_money',
        render(text, record) {
          return (
            <span>
              {text}{self.state.pay_type} 
            </span>
          );
        }
      }
    ];

    return (
      <div className="gift-detail">
        <h2 style={{marginBottom: 10}}>礼物明细：{this.state.gift_name}</h2>
        <div style={{marginBottom: 10}}>
          <Row>
            <Col span="16">
              <SearchInput handlePageUpload={this.handlePageUpload} />
            </Col>
            <Col span="8" style={{textAlign: "right"}}>
            <a className="ant-btn ant-btn-primary" href={`${apiUrl.giftDetail}?gift_id=${this.state.gift_id}&start_date=${this.state.start_date}&end_date=${this.state.end_date}&save_file=1`}>导出</a>
            </Col>
          </Row>
        </div>

        <Table 
          columns={columns} 
          dataSource={this.state.list}
          loading={this.state.loading}
          rowKey={record => record.date}
          pagination={false}
        />

      </div>
    );
  }
});

Detail.key = 'gift';

export default Detail;
