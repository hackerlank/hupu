import React from 'react';
import { Link } from 'react-router';
import { LiveRoomList } from './HuiTiLiveRoomList';
import { Icon, Menu } from 'antd';

const Room = React.createClass({
  getInitialState() {
    return {
      current: 'liveRoom1'
    };
  },
  handleClick(e){
    this.setState({
      current: e.key
    });
  },
  render() {
    return (
      <div className="">
        <Menu
          onClick={this.handleClick}
          defaultOpenKeys={['liveRoom1']}
          selectedKeys={[this.state.current]}
          mode="horizontal"
          >
          <Menu.Item key="liveRoom1">
            <Link to='room/huiti/main'><Icon type="caret-right" />慧体直播流</Link>
          </Menu.Item>
          <Menu.Item key="liveRoom2">
            <Link to='room/huiti/close'><Icon type="appstore" />待关闭直播间列表</Link>
          </Menu.Item>
          <Menu.Item key="liveRoom3">
            <Link to='room/huiti/open'><Icon type="appstore-o" />待开启直播间列表</Link>
          </Menu.Item>
          <Menu.Item key="huitiOperate">
            <Link to='room/huiti/operate'><Icon type="aliwangwang-o" />慧体运营直播间列表</Link>
          </Menu.Item>
        </Menu>

        {React.cloneElement(this.props.children, {
          hashCurrent: this.state.current
        })}
      </div>
    );
  }
});

Room.key = 'HuiTiLive';
export default Room;
