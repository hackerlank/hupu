import React from 'react';
import { Menu } from 'antd';

const App = React.createClass({
  getInitialState() {
    return {
      current: 'index'
    };
  },
  handleClick(e) {
    this.setState({
      current: e.key
    });
  },
  render() {
    return (
      <Menu onClick={this.handleClick}
        selectedKeys={[this.state.current]}
        theme={this.state.theme}
        mode="horizontal">
        <Menu.Item key="index">
        	直播间列表
        </Menu.Item>
        <Menu.Item key="anchor">
          主播列表
        </Menu.Item>
      </Menu>
    );
  }
});

export default App;

