import React from 'react';
import { Form, Button, Input, Alert, message } from 'antd';

import dataService from 'common/dataService';

const FormItem = Form.Item;

/**
 * 接口地址
 * @type {Object}
 */
const apiUrl = {
  badwords: '/manage/badwords'
}

const App = React.createClass({
  getInitialState() {
    return {
      loading: true,
      badwords: ''
    }
  },
  componentWillMount() {
    this.getBannedwords();
  },
  /**
   * 获取违禁词
   */
  getBannedwords() {

    this.setState({
      loading: true
    });

    dataService
      .get(apiUrl.badwords)
      .then((result) => {
        this.setState({
          loading: false
        });

        console.log(result);

        if(result.code === 1){
          this.setState({
            ...result.data
          });
        }else{
          message.error(result.msg);
        }
    })
  },
  handleBlurTextarea(e) {
    this.setState({
      badwords: e.target.value
    });
  },
  handleSubmit() {
    let params = {
      badwords: this.state.badwords
    };

    dataService
      .post(apiUrl.badwords, params)
      .then((result) => {
        console.log(result);
        message.success(result.msg);
      })
  },
  render() {
    console.log(this.state.badwords);
    return (
      <div style={{width: '70%',margin: '50px auto'}}>
        <Form horizontal onSubmit={this.handleSubmit}>
          <FormItem>
            <Input 
              type="textarea" 
              value={this.state.badwords} 
              rows={6} 
              autosize 
              onChange={this.handleBlurTextarea}
              placeholder="输入违禁词" />
          </FormItem>
          <FormItem>
            <Button type="primary" htmlType="submit">确定</Button>
            <div style={{marginTop: 15}}>
              <Alert message="违禁词用逗号(,)隔开" type="info" />
            </div>
          </FormItem>
        </Form>
      </div>
    );
  }
});

App.key = 'bannedwords';

export default App;
