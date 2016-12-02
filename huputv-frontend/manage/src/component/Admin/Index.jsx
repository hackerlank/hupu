import React from 'react';
import { Link } from 'react-router';
import { Icon, Menu } from 'antd';
import Adminmanage from './List';

const App = React.createClass({
  getInitialState() {
    return {
      current: this.props.children.type.key || 'admin'
    };
  },
  handleClick(e){
    this.setState({
      current: e.key
    });
  },
  render() {
    return (
      <div>
        <Menu
          onClick={this.handleClick}
          defaultOpenKeys={['admin']}
          selectedKeys={[this.state.current]}
          mode="horizontal"
          >
          <Menu.Item key="admin">
            <Link to='other/admin'>管理员</Link>
          </Menu.Item>
          <Menu.Item key="system">
            <Link to='other/system'>系统消息</Link>
          </Menu.Item>
          <Menu.Item key="bannedwords">
            <Link to='other/bannedwords'>违禁词库</Link>
          </Menu.Item>
          <Menu.Item key="waterarmy">
            <Link to='other/waterarmy'>水军ID管理</Link>
          </Menu.Item>
        </Menu>

        {this.props.children || <Adminmanage />}
      </div>
    );
  }
});

App.key = 'other';

export default App;
