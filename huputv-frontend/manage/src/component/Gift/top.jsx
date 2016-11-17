import React from 'react';
import { Table, Form, DatePicker, Button, Select, Tabs, message } from 'antd';

import dataService from 'common/dataService';

const FormItem = Form.Item;
const Option = Select.Option;
const TabPane = Tabs.TabPane;

/**
 * 接口地址
 * @type {Object}
 */
const apiUrl = {
  giftTop: '/manage/send-gift-rank'
}

/**
 * 搜索
 */
const SearchInput = React.createClass({
  getInitialState() {
    return {
      startValue: '',
      endValue: '',
      giftId: 0
    };
  },
  disabledStartDate(startValue) {
    if (!startValue || !this.state.endValue) {
      return false;
    }
    return startValue.getTime() >= this.state.endValue.getTime();
  },
  disabledEndDate(endValue) {
    if (!endValue || !this.state.startValue) {
      return false;
    }
    return endValue.getTime() <= this.state.startValue.getTime();
  },
  format(value) {
    if(!value){
      return '';
    }
    var date = new Date(value);
    
    return date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate();
  },
  onChange(field, value) {
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
      start_time: this.format(this.state.startValue),
      end_time: this.format(this.state.endValue),
      gift_id: this.state.giftId
    });
  },
  /**
   * 选择礼物
   */
  handleSelectChange(index){
    this.setState({
      giftId: index
    })
  },
  render() {
    const results = this.props.gift_list;
    
    return (
      <div>
        <Form inline>
          <FormItem label="统计周期：">
              <DatePicker disabledDate={this.disabledStartDate}
                value={this.state.startValue}
                placeholder="开始时间"
                onChange={this.onChange.bind(this, 'startValue')} />
              <span style={{ marginRight:10, marginLeft: 10 }}>至</span>  
              <DatePicker disabledDate={this.disabledEndDate}
                value={this.state.endValue}
                placeholder="结束时间"
                onChange={this.onChange.bind(this, 'endValue')} />
          </FormItem>
          <FormItem label="选择礼物：">
            <Select defaultValue="全部" style={{ width: 120 }} onChange={this.handleSelectChange}>
              {
                results.map(item => {
                  return <Option key={item.id} value={item.id}>{item.name}</Option>
                })
              }
            </Select>
          </FormItem>
          <Button type="primary" htmlType="submit" onClick={this.handleSubmit}>查询</Button>
        </Form>
      </div>
    );
  }
});


const GiftTop = React.createClass({
  getInitialState() {
    return {
      loading: true,
      type: 6,
      gift_list: [],
      rank_list: []
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

    this.setState({
      loading: true
    });

    params = Object.assign({
      type: this.state.type
    }, params);


    dataService
      .get(apiUrl.giftTop, params)
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
  /**
   * 切换tabs
   * @return {[type]} [description]
   */
  bandleTabs(type) {
    this.setState({
      type
    });

    this.handlePageUpload({
      type
    });
  },
  render() {
    const columns = [
      {title: '用户名', dataIndex: 'nickname'}, 
      {title: 'PassportUid', dataIndex: 'sent_puid'}, 
      {title: '赠送金额', dataIndex: 'money'}
    ];

    return (
      <div className="gift-detail">
        <h2 style={{marginBottom: 10}}>送礼排行</h2>

        <Tabs defaultActiveKey="6" onChange={this.bandleTabs}>
          <TabPane tab="虎扑币" key="6"></TabPane>
          <TabPane tab="金豆" key="1"></TabPane>
        </Tabs>
        <div style={{marginBottom: 10}}>
          <SearchInput 
            gift_list={this.state.gift_list}
            handlePageUpload={this.handlePageUpload}
           />
        </div>

        <Table 
          columns={columns} 
          loading={this.state.loading}
          dataSource={this.state.rank_list}
          pagination={false}
        />

      </div>
    );
  }
});

GiftTop.key = 'gift';

export default GiftTop;
