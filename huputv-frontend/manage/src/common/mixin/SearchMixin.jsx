import React from 'react';
import { DatePicker, Form, Button } from 'antd';

const FormItem = Form.Item;

const SearchMixin = {
  getInitialState() {
    return {
      startValue: '',
      endValue: ''
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
  render() {
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
          <Button type="primary" htmlType="submit" onClick={this.handleSubmit}>查询</Button>
        </Form>
      </div>
    );
  }
}

export default SearchMixin;
