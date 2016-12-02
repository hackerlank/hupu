import React, { Component } from 'react';
import { Link } from 'react-router';
import { Menu } from 'antd';

import LrwMatchApp from './Match';
import LrwMatchViewPlayers from './MatchViewPlayers';
import LrwPlayersApp from './Players';

class LrwApp extends Component {
  constructor(props) {
    super(props);

    this.state = {
      current: this.props.children.type.key
    };
  }
  componentWillMount() {
    console.log(this.props.children.type);
  }
  handleClick(e) {
    this.setState({
      current: e.key
    })
  }
  render() {
    const styles = {
      padding: "10px 0"
    }

    return (
      <div>
        <Menu
          onClick={this.handleClick.bind(this)}
          selectedKeys={[this.state.current]}
          mode="horizontal"
          >
          <Menu.Item key="match">
            <Link to="lrw">比赛管理</Link>
          </Menu.Item>
          <Menu.Item key="players">
            <Link to="lrw/players">球员管理</Link>
          </Menu.Item>
        </Menu>
        <div style={styles}>
          {this.props.children}
        </div>
      </div>
    );
  }
}

LrwApp.key = 'lrw';

export {
  LrwMatchApp,
  LrwMatchViewPlayers,
  LrwPlayersApp
};

export default LrwApp;
