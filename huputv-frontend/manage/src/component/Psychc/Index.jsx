import React from 'react';
import { Link } from 'react-router';
import { Icon, Menu } from 'antd';
import Matchmanage from './Matchmanage';

const App = React.createClass({
  getInitialState() {
    return {
      current: 'matchm'
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
          defaultOpenKeys={['matchm']}
          selectedKeys={[this.state.current]}
          mode="horizontal"
          >
          <Menu.Item key="matchm">
            <Link to='psychc/match'>比赛管理</Link>
          </Menu.Item>
          <Menu.Item key="teamm">
            <Link to='psychc/team'>球队管理</Link>
          </Menu.Item>
          <Menu.Item key="skillm">
            <Link to='psychc/skill'>技能管理</Link>
          </Menu.Item>
        </Menu>

        {this.props.children || <Matchmanage />}
      </div>
    );
  }
});

export default App;
